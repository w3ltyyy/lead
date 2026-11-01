#import "LeadMenu.h"
#import "Headers.h"
#import <objc/message.h>

// Entries come from TLParser.messageLogEntries (Swift): dictionaries with
// kind ("deleted"/"edited"), peer ("u…"/"g…"/"c…"), id, text, old, date, name, username.
NSArray<NSDictionary *> *LeadMessageLogEntries(void) {
  Class parser = NSClassFromString(@"TLParser");
  SEL selector = NSSelectorFromString(@"messageLogEntries");
  if (![parser respondsToSelector:selector]) return @[];
  NSArray *entries = ((NSArray * (*)(id, SEL))objc_msgSend)(parser, selector);
  return [entries isKindOfClass:[NSArray class]] ? entries : @[];
}

@interface LeadMessageLogViewController ()
@property (nonatomic, strong) UISegmentedControl *segments;
@property (nonatomic, strong) NSArray<NSDictionary *> *entries;
@property (nonatomic, strong) UIView *emptyView;
@property (nonatomic, strong) UILabel *emptyTitle;
@property (nonatomic, strong) UILabel *emptyHint;
@end

@implementation LeadMessageLogViewController

- (instancetype)init {
  return [super initWithStyle:UITableViewStyleInsetGrouped];
}

- (void)viewDidLoad {
  [super viewDidLoad];
  self.title = LeadL(@"UI_MESSAGE_LOG");
  self.tableView.backgroundColor = UIColor.systemGroupedBackgroundColor;
  self.tableView.rowHeight = UITableViewAutomaticDimension;
  self.tableView.estimatedRowHeight = 72;
  [self.tableView registerClass:[LeadCell class] forCellReuseIdentifier:@"LeadCell"];

  self.segments = [[UISegmentedControl alloc] initWithItems:@[ LeadL(@"UI_LOG_DELETED"), LeadL(@"UI_LOG_EDITED"), LeadL(@"UI_LOG_PROFILES") ]];
  self.segments.selectedSegmentIndex = 0;
  [self.segments addTarget:self action:@selector(segmentChanged) forControlEvents:UIControlEventValueChanged];
  UIView *header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 52)];
  self.segments.translatesAutoresizingMaskIntoConstraints = NO;
  [header addSubview:self.segments];
  [NSLayoutConstraint activateConstraints:@[
    [self.segments.leadingAnchor constraintEqualToAnchor:header.layoutMarginsGuide.leadingAnchor],
    [self.segments.trailingAnchor constraintEqualToAnchor:header.layoutMarginsGuide.trailingAnchor],
    [self.segments.centerYAnchor constraintEqualToAnchor:header.centerYAnchor],
  ]];
  self.tableView.tableHeaderView = header;

  self.navigationItem.rightBarButtonItem =
      [[UIBarButtonItem alloc] initWithImage:[UIImage systemImageNamed:@"trash"] style:UIBarButtonItemStylePlain target:self action:@selector(clearTapped)];
  self.emptyView = [self buildEmptyView];

  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reload) name:@"LeadMessageLogChanged" object:nil];
  [self reload];
}

