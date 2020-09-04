//
//  DYCircleTransition.m
//  02_Transition
//
//  Created by yidai on 2020/9/2.
//  Copyright © 2020 yidai. All rights reserved.
//

#import "DYCircleTransition.h"
#import "ViewController.h"
#import "SecondViewController.h"

/*
 1， 用贝塞尔画两个圆圈（重点：就是圆圈，中心店，半径）
 2， 做动画
 */

@interface DYCircleTransition() <CAAnimationDelegate>

@property (nonatomic, strong) id<UIViewControllerContextTransitioning> context;

@property (nonatomic,   weak) UIView *startView;
@property (nonatomic,   weak) UIView *endView;

@end

@implementation DYCircleTransition

static NSString * const transitionStartID = @"transition.start";
static NSString * const transitionEndID = @"transition.end";

- (void)animateTransition:(nonnull id<UIViewControllerContextTransitioning>)transitionContext {
    // 1. 持有上下文
    _context = transitionContext;
    // 2. 获取View的容器
    UIView *containerView = [transitionContext containerView];
    // 3. 获取toVC，把toVC的view添加到容器view中
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];

    // 查询相关view
    [self searchAnimationView:fromVC.view toView:toVC.view];

    if (_isPush) {
        [containerView addSubview:fromVC.view];
        [containerView addSubview:toVC.view];
        // 4. 添加动画
        /*
         1，2个圆(大小圆中心点一致)
         2，贝塞尔
         3，蒙版
         */
        // a, 画出小圆
        UIBezierPath *smallPath = [UIBezierPath bezierPathWithOvalInRect:self.endView.frame];
        CGPoint centerP = self.endView.center;
        CGRect rect = [toVC.view convertRect:self.endView.bounds fromView:self.endView];
        // 获取中心点
        CGPoint center = CGPointMake(rect.origin.x + self.startView.bounds.size.width * 0.5, rect.origin.y + self.startView.bounds.size.height * 0.5);
        // 获取中心点
        CGFloat width = MAX(toVC.view.bounds.size.width - center.x, center.x);
        CGFloat height = MAX(toVC.view.bounds.size.height - center.y, center.y);
        CGFloat radius = sqrtf(width * width + height * height);

        // c. 画出大圆
        UIBezierPath *bigPath = [UIBezierPath bezierPathWithArcCenter:center radius:radius startAngle:0 endAngle:M_PI*2 clockwise:YES];
        CAShapeLayer *shapeLayer = [CAShapeLayer layer];
        shapeLayer.path = bigPath.CGPath;
        // d. 添加蒙版
        toVC.view.layer.mask = shapeLayer;
        // e. 给layer添加动画
        CABasicAnimation *anim = [CABasicAnimation animationWithKeyPath:@"path"];
        anim.fromValue = (id)smallPath.CGPath;
//        anim.toValue = (id)bigPath.CGPath;  // 可以不写
        anim.duration = [self transitionDuration:transitionContext];
        anim.delegate = self;
        [shapeLayer addAnimation:anim forKey:nil];


    } else {
        [containerView addSubview:toVC.view];
        [containerView addSubview:fromVC.view];
        // a, 画出小圆
        CGRect rect = [fromVC.view convertRect:self.endView.bounds fromView:self.startView];
        UIBezierPath *smallPath = [UIBezierPath bezierPathWithOvalInRect:rect];
        CGPoint centerP = self.endView.center;
        // b. 求出半径
        
        // 获取中心点
        CGPoint center = CGPointMake(rect.origin.x + self.endView.bounds.size.width * 0.5, rect.origin.y + self.endView.bounds.size.height * 0.5);
        CGFloat width = MAX(UIScreen.mainScreen.bounds.size.width - center.x, center.x);
        CGFloat height = MAX(UIScreen.mainScreen.bounds.size.height - center.y, center.y);
        CGFloat radius = sqrtf(width * width + height * height);

        // c. 画出大圆
        UIBezierPath *bigPath = [UIBezierPath bezierPathWithArcCenter:centerP radius:radius startAngle:0 endAngle:M_PI*2 clockwise:YES];
        CAShapeLayer *shapeLayer = [CAShapeLayer layer];
        shapeLayer.path = smallPath.CGPath;
        // d. 添加蒙版
        fromVC.view.layer.mask = shapeLayer;
        // e. 给layer添加动画
        CABasicAnimation *anim = [CABasicAnimation animationWithKeyPath:@"path"];
        anim.fromValue = (id)bigPath.CGPath;
        anim.toValue = (id)smallPath.CGPath;  // 可以不写
        anim.duration = [self transitionDuration:transitionContext];
        anim.delegate = self;
        [shapeLayer addAnimation:anim forKey:nil];
    }

