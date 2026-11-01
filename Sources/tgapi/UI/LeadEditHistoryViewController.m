#import "LeadMenu.h"
#import "Headers.h"
#import "../Headers.h"

// Sheet behind the pencil on an edited message: every saved version on a
// timeline, each one diffed against the version before it (added words
// highlighted, removed words struck through).

// Words with the whitespace that follows them, so spacing travels with its word
// and removed words never run into their neighbours.
static NSArray<NSString *> *LeadDiffTokens(NSString *text) {
  NSMutableArray<NSString *> *tokens = [NSMutableArray array];
  static NSRegularExpression *regex;
  static dispatch_once_t once;
  dispatch_once(&once, ^{
    regex = [NSRegularExpression regularExpressionWithPattern:@"^\\s+|\\S+\\s*" options:0 error:nil];
  });
  [regex enumerateMatchesInString:text options:0 range:NSMakeRange(0, text.length) usingBlock:^(NSTextCheckingResult *match, __unused NSMatchingFlags flags, __unused BOOL *stop) {
    [tokens addObject:[text substringWithRange:match.range]];
  }];
  return tokens;
}

static NSString *LeadDiffWord(NSString *token) {
  return [token stringByTrimmingCharactersInSet:NSCharacterSet.whitespaceAndNewlineCharacterSet];
}

// Word-level LCS diff of `text` against `previous`.
static NSAttributedString *LeadDiffText(NSString *previous, NSString *text, UIFont *font) {
  NSDictionary *plain = @{ NSFontAttributeName : font, NSForegroundColorAttributeName : UIColor.labelColor };
  if (previous.length == 0) return [[NSAttributedString alloc] initWithString:text attributes:plain];
  NSArray<NSString *> *a = LeadDiffTokens(previous);
  NSArray<NSString *> *b = LeadDiffTokens(text);
  NSUInteger n = a.count, m = b.count;
  // Long rewrites are rare and the table is n*m; past this show the text as is.
  if (n * m > 1500000) return [[NSAttributedString alloc] initWithString:text attributes:plain];
  NSMutableArray<NSString *> *wa = [NSMutableArray arrayWithCapacity:n];
  NSMutableArray<NSString *> *wb = [NSMutableArray arrayWithCapacity:m];
  for (NSString *token in a) [wa addObject:LeadDiffWord(token)];
  for (NSString *token in b) [wb addObject:LeadDiffWord(token)];

  uint16_t *table = calloc((n + 1) * (m + 1), sizeof(uint16_t));
  if (!table) return [[NSAttributedString alloc] initWithString:text attributes:plain];
#define LEAD_LCS(i, j) table[(i) * (m + 1) + (j)]
  for (NSInteger i = (NSInteger)n - 1; i >= 0; i--) {
    for (NSInteger j = (NSInteger)m - 1; j >= 0; j--) {
      LEAD_LCS(i, j) = [wa[i] isEqualToString:wb[j]] ? LEAD_LCS(i + 1, j + 1) + 1 : MAX(LEAD_LCS(i + 1, j), LEAD_LCS(i, j + 1));
    }
  }

  NSDictionary *added = @{
    NSFontAttributeName : font,
    NSForegroundColorAttributeName : UIColor.labelColor,
    NSBackgroundColorAttributeName : [UIColor.systemGreenColor colorWithAlphaComponent:0.22],
  };
  NSDictionary *removed = @{
    NSFontAttributeName : font,
    NSForegroundColorAttributeName : UIColor.tertiaryLabelColor,
    NSStrikethroughStyleAttributeName : @(NSUnderlineStyleSingle),
    NSStrikethroughColorAttributeName : UIColor.tertiaryLabelColor,
  };
  NSMutableAttributedString *result = [NSMutableAttributedString new];
  // Only the word carries the change style; its trailing space stays plain.
  // A removed word right before an added one keeps at least one space between them.
  __block BOOL lastWasRemoved = NO;
  void (^append)(NSString *, NSDictionary *) = ^(NSString *token, NSDictionary *attributes) {
    NSString *word = LeadDiffWord(token);
    NSUInteger start = [token rangeOfString:word].location;
    if (word.length == 0 || start == NSNotFound) {
      [result appendAttributedString:[[NSAttributedString alloc] initWithString:token attributes:plain]];
      return;
    }
    if (lastWasRemoved && attributes != removed && result.length && ![NSCharacterSet.whitespaceAndNewlineCharacterSet characterIsMember:[result.string characterAtIndex:result.length - 1]]) {
      [result appendAttributedString:[[NSAttributedString alloc] initWithString:@" " attributes:plain]];
    }
    NSString *lead = [token substringToIndex:start];
    NSString *trail = [token substringFromIndex:start + word.length];
    if (attributes == removed && trail.length == 0) trail = @" ";
    if (lead.length) [result appendAttributedString:[[NSAttributedString alloc] initWithString:lead attributes:plain]];
    [result appendAttributedString:[[NSAttributedString alloc] initWithString:word attributes:attributes]];
    if (trail.length) [result appendAttributedString:[[NSAttributedString alloc] initWithString:trail attributes:plain]];
    lastWasRemoved = attributes == removed;
  };
  NSUInteger i = 0, j = 0;
  while (i < n && j < m) {
    if ([wa[i] isEqualToString:wb[j]]) {
      append(b[j], plain);
      i++, j++;
    } else if (LEAD_LCS(i + 1, j) >= LEAD_LCS(i, j + 1)) {
      append(a[i++], removed);
    } else {
      append(b[j++], added);
    }
  }
  while (i < n) append(a[i++], removed);
  while (j < m) append(b[j++], added);
#undef LEAD_LCS
  free(table);
  // A removed last word leaves a dangling space.
  NSString *string = result.string;
  NSUInteger end = string.length;
  while (end > 0 && [NSCharacterSet.whitespaceAndNewlineCharacterSet characterIsMember:[string characterAtIndex:end - 1]]) end--;
  if (end < string.length && end >= LeadDiffWord(text).length) [result deleteCharactersInRange:NSMakeRange(end, string.length - end)];
  return result;
}

