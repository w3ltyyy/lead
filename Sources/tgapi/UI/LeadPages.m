#import "LeadMenu.h"
#import "Headers.h"
#import "Icons.h"
#import "../Headers.h"

#pragma mark - Model

@implementation LeadRow

+ (instancetype)toggle:(NSString *)key title:(NSString *)titleKey subtitle:(NSString *)subtitleKey symbol:(NSString *)symbol {
  LeadRow *row = [LeadRow new];
  row.style = LeadRowStyleToggle;
  row.defaultsKey = key;
  row.titleKey = titleKey;
  row.subtitleKey = subtitleKey;
  row.symbol = symbol;
  return row;
}

+ (instancetype)link:(NSString *)titleKey symbol:(NSString *)symbol tap:(void (^)(UIViewController *host))tap {
  LeadRow *row = [LeadRow new];
  row.style = LeadRowStyleLink;
  row.titleKey = titleKey;
  row.symbol = symbol;
  row.tapBlock = tap;
  return row;
}

- (NSString *)title {
  return self.titleKey ? LeadL(self.titleKey) : @"";
}

- (NSString *)subtitle {
  return self.subtitleKey ? LeadL(self.subtitleKey) : nil;
}

- (BOOL)isOn {
  return self.defaultsKey && [[NSUserDefaults standardUserDefaults] boolForKey:self.defaultsKey];
}

@end

@implementation LeadSection

+ (instancetype)title:(NSString *)titleKey rows:(NSArray<LeadRow *> *)rows {
  LeadSection *section = [LeadSection new];
  section.titleKey = titleKey;
  section.rows = rows;
  return section;
}

@end

@implementation LeadPage

- (NSArray<LeadRow *> *)toggleRows {
  NSMutableArray *rows = [NSMutableArray array];
  for (LeadSection *section in self.sections) {
    for (LeadRow *row in section.rows) {
      if (row.style == LeadRowStyleToggle) [rows addObject:row];
    }
  }
  return rows;
}

- (NSInteger)enabledCount {
  if (self.isGhost) {
    return [[NSUserDefaults standardUserDefaults] boolForKey:kGhostModeEnabled] ? 1 : 0;
  }
  NSInteger count = 0;
  for (LeadRow *row in self.toggleRows) {
    if (row.isOn) count++;
  }
  return count;
}

@end

#pragma mark - Helpers

UIImage *LeadLogoImage(CGFloat side) {
  static UIImage *source = nil;
  static dispatch_once_t once;
  dispatch_once(&once, ^{
    NSData *data = [[NSData alloc] initWithBase64EncodedString:CHOCOPNG options:NSDataBase64DecodingIgnoreUnknownCharacters];
    source = [UIImage imageWithData:data];
  });
  if (!source) return nil;
  UIGraphicsImageRenderer *renderer = [[UIGraphicsImageRenderer alloc] initWithSize:CGSizeMake(side, side)];
  return [renderer imageWithActions:^(__unused UIGraphicsImageRendererContext *context) {
    [source drawInRect:CGRectMake(0, 0, side, side)];
  }];
}

void LeadOpenTelegramURL(NSString *urlString) {
  if (urlString.length == 0) return;
  NSURL *finalURL = nil;
  if ([urlString hasPrefix:@"@"]) {
    finalURL = [NSURL URLWithString:[NSString stringWithFormat:@"tg://resolve?domain=%@", [urlString substringFromIndex:1]]];
  } else if ([urlString containsString:@"t.me/"]) {
    NSString *path = [[urlString componentsSeparatedByString:@"t.me/"] lastObject];
    if ([path hasSuffix:@"/"]) path = [path substringToIndex:path.length - 1];
    if ([path hasPrefix:@"+"]) {
      finalURL = [NSURL URLWithString:[NSString stringWithFormat:@"tg://join?invite=%@", [path substringFromIndex:1]]];
    } else if ([path containsString:@"/"]) {
      NSArray *parts = [path componentsSeparatedByString:@"/"];
      finalURL = [NSURL URLWithString:[NSString stringWithFormat:@"tg://resolve?domain=%@&post=%@", parts[0], parts[1]]];
    } else {
      finalURL = [NSURL URLWithString:[NSString stringWithFormat:@"tg://resolve?domain=%@", path]];
    }
  }
  if (!finalURL) finalURL = [NSURL URLWithString:urlString];
  if (!finalURL) return;

  void (^open)(void) = ^{
    [[UIApplication sharedApplication] openURL:finalURL options:@{} completionHandler:nil];
  };
  // Telegram routes tg:// links under the menu; close the menu first so the result is visible.
  UIViewController *presenter = LeadMainWindow().rootViewController;
  UIViewController *top = presenter;
  while (top.presentedViewController && ![top.presentedViewController isKindOfClass:[LeadNavigationController class]]) {
    top = top.presentedViewController;
  }
  if ([finalURL.scheme isEqualToString:@"tg"] && [top.presentedViewController isKindOfClass:[LeadNavigationController class]]) {
    [top dismissViewControllerAnimated:YES completion:open];
  } else {
    open();
  }
}

