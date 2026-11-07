#import "Headers.h"
#import "LeadMenu.h"
#import <objc/runtime.h>

// Announcements are fetched from this JSON file on GitHub
static NSString *const kLeadAnnouncementsURL = @"https://raw.githubusercontent.com/w3ltyyy/lead/main/announcements.json";

static NSString *const kCellId = @"LeadCell";
static NSString *const kHeroId = @"LeadHero";
static NSString *const kHeaderId = @"LeadHeader";

typedef NS_ENUM(NSInteger, LeadHomeSection) {
  LeadHomeSectionGhost = 0,
  LeadHomeSectionFeatures,
  LeadHomeSectionGeneral,
  LeadHomeSectionAbout,
  LeadHomeSectionCount
};

typedef NS_ENUM(NSInteger, LeadGeneralRow) {
  LeadGeneralRowCompat = 0,
  LeadGeneralRowLanguage,
  LeadGeneralRowExport,
  LeadGeneralRowImport,
  LeadGeneralRowCount
};

typedef NS_ENUM(NSInteger, LeadAboutRow) {
  LeadAboutRowDeveloper = 0,
  LeadAboutRowSupport,
  LeadAboutRowDisclaimer,
  LeadAboutRowDebugLog,
  LeadAboutRowCount
};

static NSDictionary<NSString *, NSString *> *LeadLanguageNames(void) {
  return @{
    @"ar" : @"العربية", @"cn" : @"简体中文", @"en" : @"English", @"es" : @"Español", @"fr" : @"Français",
    @"it" : @"Italiano", @"ja" : @"日本語", @"ru" : @"Русский", @"tr" : @"Türkçe", @"tw" : @"繁體中文", @"vn" : @"Tiếng Việt"
  };
}

@interface Lead () <UISearchResultsUpdating, UIScrollViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UISearchController *searchController;
@property (nonatomic, strong) NSArray<LeadPage *> *pages;
@property (nonatomic, strong) LeadPage *ghostPage;
@property (nonatomic, strong) NSArray *searchResults; // LeadRow or LeadPage
@property (nonatomic, strong) UIView *headerView;
@property (nonatomic, strong) LeadLogoView *logoView;
@property (nonatomic, strong) UILabel *statusLabel;
@property (nonatomic, strong) UIView *statusDot;
@property (nonatomic, strong) UIStackView *announcementStack;
@property (nonatomic, strong) UILabel *navTitleLabel;
@property (nonatomic, strong) UILabel *emptySearchLabel;
@property (nonatomic, strong) UIView *engineWarningCard;
@property (nonatomic, assign) BOOL didIntro;
@property (nonatomic, assign) BOOL didAnimateRows;
@property (nonatomic, assign) NSInteger appearOrder;
@end

@implementation Lead

+ (void)presentMenu {
  UIViewController *root = LeadTopPresenter();
  if (!root) return;
  // Already open (and actually on screen) — nothing to do.
  if ([root isKindOfClass:[LeadNavigationController class]] && root.view.window) return;
  LeadNavigationController *nav = [[LeadNavigationController alloc] initWithRootViewController:[Lead new]];
  [root presentViewController:nav animated:YES completion:nil];
}

- (void)viewDidLoad {
  [super viewDidLoad];
  self.view.backgroundColor = UIColor.systemGroupedBackgroundColor;
  self.ghostPage = LeadGhostPage();
  self.pages = LeadFeaturePages();

  [self setupNavigation];
  [self setupTable];
  [self setupHeader];
  [self setupFooter];
  [self refreshStatusAnimated:NO];
  [self fetchAnnouncements];
  LeadRefreshContentSettings();

  NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
  [center addObserver:self selector:@selector(settingsChanged) name:LeadSettingsDidChangeNotification object:nil];
  [center addObserver:self selector:@selector(settingsChanged) name:@"LeadLocationChanged" object:nil];
}