- (void)dealloc {
  [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (NSString *)currentKind {
  return @[ @"deleted", @"edited", @"profile" ][MAX(0, MIN(2, self.segments.selectedSegmentIndex))];
}

- (void)reload {
  NSString *kind = self.currentKind;
  NSMutableArray *filtered = [NSMutableArray array];
  for (NSDictionary *entry in LeadMessageLogEntries()) {
    if ([entry isKindOfClass:[NSDictionary class]] && [entry[@"kind"] isEqualToString:kind]) [filtered addObject:entry];
  }
  self.entries = filtered;
  NSArray *emptyKeys = @[ @"UI_LOG_EMPTY_DELETED", @"UI_LOG_EMPTY_EDITED", @"UI_LOG_EMPTY_PROFILES" ];
  NSString *emptyKey = emptyKeys[MAX(0, MIN(2, self.segments.selectedSegmentIndex))];
  self.emptyTitle.text = LeadL(emptyKey);
  self.emptyHint.text = LeadL([kind isEqualToString:@"profile"] ? @"UI_LOG_EMPTY_PROFILES_HINT" : @"UI_LOG_EMPTY_HINT");
  self.tableView.backgroundView = filtered.count ? nil : self.emptyView;
  self.navigationItem.rightBarButtonItem.enabled = LeadMessageLogEntries().count > 0;
  [self.tableView reloadData];
}

- (void)segmentChanged {
  LeadSelectionHaptic();
  [UIView transitionWithView:self.tableView duration:0.2 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
    [self reload];
  } completion:nil];
}

- (UIView *)buildEmptyView {
  UIView *container = [UIView new];
  LeadIconTile *tile = [LeadIconTile new];
  tile.side = 56;
  [tile setSymbol:@"tray"];
  tile.translatesAutoresizingMaskIntoConstraints = NO;
  self.emptyTitle = [UILabel new];
  self.emptyTitle.font = LeadRoundedFont(18, UIFontWeightSemibold);
  self.emptyTitle.textAlignment = NSTextAlignmentCenter;
  UILabel *hint = [UILabel new];
  self.emptyHint = hint;
  hint.text = LeadL(@"UI_LOG_EMPTY_HINT");
  hint.font = LeadFont(14, UIFontWeightRegular);
  hint.textColor = UIColor.secondaryLabelColor;
  hint.textAlignment = NSTextAlignmentCenter;
  hint.numberOfLines = 0;
  UIStackView *stack = [[UIStackView alloc] initWithArrangedSubviews:@[ tile, self.emptyTitle, hint ]];
  stack.axis = UILayoutConstraintAxisVertical;
  stack.alignment = UIStackViewAlignmentCenter;
  stack.spacing = 10;
  [stack setCustomSpacing:16 afterView:tile];
  stack.translatesAutoresizingMaskIntoConstraints = NO;
  [container addSubview:stack];
  [NSLayoutConstraint activateConstraints:@[
    [tile.widthAnchor constraintEqualToConstant:56],
    [tile.heightAnchor constraintEqualToConstant:56],
    [stack.centerYAnchor constraintEqualToAnchor:container.centerYAnchor],
    [stack.leadingAnchor constraintEqualToAnchor:container.leadingAnchor constant:40],
    [stack.trailingAnchor constraintEqualToAnchor:container.trailingAnchor constant:-40],
  ]];
  return container;
}

#pragma mark - Formatting

NSString *LeadProfileChangeText(NSDictionary *entry) {
  NSString *field = entry[@"field"];
  NSString *old = [entry[@"old"] isKindOfClass:[NSString class]] ? entry[@"old"] : nil;
  NSString *now = [entry[@"text"] isKindOfClass:[NSString class]] ? entry[@"text"] : nil;
  if ([field isEqualToString:@"photo"]) return LeadL(@"UI_PROFILE_PHOTO_CHANGED");
  if ([field isEqualToString:@"photo_removed"]) return LeadL(@"UI_PROFILE_PHOTO_REMOVED");
  if ([field isEqualToString:@"username"]) {
    return [NSString stringWithFormat:@"%@: %@ → %@", LeadL(@"UI_PROFILE_USERNAME"),
            old.length ? [@"@" stringByAppendingString:old] : @"—", now.length ? [@"@" stringByAppendingString:now] : @"—"];
  }
  return [NSString stringWithFormat:@"%@: %@ → %@", LeadL(@"UI_PROFILE_NAME"), old ?: @"—", now ?: @"—"];
}

static NSString *LeadLogText(id value) {
  NSString *text = [value isKindOfClass:[NSString class]] ? value : nil;
  if (!text) return nil;
  if ([text isEqualToString:@"[media]"]) return LeadL(@"UI_LOG_MEDIA");
  return text;
}

- (NSString *)titleForEntry:(NSDictionary *)entry {
  NSString *name = entry[@"name"];
  if ([name isKindOfClass:[NSString class]] && name.length) return name;
  NSString *username = entry[@"username"];
  if ([username isKindOfClass:[NSString class]] && username.length) return [@"@" stringByAppendingString:username];
  NSString *peer = entry[@"peer"];
  return [peer isKindOfClass:[NSString class]] && peer.length > 1 ? [NSString stringWithFormat:@"ID %@", [peer substringFromIndex:1]] : @"Telegram";
}

- (NSString *)timeForEntry:(NSDictionary *)entry {
  NSDate *date = [NSDate dateWithTimeIntervalSince1970:[entry[@"date"] doubleValue]];
  static NSDateFormatter *time, *day;
  static dispatch_once_t once;
  dispatch_once(&once, ^{
    time = [NSDateFormatter new];
    [time setLocalizedDateFormatFromTemplate:@"jjmm"];
    day = [NSDateFormatter new];
    [day setLocalizedDateFormatFromTemplate:@"dMMM"];
  });
  return [NSCalendar.currentCalendar isDateInToday:date] ? [time stringFromDate:date] : [day stringFromDate:date];
}

- (NSAttributedString *)detailForEntry:(NSDictionary *)entry {
  UIFont *font = LeadFont(14, UIFontWeightRegular);
  if ([entry[@"kind"] isEqualToString:@"profile"]) {
    return [[NSAttributedString alloc] initWithString:LeadProfileChangeText(entry) attributes:@{
      NSFontAttributeName : font,
      NSForegroundColorAttributeName : UIColor.secondaryLabelColor,
    }];
  }
  NSString *text = LeadLogText(entry[@"text"]);
  if ([entry[@"kind"] isEqualToString:@"edited"]) {
    NSMutableAttributedString *result = [NSMutableAttributedString new];
    NSString *old = LeadLogText(entry[@"old"]);
    if (old.length) {
      [result appendAttributedString:[[NSAttributedString alloc] initWithString:old attributes:@{
        NSFontAttributeName : font,
        NSForegroundColorAttributeName : UIColor.tertiaryLabelColor,
        NSStrikethroughStyleAttributeName : @(NSUnderlineStyleSingle),
      }]];
      [result appendAttributedString:[[NSAttributedString alloc] initWithString:@"\n" attributes:@{ NSFontAttributeName : font }]];
    }
    [result appendAttributedString:[[NSAttributedString alloc] initWithString:text ?: @"" attributes:@{
      NSFontAttributeName : font,
      NSForegroundColorAttributeName : UIColor.labelColor,
    }]];
    return result;
  }
  if (text.length == 0) {
    return [[NSAttributedString alloc] initWithString:LeadL(@"UI_LOG_NO_TEXT") attributes:@{
      NSFontAttributeName : [UIFont italicSystemFontOfSize:14],
      NSForegroundColorAttributeName : UIColor.tertiaryLabelColor,
    }];
  }
  return [[NSAttributedString alloc] initWithString:text attributes:@{
    NSFontAttributeName : font,
    NSForegroundColorAttributeName : UIColor.secondaryLabelColor,
  }];
}

#pragma mark - Table

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return self.entries.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  NSDictionary *entry = self.entries[indexPath.row];
  LeadCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LeadCell" forIndexPath:indexPath];
  NSString *title = [self titleForEntry:entry];
  [cell configureTitle:title subtitle:@" " symbol:nil];
  BOOL named = [entry[@"name"] length] > 0 || [entry[@"username"] length] > 0;
  if (named) {
    NSRange first = [title rangeOfComposedCharacterSequenceAtIndex:0];
    [cell.tile setText:[[title substringWithRange:first] uppercaseString]];
  } else {
    // Chat never seen by name: show what kind of event it is instead of a stray letter.
    [cell.tile setSymbol:[entry[@"kind"] isEqualToString:@"edited"] ? @"pencil" : ([entry[@"kind"] isEqualToString:@"profile"] ? @"person" : @"trash")];
  }
  cell.subtitleLabel.attributedText = [self detailForEntry:entry];
  cell.subtitleLabel.numberOfLines = 6;
  [cell showValue:[self timeForEntry:entry] chevron:NO];
  return cell;
}

