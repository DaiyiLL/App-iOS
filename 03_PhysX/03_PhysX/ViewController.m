//
//  ViewController.m
//  03_PhysX
//
//  Created by yidai on 2020/9/4.
//  Copyright © 2020 yidai. All rights reserved.
//

#import "ViewController.h"

/*
 1，添加行为 （需要绑定View）
 2，把行为添加到容器里面（绑定view的父view）
 
 */
@interface ViewController ()

@property (nonatomic, strong) UIDynamicAnimator *animator;
@property (nonatomic, strong) UIAttachmentBehavior *attachmentBehavior;
@property (weak, nonatomic) IBOutlet UIView *redView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self commentInit];
}

- (void)commentInit {
    // 容器
    _animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
    // 自由落体行为
    UIGravityBehavior *gravity = [[UIGravityBehavior alloc] initWithItems:@[_redView]];
    [_animator addBehavior:gravity];
    // 碰撞行为
    UICollisionBehavior *collision = [[UICollisionBehavior alloc] initWithItems:@[_redView]];
    collision.translatesReferenceBoundsIntoBoundary = true;
    [_animator addBehavior:collision];
    // 弹性系数
    UIDynamicItemBehavior *itemBehavior = [[UIDynamicItemBehavior alloc] initWithItems:@[_redView]];
    itemBehavior.elasticity = 0.6;
    [_animator addBehavior:itemBehavior];
    
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panAction:)];
    [self.view addGestureRecognizer:pan];
}

- (void)panAction: (UIPanGestureRecognizer *)pan {
    if (pan.state == UIGestureRecognizerStateBegan) {
        UIOffset offset = UIOffsetMake(-30, -30);
        _attachmentBehavior = [[UIAttachmentBehavior alloc] initWithItem:_redView offsetFromCenter:offset attachedToAnchor:[pan locationInView:self.view]];
        [_animator addBehavior:_attachmentBehavior];
    } else if (pan.state == UIGestureRecognizerStateChanged) {
        [_attachmentBehavior setAnchorPoint:[pan locationInView:self.view]];
    } else if (pan.state == UIGestureRecognizerStateEnded || pan.state == UIGestureRecognizerStateCancelled || pan.state == UIGestureRecognizerStateFailed) {
        [_animator removeBehavior:_attachmentBehavior];
    }
}


@end