- (void)dealloc {
  [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
  [self settingsChanged];
  [self refreshEngineWarning];
}

// With Telegram's Rust engine (Debug menu) no request passes through MtProtoKit,
// so every network feature of Lead is silently off. Say so instead of pretending.
- (void)refreshEngineWarning {
  BOOL blind = LeadNetworkHookActivity() == 0 && LeadTweakUptime() > 20;
  if (blind == (self.engineWarningCard != nil)) return;
  if (blind) {
    self.engineWarningCard = [self announcementCardWithTitle:LeadL(@"UI_RUST_TITLE") message:LeadL(@"UI_RUST_MESSAGE") type:@"warning" url:nil];
    [self.announcementStack insertArrangedSubview:self.engineWarningCard atIndex:0];
  } else {
    [self.engineWarningCard removeFromSuperview];
    self.engineWarningCard = nil;
  }
  [self.view setNeedsLayout];
}

- (void)viewDidAppear:(BOOL)animated {
  [super viewDidAppear:animated];
  if (!self.didIntro) {
    self.didIntro = YES;
    [self.logoView playIntro];
  }
}

#pragma mark - Setup

- (void)setupNavigation {
  self.navigationItem.largeTitleDisplayMode = UINavigationItemLargeTitleDisplayModeNever;

  // System close button: a gray circle up to iOS 18, Liquid Glass on 26.
  self.navigationItem.leftBarButtonItem =
      [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemClose target:self action:@selector(closeTapped)];

  self.navTitleLabel = [UILabel new];
  self.navTitleLabel.text = @"Lead";
  self.navTitleLabel.font = LeadRoundedFont(17, UIFontWeightSemibold);
  self.navTitleLabel.alpha = 0;
  // Navigation transitions animate the titleView's own alpha back to 1, so the
  // scroll-driven fade lives on a label inside a container.
  [self.navTitleLabel sizeToFit];
  UIView *titleContainer = [[UIView alloc] initWithFrame:self.navTitleLabel.bounds];
  [titleContainer addSubview:self.navTitleLabel];
  self.navigationItem.titleView = titleContainer;
  self.navigationItem.backButtonTitle = @"Lead";

  self.searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
  self.searchController.searchResultsUpdater = self;
  self.searchController.obscuresBackgroundDuringPresentation = NO;
  self.searchController.searchBar.placeholder = LeadL(@"UI_SEARCH");
  self.navigationItem.searchController = self.searchController;
  self.navigationItem.hidesSearchBarWhenScrolling = YES;
  self.definesPresentationContext = YES;
}

- (void)setupTable {
  self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleInsetGrouped];
  self.tableView.dataSource = self;
  self.tableView.delegate = self;
  self.tableView.backgroundColor = UIColor.systemGroupedBackgroundColor;
  self.tableView.rowHeight = UITableViewAutomaticDimension;
  self.tableView.estimatedRowHeight = 60;
  self.tableView.sectionHeaderHeight = UITableViewAutomaticDimension;
  self.tableView.estimatedSectionHeaderHeight = 36;
  self.tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
  [self.tableView registerClass:[LeadCell class] forCellReuseIdentifier:kCellId];
  [self.tableView registerClass:[LeadHeroCell class] forCellReuseIdentifier:kHeroId];
  [self.tableView registerClass:[LeadSectionHeader class] forHeaderFooterViewReuseIdentifier:kHeaderId];
  self.tableView.translatesAutoresizingMaskIntoConstraints = NO;
  [self.view addSubview:self.tableView];
  [NSLayoutConstraint activateConstraints:@[
    [self.tableView.topAnchor constraintEqualToAnchor:self.view.topAnchor],
    [self.tableView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor],
    [self.tableView.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor],
    [self.tableView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor],
  ]];

  self.emptySearchLabel = [UILabel new];
  self.emptySearchLabel.text = LeadL(@"UI_SEARCH_EMPTY");
  self.emptySearchLabel.font = LeadFont(15, UIFontWeightRegular);
  self.emptySearchLabel.textColor = UIColor.secondaryLabelColor;
  self.emptySearchLabel.textAlignment = NSTextAlignmentCenter;
}