- (NSString *)urlForEntry:(NSDictionary *)entry {
  return LeadURLForLogEntry(entry);
}

NSString *LeadURLForLogEntry(NSDictionary *entry) {
  NSString *peer = entry[@"peer"];
  if (![peer isKindOfClass:[NSString class]] || peer.length < 2) return nil;
  NSString *rawId = [peer substringFromIndex:1];
  NSString *username = [entry[@"username"] isKindOfClass:[NSString class]] ? entry[@"username"] : nil;
  long long messageId = [entry[@"id"] longLongValue];
  if ([peer hasPrefix:@"c"] && messageId == 0) {
    return username.length ? [NSString stringWithFormat:@"tg://resolve?domain=%@", username] : nil;
  }
  if ([peer hasPrefix:@"c"]) {
    return username.length ? [NSString stringWithFormat:@"tg://resolve?domain=%@&post=%lld", username, messageId]
                           : [NSString stringWithFormat:@"tg://privatepost?channel=%@&post=%lld", rawId, messageId];
  }
  if ([peer hasPrefix:@"u"]) {
    return username.length ? [NSString stringWithFormat:@"tg://resolve?domain=%@", username]
                           : [NSString stringWithFormat:@"tg://user?id=%@", rawId];
  }
  return nil;
}

- (void)openEntry:(NSDictionary *)entry {
  NSString *url = [self urlForEntry:entry];
  if (!url) {
    [LeadToast showText:LeadL(@"UI_LOG_CANT_OPEN") symbol:@"exclamationmark.circle" inView:self.view];
    return;
  }
  LeadOpenTelegramURL(url);
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  [tableView deselectRowAtIndexPath:indexPath animated:YES];
  [self openEntry:self.entries[indexPath.row]];
}

