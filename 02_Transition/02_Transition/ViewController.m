//
//  ViewController.m
//  02_Transition
//
//  Created by yidai on 2020/9/2.
//  Copyright © 2020 yidai. All rights reserved.
//

#import "ViewController.h"
#import "SecondViewController.h"
#import "DYCircleTransition.h"
#import "DNCircleTransition.h"
#import "DYTransitionAnimation.h"

@interface ViewController ()

@property (nonatomic, strong) DYTransitionAnimation *animation;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    self.navigationController.delegate = self;
    [self.blackBtn addTarget:self action:@selector(backBtnClicked:) forControlEvents:(UIControlEventTouchUpInside)];
    self.blackBtn.accessibilityIdentifier = @"transition.start";
    
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    self.navigationController.transitioningDelegate = nil;
}

- (void)backBtnClicked: (UIButton *)sender {
    UIStoryboard*storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    SecondViewController *secondVC = [storyboard instantiateViewControllerWithIdentifier:@"SecondViewController"];
    
    self.animation = [[DYTransitionAnimation alloc] init];
    self.navigationController.delegate = self.animation;
    [self.navigationController pushViewController:secondVC animated:true];
}

//- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    CGRect rect = [UIApplication.sharedApplication.windows.firstObject convertRect:self.blackBtn.bounds fromView:self.blackBtn];
//    NSLog(@"%@", NSStringFromCGRect(rect));
//}

// 告诉nav，我想自己自定义一个转场
- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC {
    if (operation == UINavigationControllerOperationPush) {
        DYCircleTransition *transition = [[DYCircleTransition alloc] init];
        transition.isPush = true;
        return transition;
        
//        DNCircleTransition *transition = [[DNCircleTransition alloc] init];
//        transition.isPush = true;
//        return transition;
    }
    DYCircleTransition *transition = [[DYCircleTransition alloc] init];
    return transition;
}


//- (id<UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController interactionControllerForAnimationController:(id<UIViewControllerAnimatedTransitioning>)animationController {
//
//}




@end