NSArray<NSString *> *LeadGhostFeatureKeys(void) {
  return @[
    kDisableOnlineStatus, kDisableTypingStatus, kDisableRecordingVideoStatus,
    kDisableUploadingVideoStatus, kDisableRecordingVoiceStatus, kDisableUploadingVoiceStatus,
    kDisableUploadingPhotoStatus, kDisableUploadingFileStatus, kDisableChoosingLocationStatus,
    kDisableChoosingContactStatus, kDisablePlayingGameStatus, kDisableRecordingRoundVideoStatus,
    kDisableUploadingRoundVideoStatus, kDisableSpeakingInGroupCallStatus, kDisableChoosingStickerStatus,
    kDisableEmojiInteractionStatus, kDisableEmojiAcknowledgementStatus, kDisableMessageReadReceipt,
    kDisableStoriesReadReceipt, kGhostKeepVoiceUnread
  ];
}

static NSInteger LeadGhostEnabledSubCount(void) {
  NSInteger count = 0;
  for (NSString *key in LeadGhostFeatureKeys()) {
    if ([[NSUserDefaults standardUserDefaults] boolForKey:key]) count++;
  }
  return count;
}

NSString *LeadGhostStatusText(void) {
  if (![[NSUserDefaults standardUserDefaults] boolForKey:kGhostModeEnabled]) {
    return LeadL(@"UI_GHOST_SUBTITLE");
  }
  return [NSString stringWithFormat:LeadL(@"UI_GHOST_ON"), (long)LeadGhostEnabledSubCount()];
}

BOOL LeadEnableGhostMode(UIViewController *host) {
  BOOL pickedDefaults = NO;
  if (LeadGhostEnabledSubCount() == 0) {
    for (NSString *key in @[ kDisableOnlineStatus, kDisableTypingStatus, kDisableMessageReadReceipt, kDisableStoriesReadReceipt ]) {
      [[NSUserDefaults standardUserDefaults] setBool:YES forKey:key];
    }
    pickedDefaults = YES;
  }
  LeadSetBool(kGhostModeEnabled, YES);
  if (pickedDefaults && host) {
    [LeadToast showText:LeadL(@"UI_GHOST_DEFAULTS_ENABLED") symbol:@"eye.slash" inView:host.view];
  }
  return pickedDefaults;
}

NSInteger LeadEnabledFeatureCount(void) {
  NSInteger count = [[NSUserDefaults standardUserDefaults] boolForKey:kGhostModeEnabled] ? 1 : 0;
  for (LeadPage *page in LeadFeaturePages()) {
    count += page.enabledCount;
  }
  return count;
}

static NSString *LeadFormattedStars(long long amount) {
  NSNumberFormatter *formatter = [NSNumberFormatter new];
  formatter.numberStyle = NSNumberFormatterDecimalStyle;
  return [formatter stringFromNumber:@(MAX(0, amount))] ?: [NSString stringWithFormat:@"%lld", MAX(0, amount)];
}

#pragma mark - Actions

static void LeadPresentInNav(UIViewController *host, UIViewController *vc) {
  UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
  [host presentViewController:nav animated:YES completion:nil];
}

static void LeadEditStarsAmount(UIViewController *host) {
  NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
  long long current = [[defaults objectForKey:kVisualStarsAmount] longLongValue];
  UIAlertController *alert = [UIAlertController alertControllerWithTitle:LeadL(@"UI_STARS_AMOUNT")
                                                                 message:LeadL(@"UI_STARS_SUBTITLE")
                                                          preferredStyle:UIAlertControllerStyleAlert];
  [alert addTextFieldWithConfigurationHandler:^(UITextField *field) {
    field.keyboardType = UIKeyboardTypeNumberPad;
    field.placeholder = @"999999";
    field.text = current > 0 ? [NSString stringWithFormat:@"%lld", current] : @"";
  }];
  [alert addAction:[UIAlertAction actionWithTitle:LeadL(@"CANCEL") style:UIAlertActionStyleCancel handler:nil]];
  [alert addAction:[UIAlertAction actionWithTitle:LeadL(@"UI_SAVE") style:UIAlertActionStyleDefault handler:^(__unused UIAlertAction *action) {
    NSString *raw = alert.textFields.firstObject.text ?: @"";
    NSString *digits = [[raw componentsSeparatedByCharactersInSet:[NSCharacterSet decimalDigitCharacterSet].invertedSet] componentsJoinedByString:@""];
    [defaults setObject:@(MAX(0, digits.longLongValue)) forKey:kVisualStarsAmount];
    [defaults synchronize];
    [[NSNotificationCenter defaultCenter] postNotificationName:LeadSettingsDidChangeNotification object:kVisualStarsAmount];
  }]];
  [host presentViewController:alert animated:YES completion:nil];
}

static NSString *sFilePickerCacheSize = nil;

static void LeadRefreshFilePickerCacheSize(void) {
  dispatch_async(dispatch_get_global_queue(QOS_CLASS_UTILITY, 0), ^{
    NSString *dir = [NSTemporaryDirectory() stringByAppendingPathComponent:FILE_PICKER_PATH];
    NSFileManager *fm = [NSFileManager defaultManager];
    unsigned long long total = 0;
    for (NSString *sub in [fm subpathsAtPath:dir]) {
      NSDictionary *attrs = [fm attributesOfItemAtPath:[dir stringByAppendingPathComponent:sub] error:nil];
      if (![attrs.fileType isEqualToString:NSFileTypeDirectory]) total += attrs.fileSize;
    }
    NSString *size = [NSByteCountFormatter stringFromByteCount:(long long)total countStyle:NSByteCountFormatterCountStyleFile];
    dispatch_async(dispatch_get_main_queue(), ^{
      sFilePickerCacheSize = size;
      [[NSNotificationCenter defaultCenter] postNotificationName:LeadSettingsDidChangeNotification object:nil];
    });
  });
}