- (UIContextMenuConfiguration *)tableView:(UITableView *)tableView
    contextMenuConfigurationForRowAtIndexPath:(NSIndexPath *)indexPath
                                        point:(CGPoint)point {
  NSDictionary *entry = self.entries[indexPath.row];
  __weak typeof(self) weakSelf = self;
  return [UIContextMenuConfiguration configurationWithIdentifier:nil previewProvider:nil actionProvider:^UIMenu *(__unused NSArray *suggested) {
    NSMutableArray *actions = [NSMutableArray array];
    NSString *text = LeadLogText(entry[@"text"]);
    if (text.length) {
      [actions addObject:[UIAction actionWithTitle:LeadL(@"UI_COPY") image:[UIImage systemImageNamed:@"doc.on.doc"] identifier:nil handler:^(__unused UIAction *action) {
        [UIPasteboard generalPasteboard].string = text;
        [LeadToast showText:LeadL(@"UI_COPIED") symbol:@"checkmark" inView:weakSelf.view];
      }]];
    }
    if ([weakSelf urlForEntry:entry]) {
      [actions addObject:[UIAction actionWithTitle:LeadL(@"UI_LOG_OPEN") image:[UIImage systemImageNamed:@"arrow.up.forward.app"] identifier:nil handler:^(__unused UIAction *action) {
        [weakSelf openEntry:entry];
      }]];
    }
    return [UIMenu menuWithTitle:@"" children:actions];
  }];
}

- (void)clearTapped {
  UIAlertController *alert = [UIAlertController alertControllerWithTitle:LeadL(@"UI_LOG_CLEAR_CONFIRM") message:nil preferredStyle:UIAlertControllerStyleAlert];
  [alert addAction:[UIAlertAction actionWithTitle:LeadL(@"CANCEL") style:UIAlertActionStyleCancel handler:nil]];
  [alert addAction:[UIAlertAction actionWithTitle:LeadL(@"UI_CLEAR") style:UIAlertActionStyleDestructive handler:^(__unused UIAlertAction *action) {
    Class parser = NSClassFromString(@"TLParser");
    SEL selector = NSSelectorFromString(@"clearMessageLog");
    if ([parser respondsToSelector:selector]) ((void (*)(id, SEL))objc_msgSend)(parser, selector);
    LeadImpactHaptic(UIImpactFeedbackStyleMedium);
  }]];
  [self presentViewController:alert animated:YES completion:nil];
}

