#import "LeadMenu.h"
#import "Headers.h"

static NSString *const kCellId = @"LeadCell";
static NSString *const kHeroId = @"LeadHero";
static NSString *const kHeaderId = @"LeadHeader";

@interface LeadPageViewController ()
@property (nonatomic, strong) LeadPage *page;
@property (nonatomic, assign) BOOL didAnimateIn;
@property (nonatomic, assign) NSInteger appearOrder;
@end

@implementation LeadPageViewController

- (instancetype)initWithPage:(LeadPage *)page {
  self = [super initWithStyle:UITableViewStyleInsetGrouped];
  if (self) {
    _page = page;
    self.title = LeadL(page.titleKey);
  }
  return self;
}

- (void)viewDidLoad {
  [super viewDidLoad];
  self.navigationItem.largeTitleDisplayMode = UINavigationItemLargeTitleDisplayModeNever;
  self.tableView.backgroundColor = UIColor.systemGroupedBackgroundColor;
  self.tableView.estimatedRowHeight = 64;
  self.tableView.rowHeight = UITableViewAutomaticDimension;
  self.tableView.sectionHeaderHeight = UITableViewAutomaticDimension;
  self.tableView.estimatedSectionHeaderHeight = 36;
  [self.tableView registerClass:[LeadCell class] forCellReuseIdentifier:kCellId];
  [self.tableView registerClass:[LeadHeroCell class] forCellReuseIdentifier:kHeroId];
  [self.tableView registerClass:[LeadSectionHeader class] forHeaderFooterViewReuseIdentifier:kHeaderId];

  NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
  [center addObserver:self selector:@selector(externalChange:) name:LeadSettingsDidChangeNotification object:nil];
  [center addObserver:self selector:@selector(externalChange:) name:@"LeadLocationChanged" object:nil];
}