static void LeadClearFilePickerCache(UIViewController *host) {
  UIAlertController *alert = [UIAlertController alertControllerWithTitle:LeadL(@"CACHE_CLEAR_WARNING_TITLE")
                                                                 message:LeadL(@"CACHE_CLEAR_WARNING_MESSAGE")
                                                          preferredStyle:UIAlertControllerStyleAlert];
  [alert addAction:[UIAlertAction actionWithTitle:LeadL(@"CANCEL") style:UIAlertActionStyleCancel handler:nil]];
  [alert addAction:[UIAlertAction actionWithTitle:LeadL(@"UI_CLEAR") style:UIAlertActionStyleDestructive handler:^(__unused UIAlertAction *action) {
    NSString *dir = [NSTemporaryDirectory() stringByAppendingPathComponent:FILE_PICKER_PATH];
    NSFileManager *fm = [NSFileManager defaultManager];
    [fm removeItemAtPath:dir error:nil];
    [fm createDirectoryAtPath:dir withIntermediateDirectories:YES attributes:nil error:nil];
    LeadImpactHaptic(UIImpactFeedbackStyleMedium);
    [LeadToast showText:LeadL(@"UI_CLEARED") symbol:@"trash" inView:host.view];
    LeadRefreshFilePickerCacheSize();
  }]];
  [host presentViewController:alert animated:YES completion:nil];
}

#pragma mark - 18+ content

// The same call Telegram's own switch makes. On iOS Telegram shows that switch only when
// the setting is already on, so it can't be turned on from the phone; the server still
// decides whether this account may change it.
static BOOL sLeadContentSettingsBusy = NO;

void LeadRefreshContentSettings(void) {
  if (sLeadContentSettingsBusy) return;
  int32_t function = kAccountGetContentSettings;
  LeadSendRawRequest([NSData dataWithBytes:&function length:sizeof(function)], ^(NSData *result, NSString *error) {
    if (error || result.length < 8 || sLeadContentSettingsBusy) return;
    int32_t constructor = 0, flags = 0;
    [result getBytes:&constructor range:NSMakeRange(0, 4)];
    [result getBytes:&flags range:NSMakeRange(4, 4)];
    if (constructor != (int32_t)0x57e28221) return; // account.contentSettings#57e28221
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    BOOL on = (flags & (1 << 0)) != 0;
    if ([defaults boolForKey:kSensitiveContent] == on) return;
    [defaults setBool:on forKey:kSensitiveContent];
    [[NSNotificationCenter defaultCenter] postNotificationName:LeadSettingsDidChangeNotification object:kSensitiveContent];
  });
}

static void LeadApplySensitiveContent(BOOL on, UIViewController *host) {
  NSMutableData *payload = [NSMutableData data];
  int32_t function = kAccountSetContentSettings, flags = on ? 1 : 0;
  [payload appendBytes:&function length:sizeof(function)];
  [payload appendBytes:&flags length:sizeof(flags)];
  void (^revert)(void) = ^{
    [[NSUserDefaults standardUserDefaults] setBool:!on forKey:kSensitiveContent];
    [[NSNotificationCenter defaultCenter] postNotificationName:LeadSettingsDidChangeNotification object:kSensitiveContent];
    LeadImpactHaptic(UIImpactFeedbackStyleRigid);
    [LeadToast showText:LeadL(@"UI_SENSITIVE_FAILED") symbol:@"exclamationmark.circle" inView:host.view];
  };
  sLeadContentSettingsBusy = YES;
  BOOL sent = LeadSendRawRequest(payload, ^(__unused NSData *result, NSString *error) {
    sLeadContentSettingsBusy = NO;
    if (error) revert();
  });
  if (!sent) {
    sLeadContentSettingsBusy = NO;
    revert();
  }
}

#pragma mark - Device name

static void LeadEditDeviceName(UIViewController *host) {
  NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
  UIAlertController *alert = [UIAlertController alertControllerWithTitle:LeadL(@"UI_DEVICE_NAME")
                                                                 message:LeadL(@"UI_DEVICE_NAME_HINT")
                                                          preferredStyle:UIAlertControllerStyleAlert];
  [alert addTextFieldWithConfigurationHandler:^(UITextField *field) {
    field.placeholder = @"iPhone 17 Pro";
    field.text = [defaults stringForKey:kFakeDeviceName];
    field.clearButtonMode = UITextFieldViewModeWhileEditing;
  }];
  [alert addAction:[UIAlertAction actionWithTitle:LeadL(@"CANCEL") style:UIAlertActionStyleCancel handler:^(__unused UIAlertAction *action) {
    if ([defaults stringForKey:kFakeDeviceName].length == 0 && [defaults boolForKey:kFakeDeviceEnabled]) {
      LeadSetBool(kFakeDeviceEnabled, NO);
    }
  }]];
  [alert addAction:[UIAlertAction actionWithTitle:LeadL(@"UI_SAVE") style:UIAlertActionStyleDefault handler:^(__unused UIAlertAction *action) {
    NSString *name = [alert.textFields.firstObject.text stringByTrimmingCharactersInSet:NSCharacterSet.whitespaceAndNewlineCharacterSet];
    if (name.length > 64) name = [name substringToIndex:64];
    if (name.length) {
      [defaults setObject:name forKey:kFakeDeviceName];
    } else {
      [defaults removeObjectForKey:kFakeDeviceName];
      [defaults setBool:NO forKey:kFakeDeviceEnabled];
    }
    LeadNotifySettingsChanged();
  }]];
  [host presentViewController:alert animated:YES completion:nil];
}