static NSString *LeadHistoryDateText(NSNumber *timestamp) {
  if (![timestamp isKindOfClass:[NSNumber class]] || timestamp.doubleValue <= 0) return nil;
  NSDate *date = [NSDate dateWithTimeIntervalSince1970:timestamp.doubleValue];
  NSDateFormatter *formatter = [NSDateFormatter new];
  formatter.timeStyle = NSDateFormatterShortStyle;
  formatter.dateStyle = [NSCalendar.currentCalendar isDateInToday:date] ? NSDateFormatterNoStyle : NSDateFormatterMediumStyle;
  formatter.doesRelativeDateFormatting = YES;
  return [formatter stringFromDate:date];
}

@interface LeadEditHistoryViewController () <UIContextMenuInteractionDelegate>
@property (nonatomic, copy) NSArray<NSDictionary *> *versions;
@property (nonatomic, assign) BOOL mediaReplaced;
@property (nonatomic, strong) NSMutableArray<UIView *> *rows;
@end

@implementation LeadEditHistoryViewController

+ (void)presentForKey:(NSString *)key mediaReplaced:(BOOL)mediaReplaced from:(UIViewController *)host {
  if (!host) return;
  NSArray *stored = key.length ? [TLParser editHistoryForKey:key] : @[];
  // Same text twice (an edit reverted, a re-render) is one version.
  NSMutableArray<NSDictionary *> *versions = [NSMutableArray array];
  for (NSDictionary *version in stored) {
    if (![version isKindOfClass:[NSDictionary class]]) continue;
    NSString *text = [version[@"text"] isKindOfClass:[NSString class]] ? version[@"text"] : @"";
    if ([[versions.lastObject objectForKey:@"text"] isEqualToString:text]) continue;
    [versions addObject:version];
  }

  LeadEditHistoryViewController *controller = [LeadEditHistoryViewController new];
  controller.versions = versions;
  controller.mediaReplaced = mediaReplaced;
  UINavigationController *navigation = [[UINavigationController alloc] initWithRootViewController:controller];
  if (@available(iOS 15.0, *)) {
    UISheetPresentationController *sheet = navigation.sheetPresentationController;
    sheet.detents = versions.count > 2 ? @[ UISheetPresentationControllerDetent.largeDetent ]
                                       : @[ UISheetPresentationControllerDetent.mediumDetent, UISheetPresentationControllerDetent.largeDetent ];
    sheet.prefersGrabberVisible = YES;
    sheet.preferredCornerRadius = 24;
  }
  LeadImpactHaptic(UIImpactFeedbackStyleLight);
  [host presentViewController:navigation animated:YES completion:nil];
}

