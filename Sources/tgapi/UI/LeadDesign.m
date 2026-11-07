#import "LeadDesign.h"
#import "Headers.h"

NSString *const kLeadTweakVersion = @"2.0.3";
NSString *const kLeadTweakBuild = @"122";
NSString *const LeadSettingsDidChangeNotification = @"LeadSettingsDidChangeNotification";

static BOOL sLeadNeedsRestart = NO;

#pragma mark - Basics

UIFont *LeadFont(CGFloat size, UIFontWeight weight) {
  return [UIFont systemFontOfSize:size weight:weight];
}

UIFont *LeadRoundedFont(CGFloat size, UIFontWeight weight) {
  UIFont *base = [UIFont systemFontOfSize:size weight:weight];
  UIFontDescriptor *rounded = [base.fontDescriptor fontDescriptorWithDesign:UIFontDescriptorSystemDesignRounded];
  return rounded ? [UIFont fontWithDescriptor:rounded size:size] : base;
}

void LeadSelectionHaptic(void) {
  UISelectionFeedbackGenerator *generator = [UISelectionFeedbackGenerator new];
  [generator selectionChanged];
}

void LeadImpactHaptic(UIImpactFeedbackStyle style) {
  UIImpactFeedbackGenerator *generator = [[UIImpactFeedbackGenerator alloc] initWithStyle:style];
  [generator impactOccurred];
}

void LeadSpring(NSTimeInterval duration, CGFloat damping, void (^animations)(void), void (^completion)(BOOL finished)) {
  [UIView animateWithDuration:duration
                        delay:0
       usingSpringWithDamping:damping
        initialSpringVelocity:0.4
                      options:UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionAllowUserInteraction
                   animations:animations
                   completion:completion];
}

void LeadSetBool(NSString *key, BOOL value) {
  if (key.length == 0) return;
  NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
  [defaults setBool:value forKey:key];
  // Diagnostics switch themselves off 30 minutes after they're turned on.
  if ([key isEqualToString:kLeadDiagnostics]) [defaults removeObjectForKey:@"LeadDiagnosticsSince"];
  [defaults synchronize];
  // These are read at the moment they matter, so they apply without a restart.
  static NSSet<NSString *> *liveKeys;
  static dispatch_once_t once;
  dispatch_once(&once, ^{
    liveKeys = [NSSet setWithArray:@[ kDeletionBanner, kShowPeerInfo, kForwardDropAuthor, kConfirmCalls, kProfileChangesLog, kLeadDiagnostics ]];
  });
  if (![liveKeys containsObject:key]) sLeadNeedsRestart = YES;
  [[NSNotificationCenter defaultCenter] postNotificationName:LeadSettingsDidChangeNotification object:key];
}

UIWindow *LeadMainWindow(void) {
  UIWindow *fallback = nil;
  for (UIScene *scene in UIApplication.sharedApplication.connectedScenes) {
    if (![scene isKindOfClass:[UIWindowScene class]]) continue;
    BOOL active = scene.activationState == UISceneActivationStateForegroundActive;
    for (UIWindow *window in ((UIWindowScene *)scene).windows) {
      if (window.hidden || window.alpha <= 0 || !window.rootViewController) continue;
      if (window.isKeyWindow) return window;
      if (window.windowLevel == UIWindowLevelNormal && (!fallback || (active && fallback.windowScene.activationState != UISceneActivationStateForegroundActive))) {
        fallback = window;
      }
    }
  }
  if (fallback) return fallback;
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
  return UIApplication.sharedApplication.keyWindow;
#pragma clang diagnostic pop
}

UIViewController *LeadTopPresenter(void) {
  UIViewController *top = LeadMainWindow().rootViewController;
  // A controller on its way out can't present; stop at the one below it.
  while (top.presentedViewController && !top.presentedViewController.isBeingDismissed) {
    top = top.presentedViewController;
  }
  return top;
}

void LeadNotifySettingsChanged(void) {
  sLeadNeedsRestart = YES;
  [[NSNotificationCenter defaultCenter] postNotificationName:LeadSettingsDidChangeNotification object:nil];
}

BOOL LeadNeedsRestart(void) {
  return sLeadNeedsRestart;
}

void LeadRestartTelegram(void) {
  [[UIApplication sharedApplication] performSelector:@selector(suspend)];
  dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
    exit(0);
  });
}

void LeadAnimateCellIn(UITableViewCell *cell, NSInteger order) {
  cell.alpha = 0.0;
  cell.transform = CGAffineTransformMakeTranslation(0, 14);
  [UIView animateWithDuration:0.55
                        delay:0.025 * MIN(order, 14)
       usingSpringWithDamping:0.86
        initialSpringVelocity:0.2
                      options:UIViewAnimationOptionAllowUserInteraction
                   animations:^{
                     cell.alpha = 1.0;
                     cell.transform = CGAffineTransformIdentity;
                   }
                   completion:nil];
}