- (void)setupHeader {
  UIView *header = [UIView new];

  self.logoView = [LeadLogoView new];
  self.logoView.translatesAutoresizingMaskIntoConstraints = NO;
  [header addSubview:self.logoView];

  UILabel *title = [UILabel new];
  title.text = @"Lead";
  title.font = LeadRoundedFont(32, UIFontWeightBold);
  title.textColor = UIColor.labelColor;

  self.statusDot = [UIView new];
  self.statusDot.layer.cornerRadius = 3.5;
  [self.statusDot.widthAnchor constraintEqualToConstant:7].active = YES;
  [self.statusDot.heightAnchor constraintEqualToConstant:7].active = YES;
  self.statusLabel = [UILabel new];
  self.statusLabel.font = LeadFont(14, UIFontWeightMedium);
  self.statusLabel.textColor = UIColor.secondaryLabelColor;
  UIStackView *status = [[UIStackView alloc] initWithArrangedSubviews:@[ self.statusDot, self.statusLabel ]];
  status.spacing = 7;
  status.alignment = UIStackViewAlignmentCenter;

  UIStackView *titles = [[UIStackView alloc] initWithArrangedSubviews:@[ title, status ]];
  titles.axis = UILayoutConstraintAxisVertical;
  titles.alignment = UIStackViewAlignmentCenter;
  titles.spacing = 4;
  titles.translatesAutoresizingMaskIntoConstraints = NO;
  [header addSubview:titles];

  self.announcementStack = [UIStackView new];
  self.announcementStack.axis = UILayoutConstraintAxisVertical;
  self.announcementStack.spacing = 10;
  self.announcementStack.translatesAutoresizingMaskIntoConstraints = NO;
  [header addSubview:self.announcementStack];

  [NSLayoutConstraint activateConstraints:@[
    [self.logoView.topAnchor constraintEqualToAnchor:header.topAnchor constant:4],
    [self.logoView.centerXAnchor constraintEqualToAnchor:header.centerXAnchor],
    [self.logoView.widthAnchor constraintEqualToConstant:72],
    [self.logoView.heightAnchor constraintEqualToConstant:72],
    [titles.topAnchor constraintEqualToAnchor:self.logoView.bottomAnchor constant:10],
    [titles.centerXAnchor constraintEqualToAnchor:header.centerXAnchor],
    [self.announcementStack.topAnchor constraintEqualToAnchor:titles.bottomAnchor constant:18],
    [self.announcementStack.leadingAnchor constraintEqualToAnchor:header.leadingAnchor constant:20],
    [self.announcementStack.trailingAnchor constraintEqualToAnchor:header.trailingAnchor constant:-20],
    [self.announcementStack.bottomAnchor constraintEqualToAnchor:header.bottomAnchor constant:-4],
  ]];
  self.headerView = header;
  [self layoutHeader];
}

- (void)layoutHeader {
  if (self.isSearching) return;
  CGFloat width = self.tableView.bounds.size.width ?: UIScreen.mainScreen.bounds.size.width;
  CGFloat height = [self.headerView systemLayoutSizeFittingSize:CGSizeMake(width, UILayoutFittingCompressedSize.height)
                                  withHorizontalFittingPriority:UILayoutPriorityRequired
                                        verticalFittingPriority:UILayoutPriorityFittingSizeLevel].height;
  if (self.tableView.tableHeaderView == self.headerView && fabs(self.headerView.frame.size.height - height) < 0.5 &&
      fabs(self.headerView.frame.size.width - width) < 0.5) {
    return;
  }
  self.headerView.frame = CGRectMake(0, 0, width, height);
  self.tableView.tableHeaderView = self.headerView;
}

- (void)viewDidLayoutSubviews {
  [super viewDidLayoutSubviews];
  [self layoutHeader];
}

- (void)setupFooter {
  UILabel *footer = [UILabel new];
  footer.numberOfLines = 0;
  footer.textAlignment = NSTextAlignmentCenter;
  footer.font = LeadFont(12, UIFontWeightRegular);
  footer.textColor = UIColor.tertiaryLabelColor;
  footer.text = [NSString stringWithFormat:@"Lead %@ (%@)\n© 2026 Lead Team", kLeadTweakVersion, kLeadTweakBuild];
  footer.frame = CGRectMake(0, 0, 320, 72);
  self.tableView.tableFooterView = footer;
}

#pragma mark - State

