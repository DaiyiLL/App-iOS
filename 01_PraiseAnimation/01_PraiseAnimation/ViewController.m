//
//  ViewController.m
//  01_PraiseAnimation
//
//  Created by yidai on 2020/8/24.
//  Copyright © 2020 yidai. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <CAAnimationDelegate>
@property (weak, nonatomic) IBOutlet UIButton *likeBtn;
@property (nonatomic, strong) CAEmitterLayer *emitterLayer;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [_likeBtn setImage:[UIImage imageNamed:@"default"] forState:(UIControlStateNormal)];
    [_likeBtn setImage:[UIImage imageNamed:@"select"] forState:(UIControlStateSelected)];
    
    [_likeBtn addTarget:self action:@selector(likcBtnClicked:) forControlEvents:(UIControlEventTouchUpInside)];
    
    [self explosion];
    
}

- (void)explosion {
    _emitterLayer = [CAEmitterLayer layer];
    CAEmitterCell *cell = [[CAEmitterCell alloc] init];
    cell.name = @"explosionCell";
    cell.lifetime = .7;
    cell.birthRate = 4000;
    cell.velocity = 50;
    cell.velocityRange = 15;
    cell.scale = .03;
    cell.scaleRange = .02;
    cell.contents = (id)[UIImage imageNamed:@"sparkle"].CGImage;
    
    _emitterLayer.name = @"explosionLayer";
    _emitterLayer.emitterShape = kCAEmitterLayerCircle;
    _emitterLayer.emitterMode = kCAEmitterLayerOutline;
    _emitterLayer.emitterSize = CGSizeMake(25, 0);
    _emitterLayer.emitterCells = @[cell];
    _emitterLayer.renderMode = kCAEmitterLayerOldestFirst;
    _emitterLayer.masksToBounds = NO;
    _emitterLayer.birthRate = 0;
    _emitterLayer.zPosition = 0;
    _emitterLayer.position = CGPointMake(_likeBtn.width * 0.5, _likeBtn.height * 0.5);
    
    [_likeBtn.layer addSublayer:_emitterLayer];
}

- (void)likcBtnClicked: (UIButton *)sender {
    sender.selected = !sender.selected;
    // 关键帧动画
    CAKeyframeAnimation *anim = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
    if (sender.selected) {
        anim.values = @[@1.5, @0.8, @1, @1.2];
        anim.duration = .6;
        anim.delegate = self;
    } else {
        anim.values = @[@.8, @1.0];
        anim.duration = .4;
    }
    [_likeBtn.layer addAnimation:anim forKey:nil];
}

- (void)addExplosionAnim {
    _emitterLayer.beginTime = CACurrentMediaTime();
    _emitterLayer.birthRate = 1;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.emitterLayer.birthRate = 0;
    });
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    [self addExplosionAnim];
}


@end