#pragma mark - Logo

static CGPathRef LeadCreateLogoPath(CGRect r) {
  // Right triangle with a vertical left edge, rounded like the app icon:
  // soft top, wide bottom-left, tight bottom-right.
  CGPoint top = CGPointMake(CGRectGetMinX(r), CGRectGetMinY(r));
  CGPoint bottomLeft = CGPointMake(CGRectGetMinX(r), CGRectGetMaxY(r));
  CGPoint bottomRight = CGPointMake(CGRectGetMaxX(r), CGRectGetMaxY(r));
  CGFloat w = r.size.width;
  CGMutablePathRef path = CGPathCreateMutable();
  CGPathMoveToPoint(path, NULL, top.x, (top.y + bottomLeft.y) / 2.0);
  CGPathAddArcToPoint(path, NULL, bottomLeft.x, bottomLeft.y, bottomRight.x, bottomRight.y, w * 0.20);
  CGPathAddArcToPoint(path, NULL, bottomRight.x, bottomRight.y, top.x, top.y, w * 0.07);
  CGPathAddArcToPoint(path, NULL, top.x, top.y, bottomLeft.x, bottomLeft.y, w * 0.10);
  CGPathCloseSubpath(path);
  return path;
}

@implementation LeadLogoView {
  CAGradientLayer *_gradient;
  CAShapeLayer *_mask;
  CAShapeLayer *_stroke;
}

- (instancetype)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    _gradient = [CAGradientLayer layer];
    _gradient.startPoint = CGPointMake(0.3, 0.0);
    _gradient.endPoint = CGPointMake(0.6, 1.0);
    _mask = [CAShapeLayer layer];
    _gradient.mask = _mask;
    [self.layer addSublayer:_gradient];

    _stroke = [CAShapeLayer layer];
    _stroke.fillColor = UIColor.clearColor.CGColor;
    _stroke.lineWidth = 1.5;
    _stroke.lineJoin = kCALineJoinRound;
    _stroke.lineCap = kCALineCapRound;
    _stroke.strokeEnd = 0.0;
    [self.layer addSublayer:_stroke];
    [self updateColors];
  }
  return self;
}

- (void)layoutSubviews {
  [super layoutSubviews];
  CGFloat side = MIN(self.bounds.size.width, self.bounds.size.height);
  // The mark's visual mass sits low-left; nudge it so it reads centered.
  CGRect box = CGRectMake((self.bounds.size.width - side * 0.78) / 2.0 - side * 0.04,
                          (self.bounds.size.height - side * 0.80) / 2.0,
                          side * 0.78, side * 0.80);
  CGPathRef path = LeadCreateLogoPath(box);
  _gradient.frame = self.bounds;
  _mask.frame = self.bounds;
  _stroke.frame = self.bounds;
  _mask.path = path;
  _stroke.path = path;
  CGPathRelease(path);
}

- (void)updateColors {
  BOOL dark = self.traitCollection.userInterfaceStyle == UIUserInterfaceStyleDark;
  UIColor *top = dark ? [UIColor colorWithWhite:0.93 alpha:1] : [UIColor colorWithWhite:0.74 alpha:1];
  UIColor *bottom = dark ? [UIColor colorWithWhite:0.52 alpha:1] : [UIColor colorWithWhite:0.24 alpha:1];
  _gradient.colors = @[ (id)top.CGColor, (id)bottom.CGColor ];
  _stroke.strokeColor = [UIColor.labelColor resolvedColorWithTraitCollection:self.traitCollection].CGColor;
}

- (void)traitCollectionDidChange:(UITraitCollection *)previous {
  [super traitCollectionDidChange:previous];
  [self updateColors];
}

- (void)playIntro {
  [self layoutIfNeeded];
  // Outline draws itself, the gradient fills in behind it, then the outline leaves.
  CABasicAnimation *draw = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
  draw.fromValue = @0;
  draw.toValue = @1;
  draw.duration = 0.65;
  draw.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];

  CABasicAnimation *fadeStroke = [CABasicAnimation animationWithKeyPath:@"opacity"];
  fadeStroke.fromValue = @1;
  fadeStroke.toValue = @0;
  fadeStroke.beginTime = 0.75;
  fadeStroke.duration = 0.35;
  fadeStroke.fillMode = kCAFillModeBoth;

  CAAnimationGroup *strokeGroup = [CAAnimationGroup animation];
  strokeGroup.animations = @[ draw, fadeStroke ];
  strokeGroup.duration = 1.1;
  _stroke.strokeEnd = 1.0;
  _stroke.opacity = 0.0;
  [_stroke addAnimation:strokeGroup forKey:@"intro"];

  CABasicAnimation *fill = [CABasicAnimation animationWithKeyPath:@"opacity"];
  fill.fromValue = @0;
  fill.toValue = @1;
  fill.beginTime = CACurrentMediaTime() + 0.35;
  fill.duration = 0.55;
  fill.fillMode = kCAFillModeBackwards;
  fill.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
  [_gradient addAnimation:fill forKey:@"intro"];

  self.transform = CGAffineTransformMakeScale(0.88, 0.88);
  [UIView animateWithDuration:0.9 delay:0.1 usingSpringWithDamping:0.62 initialSpringVelocity:0.3 options:0 animations:^{
    self.transform = CGAffineTransformIdentity;
  } completion:nil];
}