- (void)settingsChanged {
  [self refreshStatusAnimated:YES];
  if (self.isSearching) {
    [self updateSearchResultsForSearchController:self.searchController];
    return;
  }
  for (NSIndexPath *indexPath in self.tableView.indexPathsForVisibleRows) {
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    if ([cell isKindOfClass:[LeadHeroCell class]]) {
      [(LeadHeroCell *)cell configureTitle:LeadL(@"GHOST_MODE_SECTION_HEADER")
                                     status:LeadGhostStatusText()
                                         on:[[NSUserDefaults standardUserDefaults] boolForKey:kGhostModeEnabled]
                                   animated:YES];
    } else if (indexPath.section == LeadHomeSectionFeatures && [cell isKindOfClass:[LeadCell class]]) {
      LeadPage *page = self.pages[indexPath.row];
      [(LeadCell *)cell showValue:[self valueForPage:page] chevron:YES];
      [((LeadCell *)cell).tile setActive:page.enabledCount > 0 animated:YES];
    }
  }
}

- (void)refreshStatusAnimated:(BOOL)animated {
  NSInteger count = LeadEnabledFeatureCount();
  NSString *text = count > 0 ? [NSString stringWithFormat:LeadL(@"UI_STATUS_ON"), (long)count] : LeadL(@"UI_STATUS_NONE");
  UIColor *dot = count > 0 ? UIColor.systemGreenColor : UIColor.tertiaryLabelColor;
  if (!animated || [self.statusLabel.text isEqualToString:text]) {
    self.statusLabel.text = text;
    self.statusDot.backgroundColor = dot;
    return;
  }
  [UIView transitionWithView:self.statusLabel duration:0.2 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
    self.statusLabel.text = text;
  } completion:nil];
  [UIView animateWithDuration:0.25 animations:^{ self.statusDot.backgroundColor = dot; }];
  self.statusDot.transform = CGAffineTransformMakeScale(1.8, 1.8);
  LeadSpring(0.5, 0.45, ^{ self.statusDot.transform = CGAffineTransformIdentity; }, nil);
}

- (NSString *)valueForPage:(LeadPage *)page {
  NSInteger count = page.enabledCount;
  return count > 0 ? [NSString stringWithFormat:LeadL(@"UI_ON_COUNT"), (long)count] : LeadL(@"UI_OFF");
}

#pragma mark - Search

- (BOOL)isSearching {
  return self.searchController.isActive && self.searchController.searchBar.text.length > 0;
}

- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {
  NSString *query = [searchController.searchBar.text stringByTrimmingCharactersInSet:NSCharacterSet.whitespaceCharacterSet];
  NSMutableArray *results = [NSMutableArray array];
  if (query.length > 0) {
    NSStringCompareOptions options = NSCaseInsensitiveSearch | NSDiacriticInsensitiveSearch;
    NSMutableArray *allPages = [NSMutableArray arrayWithObject:self.ghostPage];
    [allPages addObjectsFromArray:self.pages];
    for (LeadPage *page in allPages) {
      if ([LeadL(page.titleKey) rangeOfString:query options:options].location != NSNotFound) [results addObject:page];
    }
    for (LeadPage *page in allPages) {
      for (LeadSection *section in page.sections) {
        for (LeadRow *row in section.rows) {
          if ([row.title rangeOfString:query options:options].location != NSNotFound ||
              (row.subtitle && [row.subtitle rangeOfString:query options:options].location != NSNotFound)) {
            [results addObject:row];
          }
        }
      }
    }
  }
  self.searchResults = results;
  self.tableView.backgroundView = (self.isSearching && results.count == 0) ? self.emptySearchLabel : nil;
  // Results get the whole screen; the header comes back with the full list.
  UIView *wantedHeader = self.isSearching ? nil : self.headerView;
  if (self.tableView.tableHeaderView != wantedHeader) {
    self.tableView.tableHeaderView = wantedHeader;
  }
  [self.tableView reloadData];
}

