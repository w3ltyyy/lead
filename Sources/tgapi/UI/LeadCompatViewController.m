#import "LeadMenu.h"
#import "Headers.h"
#import "../Headers.h"
#import <objc/message.h>

typedef NS_ENUM(NSInteger, LeadCheck) {
  LeadCheckUnknown,
  LeadCheckOK,
  LeadCheckWarning,
  LeadCheckFailed,
};

static NSString *const kCompatCellId = @"LeadCell";

// The layer this client talks to Telegram's servers with. Serialization is an NSObject
// subclass with an ObjC-visible method, in every fork, whatever its framework is called.
static NSInteger LeadClientApiLayer(void) {
  Class cls = NSClassFromString(@"_TtC12TelegramCore13Serialization");
  SEL selector = NSSelectorFromString(@"currentLayer");
  if (!cls || ![cls instancesRespondToSelector:selector]) return 0;
  id serialization = [cls new];
  return (NSInteger)((NSUInteger (*)(id, SEL))objc_msgSend)(serialization, selector);
}

static NSDictionary *LeadCompatItem(NSString *titleKey, LeadCheck check, NSString *detail) {
  return @{ @"title" : LeadL(titleKey), @"check" : @(check), @"detail" : detail ?: @"" };
}

static NSString *LeadCompatFormat(NSString *key, ...) NS_FORMAT_ARGUMENT(1);
static NSString *LeadCompatFormat(NSString *key, ...) {
  va_list args;
  va_start(args, key);
  NSString *text = [[NSString alloc] initWithFormat:LeadL(key) arguments:args];
  va_end(args);
  return text;
}