#pragma mark - Registration date estimate

// User ids grow with sign-up time. Known (id, unix time) anchors, interpolated —
// good to about a year, so only the year is shown.
NSString *LeadRegistrationEstimate(long long userId) {
  static const long long anchors[][2] = {
    {2768409, 1383264000}, {7679610, 1388448000}, {11538514, 1391212000}, {15835244, 1392940000},
    {23646077, 1393459000}, {38015510, 1393632000}, {44634663, 1399334000}, {46145305, 1400198000},
    {54845238, 1411257000}, {63263518, 1414454000}, {101260938, 1425600000}, {111220210, 1429574000},
    {116812045, 1437696000}, {124872445, 1439856000}, {130029930, 1441324000}, {133909606, 1444176000},
    {157242073, 1446768000}, {171295414, 1457481000}, {181783990, 1460246000}, {222021233, 1465344000},
    {225034354, 1466208000}, {278941742, 1473465000}, {285253072, 1476835000}, {294851037, 1479600000},
    {297621225, 1481846000}, {328594461, 1482969000}, {337808429, 1487707000}, {352940995, 1487894000},
    {369669043, 1490918000}, {400169472, 1501459000}, {805158066, 1563208000}, {1974255900, 1634000000},
    {5000000000LL, 1643673600}, {6000000000LL, 1675209600}, {7000000000LL, 1706745600}, {8000000000LL, 1738368000},
  };
  if (userId <= 0) return nil;
  size_t count = sizeof(anchors) / sizeof(anchors[0]);
  double time;
  if (userId <= anchors[0][0]) {
    time = anchors[0][1];
  } else if (userId >= anchors[count - 1][0]) {
    time = MIN(anchors[count - 1][1], (long long)[NSDate date].timeIntervalSince1970);
  } else {
    size_t i = 1;
    while (anchors[i][0] < userId) i++;
    double t = (double)(userId - anchors[i - 1][0]) / (double)(anchors[i][0] - anchors[i - 1][0]);
    time = anchors[i - 1][1] + t * (anchors[i][1] - anchors[i - 1][1]);
  }
  NSDateComponents *components = [NSCalendar.currentCalendar components:NSCalendarUnitYear fromDate:[NSDate dateWithTimeIntervalSince1970:time]];
  return [NSString stringWithFormat:@"≈ %ld", (long)components.year];
}

#pragma mark - Settings transfer

static NSString *const kLeadSettingsMarker = @"lead-settings";

// Everything a user would expect to carry over: every switch in the menu plus the
// values behind its links. Import only ever writes these keys.
static NSArray<NSString *> *LeadTransferableKeys(void) {
  NSMutableOrderedSet *keys = [NSMutableOrderedSet orderedSetWithObject:kGhostModeEnabled];
  NSMutableArray *pages = [NSMutableArray arrayWithObject:LeadGhostPage()];
  [pages addObjectsFromArray:LeadFeaturePages()];
  for (LeadPage *page in pages) {
    for (LeadRow *row in page.toggleRows) [keys addObject:row.defaultsKey];
  }
  [keys addObjectsFromArray:@[ kVisualStarsAmount, FAKE_LATITUDE_KEY, FAKE_LONGITUDE_KEY,
                               kGhostPeerRecords, kGhostPeerKeys, @"LeadLanguage", kFakeDeviceName ]];
  // Lives on the server and belongs to the account, not to this device's settings.
  [keys removeObject:kSensitiveContent];
  return keys.array;
}

void LeadExportSettings(UIViewController *host) {
  NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
  NSMutableDictionary *values = [NSMutableDictionary dictionary];
  for (NSString *key in LeadTransferableKeys()) {
    id value = [defaults objectForKey:key];
    if (value && [NSJSONSerialization isValidJSONObject:@{ key : value }]) values[key] = value;
  }
  NSDictionary *payload = @{ @"lead" : kLeadSettingsMarker, @"v" : @1, @"version" : kLeadTweakVersion, @"values" : values };
  NSData *json = [NSJSONSerialization dataWithJSONObject:payload options:NSJSONWritingSortedKeys error:nil];
  if (!json) return;
  [UIPasteboard generalPasteboard].string = [[NSString alloc] initWithData:json encoding:NSUTF8StringEncoding];
  LeadImpactHaptic(UIImpactFeedbackStyleMedium);
  [LeadToast showText:LeadL(@"UI_EXPORT_DONE") symbol:@"doc.on.clipboard" inView:host.view];
}