#pragma mark - Table

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return self.isSearching ? 1 : LeadHomeSectionCount;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  if (self.isSearching) return self.searchResults.count;
  switch (section) {
  case LeadHomeSectionGhost: return 1;
  case LeadHomeSectionFeatures: return self.pages.count;
  case LeadHomeSectionGeneral: return LeadGeneralRowCount;
  case LeadHomeSectionAbout: return LeadAboutRowCount;
  }
  return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  if (self.isSearching) return [self searchCellAt:indexPath];

  if (indexPath.section == LeadHomeSectionGhost) {
    LeadHeroCell *hero = [tableView dequeueReusableCellWithIdentifier:kHeroId forIndexPath:indexPath];
    [hero configureTitle:LeadL(@"GHOST_MODE_SECTION_HEADER")
                  status:LeadGhostStatusText()
                      on:[[NSUserDefaults standardUserDefaults] boolForKey:kGhostModeEnabled]
                animated:NO];
    hero.accessoryType = UITableViewCellAccessoryNone;
    __weak typeof(self) weakSelf = self;
    hero.onToggle = ^(BOOL on) {
      if (on) {
        LeadEnableGhostMode(weakSelf);
      } else {
        LeadSetBool(kGhostModeEnabled, NO);
      }
    };
    return hero;
  }

  LeadCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellId forIndexPath:indexPath];
  if (indexPath.section == LeadHomeSectionFeatures) {
    LeadPage *page = self.pages[indexPath.row];
    [cell configureTitle:LeadL(page.titleKey) subtitle:nil symbol:page.symbol];
    [cell showValue:[self valueForPage:page] chevron:YES];
    [cell.tile setActive:page.enabledCount > 0 animated:NO];
  } else if (indexPath.section == LeadHomeSectionGeneral) {
    if (indexPath.row == LeadGeneralRowCompat) {
      [cell configureTitle:LeadL(@"UI_COMPAT_TITLE") subtitle:LeadL(@"UI_COMPAT_SUBTITLE") symbol:@"checkmark.shield"];
      [cell showValue:nil chevron:YES];
    } else if (indexPath.row == LeadGeneralRowLanguage) {
      NSString *code = [[NSUserDefaults standardUserDefaults] stringForKey:@"LeadLanguage"] ?: @"en";
      [cell configureTitle:LeadL(@"LANGUAGE_SECTION_HEADER") subtitle:nil symbol:@"globe"];
      [cell showValue:LeadLanguageNames()[code] ?: code chevron:YES];
    } else if (indexPath.row == LeadGeneralRowExport) {
      [cell configureTitle:LeadL(@"UI_EXPORT") subtitle:LeadL(@"UI_EXPORT_SUBTITLE") symbol:@"square.and.arrow.up"];
      [cell showValue:nil chevron:NO];
    } else {
      [cell configureTitle:LeadL(@"UI_IMPORT") subtitle:LeadL(@"UI_IMPORT_SUBTITLE") symbol:@"square.and.arrow.down"];
      [cell showValue:nil chevron:NO];
    }
  } else {
    switch (indexPath.row) {
    case LeadAboutRowDeveloper:
      [cell configureTitle:@"w3ltyyy · Lead Team" subtitle:@"@Leadgramm" symbol:nil];
      [cell.tile setImage:LeadLogoImage(60)];
      [cell showValue:nil chevron:YES];
      break;
    case LeadAboutRowSupport:
      [cell configureTitle:LeadL(@"UI_SUPPORT") subtitle:LeadL(@"UI_SUPPORT_SUBTITLE") symbol:@"heart"];
      [cell showValue:nil chevron:YES];
      break;
    case LeadAboutRowDisclaimer:
      [cell configureTitle:LeadL(@"DISCLAIMER") subtitle:LeadL(@"UI_DISCLAIMER_SUBTITLE") symbol:@"text.quote"];
      [cell showValue:nil chevron:YES];
      break;
    case LeadAboutRowDebugLog:
      [cell configureTitle:LeadL(@"UI_DEBUG_LOG") subtitle:nil symbol:@"ladybug"];
      [cell showValue:nil chevron:YES];
      break;
    }
  }
  return cell;
}