@end

#pragma mark - Deletion banner

// "Anna · deleted a message" at the top of Telegram when Anti-Revoke catches a
// deletion. Deletions arriving together (a cleared chat) collapse into one banner.
@implementation LeadDeletionBanner {
  NSMutableArray<NSDictionary *> *_pending;
  UIView *_current;
}

+ (instancetype)shared {
  static LeadDeletionBanner *banner;
  static dispatch_once_t once;
  dispatch_once(&once, ^{
    banner = [LeadDeletionBanner new];
  });
  return banner;
}

+ (void)install {
  [[NSNotificationCenter defaultCenter] addObserver:[self shared] selector:@selector(deletion:) name:@"LeadDeletionBanner" object:nil];
}

- (void)deletion:(NSNotification *)note {
  if (!note.userInfo) return;
  if (!_pending) _pending = [NSMutableArray array];
  [_pending addObject:note.userInfo];
  if (_pending.count == 1) {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
      [self flush];
    });
  }
}

- (void)flush {
  NSArray *entries = [_pending copy];
  [_pending removeAllObjects];
  if (entries.count == 0) return;
  UIWindow *window = LeadMainWindow();
  if (!window) return;
  NSDictionary *first = entries.firstObject;
  NSString *name = [first[@"name"] isKindOfClass:[NSString class]] && [first[@"name"] length] ? first[@"name"] : LeadL(@"UI_BANNER_FALLBACK");
  NSString *text = LeadLogText(first[@"text"]);
  NSString *detail = entries.count > 1 ? [NSString stringWithFormat:LeadL(@"UI_BANNER_MANY"), (long)entries.count]
                                       : (text.length ? [NSString stringWithFormat:@"%@: %@", LeadL(@"UI_BANNER_ONE"), text] : LeadL(@"UI_BANNER_ONE"));
  [self showTitle:name detail:detail entry:entries.count == 1 ? first : nil inWindow:window];
}

- (void)showTitle:(NSString *)title detail:(NSString *)detail entry:(NSDictionary *)entry inWindow:(UIWindow *)window {
  [_current removeFromSuperview];
  UIVisualEffectView *card = [[UIVisualEffectView alloc] initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleSystemChromeMaterial]];
  card.layer.cornerRadius = 22;
  card.layer.cornerCurve = kCACornerCurveContinuous;
  card.clipsToBounds = YES;
  card.translatesAutoresizingMaskIntoConstraints = NO;

  LeadIconTile *tile = [LeadIconTile new];
  tile.side = 34;
  [tile setSymbol:@"trash"];
  [tile setActive:YES animated:NO];
  tile.translatesAutoresizingMaskIntoConstraints = NO;
  UILabel *titleLabel = [UILabel new];
  titleLabel.text = title;
  titleLabel.font = LeadFont(15, UIFontWeightSemibold);
  UILabel *detailLabel = [UILabel new];
  detailLabel.text = detail;
  detailLabel.font = LeadFont(14, UIFontWeightRegular);
  detailLabel.textColor = UIColor.secondaryLabelColor;
  detailLabel.numberOfLines = 2;
  UIStackView *texts = [[UIStackView alloc] initWithArrangedSubviews:@[ titleLabel, detailLabel ]];
  texts.axis = UILayoutConstraintAxisVertical;
  texts.spacing = 1;
  UIStackView *row = [[UIStackView alloc] initWithArrangedSubviews:@[ tile, texts ]];
  row.spacing = 12;
  row.alignment = UIStackViewAlignmentCenter;
  row.translatesAutoresizingMaskIntoConstraints = NO;
  [card.contentView addSubview:row];
  [window addSubview:card];
  _current = card;
  [NSLayoutConstraint activateConstraints:@[
    [tile.widthAnchor constraintEqualToConstant:34],
    [tile.heightAnchor constraintEqualToConstant:34],
    [row.leadingAnchor constraintEqualToAnchor:card.contentView.leadingAnchor constant:12],
    [row.trailingAnchor constraintEqualToAnchor:card.contentView.trailingAnchor constant:-16],
    [row.topAnchor constraintEqualToAnchor:card.contentView.topAnchor constant:11],
    [row.bottomAnchor constraintEqualToAnchor:card.contentView.bottomAnchor constant:-11],
    [card.topAnchor constraintEqualToAnchor:window.safeAreaLayoutGuide.topAnchor constant:6],
    [card.leadingAnchor constraintEqualToAnchor:window.safeAreaLayoutGuide.leadingAnchor constant:12],
    [card.trailingAnchor constraintEqualToAnchor:window.safeAreaLayoutGuide.trailingAnchor constant:-12],
  ]];
  [window layoutIfNeeded];

  if (entry && LeadURLForLogEntry(entry)) {
    objc_setAssociatedObject(card, @selector(tapped:), entry, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [card addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapped:)]];
  }
  UISwipeGestureRecognizer *swipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swiped:)];
  swipe.direction = UISwipeGestureRecognizerDirectionUp;
  [card addGestureRecognizer:swipe];
  [card addGestureRecognizer:[[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(pressed:)]];

  LeadImpactHaptic(UIImpactFeedbackStyleLight);
  card.alpha = 0;
  card.transform = CGAffineTransformMakeTranslation(0, -60);
  LeadSpring(0.55, 0.78, ^{
    card.alpha = 1;
    card.transform = CGAffineTransformIdentity;
  }, nil);
  __weak UIView *weakCard = card;
  dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
    [self dismiss:weakCard];
  });
}