static NSArray<NSDictionary *> *LeadCompatItems(void) {
  NSMutableArray *items = [NSMutableArray array];
  NSDictionary *counters = [TLParser compatCounters];
  NSInteger (^count)(NSString *) = ^NSInteger(NSString *key) { return [counters[key] integerValue]; };

  // API layer: the one thing that decides whether Lead can read this client's traffic.
  NSInteger layer = LeadClientApiLayer();
  if (layer == 0) {
    [items addObject:LeadCompatItem(@"UI_COMPAT_API", LeadCheckUnknown, LeadL(@"UI_COMPAT_API_UNKNOWN"))];
  } else if (layer < kLeadApiLayerMin) {
    [items addObject:LeadCompatItem(@"UI_COMPAT_API", LeadCheckFailed, LeadCompatFormat(@"UI_COMPAT_API_OLD", (long)layer, kLeadApiLayerMin, kLeadApiLayerMax))];
  } else if (layer > kLeadApiLayerMax) {
    [items addObject:LeadCompatItem(@"UI_COMPAT_API", LeadCheckWarning, LeadCompatFormat(@"UI_COMPAT_API_NEW", (long)layer, kLeadApiLayerMin, kLeadApiLayerMax))];
  } else {
    [items addObject:LeadCompatItem(@"UI_COMPAT_API", LeadCheckOK, LeadCompatFormat(@"UI_COMPAT_API_OK", (long)layer))];
  }

  // Network hooks: no traffic through MtProtoKit means the Rust engine.
  long long requests = LeadNetworkHookActivity();
  BOOL hooksExist = NSClassFromString(@"MTRequest") && NSClassFromString(@"MTProto") && NSClassFromString(@"MTRequestMessageService");
  if (!hooksExist) {
    [items addObject:LeadCompatItem(@"UI_COMPAT_NETWORK", LeadCheckFailed, LeadL(@"UI_COMPAT_NETWORK_MISSING"))];
  } else if (requests > 0) {
    [items addObject:LeadCompatItem(@"UI_COMPAT_NETWORK", LeadCheckOK, LeadCompatFormat(@"UI_COMPAT_NETWORK_OK", requests))];
  } else if (LeadTweakUptime() > 20) {
    [items addObject:LeadCompatItem(@"UI_COMPAT_NETWORK", LeadCheckFailed, LeadL(@"UI_RUST_MESSAGE"))];
  } else {
    [items addObject:LeadCompatItem(@"UI_COMPAT_NETWORK", LeadCheckUnknown, LeadL(@"UI_COMPAT_WAIT"))];
  }

  // Responses Lead understands vs. known types that still failed to parse.
  NSInteger parsed = count(@"parsed"), failed = count(@"parseFailed");
  if (parsed + failed == 0) {
    [items addObject:LeadCompatItem(@"UI_COMPAT_PARSER", LeadCheckUnknown, LeadL(@"UI_COMPAT_PARSER_IDLE"))];
  } else if (failed == 0) {
    [items addObject:LeadCompatItem(@"UI_COMPAT_PARSER", LeadCheckOK, LeadCompatFormat(@"UI_COMPAT_PARSER_OK", (long)parsed))];
  } else {
    [items addObject:LeadCompatItem(@"UI_COMPAT_PARSER", failed * 4 > parsed ? LeadCheckFailed : LeadCheckWarning,
                                    LeadCompatFormat(@"UI_COMPAT_PARSER_FAILED", (long)failed, (long)(parsed + failed), counters[@"lastFailed"] ?: @"?"))];
  }

  // The notification extension stores messages while the app is suspended.
  NSInteger injected = LeadExtensionInjected();
  NSDictionary *status = [TLParser bridgeExtensionStatus];
  if (injected == 0) {
    [items addObject:LeadCompatItem(@"UI_COMPAT_EXTENSION", LeadCheckWarning, LeadL(@"UI_COMPAT_EXTENSION_NOT_INJECTED"))];
  } else if (injected < 0) {
    [items addObject:LeadCompatItem(@"UI_COMPAT_EXTENSION", LeadCheckUnknown, LeadL(@"UI_COMPAT_EXTENSION_NONE"))];
  } else if (TLParser.sharedNotesPath.length == 0) {
    [items addObject:LeadCompatItem(@"UI_COMPAT_EXTENSION", LeadCheckWarning, LeadL(@"UI_COMPAT_EXTENSION_NO_GROUP"))];
  } else if (status[@"date"]) {
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:[status[@"date"] doubleValue]];
    NSString *when = [NSDateFormatter localizedStringFromDate:date dateStyle:NSDateFormatterShortStyle timeStyle:NSDateFormatterShortStyle];
    [items addObject:LeadCompatItem(@"UI_COMPAT_EXTENSION", LeadCheckOK, LeadCompatFormat(@"UI_COMPAT_EXTENSION_OK", (long)[status[@"patched"] integerValue], when))];
  } else {
    [items addObject:LeadCompatItem(@"UI_COMPAT_EXTENSION", LeadCheckOK, LeadL(@"UI_COMPAT_EXTENSION_READY"))];
  }

  // Marks next to messages need Telegram's item to be readable.
  NSInteger refOk = count(@"refOk"), refNoChat = count(@"refNoChat"), refMissing = count(@"refMissing");
  if (refOk + refNoChat + refMissing == 0) {
    [items addObject:LeadCompatItem(@"UI_COMPAT_MESSAGES", LeadCheckUnknown, LeadL(@"UI_COMPAT_MESSAGES_IDLE"))];
  } else if (refNoChat == 0) {
    [items addObject:LeadCompatItem(@"UI_COMPAT_MESSAGES", LeadCheckOK, LeadCompatFormat(@"UI_COMPAT_MESSAGES_OK", (long)refOk))];
  } else {
    [items addObject:LeadCompatItem(@"UI_COMPAT_MESSAGES", LeadCheckWarning, LeadCompatFormat(@"UI_COMPAT_MESSAGES_PARTIAL", (long)refNoChat, (long)(refOk + refNoChat)))];
  }

  // Lead's buttons on profiles and the chat hook are attached to these classes.
  BOOL profile = objc_getClass("_TtC14PeerInfoScreen18PeerInfoScreenImpl") != Nil;
  BOOL chat = objc_getClass("_TtC10TelegramUI18ChatControllerImpl") != Nil;
  [items addObject:LeadCompatItem(@"UI_COMPAT_SCREENS", profile && chat ? LeadCheckOK : LeadCheckFailed,
                                  LeadL(profile && chat ? @"UI_COMPAT_SCREENS_OK" : @"UI_COMPAT_SCREENS_MISSING"))];
  return items;
}