- (UITableViewCell *)searchCellAt:(NSIndexPath *)indexPath {
  id item = self.searchResults[indexPath.row];
  LeadCell *cell = [self.tableView dequeueReusableCellWithIdentifier:kCellId forIndexPath:indexPath];
  if ([item isKindOfClass:[LeadPage class]]) {
    LeadPage *page = item;
    [cell configureTitle:LeadL(page.titleKey) subtitle:nil symbol:page.symbol];
    [cell showValue:page.isGhost ? nil : [self valueForPage:page] chevron:YES];
    return cell;
  }
  LeadRow *row = item;
  [cell configureTitle:row.title subtitle:row.subtitle symbol:row.symbol];
  [cell setDestructive:row.destructive];
  if (row.style == LeadRowStyleToggle) {
    [cell showToggle:row.isOn];
    NSString *key = row.defaultsKey;
    __weak typeof(self) weakSelf = self;
    cell.onToggle = ^(BOOL on) {
      if ([key isEqualToString:kGhostModeEnabled] && on) {
        LeadEnableGhostMode(weakSelf);
      } else {
        LeadSetBool(key, on);
        if (row.toggleBlock) row.toggleBlock(on, weakSelf);
      }
    };
  } else {
    [cell showValue:row.valueBlock ? row.valueBlock() : nil chevron:row.style == LeadRowStyleLink];
  }
  return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
  if (self.didAnimateRows || self.isSearching) return;
  LeadAnimateCellIn(cell, self.appearOrder++ + 4);
  dispatch_async(dispatch_get_main_queue(), ^{
    self.didAnimateRows = YES;
  });
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
  NSString *key = nil;
  if (!self.isSearching) {
    if (section == LeadHomeSectionFeatures) key = @"UI_SECTION_FEATURES";
    if (section == LeadHomeSectionGeneral) key = @"UI_SECTION_GENERAL";
    if (section == LeadHomeSectionAbout) key = @"UI_SECTION_ABOUT";
  }
  if (!key) return nil;
  LeadSectionHeader *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:kHeaderId];
  header.label.text = LeadL(key);
  header.actionButton.hidden = YES;
  return header;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
  if (self.isSearching || section == LeadHomeSectionGhost) return 8;
  return UITableViewAutomaticDimension;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  [tableView deselectRowAtIndexPath:indexPath animated:YES];
  if (self.isSearching) {
    id item = self.searchResults[indexPath.row];
    if ([item isKindOfClass:[LeadPage class]]) {
      [self openPage:item];
    } else if ([(LeadRow *)item style] == LeadRowStyleToggle) {
      LeadCell *cell = [tableView cellForRowAtIndexPath:indexPath];
      [cell.toggle setOn:!cell.toggle.on animated:YES];
      [cell.toggle sendActionsForControlEvents:UIControlEventValueChanged];
    } else if ([(LeadRow *)item tapBlock]) {
      [(LeadRow *)item tapBlock](self);
    }
    return;
  }

  switch (indexPath.section) {
  case LeadHomeSectionGhost:
    [self openPage:self.ghostPage];
    break;
  case LeadHomeSectionFeatures:
    [self openPage:self.pages[indexPath.row]];
    break;
  case LeadHomeSectionGeneral:
    if (indexPath.row == LeadGeneralRowCompat) {
      [self.navigationController pushViewController:[LeadCompatViewController new] animated:YES];
    } else if (indexPath.row == LeadGeneralRowLanguage) {
      [self.navigationController pushViewController:[LanguageSelector new] animated:YES];
    } else if (indexPath.row == LeadGeneralRowExport) {
      LeadExportSettings(self);
    } else {
      LeadImportSettings(self);
    }
    break;
  case LeadHomeSectionAbout:
    [self openAboutRow:indexPath.row];
    break;
  }
}

- (void)openPage:(LeadPage *)page {
  [self.navigationController pushViewController:[[LeadPageViewController alloc] initWithPage:page] animated:YES];
}

- (void)openAboutRow:(NSInteger)row {
  switch (row) {
  case LeadAboutRowDeveloper:
    LeadOpenTelegramURL(@"https://t.me/Leadgramm");
    break;
  case LeadAboutRowSupport:
    [self.navigationController pushViewController:[DonateViewController new] animated:YES];
    break;
  case LeadAboutRowDisclaimer:
    [self.navigationController pushViewController:[[LeadTextViewController alloc] initWithTitle:LeadL(@"DISCLAIMER") text:LeadL(@"AUTHOR_MESSAGE") monospaced:NO]
                                         animated:YES];
    break;
  case LeadAboutRowDebugLog: {
    LeadTextViewController *log = [[LeadTextViewController alloc] initWithTitle:LeadL(@"UI_DEBUG_LOG") text:nil monospaced:YES];
    log.filePath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/lead_debug.txt"];
    [self.navigationController pushViewController:log animated:YES];
    break;
  }
  }
}