- (void)dismiss:(UIView *)card {
  if (!card.superview) return;
  [UIView animateWithDuration:0.25 animations:^{
    card.alpha = 0;
    card.transform = CGAffineTransformMakeTranslation(0, -40);
  } completion:^(__unused BOOL finished) {
    [card removeFromSuperview];
  }];
}

- (void)swiped:(UISwipeGestureRecognizer *)gesture {
  [self dismiss:gesture.view];
}

// Long press: offer to turn the banner off without going through the menu.
- (void)pressed:(UILongPressGestureRecognizer *)gesture {
  if (gesture.state != UIGestureRecognizerStateBegan) return;
  UIView *card = gesture.view;
  UIViewController *host = card.window.rootViewController;
  while (host.presentedViewController) host = host.presentedViewController;
  if (!host) return;
  LeadImpactHaptic(UIImpactFeedbackStyleMedium);
  UIAlertController *alert = [UIAlertController alertControllerWithTitle:LeadL(@"UI_BANNER_DISABLE_TITLE")
                                                                 message:LeadL(@"UI_BANNER_DISABLE_MESSAGE")
                                                          preferredStyle:UIAlertControllerStyleActionSheet];
  [alert addAction:[UIAlertAction actionWithTitle:LeadL(@"UI_BANNER_DISABLE_ACTION") style:UIAlertActionStyleDestructive handler:^(__unused UIAlertAction *action) {
    LeadSetBool(kDeletionBanner, NO);
    [self dismiss:card];
    [LeadToast showText:LeadL(@"UI_BANNER_DISABLED") symbol:@"bell.slash" inView:host.view];
  }]];
  [alert addAction:[UIAlertAction actionWithTitle:LeadL(@"CANCEL") style:UIAlertActionStyleCancel handler:nil]];
  alert.popoverPresentationController.sourceView = card;
  alert.popoverPresentationController.sourceRect = card.bounds;
  [host presentViewController:alert animated:YES completion:nil];
}

- (void)tapped:(UITapGestureRecognizer *)gesture {
  NSDictionary *entry = objc_getAssociatedObject(gesture.view, @selector(tapped:));
  [self dismiss:gesture.view];
  NSString *url = LeadURLForLogEntry(entry);
  if (url) LeadOpenTelegramURL(url);
}

@end
