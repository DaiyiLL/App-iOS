//
//  DNCircleTransition.m
//  自定义转场动画002
//
//  Created by Dean on 2018/7/31.
//  Copyright © 2018年 tz. All rights reserved.
//

/*
 1.用贝塞尔画2个圆圈(重点：就是画圆圈，中心点，半径)
 2.做动画
 */
#import "DNCircleTransition.h"
#import "ViewController.h"
#import "SecondViewController.h"
@interface DNCircleTransition()<CAAnimationDelegate>

@property (nonatomic, strong) id<UIViewControllerContextTransitioning> context;
@end

@implementation DNCircleTransition

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext{
    return .8f;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext{
    //1.持有上下文
    _context = transitionContext;
    //2.获取view的容器
    UIView *containerView = [transitionContext containerView];
    //3.初始化tovc，把tovc的view添加到容器view
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
//    [containerView addSubview:toVC.view];
    //4.添加动画
    /*
     拆分
     1.2个圆（大小圆的中心点一致）
     2.贝塞尔
     3.蒙版
     */
    UIButton *btn;
    ViewController *VC1;
    SecondViewController *VC2;
    
    if (_isPush) {
        VC1 = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
        VC2 = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
        btn = VC1.blackBtn;
    }else{
        VC2 = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
        VC1 = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
        btn = VC2.redBtn;
    }
    [containerView addSubview:VC1.view];
    [containerView addSubview:VC2.view];
//    ViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    //5.画出小圆
//    UIButton *btn = fromVC.blackBtn;
    UIBezierPath *smallPath = [UIBezierPath bezierPathWithOvalInRect:btn.frame];
    CGPoint centerP;
    centerP = btn.center;
    //6.求半径
    CGFloat radius;
    CGFloat y = CGRectGetHeight(toVC.view.bounds) - CGRectGetMaxY(btn.frame) + CGRectGetHeight(btn.bounds)/2;
    CGFloat x = CGRectGetWidth(toVC.view.bounds) - CGRectGetMaxX(btn.frame) + CGRectGetWidth(btn.bounds)/2;
    if (btn.frame.origin.x > CGRectGetWidth(toVC.view.bounds)/2) {
        if (CGRectGetMaxY(btn.frame) < CGRectGetHeight(toVC.view.bounds)/2) {
            //第一象限(求平方根)
            radius = sqrtf(btn.center.x*btn.center.x + y*y);
        }else{
            //第四象限
            radius = sqrtf(btn.center.x*btn.center.x + btn.center.y*btn.center.y);
        }
    }else{
        if (CGRectGetMidY(btn.frame) < CGRectGetHeight(toVC.view.frame)) {
            //第二象限
            radius = sqrtf(x*x + y*y);
        }else{
            //第三象限
            radius = sqrtf(x*x + btn.center.y*btn.center.y);
        }
    }
    //7.画大圆
    UIBezierPath *bigPath = [UIBezierPath bezierPathWithArcCenter:centerP radius:radius startAngle:0 endAngle:M_PI*2 clockwise:YES];
    //8.
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    if (_isPush) {
        shapeLayer.path = bigPath.CGPath;

    }else{
        shapeLayer.path = smallPath.CGPath;

    }
    //9.添加蒙板
    UIViewController *VC;
    if (_isPush) {
        VC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    }else{
        VC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    }
    VC.view.layer.mask = shapeLayer;
    //10.给layer添加动画
    CABasicAnimation *anim = [CABasicAnimation animationWithKeyPath:@"path"];
    if (_isPush) {
        anim.fromValue = (id)smallPath.CGPath;

    }else{
        anim.fromValue = (id)bigPath.CGPath;

    }
    anim.duration = [self transitionDuration:transitionContext];
    anim.delegate = self;
    [shapeLayer addAnimation:anim forKey:nil];
    
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
@end