#pragma mark - Scroll

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
  CGFloat y = scrollView.contentOffset.y + scrollView.adjustedContentInset.top;
  if (y < 0) {
    // Pull down: the mark grows a little, like it's being stretched.
    CGFloat scale = 1.0 + MIN(-y, 160) / 400.0;
    self.logoView.transform = CGAffineTransformMakeScale(scale, scale);
    self.logoView.alpha = 1;
  } else {
    self.logoView.transform = CGAffineTransformMakeTranslation(0, y * 0.35);
    self.logoView.alpha = MAX(0, 1 - y / 90.0);
  }
  self.navTitleLabel.alpha = MIN(1, MAX(0, (y - 90) / 30.0));
}

#pragma mark - Announcements

- (void)fetchAnnouncements {
  NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:kLeadAnnouncementsURL]];
  request.timeoutInterval = 10;
  request.cachePolicy = NSURLRequestReloadIgnoringLocalCacheData;
  __weak typeof(self) weakSelf = self;
  [[[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData *data, __unused NSURLResponse *response, NSError *error) {
    if (error || !data) return;
    id parsed = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    NSArray *items = [parsed isKindOfClass:[NSArray class]] ? parsed : ([parsed isKindOfClass:[NSDictionary class]] ? @[ parsed ] : @[]);
    dispatch_async(dispatch_get_main_queue(), ^{
      [weakSelf showAnnouncements:items];
    });
  }] resume];
}

- (NSString *)symbolForAnnouncementType:(NSString *)type {
  if ([type isEqualToString:@"update"]) return @"arrow.down.circle";
  if ([type isEqualToString:@"warning"]) return @"exclamationmark.triangle";
  if ([type isEqualToString:@"promo"]) return @"star";
  return @"info.circle";
}

- (void)showAnnouncements:(NSArray *)items {
  for (UIView *view in self.announcementStack.arrangedSubviews) {
    if (view != self.engineWarningCard) [view removeFromSuperview];
  }
  NSMutableArray<UIView *> *cards = [NSMutableArray array];
  for (NSDictionary *item in items) {
    if (![item isKindOfClass:[NSDictionary class]]) continue;
    // target_version: shown only to users below that version.
    NSString *target = [item[@"target_version"] isKindOfClass:[NSString class]] ? item[@"target_version"] : nil;
    if (target.length && [kLeadTweakVersion compare:target options:NSNumericSearch] != NSOrderedAscending) continue;
    NSString *url = [item[@"url"] isKindOfClass:[NSString class]] ? item[@"url"] : nil;
    UIView *card = [self announcementCardWithTitle:item[@"title"] message:item[@"message"] type:item[@"type"] url:url];
    [self.announcementStack addArrangedSubview:card];
    [cards addObject:card];
  }
  [self.view setNeedsLayout];
  [self.view layoutIfNeeded];
  [UIView animateWithDuration:0.35 animations:^{
    [self.tableView beginUpdates];
    [self.tableView endUpdates];
  }];
  [cards enumerateObjectsUsingBlock:^(UIView *card, NSUInteger idx, __unused BOOL *stop) {
    card.alpha = 0;
    card.transform = CGAffineTransformMakeTranslation(0, 10);
    [UIView animateWithDuration:0.5 delay:0.06 * idx usingSpringWithDamping:0.85 initialSpringVelocity:0 options:0 animations:^{
      card.alpha = 1;
      card.transform = CGAffineTransformIdentity;
    } completion:nil];
  }];
}

