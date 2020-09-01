//
//  ViewController.m
//  01_FirePerson
//
//  Created by yidai on 2020/8/17.
//  Copyright © 2020 yidai. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    [self shapeLayer];
    [self textLayer];
}

- (void)textLayer {
    CATextLayer *textLayer = [CATextLayer layer];
    textLayer.frame = CGRectMake(100, 100, 200, 50);
    textLayer.backgroundColor = UIColor.orangeColor.CGColor;
    textLayer.string = @"Hello world";
    textLayer.alignmentMode = kCAAlignmentCenter;
    textLayer.fontSize = [UIFont systemFontOfSize:20].pointSize;
    textLayer.foregroundColor = UIColor.blueColor.CGColor;
    [self.view.layer addSublayer:textLayer];
}

- (void)shapeLayer {
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(175, 100)];
    [path addArcWithCenter:CGPointMake(150, 100) radius:25 startAngle:0 endAngle:2 * M_PI clockwise:true];
    
    [path moveToPoint:CGPointMake(150, 125)];
    [path addLineToPoint:CGPointMake(150, 175)];
    [path addLineToPoint:CGPointMake(125, 225)];
    
    [path moveToPoint:CGPointMake(150, 175)];
    [path addLineToPoint:CGPointMake(175, 225)];
    
    [path moveToPoint:CGPointMake(120, 135)];
    [path addLineToPoint:CGPointMake(180, 135)];
    
    
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.path = path.CGPath;
    shapeLayer.strokeColor = UIColor.redColor.CGColor;
    shapeLayer.lineWidth = 5;
    shapeLayer.fillColor = nil;
    shapeLayer.lineCap = kCALineCapRound;
    [self.view.layer addSublayer:shapeLayer];
}


@end
