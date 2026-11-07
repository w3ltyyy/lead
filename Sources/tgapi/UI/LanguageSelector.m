#import "Headers.h"
#import "LeadMenu.h"

@interface LanguageSelector ()
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray<NSDictionary *> *languages;
@property (nonatomic, copy) NSString *currentCode;
@end

@implementation LanguageSelector

- (void)viewDidLoad {
  [super viewDidLoad];
  self.title = LeadL(@"LANGUAGE_SECTION_HEADER");
  self.view.backgroundColor = UIColor.systemGroupedBackgroundColor;
  self.currentCode = [[NSUserDefaults standardUserDefaults] stringForKey:@"LeadLanguage"] ?: @"en";
  self.languages = @[
    @{ @"code" : @"en", @"name" : @"English", @"flag" : @"🇺🇸" },
    @{ @"code" : @"ru", @"name" : @"Русский", @"flag" : @"🇷🇺" },
    @{ @"code" : @"es", @"name" : @"Español", @"flag" : @"🇪🇸" },
    @{ @"code" : @"fr", @"name" : @"Français", @"flag" : @"🇫🇷" },
    @{ @"code" : @"it", @"name" : @"Italiano", @"flag" : @"🇮🇹" },
    @{ @"code" : @"tr", @"name" : @"Türkçe", @"flag" : @"🇹🇷" },
    @{ @"code" : @"ar", @"name" : @"العربية", @"flag" : @"🇸🇦" },
    @{ @"code" : @"cn", @"name" : @"简体中文", @"flag" : @"🇨🇳" },
    @{ @"code" : @"tw", @"name" : @"繁體中文", @"flag" : @"🇹🇼" },
    @{ @"code" : @"ja", @"name" : @"日本語", @"flag" : @"🇯🇵" },
    @{ @"code" : @"vn", @"name" : @"Tiếng Việt", @"flag" : @"🇻🇳" },
  ];

  self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleInsetGrouped];
  self.tableView.dataSource = self;
  self.tableView.delegate = self;
  self.tableView.backgroundColor = UIColor.systemGroupedBackgroundColor;
  self.tableView.rowHeight = UITableViewAutomaticDimension;
  self.tableView.estimatedRowHeight = 52;
  [self.tableView registerClass:[LeadCell class] forCellReuseIdentifier:@"LeadCell"];
  self.tableView.translatesAutoresizingMaskIntoConstraints = NO;
  [self.view addSubview:self.tableView];
  [NSLayoutConstraint activateConstraints:@[
    [self.tableView.topAnchor constraintEqualToAnchor:self.view.topAnchor],
    [self.tableView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor],
    [self.tableView.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor],
    [self.tableView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor],
  ]];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return self.languages.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  NSDictionary *language = self.languages[indexPath.row];
  LeadCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LeadCell" forIndexPath:indexPath];
  [cell configureTitle:language[@"name"] subtitle:nil symbol:nil];
  [cell.tile setText:language[@"flag"]];
  BOOL selected = [language[@"code"] isEqualToString:self.currentCode];
  [cell showValue:nil chevron:NO];
  if (selected) {
    UIImageView *check = [[UIImageView alloc] initWithImage:[UIImage systemImageNamed:@"checkmark"
                                                                     withConfiguration:[UIImageSymbolConfiguration configurationWithPointSize:15 weight:UIImageSymbolWeightSemibold]]];
    check.tintColor = UIColor.labelColor;
    cell.accessoryView = check;
  }
  return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section {
  return LeadL(@"UI_LANGUAGE_RESTART");
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  [tableView deselectRowAtIndexPath:indexPath animated:YES];
  NSString *code = self.languages[indexPath.row][@"code"];
  if ([code isEqualToString:self.currentCode]) return;
  LeadSelectionHaptic();
  UIAlertController *alert = [UIAlertController alertControllerWithTitle:self.languages[indexPath.row][@"name"]
                                                                 message:LeadL(@"UI_LANGUAGE_RESTART")
                                                          preferredStyle:UIAlertControllerStyleAlert];
  [alert addAction:[UIAlertAction actionWithTitle:LeadL(@"CANCEL") style:UIAlertActionStyleCancel handler:nil]];
  [alert addAction:[UIAlertAction actionWithTitle:LeadL(@"UI_RESTART") style:UIAlertActionStyleDefault handler:^(__unused UIAlertAction *action) {
    [[NSUserDefaults standardUserDefaults] setObject:code forKey:@"LeadLanguage"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    LeadRestartTelegram();
  }]];
  [self presentViewController:alert animated:YES completion:nil];
}

@end