void LeadImportSettings(UIViewController *host) {
  NSString *raw = [UIPasteboard generalPasteboard].string;
  // Pasting through a chat may wrap the JSON in other text; take the outermost object.
  NSRange start = [raw rangeOfString:@"{"];
  NSRange end = [raw rangeOfString:@"}" options:NSBackwardsSearch];
  NSDictionary *payload = nil;
  if (start.location != NSNotFound && end.location != NSNotFound && end.location > start.location) {
    NSData *data = [[raw substringWithRange:NSMakeRange(start.location, end.location - start.location + 1)] dataUsingEncoding:NSUTF8StringEncoding];
    id parsed = data ? [NSJSONSerialization JSONObjectWithData:data options:0 error:nil] : nil;
    payload = [parsed isKindOfClass:[NSDictionary class]] ? parsed : nil;
  }
  NSDictionary *values = [payload[@"values"] isKindOfClass:[NSDictionary class]] ? payload[@"values"] : nil;
  NSMutableDictionary *accepted = [NSMutableDictionary dictionary];
  NSSet *allowed = [NSSet setWithArray:LeadTransferableKeys()];
  for (NSString *key in values) {
    if ([allowed containsObject:key]) accepted[key] = values[key];
  }
  if (![payload[@"lead"] isEqual:kLeadSettingsMarker] || accepted.count == 0) {
    LeadImpactHaptic(UIImpactFeedbackStyleRigid);
    [LeadToast showText:LeadL(@"UI_IMPORT_INVALID") symbol:@"exclamationmark.circle" inView:host.view];
    return;
  }
  UIAlertController *alert = [UIAlertController alertControllerWithTitle:LeadL(@"UI_IMPORT")
                                                                 message:[NSString stringWithFormat:LeadL(@"UI_IMPORT_CONFIRM"), (long)accepted.count]
                                                          preferredStyle:UIAlertControllerStyleAlert];
  [alert addAction:[UIAlertAction actionWithTitle:LeadL(@"CANCEL") style:UIAlertActionStyleCancel handler:nil]];
  [alert addAction:[UIAlertAction actionWithTitle:LeadL(@"UI_APPLY") style:UIAlertActionStyleDefault handler:^(__unused UIAlertAction *action) {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [accepted enumerateKeysAndObjectsUsingBlock:^(NSString *key, id value, __unused BOOL *stop) {
      [defaults setObject:value forKey:key];
    }];
    [defaults synchronize];
    LeadImpactHaptic(UIImpactFeedbackStyleMedium);
    [LeadToast showText:LeadL(@"UI_IMPORT_DONE") symbol:@"checkmark" inView:host.view];
    LeadNotifySettingsChanged();
  }]];
  [host presentViewController:alert animated:YES completion:nil];
}

#pragma mark - Pages

static LeadRow *LeadGhostRow(NSString *key, NSString *titleKey, NSString *subtitleKey, NSString *symbol) {
  return [LeadRow toggle:key title:titleKey subtitle:subtitleKey symbol:symbol];
}

LeadPage *LeadGhostPage(void) {
  LeadPage *page = [LeadPage new];
  page.titleKey = @"GHOST_MODE_SECTION_HEADER";
  page.symbol = @"eye.slash";
  page.isGhost = YES;

  LeadRow *exceptions = [LeadRow link:@"UI_EXCEPTIONS" symbol:@"person.crop.circle.badge.checkmark" tap:^(UIViewController *host) {
    [host.navigationController pushViewController:[[LeadGhostExceptionsViewController alloc] initWithStyle:UITableViewStyleInsetGrouped] animated:YES];
  }];
  exceptions.valueBlock = ^NSString * {
    NSUInteger count = LeadGhostPeerRecords().count;
    return count ? [NSString stringWithFormat:@"%lu", (unsigned long)count] : nil;
  };

  LeadSection *presence = [LeadSection title:@"UI_GHOST_PRESENCE" rows:@[
    LeadGhostRow(kDisableOnlineStatus, @"DISABLE_ONLINE_STATUS_TITLE", @"DISABLE_ONLINE_STATUS_SUBTITLE", @"antenna.radiowaves.left.and.right"),
    LeadGhostRow(kDisableMessageReadReceipt, @"DISABLE_MESSAGE_READ_RECEIPT_TITLE", @"DISABLE_MESSAGE_READ_RECEIPT_SUBTITLE", @"text.bubble"),
    LeadGhostRow(kDisableStoriesReadReceipt, @"DISABLE_STORY_READ_RECEIPT_TITLE", @"DISABLE_STORY_READ_RECEIPT_SUBTITLE", @"circle.dashed"),
    LeadGhostRow(kGhostReadOnReply, @"UI_READ_ON_REPLY_TITLE", @"UI_READ_ON_REPLY_SUBTITLE", @"arrowshape.turn.up.left"),
    LeadGhostRow(kGhostKeepVoiceUnread, @"UI_KEEP_VOICE_UNREAD_TITLE", @"UI_KEEP_VOICE_UNREAD_SUBTITLE", @"waveform.circle"),
  ]];
  LeadSection *activity = [LeadSection title:@"UI_GHOST_ACTIVITY" rows:@[
    LeadGhostRow(kDisableTypingStatus, @"DISABLE_TYPING_STATUS_TITLE", @"DISABLE_TYPING_STATUS_SUBTITLE", @"keyboard"),
    LeadGhostRow(kDisableRecordingVoiceStatus, @"DISABLE_VC_MESSAGE_RECORDING_STATUS_TITLE", @"DISABLE_VC_MESSAGE_RECORDING_STATUS_SUBTITLE", @"mic"),
    LeadGhostRow(kDisableUploadingVoiceStatus, @"DISABLE_VC_MESSAGE_UPLOADING_STATUS_TITLE", @"DISABLE_VC_MESSAGE_UPLOADING_STATUS_SUBTITLE", @"waveform"),
    LeadGhostRow(kDisableRecordingVideoStatus, @"DISABLE_RECORDING_VIDEO_STATUS_TITLE", @"DISABLE_RECORDING_VIDEO_STATUS_SUBTITLE", @"video"),
    LeadGhostRow(kDisableUploadingVideoStatus, @"DISABLE_UPLOADING_VIDEO_STATUS_TITLE", @"DISABLE_UPLOADING_VIDEO_STATUS_SUBTITLE", @"film"),
    LeadGhostRow(kDisableRecordingRoundVideoStatus, @"DISABLE_RECORDING_ROUND_VIDEO_STATUS_TITLE", @"DISABLE_RECORDING_ROUND_VIDEO_STATUS_SUBTITLE", @"record.circle"),
    LeadGhostRow(kDisableUploadingRoundVideoStatus, @"DISABLE_UPLOADING_ROUND_VIDEO_STATUS_TITLE", @"DISABLE_UPLOADING_ROUND_VIDEO_STATUS_SUBTITLE", @"camera"),
    LeadGhostRow(kDisableUploadingPhotoStatus, @"DISABLE_UPLOADING_PHOTO_STATUS_TITLE", @"DISABLE_UPLOADING_PHOTO_STATUS_SUBTITLE", @"photo"),
    LeadGhostRow(kDisableUploadingFileStatus, @"DISABLE_UPLOADING_FILE_STATUS_TITLE", @"DISABLE_UPLOADING_FILE_STATUS_SUBTITLE", @"doc"),
    LeadGhostRow(kDisableChoosingLocationStatus, @"DISABLE_CHOOSING_LOCATION_STATUS_TITLE", @"DISABLE_CHOOSING_LOCATION_STATUS_SUBTITLE", @"location"),
    LeadGhostRow(kDisableChoosingContactStatus, @"DISABLE_CHOOSING_CONTACT_TITLE", @"DISABLE_CHOOSING_CONTACT_SUBTITLE", @"person.crop.circle"),
    LeadGhostRow(kDisableChoosingStickerStatus, @"DISABLE_CHOOSING_STICKER_STATUS_TITLE", @"DISABLE_CHOOSING_STICKER_STATUS_SUBTITLE", @"face.smiling"),
    LeadGhostRow(kDisableEmojiInteractionStatus, @"DISABLE_EMOJI_INTERACTION_STATUS_TITLE", @"DISABLE_EMOJI_INTERACTION_STATUS_SUBTITLE", @"hand.tap"),
    LeadGhostRow(kDisableEmojiAcknowledgementStatus, @"DISABLE_EMOJI_ACKNOWLEDGEMENT_STATUS_TITLE", @"DISABLE_EMOJI_ACKNOWLEDGEMENT_STATUS_SUBTITLE", @"hand.thumbsup"),
    LeadGhostRow(kDisablePlayingGameStatus, @"DISABLE_PLAYING_GAME_STATUS_TITLE", @"DISABLE_PLAYING_GAME_STATUS_SUBTITLE", @"gamecontroller"),
    LeadGhostRow(kDisableSpeakingInGroupCallStatus, @"DISABLE_SPEAKING_IN_GROUP_CALL_STATUS_TITLE", @"DISABLE_SPEAKING_IN_GROUP_CALL_STATUS_SUBTITLE", @"speaker.wave.2"),
  ]];
  activity.bulkToggle = YES;

  LeadSection *exceptionsSection = [LeadSection title:nil rows:@[ exceptions ]];
  exceptionsSection.footerKey = @"UI_EXCEPTIONS_FOOTER";
  page.sections = @[ exceptionsSection, presence, activity ];
  return page;
}