@end

#pragma mark - Icon tile

@implementation LeadIconTile {
  UIImageView *_imageView;
  UILabel *_textLabel;
  BOOL _active;
  BOOL _templateImage;
}

- (instancetype)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    _side = 30;
    self.layer.cornerCurve = kCACornerCurveContinuous;
    self.clipsToBounds = YES;
    _imageView = [UIImageView new];
    _imageView.contentMode = UIViewContentModeCenter;
    _imageView.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:_imageView];
    _textLabel = [UILabel new];
    _textLabel.textAlignment = NSTextAlignmentCenter;
    _textLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:_textLabel];
    [NSLayoutConstraint activateConstraints:@[
      [_imageView.centerXAnchor constraintEqualToAnchor:self.centerXAnchor],
      [_imageView.centerYAnchor constraintEqualToAnchor:self.centerYAnchor],
      [_imageView.widthAnchor constraintEqualToAnchor:self.widthAnchor],
      [_imageView.heightAnchor constraintEqualToAnchor:self.heightAnchor],
      [_textLabel.centerXAnchor constraintEqualToAnchor:self.centerXAnchor],
      [_textLabel.centerYAnchor constraintEqualToAnchor:self.centerYAnchor],
    ]];
    [self applyColors];
  }
  return self;
}

- (void)layoutSubviews {
  [super layoutSubviews];
  self.layer.cornerRadius = self.bounds.size.width * 0.28;
}

- (void)setSymbol:(NSString *)symbol {
  UIImageSymbolConfiguration *config =
      [UIImageSymbolConfiguration configurationWithPointSize:self.side * 0.46 weight:UIImageSymbolWeightMedium];
  _imageView.image = symbol.length ? [UIImage systemImageNamed:symbol withConfiguration:config] : nil;
  _imageView.contentMode = UIViewContentModeCenter;
  _templateImage = YES;
  _textLabel.text = nil;
  [self applyColors];
}

- (void)setText:(NSString *)text {
  _imageView.image = nil;
  _textLabel.text = text;
  _textLabel.font = LeadRoundedFont(self.side * 0.46, UIFontWeightSemibold);
  _templateImage = YES;
  [self applyColors];
}

- (void)setImage:(UIImage *)image {
  _textLabel.text = nil;
  _imageView.image = image;
  _imageView.contentMode = UIViewContentModeScaleAspectFill;
  _templateImage = NO;
  [self applyColors];
}

- (void)setTemplateImage:(UIImage *)image {
  _textLabel.text = nil;
  // Same optical size as the SF Symbols in the other tiles.
  CGFloat points = MAX(self.side, 20) * 0.6;
  _imageView.image = image.CGImage ? [[UIImage imageWithCGImage:image.CGImage scale:image.size.width * image.scale / points orientation:UIImageOrientationUp]
                                         imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] : nil;
  _imageView.contentMode = UIViewContentModeCenter;
  _templateImage = YES;
  [self applyColors];
}

- (void)applyColors {
  if (!_templateImage) {
    self.backgroundColor = UIColor.tertiarySystemFillColor;
    return;
  }
  self.backgroundColor = _active ? UIColor.labelColor : UIColor.tertiarySystemFillColor;
  UIColor *ink = _active ? UIColor.systemBackgroundColor : UIColor.labelColor;
  _imageView.tintColor = ink;
  _textLabel.textColor = ink;
}

- (void)setActive:(BOOL)active animated:(BOOL)animated {
  if (_active == active && animated) return;
  _active = active;
  if (!animated) {
    [self applyColors];
    return;
  }
  [UIView transitionWithView:self duration:0.22 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
    [self applyColors];
  } completion:nil];
  self.transform = CGAffineTransformMakeScale(0.86, 0.86);
  LeadSpring(0.5, 0.5, ^{ self.transform = CGAffineTransformIdentity; }, nil);
}

@end

#pragma mark - Cells