- (void)viewDidLoad {
  [super viewDidLoad];
  self.view.backgroundColor = UIColor.systemGroupedBackgroundColor;
  self.view.tintColor = UIColor.labelColor;
  self.title = LeadL(@"UI_EDIT_HISTORY_TITLE");
  self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemClose target:self action:@selector(close)];
  if (self.versions.count > 0) {
    UIBarButtonItem *copyAll = [[UIBarButtonItem alloc] initWithImage:[UIImage systemImageNamed:@"doc.on.doc"] style:UIBarButtonItemStylePlain target:self action:@selector(copyAll)];
    copyAll.accessibilityLabel = LeadL(@"UI_COPY_ALL");
    self.navigationItem.rightBarButtonItem = copyAll;
  }

  UIScrollView *scroll = [UIScrollView new];
  scroll.alwaysBounceVertical = YES;
  scroll.translatesAutoresizingMaskIntoConstraints = NO;
  [self.view addSubview:scroll];
  UIStackView *stack = [UIStackView new];
  stack.axis = UILayoutConstraintAxisVertical;
  stack.translatesAutoresizingMaskIntoConstraints = NO;
  [scroll addSubview:stack];
  [NSLayoutConstraint activateConstraints:@[
    [scroll.topAnchor constraintEqualToAnchor:self.view.topAnchor],
    [scroll.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor],
    [scroll.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor],
    [scroll.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor],
    [stack.topAnchor constraintEqualToAnchor:scroll.contentLayoutGuide.topAnchor constant:8],
    [stack.bottomAnchor constraintEqualToAnchor:scroll.contentLayoutGuide.bottomAnchor constant:-24],
    [stack.leadingAnchor constraintEqualToAnchor:scroll.frameLayoutGuide.leadingAnchor constant:20],
    [stack.trailingAnchor constraintEqualToAnchor:scroll.frameLayoutGuide.trailingAnchor constant:-20],
  ]];

  self.rows = [NSMutableArray array];
  if (self.versions.count == 0) {
    [stack addArrangedSubview:[self emptyView]];
    return;
  }

  UILabel *count = [UILabel new];
  count.text = [NSString stringWithFormat:LeadL(@"UI_EDIT_COUNT"), (long)self.versions.count];
  count.font = LeadFont(13, UIFontWeightMedium);
  count.textColor = UIColor.secondaryLabelColor;
  [stack addArrangedSubview:count];
  [stack setCustomSpacing:14 afterView:count];

  UIFont *font = LeadFont(16, UIFontWeightRegular);
  for (NSUInteger idx = 0; idx < self.versions.count; idx++) {
    NSDictionary *version = self.versions[idx];
    NSString *text = [version[@"text"] isKindOfClass:[NSString class]] ? version[@"text"] : @"";
    NSString *previous = idx > 0 ? self.versions[idx - 1][@"text"] : nil;
    BOOL isLast = idx + 1 == self.versions.count;
    NSString *label = idx == 0 ? LeadL(@"UI_EDIT_ORIGINAL")
                    : isLast  ? LeadL(@"UI_EDIT_CURRENT")
                              : [NSString stringWithFormat:LeadL(@"UI_EDIT_VERSION"), (long)idx];
    // The original's timestamp is when Lead noticed the first edit, not when it was sent.
    NSString *date = idx > 0 ? LeadHistoryDateText(version[@"date"]) : nil;
    NSAttributedString *body = LeadDiffText([previous isKindOfClass:[NSString class]] ? previous : nil, text, font);
    UIView *row = [self rowWithLabel:label date:date body:body current:isLast last:isLast index:idx];
    [stack addArrangedSubview:row];
    [self.rows addObject:row];
  }
}

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
  [self.rows enumerateObjectsUsingBlock:^(UIView *row, NSUInteger idx, __unused BOOL *stop) {
    row.alpha = 0;
    row.transform = CGAffineTransformMakeTranslation(0, 14);
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(MIN(idx, 8) * 0.045 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
      LeadSpring(0.5, 0.86, ^{
        row.alpha = 1;
        row.transform = CGAffineTransformIdentity;
      }, nil);
    });
  }];
  self.rows = nil;
}