- (void)dealloc {
  [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
  [self refreshVisibleRows];
}

// Values like counts or coordinates may change on another screen; update in place
// so switches don't jump mid-animation.
- (void)externalChange:(NSNotification *)note {
  [self refreshVisibleRows];
}

- (void)refreshVisibleRows {
  for (NSIndexPath *indexPath in self.tableView.indexPathsForVisibleRows) {
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    if ([cell isKindOfClass:[LeadHeroCell class]]) {
      [(LeadHeroCell *)cell configureTitle:LeadL(@"GHOST_MODE_SECTION_HEADER")
                                     status:LeadGhostStatusText()
                                         on:[[NSUserDefaults standardUserDefaults] boolForKey:kGhostModeEnabled]
                                   animated:YES];
      continue;
    }
    LeadRow *row = [self rowAtIndexPath:indexPath];
    LeadCell *leadCell = (LeadCell *)cell;
    if (!row || ![leadCell isKindOfClass:[LeadCell class]]) continue;
    if (row.style == LeadRowStyleToggle) {
      if (leadCell.toggle.on != row.isOn) {
        [leadCell.toggle setOn:row.isOn animated:YES];
        [leadCell.tile setActive:row.isOn animated:YES];
      }
    } else if (row.valueBlock) {
      [leadCell showValue:row.valueBlock() chevron:row.style == LeadRowStyleLink];
    }
  }
}

#pragma mark - Data

- (NSInteger)sectionOffset {
  return self.page.isGhost ? 1 : 0;
}

- (LeadSection *)sectionAt:(NSInteger)index {
  NSInteger i = index - self.sectionOffset;
  return (i >= 0 && i < (NSInteger)self.page.sections.count) ? self.page.sections[i] : nil;
}

- (LeadRow *)rowAtIndexPath:(NSIndexPath *)indexPath {
  LeadSection *section = [self sectionAt:indexPath.section];
  return (indexPath.row < (NSInteger)section.rows.count) ? section.rows[indexPath.row] : nil;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return self.page.sections.count + self.sectionOffset;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  if (self.page.isGhost && section == 0) return 1;
  return [self sectionAt:section].rows.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  if (self.page.isGhost && indexPath.section == 0) {
    LeadHeroCell *hero = [tableView dequeueReusableCellWithIdentifier:kHeroId forIndexPath:indexPath];
    [hero configureTitle:LeadL(@"GHOST_MODE_SECTION_HEADER")
                  status:LeadGhostStatusText()
                      on:[[NSUserDefaults standardUserDefaults] boolForKey:kGhostModeEnabled]
                animated:NO];
    hero.selectionStyle = UITableViewCellSelectionStyleNone;
    __weak typeof(self) weakSelf = self;
    hero.onToggle = ^(BOOL on) {
      if (on) {
        if (LeadEnableGhostMode(weakSelf)) [weakSelf.tableView reloadData];
      } else {
        LeadSetBool(kGhostModeEnabled, NO);
      }
    };
    return hero;
  }

  LeadRow *row = [self rowAtIndexPath:indexPath];
  LeadCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellId forIndexPath:indexPath];
  [cell configureTitle:row.title subtitle:row.subtitle symbol:row.symbol];
  [cell setDestructive:row.destructive];
  if (row.style == LeadRowStyleToggle) {
    [cell showToggle:row.isOn];
    NSString *key = row.defaultsKey;
    __weak typeof(self) weakSelf = self;
    void (^toggleBlock)(BOOL, UIViewController *) = row.toggleBlock;
    cell.onToggle = ^(BOOL on) {
      LeadSetBool(key, on);
      if (toggleBlock) toggleBlock(on, weakSelf);
    };
  } else {
    [cell showValue:row.valueBlock ? row.valueBlock() : nil chevron:row.style == LeadRowStyleLink];
  }
  return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
  if (self.didAnimateIn) return;
  LeadAnimateCellIn(cell, self.appearOrder++);
  dispatch_async(dispatch_get_main_queue(), ^{
    self.didAnimateIn = YES;
  });
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)sectionIndex {
  LeadSection *section = [self sectionAt:sectionIndex];
  if (section.titleKey.length == 0) return nil;
  LeadSectionHeader *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:kHeaderId];
  header.label.text = LeadL(section.titleKey);
  header.actionButton.hidden = !section.bulkToggle;
  if (section.bulkToggle) {
    BOOL allOn = YES;
    for (LeadRow *row in section.rows) allOn = allOn && row.isOn;
    [header.actionButton setTitle:LeadL(allOn ? @"UI_ALL_OFF" : @"UI_ALL_ON") forState:UIControlStateNormal];
    __weak typeof(self) weakSelf = self;
    header.onAction = ^{
      for (LeadRow *row in section.rows) {
        [[NSUserDefaults standardUserDefaults] setBool:!allOn forKey:row.defaultsKey];
      }
      LeadSetBool(section.rows.firstObject.defaultsKey, !allOn);
      [weakSelf.tableView reloadSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationNone];
    };
  }
  return header;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
  if (self.page.isGhost && section == 0) return 12;
  return [self sectionAt:section].titleKey.length ? UITableViewAutomaticDimension : 14;
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section {
  NSString *key = [self sectionAt:section].footerKey;
  return key ? LeadL(key) : nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  [tableView deselectRowAtIndexPath:indexPath animated:YES];
  if (self.page.isGhost && indexPath.section == 0) return;
  LeadRow *row = [self rowAtIndexPath:indexPath];
  if (row.style == LeadRowStyleToggle) {
    // The whole row is a hit target, not just the switch.
    LeadCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    [cell.toggle setOn:!cell.toggle.on animated:YES];
    [cell.toggle sendActionsForControlEvents:UIControlEventValueChanged];
    return;
  }
  if (row.tapBlock) row.tapBlock(self);
}

@end

#pragma mark - Ghost exceptions

static BOOL LeadGhostTitleIsUsable(NSString *title, NSString *key) {
  NSString *trimmed = [title stringByTrimmingCharactersInSet:NSCharacterSet.whitespaceAndNewlineCharacterSet];
  if (trimmed.length == 0 || [trimmed isEqualToString:key]) return NO;
  NSString *lower = trimmed.localizedLowercaseString;
  for (NSString *prefix in @[ @"peer:", @"user:", @"channel:", @"chat:" ]) {
    if ([lower hasPrefix:prefix]) return NO;
  }
  NSArray *uiWords = @[ @"username", @"addressname", @"firstname", @"lastname", @"title", @"peer", @"_peer", @"message",
                        @"call", @"video call", @"mute", @"notifications", @"bio", @"about", @"info", @"edit", @"done",
                        @"settings", @"add to contacts", @"add contact", @"contact", @"invite", @"more", @"back",
                        @"block user", @"block", @"report", @"delete contact", @"share contact", @"send message" ];
  if ([uiWords containsObject:lower] || [lower containsString:@"qr code"] || [lower containsString:@"share qr"]) return NO;
  if ([trimmed rangeOfCharacterFromSet:NSCharacterSet.decimalDigitCharacterSet.invertedSet].location == NSNotFound) return NO;
  // UI scraping has picked up the account's own phone number on some iPad layouts.
  if ([trimmed hasPrefix:@"+"]) return NO;
  return YES;
}