@interface LeadCompatViewController ()
@property (nonatomic, copy) NSArray<NSDictionary *> *items;
@end

@implementation LeadCompatViewController

- (instancetype)init {
  return [super initWithStyle:UITableViewStyleInsetGrouped];
}

- (void)viewDidLoad {
  [super viewDidLoad];
  self.title = LeadL(@"UI_COMPAT_TITLE");
  self.navigationItem.largeTitleDisplayMode = UINavigationItemLargeTitleDisplayModeNever;
  self.tableView.backgroundColor = UIColor.systemGroupedBackgroundColor;
  self.tableView.estimatedRowHeight = 72;
  self.tableView.rowHeight = UITableViewAutomaticDimension;
  [self.tableView registerClass:[LeadCell class] forCellReuseIdentifier:kCompatCellId];
  self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage systemImageNamed:@"doc.on.doc"]
                                                                            style:UIBarButtonItemStylePlain
                                                                           target:self
                                                                           action:@selector(copyReport)];
}

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
  self.items = LeadCompatItems();
  [self.tableView reloadData];
}

- (NSString *)clientLine {
  NSDictionary *info = NSBundle.mainBundle.infoDictionary;
  return [NSString stringWithFormat:@"%@ %@ (%@)", info[@"CFBundleDisplayName"] ?: info[@"CFBundleName"] ?: @"?", info[@"CFBundleShortVersionString"] ?: @"?", info[@"CFBundleVersion"] ?: @"?"];
}

- (void)copyReport {
  NSMutableArray *lines = [NSMutableArray arrayWithObject:[NSString stringWithFormat:@"Lead %@ (%@), %@", kLeadTweakVersion, kLeadTweakBuild, [self clientLine]]];
  for (NSDictionary *item in self.items) {
    [lines addObject:[NSString stringWithFormat:@"[%@] %@: %@", @[ @"?", @"OK", @"WARN", @"FAIL" ][[item[@"check"] integerValue]], item[@"title"], item[@"detail"]]];
  }
  [lines addObject:LeadDiagStateLine()];
  [lines addObject:LeadDiagSignLine()];
  [UIPasteboard generalPasteboard].string = [lines componentsJoinedByString:@"\n"];
  LeadImpactHaptic(UIImpactFeedbackStyleMedium);
  [LeadToast showText:LeadL(@"UI_COPIED") symbol:@"checkmark" inView:self.view];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return section == 0 ? 1 : self.items.count;
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section {
  return section == 1 ? LeadL(@"UI_COMPAT_FOOTER") : nil;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  LeadCell *cell = [tableView dequeueReusableCellWithIdentifier:kCompatCellId forIndexPath:indexPath];
  cell.selectionStyle = UITableViewCellSelectionStyleNone;
  if (indexPath.section == 0) {
    LeadCheck worst = LeadCheckOK;
    for (NSDictionary *item in self.items) {
      LeadCheck check = [item[@"check"] integerValue];
      if (check > worst) worst = check;
    }
    NSString *summary = LeadL(worst == LeadCheckFailed ? @"UI_COMPAT_SUMMARY_FAILED" : worst == LeadCheckWarning ? @"UI_COMPAT_SUMMARY_WARNING" : @"UI_COMPAT_SUMMARY_OK");
    [cell configureTitle:[self clientLine] subtitle:summary symbol:worst == LeadCheckOK ? @"checkmark.shield" : @"exclamationmark.shield"];
    [cell.tile setActive:worst == LeadCheckOK animated:NO];
    [cell showValue:nil chevron:NO];
    return cell;
  }
  NSDictionary *item = self.items[indexPath.row];
  LeadCheck check = [item[@"check"] integerValue];
  NSString *symbol = check == LeadCheckOK ? @"checkmark" : check == LeadCheckWarning ? @"exclamationmark.triangle" : check == LeadCheckFailed ? @"xmark" : @"questionmark";
  [cell configureTitle:item[@"title"] subtitle:item[@"detail"] symbol:symbol];
  [cell.tile setActive:check == LeadCheckOK animated:NO];
  [cell showValue:nil chevron:NO];
  cell.subtitleLabel.numberOfLines = 0;
  return cell;
}

@end