- (UIView *)rowWithLabel:(NSString *)label date:(NSString *)date body:(NSAttributedString *)body current:(BOOL)current last:(BOOL)last index:(NSUInteger)index {
  UIView *row = [UIView new];

  // Timeline rail: a dot per version, joined by a hairline.
  UIView *dot = [UIView new];
  dot.translatesAutoresizingMaskIntoConstraints = NO;
  dot.layer.cornerRadius = 5;
  dot.layer.borderWidth = 1.5;
  dot.layer.borderColor = (current ? UIColor.labelColor : UIColor.tertiaryLabelColor).CGColor;
  dot.backgroundColor = current ? UIColor.labelColor : UIColor.systemGroupedBackgroundColor;
  UIView *line = [UIView new];
  line.translatesAutoresizingMaskIntoConstraints = NO;
  line.backgroundColor = UIColor.separatorColor;
  line.hidden = last;
  [row addSubview:line];
  [row addSubview:dot];

  UILabel *title = [UILabel new];
  title.translatesAutoresizingMaskIntoConstraints = NO;
  NSMutableAttributedString *heading = [[NSMutableAttributedString alloc] initWithString:label attributes:@{
    NSFontAttributeName : LeadFont(13, UIFontWeightSemibold),
    NSForegroundColorAttributeName : current ? UIColor.labelColor : UIColor.secondaryLabelColor,
  }];
  if (date.length) {
    [heading appendAttributedString:[[NSAttributedString alloc] initWithString:[@"  " stringByAppendingString:date] attributes:@{
      NSFontAttributeName : LeadFont(13, UIFontWeightRegular),
      NSForegroundColorAttributeName : UIColor.tertiaryLabelColor,
    }]];
  }
  title.attributedText = heading;
  [row addSubview:title];

  UIView *card = [UIView new];
  card.translatesAutoresizingMaskIntoConstraints = NO;
  card.backgroundColor = UIColor.secondarySystemGroupedBackgroundColor;
  card.layer.cornerRadius = 16;
  card.layer.cornerCurve = kCACornerCurveContinuous;
  card.tag = (NSInteger)index;
  [card addInteraction:[[UIContextMenuInteraction alloc] initWithDelegate:self]];
  [row addSubview:card];

  UITextView *textView = [UITextView new];
  textView.translatesAutoresizingMaskIntoConstraints = NO;
  textView.editable = NO;
  textView.scrollEnabled = NO;
  textView.backgroundColor = UIColor.clearColor;
  textView.textContainerInset = UIEdgeInsetsZero;
  textView.textContainer.lineFragmentPadding = 0;
  textView.attributedText = body.length ? body : [[NSAttributedString alloc] initWithString:LeadL(@"UI_LOG_NO_TEXT") attributes:@{
    NSFontAttributeName : LeadFont(16, UIFontWeightRegular),
    NSForegroundColorAttributeName : UIColor.tertiaryLabelColor,
  }];
  [card addSubview:textView];

  [NSLayoutConstraint activateConstraints:@[
    [dot.widthAnchor constraintEqualToConstant:10],
    [dot.heightAnchor constraintEqualToConstant:10],
    [dot.leadingAnchor constraintEqualToAnchor:row.leadingAnchor],
    [dot.centerYAnchor constraintEqualToAnchor:title.centerYAnchor],
    [line.widthAnchor constraintEqualToConstant:1.5],
    [line.centerXAnchor constraintEqualToAnchor:dot.centerXAnchor],
    [line.topAnchor constraintEqualToAnchor:dot.bottomAnchor constant:4],
    [line.bottomAnchor constraintEqualToAnchor:row.bottomAnchor constant:4],
    [title.leadingAnchor constraintEqualToAnchor:dot.trailingAnchor constant:12],
    [title.trailingAnchor constraintLessThanOrEqualToAnchor:row.trailingAnchor],
    [title.topAnchor constraintEqualToAnchor:row.topAnchor],
    [card.leadingAnchor constraintEqualToAnchor:title.leadingAnchor],
    [card.trailingAnchor constraintEqualToAnchor:row.trailingAnchor],
    [card.topAnchor constraintEqualToAnchor:title.bottomAnchor constant:6],
    [card.bottomAnchor constraintEqualToAnchor:row.bottomAnchor constant:last ? 0 : -18],
    [textView.topAnchor constraintEqualToAnchor:card.topAnchor constant:12],
    [textView.bottomAnchor constraintEqualToAnchor:card.bottomAnchor constant:-12],
    [textView.leadingAnchor constraintEqualToAnchor:card.leadingAnchor constant:14],
    [textView.trailingAnchor constraintEqualToAnchor:card.trailingAnchor constant:-14],
  ]];
  return row;
}

