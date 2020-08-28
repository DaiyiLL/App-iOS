//
//  slideMenuView.m
//  侧滑动画001
//
//  Created by Dean on 2018/7/12.
//  Copyright © 2018年 tz. All rights reserved.
//
/*
 1.添加模糊背景
 2.划入菜单栏
 3.思考：如何让view动起来？多次绘制（动画基于绘制）
 4.通过2个辅助view，求出它们的插值，获取到一组动态的数据
 5.CADisplayLink
 6.添加按钮
 */
#define menuBlankWidth 50
#define menuBtnHeight 40
#define buttonSpace 30

#import "SlideMenuView.h"

@interface SlideMenuView()

@property (nonatomic, strong) UIVisualEffectView *blurView;
@property (nonatomic, strong) UIView *helperSideView;
@property (nonatomic, strong) UIView *helperCenterView;
@property (nonatomic, strong) UIWindow *keyWindow;

@property (nonatomic, assign) BOOL swiched;
@property (nonatomic, assign) CGFloat diff;
@property (nonatomic, strong) UIColor *menuColor;
@property (nonatomic, strong) CADisplayLink *displayLink;
@property (nonatomic, assign) NSInteger animationCount;

@property (nonatomic, strong) NSArray<UIButton *> *btns;

@end

@implementation SlideMenuView

#pragma mark - lifeCycle
-(id)initWithBtnTitle:(NSArray *)btnTitles{
    self = [super init];
    if (self) {
        _menuColor = [UIColor colorWithRed:0 green:0.722 blue:1 alpha:1];
        
        _keyWindow = [UIApplication sharedApplication].windows.firstObject;
        _blurView = [[UIVisualEffectView alloc] initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleDark]];
        _blurView.frame = _keyWindow.frame;
        _blurView.alpha = 0.5;
        
        self.frame =CGRectMake(-(CGRectGetWidth(_keyWindow.frame)/2 + menuBlankWidth), 0, CGRectGetWidth(_keyWindow.frame)/2 + menuBlankWidth, CGRectGetHeight(_keyWindow.frame));
        self.backgroundColor = [UIColor clearColor];
        
//        [keyWindow addSubview:self];
        _helperSideView = [[UIView alloc] initWithFrame:CGRectMake(-40, AppDelegate.safeInset.top, 40, 40)];;
//        _helperSideView.backgroundColor = [UIColor redColor];
        _helperCenterView = [[UIView alloc] initWithFrame:CGRectMake(-40, CGRectGetHeight(_keyWindow.bounds)/2-20, 40, 40)];;
//        _helperCenterView.backgroundColor = [UIColor orangeColor];
        
        [_keyWindow addSubview:_helperSideView];
        [_keyWindow addSubview:_helperCenterView];
        [_keyWindow insertSubview:self belowSubview:_helperSideView];
        
        //添加手势
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissView)];
        [_blurView addGestureRecognizer:tap];
        
        //添加按钮
        [self addBtnTitles:btnTitles];
        
    }
    return self;
   
}

- (void)drawRect:(CGRect)rect{
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(0, 0)];
    
    CGFloat halfWidth = _keyWindow.width * 0.5;
    [path addLineToPoint:CGPointMake(halfWidth, 0)];
    [path addQuadCurveToPoint:CGPointMake(halfWidth, self.height) controlPoint:CGPointMake(halfWidth + _diff, self.height * 0.5)];
    [path addLineToPoint:CGPointMake(0, self.height)];
    [path closePath];
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextAddPath(context, path.CGPath);
    [_menuColor set];
    CGContextFillPath(context);
    
    
//    [path addLineToPoint:CGPointMake(CGRectGetWidth(keyWindow.frame)/2, 0)];
//    [path addQuadCurveToPoint:CGPointMake(CGRectGetWidth(keyWindow.frame)/2, CGRectGetHeight(keyWindow.frame)) controlPoint:CGPointMake(CGRectGetWidth(keyWindow.frame)/2 + diff, CGRectGetHeight(keyWindow.frame)/2)];
//    [path addLineToPoint:CGPointMake(0, CGRectGetHeight(keyWindow.frame))];
//    [path closePath];
//
//    CGContextRef context = UIGraphicsGetCurrentContext();
//    CGContextAddPath(context, path.CGPath);
//    [menuColor set];
//    CGContextFillPath(context);
}

