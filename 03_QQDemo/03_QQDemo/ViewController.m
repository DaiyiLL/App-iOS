//
//  ViewController.m
//  03_QQDemo
//
//  Created by yidai on 2020/9/5.
//  Copyright © 2020 yidai. All rights reserved.
//

/*
 1，2个园（一个固定圆，一个可拖动）
 2，贝塞尔曲线（关键点）
 3，固定圆比例缩小
 4，拖拽到一定距离的时候需要断开
 5，断开之后有个圆反弹效果
 */

#import "ViewController.h"
#import "NSThread+Shared.h"

@interface ViewController ()

@property (nonatomic, strong) UIView *view1;
@property (nonatomic, strong) UIView *view2;
@property (nonatomic, strong) CAShapeLayer *shapeLayer;
@property (nonatomic, assign) CGPoint oldCenter;
@property (nonatomic, assign) CGFloat oldRadius;
@property (nonatomic, assign) CGFloat maxDistance;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self performSelector:@selector(test) onThread:[NSThread shareThread] withObject:nil waitUntilDone:NO];
    
    [self setup];
}

- (void)test {
    NSLog(@"test: %@", [NSThread currentThread]);
}

- (void)setup {
    _view1 = [[UIView alloc] initWithFrame:CGRectMake(100, 88, 20, 20)];
    _view1.layer.cornerRadius = 10;
    _view1.backgroundColor = UIColor.redColor;
    [self.view addSubview:_view1];
    _oldCenter = _view1.center;
    _oldRadius = _view1.width * 0.5;
    
    _view2 = [[UIView alloc] initWithFrame:_view1.frame];
    _view2.layer.cornerRadius = 10;
    _view2.backgroundColor = UIColor.greenColor;
    [self.view addSubview:_view2];
    
    // 添加label
    UILabel *numLabel = [DYFactory initLabelWithFrame:_view2.bounds text:@"99" textColor:UIColor.whiteColor font:[UIFont regularFont:15] align:(NSTextAlignmentCenter)];
    [_view2 addSubview:numLabel];
    
    // 添加手势
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panAction:)];
    [_view2 addGestureRecognizer:pan];
    
    _shapeLayer = [CAShapeLayer layer];
    _shapeLayer.fillColor = UIColor.redColor.CGColor;
   
}

- (void)panAction:(UIPanGestureRecognizer *)ges {
    if (ges.state == UIGestureRecognizerStateChanged) {
        // 1. view2跟着手势移动
        _view2.centerY = [ges locationInView:self.view].y;
        if (_view1.width < 8) {
            _view1.hidden = true;
            [_shapeLayer removeFromSuperlayer];
            return;
        }
        
        // 2. 计算6个关键点
        [self calculatePoint];
    } else if (ges.state == UIGestureRecognizerStateCancelled || ges.state == UIGestureRecognizerStateEnded || UIGestureRecognizerStateFailed == ges.state) {
        [self endAnimation];
    }
}

- (void)calculatePoint {
    // 1. 初始化中心点
    CGPoint center1 = _view1.center;
    CGPoint center2 = _view2.center;
    
    // 2. 求出2个中心点的距离
    CGFloat disX = center2.x - center1.x;
    CGFloat disY = center2.y - center1.y;
    CGFloat distance = sqrt(disX * disX + disY * disY);
    // 3. 求出正弦余弦
    CGFloat sin = (center2.x - center1.x) / distance;
    CGFloat cos = (center1.y - center2.y) / distance;
    
    // 4. 半径
    CGFloat r1 = _oldRadius - distance / 10;
    CGFloat r2 = _view2.width * 0.5;
    // 5. 计算6个关键点
    CGPoint pA = CGPointMake(center1.x - r1 * cos, center1.y - r1 * sin);
    CGPoint pB = CGPointMake(center1.x + r1 * cos, center1.y + r1 * sin);
    
    CGPoint pC = CGPointMake(center2.x + r2 * cos, center2.y + r2 * sin);
    CGPoint pD = CGPointMake(center2.x - r2 * cos, center2.y - r2 * sin);
    
//    CGPoint centerD = CGPointMake(center1.x + disX * 0.5, center1.y + disY * 0.5);
    CGPoint pO = CGPointMake(pA.x + distance * sin * 0.5, pA.y - distance * cos * 0.5);
    CGPoint pP = CGPointMake(pB.x + distance * sin * 0.5, pB.y - distance * cos * 0.5);
    
    // 6. 画贝塞尔曲线
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:pA];
    [path addQuadCurveToPoint:pD controlPoint:pO];
    [path addLineToPoint:pC];
    [path addQuadCurveToPoint:pB controlPoint:pP];
    [path closePath];
    
    // 7. 把路径添加layer上
    _shapeLayer.path = path.CGPath;
    // 8. 把layer添加在view.layer上
    [self.view.layer insertSublayer:_shapeLayer below:_view2.layer];
    
    _view1.bounds = CGRectMake(0, 0, r1 * 2, r1 * 2);
    _view1.layer.cornerRadius = r1;
    _view1.center = _oldCenter;
}

- (void)endAnimation {
    [_shapeLayer removeFromSuperlayer];
    [UIView animateWithDuration:.5 delay:0 usingSpringWithDamping:.3 initialSpringVelocity:0 options:(UIViewAnimationOptionCurveEaseInOut) animations:^{
        self.view2.center = self.oldCenter;
        
    } completion:^(BOOL finished) {
        self.view1.bounds = CGRectMake(0, 0, _oldRadius * 2, _oldRadius * 2);
        self.view1.layer.cornerRadius = self.oldRadius;
        self.view1.center = self.oldCenter;
        self.view1.hidden = false;
    }];
}

@end