- (UIView *)announcementCardWithTitle:(NSString *)title message:(NSString *)message type:(NSString *)type url:(NSString *)url {
  UIControl *card = [UIControl new];
  card.backgroundColor = UIColor.secondarySystemGroupedBackgroundColor;
  card.layer.cornerRadius = 14;
  card.layer.cornerCurve = kCACornerCurveContinuous;

  LeadIconTile *tile = [LeadIconTile new];
  tile.side = 30;
  [tile setSymbol:[self symbolForAnnouncementType:[type isKindOfClass:[NSString class]] ? type : @"info"]];
  tile.translatesAutoresizingMaskIntoConstraints = NO;
  tile.userInteractionEnabled = NO;

  UILabel *titleLabel = [UILabel new];
  titleLabel.text = [title isKindOfClass:[NSString class]] ? title : @"";
  titleLabel.font = LeadFont(15, UIFontWeightSemibold);
  titleLabel.numberOfLines = 0;
  UILabel *messageLabel = [UILabel new];
  messageLabel.text = [message isKindOfClass:[NSString class]] ? message : @"";
  messageLabel.font = LeadFont(13, UIFontWeightRegular);
  messageLabel.textColor = UIColor.secondaryLabelColor;
  messageLabel.numberOfLines = 0;
  UIStackView *texts = [[UIStackView alloc] initWithArrangedSubviews:@[ titleLabel, messageLabel ]];
  texts.axis = UILayoutConstraintAxisVertical;
  texts.spacing = 2;
  texts.userInteractionEnabled = NO;
  texts.translatesAutoresizingMaskIntoConstraints = NO;
  [card addSubview:tile];
  [card addSubview:texts];

  NSLayoutXAxisAnchor *trailing = card.trailingAnchor;
  CGFloat trailingInset = -14;
  if (url.length) {
    UIImageView *chevron = [[UIImageView alloc] initWithImage:[UIImage systemImageNamed:@"chevron.right"
                                                                       withConfiguration:[UIImageSymbolConfiguration configurationWithPointSize:12 weight:UIImageSymbolWeightSemibold]]];
    chevron.tintColor = UIColor.tertiaryLabelColor;
    chevron.translatesAutoresizingMaskIntoConstraints = NO;
    [card addSubview:chevron];
    [NSLayoutConstraint activateConstraints:@[
      [chevron.trailingAnchor constraintEqualToAnchor:card.trailingAnchor constant:-14],
      [chevron.centerYAnchor constraintEqualToAnchor:card.centerYAnchor],
    ]];
    trailing = chevron.leadingAnchor;
    trailingInset = -10;
    card.accessibilityHint = url;
    [card addTarget:self action:@selector(announcementTapped:) forControlEvents:UIControlEventTouchUpInside];
    [card addTarget:self action:@selector(cardDown:) forControlEvents:UIControlEventTouchDown | UIControlEventTouchDragEnter];
    [card addTarget:self action:@selector(cardUp:) forControlEvents:UIControlEventTouchUpInside | UIControlEventTouchUpOutside | UIControlEventTouchCancel | UIControlEventTouchDragExit];
  }
  [NSLayoutConstraint activateConstraints:@[
    [tile.widthAnchor constraintEqualToConstant:30],
    [tile.heightAnchor constraintEqualToConstant:30],
    [tile.leadingAnchor constraintEqualToAnchor:card.leadingAnchor constant:14],
    [tile.topAnchor constraintEqualToAnchor:card.topAnchor constant:13],
    [texts.leadingAnchor constraintEqualToAnchor:tile.trailingAnchor constant:12],
    [texts.trailingAnchor constraintEqualToAnchor:trailing constant:trailingInset],
    [texts.topAnchor constraintEqualToAnchor:card.topAnchor constant:12],
    [texts.bottomAnchor constraintEqualToAnchor:card.bottomAnchor constant:-12],
    [card.heightAnchor constraintGreaterThanOrEqualToConstant:56],
  ]];
  return card;
}

- (void)cardDown:(UIControl *)card {
  LeadSpring(0.3, 0.7, ^{ card.transform = CGAffineTransformMakeScale(0.97, 0.97); }, nil);
}

- (void)cardUp:(UIControl *)card {
  LeadSpring(0.45, 0.55, ^{ card.transform = CGAffineTransformIdentity; }, nil);
}

- (void)announcementTapped:(UIControl *)card {
  LeadSelectionHaptic();
  LeadOpenTelegramURL(card.accessibilityHint);
}

#pragma mark - Actions

- (void)closeTapped {
  [self dismissViewControllerAnimated:YES completion:nil];
}

@end