#pragma mark - func
- (void)addBtnAnim{
    for (int i = 0; i < self.subviews.count; i++) {
        UIButton *btn = _btns[i];
        btn.transform = CGAffineTransformMakeTranslation(-100, 0);
        [UIView animateWithDuration:.7 delay:i * (0.3 / _btns.count) usingSpringWithDamping:.6 initialSpringVelocity:0 options:(UIViewAnimationOptionBeginFromCurrentState) animations:^{
            btn.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
            
        }];
    }
    
//    for (int i = 0; i < self.subviews.count; i++) {
//        UIView *btn = self.subviews[i];
//        btn.transform = CGAffineTransformMakeTranslation(-100, 0);
//        [UIView animateWithDuration:.7 delay:i*(0.3/self.subviews.count) usingSpringWithDamping:.6 initialSpringVelocity:0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
//            btn.transform = CGAffineTransformIdentity;
//        } completion:nil];
//    }
}
- (void)addBtnTitles:(NSArray *)titles{
    CGFloat space = (CGRectGetHeight(_keyWindow.bounds) - titles.count*menuBtnHeight - (titles.count-1)*buttonSpace)/2;
    
    NSMutableArray *tempList = [NSMutableArray arrayWithCapacity:titles.count];
    for (int i = 0; i < titles.count; i++) {
        UIButton *btn = [DYFactory initButtonWithFrame:CGRectZero title:titles[i] titleColor:UIColor.whiteColor font:[UIFont regularFont:15]];
        btn.center = CGPointMake(_keyWindow.width/4, space + menuBtnHeight*i + buttonSpace*i);
        btn.bounds = CGRectMake(0, 0, _keyWindow.width/2 - 20*2, menuBtnHeight);
        btn.layer.borderColor = UIColor.whiteColor.CGColor;
        btn.layer.borderWidth = 1.0;
        btn.layer.cornerRadius = menuBtnHeight * 0.5;
        [self addSubview:btn];
        [tempList addObject:btn];
    }
    _btns = [NSArray arrayWithArray:tempList];
}
//添加定时器
- (void)getDiff{
    if (!_displayLink) {
        _displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(displayLinkAction:)];
        [_displayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
    }
}
#pragma mark - Actions
//移除定时器
- (void)removeDisplayLink{
    [_displayLink invalidate];
    _displayLink = nil;
    _diff = 0;
}
- (void)displayLinkAction:(CADisplayLink *)link{
//    NSLog(@"%@", NSStringFromCGRect(_helperSideView.frame));
    CALayer *layer1 = _helperSideView.layer.presentationLayer;
    CALayer *layer2 = _helperCenterView.layer.presentationLayer;
    
    CGRect r1 = [[layer1 valueForKeyPath:@"frame"] CGRectValue];
    CGRect r2 = [[layer2 valueForKeyPath:@"frame"] CGRectValue];
    _diff = r1.origin.x - r2.origin.x;
    
    [self setNeedsDisplay];
    
//    NSLog(@"%f", _diff);
}
//点击按钮
-(void)switchAcition{
    if (!_swiched) {
    
        //1.添加模糊背景
        [_keyWindow insertSubview:_blurView belowSubview:self];
        //2.划入菜单栏
        [UIView animateWithDuration:.3 animations:^{
            self.frame = self.bounds;
            self.blurView.alpha = 1;
        }];
        // 3. 添加弹簧动画
        [UIView animateWithDuration:0.7 delay:0 usingSpringWithDamping:.5 initialSpringVelocity:.9 options:(UIViewAnimationOptionBeginFromCurrentState) animations:^{
            self.helperSideView.center = CGPointMake(self.keyWindow.centerX, self.helperSideView.centerY);
        } completion:nil];
        
        [UIView animateWithDuration:0.7 delay:0 usingSpringWithDamping:.8 initialSpringVelocity:.9 options:(UIViewAnimationOptionBeginFromCurrentState) animations:^{
            self.helperCenterView.center = self.keyWindow.center;
        } completion:^(BOOL finished) {
            [self removeDisplayLink];
        }];
        // 获取差值
        [self getDiff];
        // 按钮的弹簧动画
        [self addBtnAnim];
        
        //3.添加弹簧动画
//        [UIView animateWithDuration:.7 delay:0 usingSpringWithDamping:.5 initialSpringVelocity:.9 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
//            self.helperSideView.center = CGPointMake(self.keyWindow.center.x, CGRectGetHeight(self.helperSideView.bounds)/2);
//        } completion:nil];
//        [UIView animateWithDuration:.7 delay:0 usingSpringWithDamping:.8 initialSpringVelocity:2 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
//            self.helperCenterView.center = self.keyWindow.center;
//        } completion:^(BOOL finished) {
//            [self removeDisplayLink];
//        }];
//        //获取差值
//        [self getDiff];
//        //添加按钮的动画
//        [self addBtnAnim];
        _swiched = YES;
    }else{
        [self dismissView];
    }
}

//消失
- (void)dismissView{
    
    _swiched = NO;
    [UIView animateWithDuration:.3 animations:^{
        self.frame =CGRectMake(-(CGRectGetWidth(self.keyWindow.frame)/2 + menuBlankWidth), 0, CGRectGetWidth(self.keyWindow.frame)/2 + menuBlankWidth, CGRectGetHeight(self.keyWindow.frame));
        self.blurView.alpha = 0;
        self.helperSideView.center = CGPointMake(-20, self.helperSideView.centerY);
        self.helperCenterView.center = CGPointMake(-20, CGRectGetHeight(self.keyWindow.bounds)/2);
    }];
}
@end