- (UIView *)emptyView {
  UIStackView *stack = [UIStackView new];
  stack.axis = UILayoutConstraintAxisVertical;
  stack.alignment = UIStackViewAlignmentCenter;
  stack.spacing = 8;
  stack.layoutMargins = UIEdgeInsetsMake(48, 12, 0, 12);
  stack.layoutMarginsRelativeArrangement = YES;
  UIImageView *icon = [[UIImageView alloc] initWithImage:[UIImage systemImageNamed:self.mediaReplaced ? @"photo.on.rectangle" : @"pencil.and.outline"
                                                                 withConfiguration:[UIImageSymbolConfiguration configurationWithPointSize:30 weight:UIImageSymbolWeightLight]]];
  icon.tintColor = UIColor.tertiaryLabelColor;
  UILabel *title = [UILabel new];
  title.text = LeadL(self.mediaReplaced ? @"UI_EDIT_MEDIA" : @"UI_EDIT_EMPTY");
  title.font = LeadFont(17, UIFontWeightSemibold);
  title.textAlignment = NSTextAlignmentCenter;
  title.numberOfLines = 0;
  [stack addArrangedSubview:icon];
  [stack setCustomSpacing:14 afterView:icon];
  [stack addArrangedSubview:title];
  if (!self.mediaReplaced) {
    UILabel *hint = [UILabel new];
    hint.text = LeadL(@"UI_EDIT_EMPTY_HINT");
    hint.font = LeadFont(14, UIFontWeightRegular);
    hint.textColor = UIColor.secondaryLabelColor;
    hint.textAlignment = NSTextAlignmentCenter;
    hint.numberOfLines = 0;
    [stack addArrangedSubview:hint];
  }
  return stack;
}

- (NSString *)textAtIndex:(NSUInteger)index {
  if (index >= self.versions.count) return nil;
  NSString *text = self.versions[index][@"text"];
  return [text isKindOfClass:[NSString class]] ? text : nil;
}

- (UIContextMenuConfiguration *)contextMenuInteraction:(UIContextMenuInteraction *)interaction configurationForMenuAtLocation:(__unused CGPoint)location {
  NSString *text = [self textAtIndex:(NSUInteger)interaction.view.tag];
  if (text.length == 0) return nil;
  __weak typeof(self) weakSelf = self;
  return [UIContextMenuConfiguration configurationWithIdentifier:nil previewProvider:nil actionProvider:^UIMenu *(__unused NSArray *suggested) {
    UIAction *copy = [UIAction actionWithTitle:LeadL(@"UI_COPY") image:[UIImage systemImageNamed:@"doc.on.doc"] identifier:nil handler:^(__unused UIAction *action) {
      UIPasteboard.generalPasteboard.string = text;
      [LeadToast showText:LeadL(@"UI_COPIED") symbol:@"checkmark" inView:weakSelf.view];
    }];
    return [UIMenu menuWithTitle:@"" children:@[ copy ]];
  }];
}

- (void)copyAll {
  NSMutableArray<NSString *> *parts = [NSMutableArray array];
  for (NSUInteger idx = 0; idx < self.versions.count; idx++) {
    BOOL isLast = idx + 1 == self.versions.count;
    NSString *label = idx == 0 ? LeadL(@"UI_EDIT_ORIGINAL")
                    : isLast  ? LeadL(@"UI_EDIT_CURRENT")
                              : [NSString stringWithFormat:LeadL(@"UI_EDIT_VERSION"), (long)idx];
    NSString *date = idx > 0 ? LeadHistoryDateText(self.versions[idx][@"date"]) : nil;
    NSString *heading = date.length ? [NSString stringWithFormat:@"%@ · %@", label, date] : label;
    [parts addObject:[NSString stringWithFormat:@"%@\n%@", heading, [self textAtIndex:idx] ?: @""]];
  }
  UIPasteboard.generalPasteboard.string = [parts componentsJoinedByString:@"\n\n"];
  LeadImpactHaptic(UIImpactFeedbackStyleLight);
  [LeadToast showText:LeadL(@"UI_COPIED") symbol:@"checkmark" inView:self.view];
}

- (void)close {
  [self dismissViewControllerAnimated:YES completion:nil];
}

@end