@implementation LeadCell {
  UIStackView *_textStack;
  UIView *_valueAccessory;
  UIImageView *_chevron;
  NSLayoutConstraint *_tileSize[2];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
  self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
  if (self) {
    UIView *selected = [UIView new];
    selected.backgroundColor = UIColor.tertiarySystemFillColor;
    self.selectedBackgroundView = selected;

    _tile = [LeadIconTile new];
    _tile.translatesAutoresizingMaskIntoConstraints = NO;
    [self.contentView addSubview:_tile];

    _titleLabel = [UILabel new];
    _titleLabel.font = LeadFont(16, UIFontWeightRegular);
    _titleLabel.textColor = UIColor.labelColor;
    _titleLabel.numberOfLines = 0;
    _subtitleLabel = [UILabel new];
    _subtitleLabel.font = LeadFont(13, UIFontWeightRegular);
    _subtitleLabel.textColor = UIColor.secondaryLabelColor;
    _subtitleLabel.numberOfLines = 0;
    _textStack = [[UIStackView alloc] initWithArrangedSubviews:@[ _titleLabel, _subtitleLabel ]];
    _textStack.axis = UILayoutConstraintAxisVertical;
    _textStack.spacing = 2;
    _textStack.translatesAutoresizingMaskIntoConstraints = NO;
    [self.contentView addSubview:_textStack];

    _toggle = [UISwitch new];
    [_toggle addTarget:self action:@selector(toggleChanged) forControlEvents:UIControlEventValueChanged];

    _valueLabel = [UILabel new];
    _valueLabel.font = LeadFont(15, UIFontWeightRegular);
    _valueLabel.textColor = UIColor.secondaryLabelColor;
    _valueLabel.textAlignment = NSTextAlignmentRight;
    _chevron = [[UIImageView alloc] initWithImage:[UIImage systemImageNamed:@"chevron.right"
                                                           withConfiguration:[UIImageSymbolConfiguration configurationWithPointSize:13 weight:UIImageSymbolWeightSemibold]]];
    _chevron.tintColor = UIColor.tertiaryLabelColor;
    UIStackView *valueStack = [[UIStackView alloc] initWithArrangedSubviews:@[ _valueLabel, _chevron ]];
    valueStack.spacing = 8;
    valueStack.alignment = UIStackViewAlignmentCenter;
    _valueAccessory = valueStack;

    _tileSize[0] = [_tile.widthAnchor constraintEqualToConstant:30];
    _tileSize[1] = [_tile.heightAnchor constraintEqualToConstant:30];
    [NSLayoutConstraint activateConstraints:@[
      _tileSize[0], _tileSize[1],
      [_tile.leadingAnchor constraintEqualToAnchor:self.contentView.leadingAnchor constant:16],
      [_tile.centerYAnchor constraintEqualToAnchor:self.contentView.centerYAnchor],
      [_textStack.leadingAnchor constraintEqualToAnchor:_tile.trailingAnchor constant:14],
      [_textStack.trailingAnchor constraintEqualToAnchor:self.contentView.trailingAnchor constant:-8],
      [_textStack.topAnchor constraintEqualToAnchor:self.contentView.topAnchor constant:11],
      [_textStack.bottomAnchor constraintEqualToAnchor:self.contentView.bottomAnchor constant:-11],
      [self.contentView.heightAnchor constraintGreaterThanOrEqualToConstant:52],
    ]];
    self.separatorInset = UIEdgeInsetsMake(0, 60, 0, 0);
  }
  return self;
}

- (void)prepareForReuse {
  [super prepareForReuse];
  self.onToggle = nil;
  self.accessoryView = nil;
  self.alpha = 1.0;
  self.transform = CGAffineTransformIdentity;
  [self setDestructive:NO];
}

- (void)configureTitle:(NSString *)title subtitle:(NSString *)subtitle symbol:(NSString *)symbol {
  _titleLabel.text = title;
  _subtitleLabel.text = subtitle;
  _subtitleLabel.hidden = subtitle.length == 0;
  if (symbol.length) [_tile setSymbol:symbol];
  [_tile setActive:NO animated:NO];
}

- (void)showToggle:(BOOL)on {
  _toggle.on = on;
  self.accessoryView = _toggle;
  self.selectionStyle = UITableViewCellSelectionStyleNone;
  [_tile setActive:on animated:NO];
}