static NSString *LeadGhostName(NSDictionary *record) {
  NSString *key = record[@"key"] ?: @"";
  if (LeadGhostTitleIsUsable(record[@"title"], key)) {
    return [record[@"title"] stringByTrimmingCharactersInSet:NSCharacterSet.whitespaceAndNewlineCharacterSet];
  }
  NSRange colon = [key rangeOfString:@":"];
  return colon.location != NSNotFound ? [NSString stringWithFormat:@"ID %@", [key substringFromIndex:colon.location + 1]] : key;
}

static NSString *LeadGhostUserId(NSDictionary *record) {
  NSMutableArray *candidates = [NSMutableArray array];
  if ([record[@"aliases"] isKindOfClass:[NSArray class]]) [candidates addObjectsFromArray:record[@"aliases"]];
  if ([record[@"key"] length]) [candidates addObject:record[@"key"]];
  for (NSString *prefix in @[ @"user:", @"peer:" ]) {
    for (NSString *candidate in candidates) {
      if ([candidate isKindOfClass:[NSString class]] && [candidate hasPrefix:prefix] && candidate.length > prefix.length) {
        return [candidate substringFromIndex:prefix.length];
      }
    }
  }
  return nil;
}

@interface LeadGhostExceptionsViewController ()
@property (nonatomic, strong) NSArray<NSDictionary *> *records;
@property (nonatomic, strong) UIView *emptyView;
@end

@implementation LeadGhostExceptionsViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  self.title = LeadL(@"UI_EXCEPTIONS");
  self.tableView.backgroundColor = UIColor.systemGroupedBackgroundColor;
  self.tableView.rowHeight = UITableViewAutomaticDimension;
  self.tableView.estimatedRowHeight = 60;
  [self.tableView registerClass:[LeadCell class] forCellReuseIdentifier:kCellId];
  self.emptyView = [self buildEmptyView];
}

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
  [self reload];
}

- (void)reload {
  self.records = LeadGhostPeerRecords();
  self.tableView.backgroundView = self.records.count ? nil : self.emptyView;
  [self.tableView reloadData];
}

- (UIView *)buildEmptyView {
  UIView *container = [UIView new];
  LeadIconTile *tile = [LeadIconTile new];
  tile.side = 56;
  [tile setSymbol:@"person.crop.circle.badge.checkmark"];
  tile.translatesAutoresizingMaskIntoConstraints = NO;
  UILabel *title = [UILabel new];
  title.text = LeadL(@"UI_EXCEPTIONS_EMPTY");
  title.font = LeadRoundedFont(18, UIFontWeightSemibold);
  title.textAlignment = NSTextAlignmentCenter;
  UILabel *hint = [UILabel new];
  hint.text = LeadL(@"UI_EXCEPTIONS_EMPTY_HINT");
  hint.font = LeadFont(14, UIFontWeightRegular);
  hint.textColor = UIColor.secondaryLabelColor;
  hint.textAlignment = NSTextAlignmentCenter;
  hint.numberOfLines = 0;
  UIStackView *stack = [[UIStackView alloc] initWithArrangedSubviews:@[ tile, title, hint ]];
  stack.axis = UILayoutConstraintAxisVertical;
  stack.alignment = UIStackViewAlignmentCenter;
  stack.spacing = 10;
  [stack setCustomSpacing:16 afterView:tile];
  stack.translatesAutoresizingMaskIntoConstraints = NO;
  [container addSubview:stack];
  [NSLayoutConstraint activateConstraints:@[
    [tile.widthAnchor constraintEqualToConstant:56],
    [tile.heightAnchor constraintEqualToConstant:56],
    [stack.centerYAnchor constraintEqualToAnchor:container.centerYAnchor constant:-40],
    [stack.leadingAnchor constraintEqualToAnchor:container.leadingAnchor constant:40],
    [stack.trailingAnchor constraintEqualToAnchor:container.trailingAnchor constant:-40],
  ]];
  return container;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return self.records.count;
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section {
  return self.records.count ? LeadL(@"UI_EXCEPTIONS_FOOTER") : nil;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  NSDictionary *record = self.records[indexPath.row];
  NSString *name = LeadGhostName(record);
  NSString *key = record[@"key"] ?: @"";
  NSRange colon = [key rangeOfString:@":"];
  NSString *detail = colon.location != NSNotFound ? [NSString stringWithFormat:@"ID %@", [key substringFromIndex:colon.location + 1]] : nil;
  LeadCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellId forIndexPath:indexPath];
  [cell configureTitle:name subtitle:[detail isEqualToString:name] ? nil : detail symbol:nil];
  NSRange first = name.length ? [name rangeOfComposedCharacterSequenceAtIndex:0] : NSMakeRange(0, 0);
  [cell.tile setText:first.length ? [[name substringWithRange:first] uppercaseString] : @"?"];
  [cell showValue:nil chevron:YES];
  return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  [tableView deselectRowAtIndexPath:indexPath animated:YES];
  NSString *recordKey = self.records[indexPath.row][@"key"];
  if ([recordKey hasPrefix:@"channel:"]) {
    LeadOpenTelegramURL([NSString stringWithFormat:@"tg://privatepost?channel=%@&post=1", [recordKey substringFromIndex:8]]);
    return;
  }
  NSString *userId = LeadGhostUserId(self.records[indexPath.row]);
  if (userId.length == 0) {
    [LeadToast showText:LeadL(@"UI_OPEN_PROFILE_FAILED") symbol:@"exclamationmark.circle" inView:self.view];
    return;
  }
  LeadOpenTelegramURL([NSString stringWithFormat:@"tg://user?id=%@", userId]);
}