////    return;
//    //1.持有上下文
//    _context = transitionContext;
//    //2.获取view的容器
//    UIView *containerView = [transitionContext containerView];
//    //3.初始化tovc，把tovc的view添加到容器view
//    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
////    [containerView addSubview:toVC.view];
//    //4.添加动画
//    /*
//     拆分
//     1.2个圆（大小圆的中心点一致）
//     2.贝塞尔
//     3.蒙版
//     */
//    UIButton *btn;
//    ViewController *VC1;
//    SecondViewController *VC2;
//
//    if (_isPush) {
//        VC1 = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
//        VC2 = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
//        btn = VC1.blackBtn;
//    }else{
//        VC2 = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
//        VC1 = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
//        btn = VC2.redBtn;
//    }
//    [containerView addSubview:VC1.view];
//    [containerView addSubview:VC2.view];
////    ViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
//    //5.画出小圆
////    UIButton *btn = fromVC.blackBtn;
//    UIBezierPath *smallPath = [UIBezierPath bezierPathWithOvalInRect:btn.frame];
//    CGPoint centerP;
//    centerP = btn.center;
//    //6.求半径
//    CGFloat radius;
//    CGFloat y = CGRectGetHeight(toVC.view.bounds) - CGRectGetMaxY(btn.frame) + CGRectGetHeight(btn.bounds)/2;
//    CGFloat x = CGRectGetWidth(toVC.view.bounds) - CGRectGetMaxX(btn.frame) + CGRectGetWidth(btn.bounds)/2;
//    if (btn.frame.origin.x > CGRectGetWidth(toVC.view.bounds)/2) {
//        if (CGRectGetMaxY(btn.frame) < CGRectGetHeight(toVC.view.bounds)/2) {
//            //第一象限(求平方根)
//            radius = sqrtf(btn.center.x*btn.center.x + y*y);
//        }else{
//            //第四象限
//            radius = sqrtf(btn.center.x*btn.center.x + btn.center.y*btn.center.y);
//        }
//    }else{
//        if (CGRectGetMidY(btn.frame) < CGRectGetHeight(toVC.view.frame)) {
//            //第二象限
//            radius = sqrtf(x*x + y*y);
//        }else{
//            //第三象限
//            radius = sqrtf(x*x + btn.center.y*btn.center.y);
//        }
//    }
//    //7.画大圆
//    UIBezierPath *bigPath = [UIBezierPath bezierPathWithArcCenter:centerP radius:radius startAngle:0 endAngle:M_PI*2 clockwise:YES];
//    //8.
//    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
//    if (_isPush) {
//        shapeLayer.path = bigPath.CGPath;
//
//    }else{
//        shapeLayer.path = smallPath.CGPath;
//
//    }
//    //9.添加蒙板
//    UIViewController *VC;
//    if (_isPush) {
//        VC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
//    }else{
//        VC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
//    }
//    VC.view.layer.mask = shapeLayer;
//    //10.给layer添加动画
//    CABasicAnimation *anim = [CABasicAnimation animationWithKeyPath:@"path"];
//    if (_isPush) {
//        anim.fromValue = (id)smallPath.CGPath;
//
//    }else{
//        anim.fromValue = (id)bigPath.CGPath;
//
//    }
//    anim.duration = [self transitionDuration:transitionContext];
//    anim.delegate = self;
//    [shapeLayer addAnimation:anim forKey:nil];

}

- (void)searchAnimationView: (UIView *)fromView toView: (UIView *)toView {
    if (self.startView && self.endView) {
        return;
    }
    UIView *tempFromView = [self searchForView:fromView];
    if (tempFromView) {
        if ([tempFromView.accessibilityIdentifier isEqualToString:transitionStartID]) {
            self.startView = tempFromView;
        } else {
            self.endView = tempFromView;
        }
    }

    UIView *tempToView = [self searchForView:toView];
    if (tempToView) {
        if ([tempToView.accessibilityIdentifier isEqualToString:transitionStartID]) {
            self.startView = tempToView;
        } else {
            self.endView = tempToView;
        }
    }
}

