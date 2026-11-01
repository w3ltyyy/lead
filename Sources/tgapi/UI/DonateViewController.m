#import "Headers.h"
#import "LeadMenu.h"
#import "CryptoIcons.h"

@interface DonateViewController ()
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray<NSDictionary *> *wallets;
@end

@implementation DonateViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  self.title = LeadL(@"UI_SUPPORT");
  self.view.backgroundColor = UIColor.systemGroupedBackgroundColor;
  self.wallets = @[
    @{ @"name" : @"Toncoin", @"ticker" : @"TON", @"logo" : LEAD_LOGO_TON, @"address" : @"UQCQ68OBH-wJ9_p1wuZ8Hi0sPp7gZ5faE5W96W4TSyJDBy_w" },
    @{ @"name" : @"Bitcoin", @"ticker" : @"BTC", @"logo" : LEAD_LOGO_BTC, @"address" : @"bc1qz8zlwqr07uku5ck45z9w55e6zrk4jg57c2qhsp" },
    @{ @"name" : @"Ethereum", @"ticker" : @"ETH", @"logo" : LEAD_LOGO_ETH, @"address" : @"0x3d09D9A9278Ed0fd853829A285C857BA8c0EcB53" },
    @{ @"name" : @"Solana", @"ticker" : @"SOL", @"logo" : LEAD_LOGO_SOL, @"address" : @"75c9fCyGHzoUg5vJyFXuV26U14B7hRJ1iuuDhkVroUHt" },
    @{ @"name" : @"Tether", @"ticker" : @"USDT · TRC20", @"logo" : LEAD_LOGO_USDT, @"address" : @"TBmuowWGJbyzcdRAVSABwsvSYBD63S7KeF" },
  ];

  self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleInsetGrouped];
  self.tableView.dataSource = self;
  self.tableView.delegate = self;
  self.tableView.backgroundColor = UIColor.systemGroupedBackgroundColor;
  self.tableView.rowHeight = UITableViewAutomaticDimension;
  self.tableView.estimatedRowHeight = 64;
  [self.tableView registerClass:[LeadCell class] forCellReuseIdentifier:@"LeadCell"];
  self.tableView.translatesAutoresizingMaskIntoConstraints = NO;
  [self.view addSubview:self.tableView];
  [NSLayoutConstraint activateConstraints:@[
    [self.tableView.topAnchor constraintEqualToAnchor:self.view.topAnchor],
    [self.tableView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor],
    [self.tableView.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor],
    [self.tableView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor],
  ]];
  self.tableView.tableHeaderView = [self buildHeader];
}

- (UIView *)buildHeader {
  UIView *header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 132)];
  LeadIconTile *tile = [LeadIconTile new];
  tile.side = 56;
  [tile setSymbol:@"heart"];
  [tile setActive:YES animated:NO];
  tile.translatesAutoresizingMaskIntoConstraints = NO;
  UILabel *label = [UILabel new];
  label.text = LeadL(@"UI_THANKS");
  label.font = LeadFont(15, UIFontWeightMedium);
  label.textColor = UIColor.secondaryLabelColor;
  label.textAlignment = NSTextAlignmentCenter;
  label.numberOfLines = 0;
  label.translatesAutoresizingMaskIntoConstraints = NO;
  [header addSubview:tile];
  [header addSubview:label];
  [NSLayoutConstraint activateConstraints:@[
    [tile.widthAnchor constraintEqualToConstant:56],
    [tile.heightAnchor constraintEqualToConstant:56],
    [tile.centerXAnchor constraintEqualToAnchor:header.centerXAnchor],
    [tile.topAnchor constraintEqualToAnchor:header.topAnchor constant:16],
    [label.topAnchor constraintEqualToAnchor:tile.bottomAnchor constant:14],
    [label.leadingAnchor constraintEqualToAnchor:header.leadingAnchor constant:32],
    [label.trailingAnchor constraintEqualToAnchor:header.trailingAnchor constant:-32],
  ]];
  // A gentle heartbeat, once.
  dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.45 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
    tile.transform = CGAffineTransformMakeScale(0.82, 0.82);
    LeadSpring(0.7, 0.35, ^{ tile.transform = CGAffineTransformIdentity; }, nil);
  });
  return header;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return self.wallets.count;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
  return LeadL(@"UI_WALLETS");
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section {
  return LeadL(@"UI_DONATE_FOOTER");
}

- (UIImageView *)copyIcon:(NSString *)symbol {
  UIImageView *icon = [[UIImageView alloc] initWithImage:[UIImage systemImageNamed:symbol
                                                                 withConfiguration:[UIImageSymbolConfiguration configurationWithPointSize:15 weight:UIImageSymbolWeightMedium]]];
  icon.tintColor = UIColor.tertiaryLabelColor;
  return icon;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  NSDictionary *wallet = self.wallets[indexPath.row];
  LeadCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LeadCell" forIndexPath:indexPath];
  [cell configureTitle:[NSString stringWithFormat:@"%@  ·  %@", wallet[@"name"], wallet[@"ticker"]] subtitle:wallet[@"address"] symbol:nil];
  NSData *logo = [[NSData alloc] initWithBase64EncodedString:wallet[@"logo"] options:0];
  [cell.tile setTemplateImage:[UIImage imageWithData:logo scale:3]];
  cell.subtitleLabel.font = [UIFont monospacedSystemFontOfSize:11.5 weight:UIFontWeightRegular];
  cell.subtitleLabel.numberOfLines = 1;
  cell.subtitleLabel.lineBreakMode = NSLineBreakByTruncatingMiddle;
  [cell showValue:nil chevron:NO];
  cell.accessoryView = [self copyIcon:@"doc.on.doc"];
  return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  [tableView deselectRowAtIndexPath:indexPath animated:YES];
  NSDictionary *wallet = self.wallets[indexPath.row];
  [UIPasteboard generalPasteboard].string = wallet[@"address"];
  LeadImpactHaptic(UIImpactFeedbackStyleMedium);
  [LeadToast showText:[NSString stringWithFormat:@"%@ · %@", wallet[@"name"], LeadL(@"UI_COPIED")] symbol:@"checkmark" inView:self.view];

  LeadCell *cell = [tableView cellForRowAtIndexPath:indexPath];
  UIImageView *check = [self copyIcon:@"checkmark"];
  check.tintColor = UIColor.labelColor;
  [UIView transitionWithView:cell duration:0.2 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
    cell.accessoryView = check;
  } completion:nil];
  [cell.tile setActive:YES animated:YES];
  dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
    if ([tableView cellForRowAtIndexPath:indexPath] != cell) return;
    [UIView transitionWithView:cell duration:0.2 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
      cell.accessoryView = [self copyIcon:@"doc.on.doc"];
    } completion:nil];
    [cell.tile setActive:NO animated:YES];
  });
}

@end