- (void)showValue:(NSString *)value chevron:(BOOL)chevron {
  _valueLabel.text = value;
  _valueLabel.hidden = value.length == 0;
  _chevron.hidden = !chevron;
  [_valueAccessory setNeedsLayout];
  CGSize size = [_valueAccessory systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
  // Only the size changes; the cell owns the position. Re-assigning the same
  // accessory doesn't trigger a layout pass on its own.
  CGRect frame = _valueAccessory.frame;
  frame.size = CGSizeMake(MIN(size.width, 180), MAX(size.height, 22));
  _valueAccessory.frame = frame;
  self.accessoryView = (value.length || chevron) ? _valueAccessory : nil;
  self.selectionStyle = UITableViewCellSelectionStyleDefault;
  [self setNeedsLayout];
}

- (void)setDestructive:(BOOL)destructive {
  _titleLabel.textColor = destructive ? UIColor.systemRedColor : UIColor.labelColor;
}

- (void)toggleChanged {
  LeadSelectionHaptic();
  [_tile setActive:_toggle.on animated:YES];
  if (self.onToggle) self.onToggle(_toggle.on);
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated {
  [super setHighlighted:highlighted animated:animated];
  if (self.selectionStyle == UITableViewCellSelectionStyleNone) return;
  LeadSpring(0.35, 0.6, ^{
    self->_tile.transform = highlighted ? CGAffineTransformMakeScale(0.88, 0.88) : CGAffineTransformIdentity;
  }, nil);
}

@end

@implementation LeadHeroCell {
  LeadIconTile *_tile;
  UILabel *_titleLabel;
  UILabel *_statusLabel;
  CAShapeLayer *_pulse;
  BOOL _on;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
  self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
  if (self) {
    UIView *selected = [UIView new];
    selected.backgroundColor = UIColor.tertiarySystemFillColor;
    self.selectedBackgroundView = selected;

    _tile = [LeadIconTile new];
    _tile.side = 48;
    _tile.translatesAutoresizingMaskIntoConstraints = NO;
    [_tile setSymbol:@"eye.slash"];
    [self.contentView addSubview:_tile];

    _titleLabel = [UILabel new];
    _titleLabel.font = LeadRoundedFont(20, UIFontWeightSemibold);
    _statusLabel = [UILabel new];
    _statusLabel.font = LeadFont(14, UIFontWeightRegular);
    _statusLabel.textColor = UIColor.secondaryLabelColor;
    _statusLabel.numberOfLines = 2;
    UIStackView *stack = [[UIStackView alloc] initWithArrangedSubviews:@[ _titleLabel, _statusLabel ]];
    stack.axis = UILayoutConstraintAxisVertical;
    stack.spacing = 3;
    stack.translatesAutoresizingMaskIntoConstraints = NO;
    [self.contentView addSubview:stack];

    _toggle = [UISwitch new];
    [_toggle addTarget:self action:@selector(toggleChanged) forControlEvents:UIControlEventValueChanged];
    self.accessoryView = _toggle;

    _pulse = [CAShapeLayer layer];
    _pulse.fillColor = UIColor.clearColor.CGColor;
    _pulse.lineWidth = 2;
    _pulse.opacity = 0;
    [self.contentView.layer insertSublayer:_pulse below:_tile.layer];

    [NSLayoutConstraint activateConstraints:@[
      [_tile.widthAnchor constraintEqualToConstant:48],
      [_tile.heightAnchor constraintEqualToConstant:48],
      [_tile.leadingAnchor constraintEqualToAnchor:self.contentView.leadingAnchor constant:16],
      [_tile.centerYAnchor constraintEqualToAnchor:self.contentView.centerYAnchor],
      [stack.leadingAnchor constraintEqualToAnchor:_tile.trailingAnchor constant:14],
      [stack.trailingAnchor constraintEqualToAnchor:self.contentView.trailingAnchor constant:-8],
      [stack.topAnchor constraintEqualToAnchor:self.contentView.topAnchor constant:18],
      [stack.bottomAnchor constraintEqualToAnchor:self.contentView.bottomAnchor constant:-18],
    ]];
    self.separatorInset = UIEdgeInsetsMake(0, 78, 0, 0);
  }
  return self;
}

- (void)configureTitle:(NSString *)title status:(NSString *)status on:(BOOL)on animated:(BOOL)animated {
  _titleLabel.text = title;
  if (animated && ![_statusLabel.text isEqualToString:status]) {
    [UIView transitionWithView:_statusLabel duration:0.2 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
      self->_statusLabel.text = status;
    } completion:nil];
  } else {
    _statusLabel.text = status;
  }
  [_toggle setOn:on animated:animated];
  [_tile setActive:on animated:animated];
  if (animated && on && !_on) [self playPulse];
  _on = on;
}

- (void)playPulse {
  [self layoutIfNeeded];
  CGRect frame = _tile.frame;
  _pulse.strokeColor = [UIColor.labelColor resolvedColorWithTraitCollection:self.traitCollection].CGColor;
  _pulse.path = [UIBezierPath bezierPathWithRoundedRect:frame cornerRadius:frame.size.width * 0.28].CGPath;
  _pulse.frame = self.contentView.bounds;
  CGPoint center = CGPointMake(CGRectGetMidX(frame), CGRectGetMidY(frame));
  _pulse.anchorPoint = CGPointMake(center.x / MAX(self.contentView.bounds.size.width, 1),
                                   center.y / MAX(self.contentView.bounds.size.height, 1));
  _pulse.position = center;

  CABasicAnimation *scale = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
  scale.fromValue = @1.0;
  scale.toValue = @1.45;
  CABasicAnimation *fade = [CABasicAnimation animationWithKeyPath:@"opacity"];
  fade.fromValue = @0.35;
  fade.toValue = @0.0;
  CAAnimationGroup *group = [CAAnimationGroup animation];
  group.animations = @[ scale, fade ];
  group.duration = 0.7;
  group.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
  [_pulse addAnimation:group forKey:@"pulse"];
}

- (void)toggleChanged {
  LeadImpactHaptic(UIImpactFeedbackStyleMedium);
  if (self.onToggle) self.onToggle(_toggle.on);
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated {
  [super setHighlighted:highlighted animated:animated];
  LeadSpring(0.35, 0.6, ^{
    self->_tile.transform = highlighted ? CGAffineTransformMakeScale(0.9, 0.9) : CGAffineTransformIdentity;
  }, nil);
}

@end

@implementation LeadSectionHeader

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
  self = [super initWithReuseIdentifier:reuseIdentifier];
  if (self) {
    _label = [UILabel new];
    _label.font = LeadFont(13, UIFontWeightSemibold);
    _label.textColor = UIColor.secondaryLabelColor;
    _label.translatesAutoresizingMaskIntoConstraints = NO;
    [self.contentView addSubview:_label];
    _actionButton = [UIButton buttonWithType:UIButtonTypeSystem];
    _actionButton.titleLabel.font = LeadFont(13, UIFontWeightSemibold);
    _actionButton.tintColor = UIColor.labelColor;
    _actionButton.translatesAutoresizingMaskIntoConstraints = NO;
    [_actionButton addTarget:self action:@selector(actionTapped) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:_actionButton];
    UILayoutGuide *margins = self.contentView.layoutMarginsGuide;
    [NSLayoutConstraint activateConstraints:@[
      [_label.leadingAnchor constraintEqualToAnchor:margins.leadingAnchor],
      [_label.bottomAnchor constraintEqualToAnchor:self.contentView.bottomAnchor constant:-7],
      [_label.topAnchor constraintGreaterThanOrEqualToAnchor:self.contentView.topAnchor constant:14],
      [_actionButton.trailingAnchor constraintEqualToAnchor:margins.trailingAnchor],
      [_actionButton.centerYAnchor constraintEqualToAnchor:_label.centerYAnchor],
      [_label.trailingAnchor constraintLessThanOrEqualToAnchor:_actionButton.leadingAnchor constant:-8],
    ]];
  }
  return self;
}

- (void)prepareForReuse {
  [super prepareForReuse];
  self.onAction = nil;
  _actionButton.hidden = YES;
}

- (void)actionTapped {
  LeadSelectionHaptic();
  if (self.onAction) self.onAction();
}

@end

#pragma mark - Toast

@implementation LeadToast

+ (void)showText:(NSString *)text symbol:(NSString *)symbol inView:(UIView *)view {
  UIView *host = view.window ?: view;
  if (!host) return;
  static __weak UIView *current = nil;
  [current removeFromSuperview];

  UIVisualEffectView *capsule = [[UIVisualEffectView alloc] initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleSystemChromeMaterial]];
  capsule.layer.cornerRadius = 20;
  capsule.layer.cornerCurve = kCACornerCurveContinuous;
  capsule.clipsToBounds = YES;
  capsule.translatesAutoresizingMaskIntoConstraints = NO;

  UIImageView *icon = [[UIImageView alloc] initWithImage:[UIImage systemImageNamed:symbol ?: @"checkmark"
                                                                withConfiguration:[UIImageSymbolConfiguration configurationWithPointSize:14 weight:UIImageSymbolWeightSemibold]]];
  icon.tintColor = UIColor.labelColor;
  UILabel *label = [UILabel new];
  label.text = text;
  label.font = LeadFont(14, UIFontWeightMedium);
  label.textColor = UIColor.labelColor;
  label.numberOfLines = 2;
  UIStackView *stack = [[UIStackView alloc] initWithArrangedSubviews:@[ icon, label ]];
  stack.spacing = 8;
  stack.alignment = UIStackViewAlignmentCenter;
  stack.translatesAutoresizingMaskIntoConstraints = NO;
  [capsule.contentView addSubview:stack];
  [host addSubview:capsule];
  current = capsule;

  [NSLayoutConstraint activateConstraints:@[
    [stack.leadingAnchor constraintEqualToAnchor:capsule.contentView.leadingAnchor constant:16],
    [stack.trailingAnchor constraintEqualToAnchor:capsule.contentView.trailingAnchor constant:-16],
    [stack.topAnchor constraintEqualToAnchor:capsule.contentView.topAnchor constant:10],
    [stack.bottomAnchor constraintEqualToAnchor:capsule.contentView.bottomAnchor constant:-10],
    [capsule.centerXAnchor constraintEqualToAnchor:host.centerXAnchor],
    [capsule.topAnchor constraintEqualToAnchor:host.safeAreaLayoutGuide.topAnchor constant:8],
    [capsule.widthAnchor constraintLessThanOrEqualToAnchor:host.widthAnchor constant:-48],
  ]];
  [host layoutIfNeeded];

  capsule.alpha = 0;
  capsule.transform = CGAffineTransformConcat(CGAffineTransformMakeScale(0.9, 0.9), CGAffineTransformMakeTranslation(0, -24));
  LeadSpring(0.5, 0.75, ^{
    capsule.alpha = 1;
    capsule.transform = CGAffineTransformIdentity;
  }, nil);
  dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.7 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
    [UIView animateWithDuration:0.25 animations:^{
      capsule.alpha = 0;
      capsule.transform = CGAffineTransformMakeTranslation(0, -16);
    } completion:^(BOOL finished) {
      [capsule removeFromSuperview];
    }];
  });
}