NSArray<LeadPage *> *LeadFeaturePages(void) {
  LeadRow *messageLog = [LeadRow link:@"UI_MESSAGE_LOG" symbol:@"list.bullet.rectangle" tap:^(UIViewController *host) {
    [host.navigationController pushViewController:[LeadMessageLogViewController new] animated:YES];
  }];
  messageLog.subtitleKey = @"UI_MESSAGE_LOG_SUBTITLE";
  messageLog.valueBlock = ^NSString * {
    NSUInteger count = LeadMessageLogEntries().count;
    return count ? [NSString stringWithFormat:@"%lu", (unsigned long)count] : nil;
  };

  LeadSection *bannerSection = [LeadSection title:nil rows:@[
    [LeadRow toggle:kDeletionBanner title:@"UI_DELETION_BANNER_TITLE" subtitle:@"UI_DELETION_BANNER_SUBTITLE" symbol:@"bell.badge"],
  ]];
  bannerSection.footerKey = @"UI_BANNER_FOOTER";

  LeadPage *messages = [LeadPage new];
  messages.titleKey = @"UI_PAGE_MESSAGES";
  messages.symbol = @"bubble.left.and.bubble.right";
  messages.sections = @[
    [LeadSection title:nil rows:@[
      [LeadRow toggle:kAntiRevoke title:@"ANTI_REVOKE_TITLE" subtitle:@"ANTI_REVOKE_SUBTITLE" symbol:@"trash.slash"],
      [LeadRow toggle:kAntiEdit title:@"ANTI_EDIT_TITLE" subtitle:@"ANTI_EDIT_SUBTITLE" symbol:@"pencil.slash"],
      [LeadRow toggle:kProfileChangesLog title:@"UI_PROFILE_LOG_TITLE" subtitle:@"UI_PROFILE_LOG_SUBTITLE" symbol:@"person.text.rectangle"],
      messageLog,
    ]],
    bannerSection,
    [LeadSection title:nil rows:@[
      [LeadRow toggle:kAntiSelfDestruct title:@"ANTI_SELF_DESTRUCT_TITLE" subtitle:@"ANTI_SELF_DESTRUCT_SUBTITLE" symbol:@"flame"],
      [LeadRow toggle:kAntiAutoDelete title:@"ANTI_AUTO_DELETE_TITLE" subtitle:@"ANTI_AUTO_DELETE_SUBTITLE" symbol:@"clock.arrow.circlepath"],
      [LeadRow toggle:kHideTTLLabel title:@"UI_HIDE_TTL_TITLE" subtitle:@"UI_HIDE_TTL_SUBTITLE" symbol:@"tag.slash"],
    ]],
    [LeadSection title:nil rows:@[
      [LeadRow toggle:kForwardDropAuthor title:@"UI_DROP_AUTHOR_TITLE" subtitle:@"UI_DROP_AUTHOR_SUBTITLE" symbol:@"arrowshape.turn.up.right"],
      [LeadRow toggle:kDisableScreenshotNotification title:@"ANTI_SCREENSHOT_TITLE" subtitle:@"ANTI_SCREENSHOT_SUBTITLE" symbol:@"camera.viewfinder"],
    ]],
  ];

  // Off by default: traces network patching and message flags on a real device (see TLParser diagnostics).
  LeadRow *diagShare = [LeadRow link:@"UI_DIAG_SHARE" symbol:@"square.and.arrow.up" tap:^(UIViewController *host) {
    [TLParser diagLog:LeadDiagStateLine()];
    [TLParser diagLog:LeadDiagSignLine()];
    // Let the queued write land before copying the file.
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
      NSString *path = [TLParser diagLogPath];
      if (![[NSFileManager defaultManager] fileExistsAtPath:path]) {
        [LeadToast showText:LeadL(@"UI_DIAG_EMPTY") symbol:@"exclamationmark.circle" inView:host.view];
        return;
      }
      NSString *copy = [NSTemporaryDirectory() stringByAppendingPathComponent:@"lead_diag.txt"];
      [[NSFileManager defaultManager] removeItemAtPath:copy error:nil];
      [[NSFileManager defaultManager] copyItemAtPath:path toPath:copy error:nil];
      UIActivityViewController *share = [[UIActivityViewController alloc] initWithActivityItems:@[ [NSURL fileURLWithPath:copy] ] applicationActivities:nil];
      share.popoverPresentationController.sourceView = host.view;
      share.popoverPresentationController.sourceRect = CGRectMake(CGRectGetMidX(host.view.bounds), CGRectGetMidY(host.view.bounds), 1, 1);
      [host presentViewController:share animated:YES completion:nil];
    });
  }];
  diagShare.valueBlock = ^NSString * {
    NSInteger size = [TLParser diagLogSize];
    return size > 0 ? [NSByteCountFormatter stringFromByteCount:size countStyle:NSByteCountFormatterCountStyleFile] : nil;
  };
  LeadRow *diagClear = [LeadRow link:@"UI_DIAG_CLEAR" symbol:@"trash" tap:^(UIViewController *host) {
    [TLParser diagClear];
    [LeadToast showText:LeadL(@"UI_CLEARED") symbol:@"trash" inView:host.view];
  }];
  diagClear.style = LeadRowStyleAction;
  diagClear.destructive = YES;
  LeadSection *diagnostics = [LeadSection title:@"UI_DIAG_SECTION" rows:@[
    [LeadRow toggle:kLeadDiagnostics title:@"UI_DIAG_TITLE" subtitle:@"UI_DIAG_SUBTITLE" symbol:@"stethoscope"],
    diagShare,
    diagClear,
  ]];
  diagnostics.footerKey = @"UI_DIAG_FOOTER";

  LeadRow *sensitive = [LeadRow toggle:kSensitiveContent title:@"UI_SENSITIVE_TITLE" subtitle:@"UI_SENSITIVE_SUBTITLE" symbol:@"eye.trianglebadge.exclamationmark"];
  sensitive.toggleBlock = ^(BOOL on, UIViewController *host) {
    LeadApplySensitiveContent(on, host);
  };

  LeadPage *content = [LeadPage new];
  content.titleKey = @"UI_PAGE_CONTENT";
  content.symbol = @"lock.open";
  content.sections = @[
    [LeadSection title:nil rows:@[
      [LeadRow toggle:kDisableForwardRestriction title:@"ENABLE_SAVING_PROTECTED_CONTENT_TITLE" subtitle:@"ENABLE_SAVING_PROTECTED_CONTENT_SUBTITLE" symbol:@"square.and.arrow.down"],
      [LeadRow toggle:kDisableAllAds title:@"DISABLE_ALL_ADS_TITLE" subtitle:@"DISABLE_ALL_ADS_SUBTITLE" symbol:@"nosign"],
      [LeadRow toggle:kShowIosRestricted title:@"SHOW_IOS_RESTRICTED_TITLE" subtitle:@"SHOW_IOS_RESTRICTED_SUBTITLE" symbol:@"eye"],
      sensitive,
      [LeadRow toggle:kHideProxyPromo title:@"UI_HIDE_PROXY_PROMO_TITLE" subtitle:@"UI_HIDE_PROXY_PROMO_SUBTITLE" symbol:@"network"],
    ]],
    [LeadSection title:nil rows:@[
      [LeadRow toggle:kSaveDeletedStories title:@"UI_SAVE_DELETED_STORIES_TITLE" subtitle:@"UI_SAVE_DELETED_STORIES_SUBTITLE" symbol:@"rectangle.stack"],
      [LeadRow toggle:kDownloadStories title:@"UI_UNLOCK_STORIES_TITLE" subtitle:@"UI_UNLOCK_STORIES_SUBTITLE" symbol:@"lock.open"],
      [LeadRow toggle:kHideStories title:@"UI_HIDE_STORIES_TITLE" subtitle:@"UI_HIDE_STORIES_SUBTITLE" symbol:@"circle.dashed"],
    ]],
    diagnostics,
  ];

  LeadRow *clearCache = [LeadRow link:@"CLEAR_FILE_PICKER_CACHE_TITLE" symbol:@"trash" tap:^(UIViewController *host) {
    LeadClearFilePickerCache(host);
  }];
  clearCache.style = LeadRowStyleAction;
  clearCache.subtitleKey = @"CLEAR_FILE_PICKER_CACHE_SUBTITLE";
  clearCache.destructive = YES;
  clearCache.valueBlock = ^NSString * {
    if (!sFilePickerCacheSize) {
      sFilePickerCacheSize = @"…";
      LeadRefreshFilePickerCacheSize();
    }
    return sFilePickerCacheSize;
  };

  LeadPage *media = [LeadPage new];
  media.titleKey = @"UI_PAGE_MEDIA";
  media.symbol = @"paperclip";
  media.sections = @[
    [LeadSection title:nil rows:@[
      [LeadRow toggle:kSendAsVoice title:@"UI_SEND_AS_VOICE_TITLE" subtitle:@"UI_SEND_AS_VOICE_SUBTITLE" symbol:@"waveform"],
    ]],
    [LeadSection title:@"UI_FILE_PICKER" rows:@[
      [LeadRow toggle:FILE_PICKER_FIX_KEY title:@"FIX_FILE_PICKER_TITLE" subtitle:@"FIX_FILE_PICKER_SUBTITLE" symbol:@"folder"],
      clearCache,
    ]],
  ];

  LeadPage *calls = [LeadPage new];
  calls.titleKey = @"UI_PAGE_CALLS";
  calls.symbol = @"phone";
  calls.sections = @[
    [LeadSection title:nil rows:@[
      [LeadRow toggle:kConfirmCalls title:@"UI_CONFIRM_CALLS_TITLE" subtitle:@"UI_CONFIRM_CALLS_SUBTITLE" symbol:@"phone.arrow.up.right"],
    ]],
  ];

  LeadRow *pickLocation = [LeadRow link:@"SELECT_FAKE_LOCATION_TITLE" symbol:@"map" tap:^(UIViewController *host) {
    LeadPresentInNav(host, [LocationSelector new]);
  }];
  pickLocation.valueBlock = ^NSString * {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if (![defaults objectForKey:FAKE_LATITUDE_KEY]) return LeadL(@"UI_NOT_SET");
    return [NSString stringWithFormat:@"%.3f, %.3f", [defaults doubleForKey:FAKE_LATITUDE_KEY], [defaults doubleForKey:FAKE_LONGITUDE_KEY]];
  };
  LeadPage *location = [LeadPage new];
  location.titleKey = @"FAKE_LOCATION_SECTION_HEADER";
  location.symbol = @"location";
  location.sections = @[
    [LeadSection title:nil rows:@[
      [LeadRow toggle:FAKE_LOCATION_ENABLED_KEY title:@"ENABLE_FAKE_LOCATION_TITLE" subtitle:@"ENABLE_FAKE_LOCATION_SUBTITLE" symbol:@"location.slash"],
      pickLocation,
    ]],
  ];

  LeadRow *starsAmount = [LeadRow link:@"UI_STARS_AMOUNT" symbol:@"number" tap:^(UIViewController *host) {
    LeadEditStarsAmount(host);
  }];
  starsAmount.valueBlock = ^NSString * {
    return LeadFormattedStars([[[NSUserDefaults standardUserDefaults] objectForKey:kVisualStarsAmount] longLongValue]);
  };
  LeadRow *fakeDevice = [LeadRow toggle:kFakeDeviceEnabled title:@"UI_FAKE_DEVICE_TITLE" subtitle:@"UI_FAKE_DEVICE_SUBTITLE" symbol:@"iphone"];
  fakeDevice.toggleBlock = ^(BOOL on, UIViewController *host) {
    if (on && [[NSUserDefaults standardUserDefaults] stringForKey:kFakeDeviceName].length == 0) LeadEditDeviceName(host);
  };
  LeadRow *deviceName = [LeadRow link:@"UI_DEVICE_NAME" symbol:@"pencil" tap:^(UIViewController *host) {
    LeadEditDeviceName(host);
  }];
  deviceName.valueBlock = ^NSString * {
    return [[NSUserDefaults standardUserDefaults] stringForKey:kFakeDeviceName] ?: LeadL(@"UI_NOT_SET");
  };

  LeadPage *extras = [LeadPage new];
  extras.titleKey = @"UI_PAGE_EXTRAS";
  extras.symbol = @"sparkles";
  extras.sections = @[
    [LeadSection title:nil rows:@[
      [LeadRow toggle:kVisualStarsEnabled title:@"UI_STARS_TITLE" subtitle:@"UI_STARS_SUBTITLE" symbol:@"star"],
      starsAmount,
    ]],
    [LeadSection title:nil rows:@[
      [LeadRow toggle:kShowPeerInfo title:@"UI_PEER_INFO_TITLE" subtitle:@"UI_PEER_INFO_SUBTITLE" symbol:@"number.circle"],
    ]],
    [LeadSection title:nil rows:@[ fakeDevice, deviceName ]],
  ];

  return @[ messages, content, media, calls, location, extras ];
}