- (void)renameAtIndexPath:(NSIndexPath *)indexPath {
  NSDictionary *record = self.records[indexPath.row];
  NSString *key = record[@"key"];
  if (key.length == 0) return;
  UIAlertController *alert = [UIAlertController alertControllerWithTitle:LeadL(@"UI_RENAME")
                                                                 message:LeadL(@"UI_RENAME_HINT")
                                                          preferredStyle:UIAlertControllerStyleAlert];
  [alert addTextFieldWithConfigurationHandler:^(UITextField *field) {
    field.placeholder = LeadL(@"UI_NAME");
    field.text = LeadGhostTitleIsUsable(record[@"title"], key) ? LeadGhostName(record) : nil;
    field.clearButtonMode = UITextFieldViewModeWhileEditing;
  }];
  __weak typeof(self) weakSelf = self;
  [alert addAction:[UIAlertAction actionWithTitle:LeadL(@"CANCEL") style:UIAlertActionStyleCancel handler:nil]];
  [alert addAction:[UIAlertAction actionWithTitle:LeadL(@"UI_SAVE") style:UIAlertActionStyleDefault handler:^(__unused UIAlertAction *action) {
    NSString *title = [alert.textFields.firstObject.text stringByTrimmingCharactersInSet:NSCharacterSet.whitespaceAndNewlineCharacterSet];
    if (title.length == 0) return;
    NSArray *aliases = [record[@"aliases"] isKindOfClass:[NSArray class]] ? record[@"aliases"] : @[ key ];
    LeadSetGhostPeerEnabled(key, aliases, title, YES);
    [weakSelf reload];
  }]];
  [self presentViewController:alert animated:YES completion:nil];
}

- (UISwipeActionsConfiguration *)tableView:(UITableView *)tableView trailingSwipeActionsConfigurationForRowAtIndexPath:(NSIndexPath *)indexPath {
  __weak typeof(self) weakSelf = self;
  UIContextualAction *remove = [UIContextualAction contextualActionWithStyle:UIContextualActionStyleDestructive
                                                                       title:LeadL(@"UI_REMOVE")
                                                                     handler:^(__unused UIContextualAction *action, __unused UIView *view, void (^done)(BOOL)) {
    __strong typeof(weakSelf) self = weakSelf;
    LeadRemoveGhostPeer(self.records[indexPath.row][@"key"]);
    self.records = LeadGhostPeerRecords();
    [self.tableView deleteRowsAtIndexPaths:@[ indexPath ] withRowAnimation:UITableViewRowAnimationAutomatic];
    self.tableView.backgroundView = self.records.count ? nil : self.emptyView;
    [[NSNotificationCenter defaultCenter] postNotificationName:LeadSettingsDidChangeNotification object:nil];
    done(YES);
  }];
  remove.image = [UIImage systemImageNamed:@"trash"];
  UIContextualAction *rename = [UIContextualAction contextualActionWithStyle:UIContextualActionStyleNormal
                                                                       title:LeadL(@"UI_RENAME")
                                                                     handler:^(__unused UIContextualAction *action, __unused UIView *view, void (^done)(BOOL)) {
    [weakSelf renameAtIndexPath:indexPath];
    done(YES);
  }];
  rename.image = [UIImage systemImageNamed:@"pencil"];
  rename.backgroundColor = UIColor.systemGrayColor;
  UISwipeActionsConfiguration *config = [UISwipeActionsConfiguration configurationWithActions:@[ remove, rename ]];
  config.performsFirstActionWithFullSwipe = NO;
  return config;
}

@end
