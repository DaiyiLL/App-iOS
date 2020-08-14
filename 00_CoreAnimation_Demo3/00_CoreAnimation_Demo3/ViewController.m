//
//  ViewController.m
//  00_CoreAnimation_Demo3
//
//  Created by yidai on 2020/7/30.
//  Copyright © 2020 yidai. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (nonatomic, strong) NSArray *imgs;
@property (nonatomic, assign) NSInteger index;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _imgs = @[@"view0", @"view1", @"view2"];
    _index = 0;
    
//    [self test];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    /*
    _index ++;
    NSString *imgName = _imgs[_index % _imgs.count];
    _iconView.image = [UIImage imageNamed:imgName];
    
    // 转场动画
    CATransition *anim = [CATransition animation];
    [anim setType:@"pageCurl"];
    anim.duration = 0.5;
    anim.startProgress = 0.2;
    anim.endProgress = 0.5;
    [_iconView.layer addAnimation:anim forKey:@"suckEffect"];
     */
    
    [self test];
}

- (void)test {
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(50, 500)];
    [path addCurveToPoint:CGPointMake(350, 500) controlPoint1:CGPointMake(170, 400) controlPoint2:CGPointMake(220, 600)];
    // 添加layer
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.path = path.CGPath;
    shapeLayer.fillColor = nil;
    shapeLayer.lineWidth = 4.0;
    shapeLayer.strokeColor = [UIColor orangeColor].CGColor;
    [self.view.layer addSublayer:shapeLayer];
    
    CALayer *colorLayer = [CALayer layer];
    colorLayer.frame = CGRectMake(0, 0, 66, 66);
    colorLayer.backgroundColor = [UIColor redColor].CGColor;
    colorLayer.position = CGPointMake(50, 500);
    [self.view.layer addSublayer:colorLayer];
    
    CAKeyframeAnimation *anim = [CAKeyframeAnimation animation];
    anim.path = path.CGPath;
    anim.keyPath = @"position";
    anim.duration = 3;
//    [colorLayer addAnimation:anim forKey:nil];
    
    
    CGFloat red = arc4random() / (CGFloat)INT_MAX;
    CGFloat green = arc4random() / (CGFloat)INT_MAX;
    CGFloat blue = arc4random() / (CGFloat)INT_MAX;
    UIColor *color = [UIColor colorWithRed:red green:green blue:blue alpha:1.0];
    
    CABasicAnimation *basicAnim = [CABasicAnimation animation];
    basicAnim.keyPath = @"backgroundColor";
    basicAnim.toValue = (id)color.CGColor;
    basicAnim.duration = 3;
//    [colorLayer addAnimation:basicAnim forKey:nil];
    
    CABasicAnimation *anim1 = [CABasicAnimation animation];
    anim1.keyPath = @"transform.scale";
    anim1.toValue = @0.5;
    anim1.duration = 3;
//    [colorLayer addAnimation:anim1 forKey:nil];
    
    
    CAAnimationGroup *group = [CAAnimationGroup animation];
    group.animations = @[anim, basicAnim, anim1];
    group.duration = 3;
    [colorLayer addAnimation:group forKey:nil];
}


@end
