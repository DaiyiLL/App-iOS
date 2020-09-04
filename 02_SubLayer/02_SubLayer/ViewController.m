//
//  ViewController.m
//  02_SubLayer
//
//  Created by yidai on 2020/8/31.
//  Copyright © 2020 yidai. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    [self gradientLayer];
    [self transform3D];
}

- (void)transform3D {
    CATransformLayer *cubeLayer = [CATransformLayer layer];
    // 正面
    CATransform3D ct = CATransform3DMakeTranslation(0, 0, 50);
    [cubeLayer addSublayer:[self faceWithTransform:ct]];
    // 后面
    ct = CATransform3DMakeTranslation(0, 0, -50);
    [cubeLayer addSublayer:[self faceWithTransform:ct]];
    
    // 上面
    ct = CATransform3DMakeTranslation(0, 50, 0);
    ct = CATransform3DRotate(ct, M_PI_2, 1, 0, 0);
    [cubeLayer addSublayer:[self faceWithTransform:ct]];
    
    // 下面
    ct = CATransform3DMakeTranslation(0, -50, 0);
    ct = CATransform3DRotate(ct, M_PI_2, 1, 0, 0);
    [cubeLayer addSublayer:[self faceWithTransform:ct]];
    
    // 左面
    ct = CATransform3DMakeTranslation(-50, 0, 0);
    ct = CATransform3DRotate(ct, M_PI_2, 0, 1, 0);
    [cubeLayer addSublayer:[self faceWithTransform:ct]];
    
    // 又面
    ct = CATransform3DMakeTranslation(50, 0, 0);
    ct = CATransform3DRotate(ct, M_PI_2, 0, 1, 0);
    [cubeLayer addSublayer:[self faceWithTransform:ct]];
    
    cubeLayer.position = CGPointMake(self.view.bounds.size.width / 2, self.view.bounds.size.height / 2);
//    cubeLayer.bounds = CGRectMake(100, 100, 100, 100);
    cubeLayer.position = self.view.center;
    cubeLayer.transform = CATransform3DMakeRotation(M_PI_4, 1, 1, 0);
    
    
    [self.view.layer addSublayer:cubeLayer];
}

- (CALayer *)faceWithTransform: (CATransform3D)transfrom {
    CALayer *face = [CALayer layer];
    face.bounds = CGRectMake(0, 0, 100, 100);
    CGFloat red = ((int)arc4random() % 256) / 255.0;
    CGFloat green = ((int)arc4random() % 256) / 255.0;
    CGFloat blue = ((int)arc4random() % 256) / 255.0;
    face.backgroundColor = [[UIColor alloc] initWithRed:red green:green blue:blue alpha:1.0].CGColor;
//    face.backgroundColor = UIColor.greenColor.CGColor;
    face.transform = transfrom;
    
    return face;
}

- (void)gradientLayer {
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = CGRectMake(100, 100, 100, 100);
    gradient.colors = @[(id)(UIColor.redColor.CGColor), (id)(UIColor.yellowColor.CGColor), (id)(UIColor.orangeColor.CGColor)];
    
    [self.view.layer addSublayer:gradient];
    
    
}


@end