- (UIView *)searchForView: (UIView *)view {
    for (UIView *subView in view.subviews) {
        if ([subView.accessibilityIdentifier isEqualToString:transitionStartID] || [subView.accessibilityIdentifier isEqualToString:transitionEndID]) {
            return subView;
        }
        UIView *tempView = [self searchForView:subView];
        if (tempView) {
            return tempView;
        }
    }
    return nil;
}

- (NSTimeInterval)transitionDuration:(nullable id<UIViewControllerContextTransitioning>)transitionContext {
    return 0.5f;
}


#pragma mark - CAAnimationDelegate

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    [_context completeTransition:YES];
    if (_isPush) {
        UIViewController *tovc = [_context viewControllerForKey:UITransitionContextToViewControllerKey];
        tovc.view.layer.mask = nil;
    }else{
        UIViewController *tovc = [_context viewControllerForKey:UITransitionContextFromViewControllerKey];
        tovc.view.layer.mask = nil;
    }
}


//- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext{
//    return .8f;
//}

//- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext{
//    //1.持有上下文
//    _context = transitionContext;
//    //2.获取view的容器
//    UIView *containerView = [transitionContext containerView];
//    //3.初始化tovc，把tovc的view添加到容器view
//    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
////    [containerView addSubview:toVC.view];
//    //4.添加动画
//    /*
//     拆分
//     1.2个圆（大小圆的中心点一致）
//     2.贝塞尔
//     3.蒙版
//     */
//    UIButton *btn;
//    ViewController *VC1;
//    SecondViewController *VC2;
//
//    if (_isPush) {
//        VC1 = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
//        VC2 = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
//        btn = VC1.blackBtn;
//    }else{
//        VC2 = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
//        VC1 = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
//        btn = VC2.redBtn;
//    }
//    [containerView addSubview:VC1.view];
//    [containerView addSubview:VC2.view];
////    ViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
//    //5.画出小圆
////    UIButton *btn = fromVC.blackBtn;
//    UIBezierPath *smallPath = [UIBezierPath bezierPathWithOvalInRect:btn.frame];
//    CGPoint centerP;
//    centerP = btn.center;
//    //6.求半径
//    CGFloat radius;
//    CGFloat y = CGRectGetHeight(toVC.view.bounds) - CGRectGetMaxY(btn.frame) + CGRectGetHeight(btn.bounds)/2;
//    CGFloat x = CGRectGetWidth(toVC.view.bounds) - CGRectGetMaxX(btn.frame) + CGRectGetWidth(btn.bounds)/2;
//    if (btn.frame.origin.x > CGRectGetWidth(toVC.view.bounds)/2) {
//        if (CGRectGetMaxY(btn.frame) < CGRectGetHeight(toVC.view.bounds)/2) {
//            //第一象限(求平方根)
//            radius = sqrtf(btn.center.x*btn.center.x + y*y);
//        }else{
//            //第四象限
//            radius = sqrtf(btn.center.x*btn.center.x + btn.center.y*btn.center.y);
//        }
//    }else{
//        if (CGRectGetMidY(btn.frame) < CGRectGetHeight(toVC.view.frame)) {
//            //第二象限
//            radius = sqrtf(x*x + y*y);
//        }else{
//            //第三象限
//            radius = sqrtf(x*x + btn.center.y*btn.center.y);
//        }
//    }
//    //7.画大圆
//    UIBezierPath *bigPath = [UIBezierPath bezierPathWithArcCenter:centerP radius:radius startAngle:0 endAngle:M_PI*2 clockwise:YES];
//    //8.
//    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
//    if (_isPush) {
//        shapeLayer.path = bigPath.CGPath;
//
//    }else{
//        shapeLayer.path = smallPath.CGPath;
//
//    }
//    //9.添加蒙板
//    UIViewController *VC;
//    if (_isPush) {
//        VC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
//    }else{
//        VC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
//    }
//    VC.view.layer.mask = shapeLayer;
//    //10.给layer添加动画
//    CABasicAnimation *anim = [CABasicAnimation animationWithKeyPath:@"path"];
//    if (_isPush) {
//        anim.fromValue = (id)smallPath.CGPath;
//
//    }else{
//        anim.fromValue = (id)bigPath.CGPath;
//
//    }
//    anim.duration = [self transitionDuration:transitionContext];
//    anim.delegate = self;
//    [shapeLayer addAnimation:anim forKey:nil];
//
//}

@end
