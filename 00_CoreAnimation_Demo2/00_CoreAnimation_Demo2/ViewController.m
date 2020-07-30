//
//  ViewController.m
//  00_CoreAnimation_Demo2
//
//  Created by yidai on 2020/7/30.
//  Copyright © 2020 yidai. All rights reserved.
//
/*
 贝塞尔曲线: 1, 数据点(起点终点) 2, 控制点
 */

#import "ViewController.h"

#define DYAngleToRadian(angle) ((angle) / 180.0 * M_PI)

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *iconView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    [self test];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    CAKeyframeAnimation *anim = [CAKeyframeAnimation animation];
    anim.keyPath = @"transform.rotation";
//    anim.values = @[@(DYAngleToRadian(-3)), @(DYAngleToRadian(3)), @(DYAngleToRadian(-3))];
    anim.values = @[@(DYAngleToRadian(-3)), @(DYAngleToRadian(3))];
    anim.autoreverses = true;
    anim.speed = 2;
//    anim.duration = 1;
    anim.repeatCount = MAXFLOAT;
    [_iconView.layer addAnimation:anim forKey:nil];
    
    [self test];
}

- (void)test {
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(20, 200)];
    [path addCurveToPoint:CGPointMake(300, 200) controlPoint1:CGPointMake(100, 100) controlPoint2:CGPointMake(200, 300)];
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.path = path.CGPath;
    shapeLayer.contents = (__bridge id _Nullable)([UIImage imageNamed:@"car"].CGImage);
    shapeLayer.fillColor = nil;
    shapeLayer.strokeColor = UIColor.greenColor.CGColor;
    shapeLayer.lineWidth = 3.0;
    [self.view.layer addSublayer:shapeLayer];
    
    CALayer *carLayer = [CALayer layer];
    carLayer.frame = CGRectMake(20 - 18, 200 - 18, 36, 36);
    carLayer.contents = (id)[UIImage imageNamed:@"car"].CGImage;
    carLayer.anchorPoint = CGPointMake(0.5, 0.8);
    [self.view.layer addSublayer:carLayer];
    
    CAKeyframeAnimation *anim = [CAKeyframeAnimation animation];
    anim.keyPath = @"position";
    anim.path = path.CGPath;
    anim.duration = 4.0;
    anim.rotationMode = kCAAnimationRotateAuto;
    [carLayer addAnimation:anim forKey:nil];
}


@end