@end

#pragma mark - Navigation + restart pill

@interface LeadNavigationController ()
@property (nonatomic, strong) UIVisualEffectView *pill;
@property (nonatomic, assign) BOOL pillVisible;
@end

@implementation LeadNavigationController

- (void)viewDidLoad {
  [super viewDidLoad];
  self.view.tintColor = UIColor.labelColor;
  UINavigationBarAppearance *edge = [UINavigationBarAppearance new];
  [edge configureWithTransparentBackground];
  edge.backgroundColor = UIColor.systemGroupedBackgroundColor;
  UINavigationBarAppearance *standard = [UINavigationBarAppearance new];
  [standard configureWithDefaultBackground];
  standard.titleTextAttributes = @{ NSFontAttributeName : LeadFont(17, UIFontWeightSemibold) };
  edge.titleTextAttributes = standard.titleTextAttributes;
  self.navigationBar.standardAppearance = standard;
  self.navigationBar.scrollEdgeAppearance = edge;
  self.navigationBar.compactAppearance = standard;

  [self buildPill];
  [[NSNotificationCenter defaultCenter] addObserver:self
                                           selector:@selector(settingsChanged)
                                               name:LeadSettingsDidChangeNotification
                                             object:nil];
}

- (void)dealloc {
  [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)buildPill {
  UIVisualEffectView *pill = [[UIVisualEffectView alloc] initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleSystemChromeMaterial]];
  pill.layer.cornerRadius = 26;
  pill.layer.cornerCurve = kCACornerCurveContinuous;
  pill.clipsToBounds = YES;
  pill.translatesAutoresizingMaskIntoConstraints = NO;

  UIImageView *icon = [[UIImageView alloc] initWithImage:[UIImage systemImageNamed:@"arrow.clockwise"
                                                                withConfiguration:[UIImageSymbolConfiguration configurationWithPointSize:14 weight:UIImageSymbolWeightSemibold]]];
  icon.tintColor = UIColor.secondaryLabelColor;
  [icon setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
  UILabel *hint = [UILabel new];
  hint.text = LeadL(@"UI_RESTART_HINT");
  hint.font = LeadFont(13, UIFontWeightMedium);
  hint.textColor = UIColor.secondaryLabelColor;
  hint.numberOfLines = 2;
  hint.adjustsFontSizeToFitWidth = YES;
  hint.minimumScaleFactor = 0.8;

  UIButton *restart = [UIButton buttonWithType:UIButtonTypeCustom];
  [restart setTitle:LeadL(@"UI_RESTART") forState:UIControlStateNormal];
  restart.titleLabel.font = LeadFont(15, UIFontWeightSemibold);
  [restart setTitleColor:UIColor.systemBackgroundColor forState:UIControlStateNormal];
  restart.backgroundColor = UIColor.labelColor;
  restart.layer.cornerRadius = 18;
  restart.layer.cornerCurve = kCACornerCurveContinuous;
  restart.contentEdgeInsets = UIEdgeInsetsMake(0, 18, 0, 18);
  [restart setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
  [restart setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
  [restart addTarget:self action:@selector(restartTapped) forControlEvents:UIControlEventTouchUpInside];
  [restart addTarget:self action:@selector(restartDown:) forControlEvents:UIControlEventTouchDown | UIControlEventTouchDragEnter];
  [restart addTarget:self action:@selector(restartUp:) forControlEvents:UIControlEventTouchUpOutside | UIControlEventTouchCancel | UIControlEventTouchDragExit | UIControlEventTouchUpInside];

  UIStackView *stack = [[UIStackView alloc] initWithArrangedSubviews:@[ icon, hint, restart ]];
  stack.spacing = 10;
  stack.alignment = UIStackViewAlignmentCenter;
  stack.translatesAutoresizingMaskIntoConstraints = NO;
  [pill.contentView addSubview:stack];
  [self.view addSubview:pill];
  self.pill = pill;

  [NSLayoutConstraint activateConstraints:@[
    [restart.heightAnchor constraintEqualToConstant:36],
    [stack.leadingAnchor constraintEqualToAnchor:pill.contentView.leadingAnchor constant:18],
    [stack.trailingAnchor constraintEqualToAnchor:pill.contentView.trailingAnchor constant:-8],
    [stack.topAnchor constraintEqualToAnchor:pill.contentView.topAnchor constant:8],
    [stack.bottomAnchor constraintEqualToAnchor:pill.contentView.bottomAnchor constant:-8],
    [pill.leadingAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.leadingAnchor constant:16],
    [pill.trailingAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.trailingAnchor constant:-16],
    [pill.bottomAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.bottomAnchor constant:-8],
  ]];
  pill.alpha = 0;
  pill.transform = CGAffineTransformMakeTranslation(0, 120);
  pill.hidden = YES;
}

- (void)settingsChanged {
  if (!LeadNeedsRestart() || self.pillVisible) return;
  self.pillVisible = YES;
  self.pill.hidden = NO;
  [self.view bringSubviewToFront:self.pill];
  LeadSpring(0.6, 0.78, ^{
    self.pill.alpha = 1;
    self.pill.transform = CGAffineTransformIdentity;
    self.additionalSafeAreaInsets = UIEdgeInsetsMake(0, 0, 64, 0);
  }, nil);
}

- (void)restartDown:(UIButton *)button {
  LeadSpring(0.3, 0.6, ^{ button.transform = CGAffineTransformMakeScale(0.94, 0.94); }, nil);
}

- (void)restartUp:(UIButton *)button {
  LeadSpring(0.4, 0.5, ^{ button.transform = CGAffineTransformIdentity; }, nil);
}

- (void)restartTapped {
  LeadImpactHaptic(UIImpactFeedbackStyleRigid);
  LeadRestartTelegram();
}

@end

#pragma mark - Text page

@implementation LeadTextViewController {
  NSString *_text;
  BOOL _monospaced;
  UITextView *_textView;
}

- (instancetype)initWithTitle:(NSString *)title text:(NSString *)text monospaced:(BOOL)monospaced {
  self = [super initWithNibName:nil bundle:nil];
  if (self) {
    self.title = title;
    _text = text ?: @"";
    _monospaced = monospaced;
  }
  return self;
}

- (void)viewDidLoad {
  [super viewDidLoad];
  self.view.backgroundColor = UIColor.systemGroupedBackgroundColor;
  _textView = [UITextView new];
  _textView.editable = NO;
  _textView.backgroundColor = UIColor.clearColor;
  _textView.textContainerInset = UIEdgeInsetsMake(16, 16, 32, 16);
  _textView.font = _monospaced ? [UIFont monospacedSystemFontOfSize:12 weight:UIFontWeightRegular] : LeadFont(16, UIFontWeightRegular);
  _textView.textColor = UIColor.labelColor;
  _textView.alwaysBounceVertical = YES;
  _textView.translatesAutoresizingMaskIntoConstraints = NO;
  [self.view addSubview:_textView];
  [NSLayoutConstraint activateConstraints:@[
    [_textView.topAnchor constraintEqualToAnchor:self.view.topAnchor],
    [_textView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor],
    [_textView.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor],
    [_textView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor],
  ]];
  [self reloadText];

  if (self.filePath) {
    __weak typeof(self) weakSelf = self;
    UIAction *copy = [UIAction actionWithTitle:LeadL(@"UI_COPY") image:[UIImage systemImageNamed:@"doc.on.doc"] identifier:nil handler:^(__unused UIAction *action) {
      [UIPasteboard generalPasteboard].string = weakSelf.currentText;
      [LeadToast showText:LeadL(@"UI_COPIED") symbol:@"checkmark" inView:weakSelf.view];
    }];
    UIAction *clear = [UIAction actionWithTitle:LeadL(@"UI_CLEAR") image:[UIImage systemImageNamed:@"trash"] identifier:nil handler:^(__unused UIAction *action) {
      [@"" writeToFile:weakSelf.filePath atomically:YES encoding:NSUTF8StringEncoding error:nil];
      [weakSelf reloadText];
      [LeadToast showText:LeadL(@"UI_CLEARED") symbol:@"trash" inView:weakSelf.view];
    }];
    clear.attributes = UIMenuElementAttributesDestructive;
    self.navigationItem.rightBarButtonItem =
        [[UIBarButtonItem alloc] initWithImage:[UIImage systemImageNamed:@"ellipsis.circle"]
                                          menu:[UIMenu menuWithTitle:@"" children:@[ copy, clear ]]];
  }
}

- (NSString *)currentText {
  return _textView.text ?: @"";
}

- (void)reloadText {
  NSString *text = _text;
  if (self.filePath) {
    text = [NSString stringWithContentsOfFile:self.filePath encoding:NSUTF8StringEncoding error:nil];
    if (text.length == 0) text = LeadL(@"UI_LOG_EMPTY");
  }
  _textView.text = text;
  if (self.filePath && text.length > 0) {
    [_textView scrollRangeToVisible:NSMakeRange(text.length - 1, 1)];
  }
}

@end
