//
//  DYTransitionAnimation.m
//  02_Transition
//
//  Created by yidai on 2020/9/4.
//  Copyright © 2020 yidai. All rights reserved.
//

#import "DYTransitionAnimation.h"
#import "DYCircleTransition.h"

@implementation DYTransitionAnimation

// 告诉nav，我想自己自定义一个转场
- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC {
    if (operation == UINavigationControllerOperationPush) {
        DYCircleTransition *transition = [[DYCircleTransition alloc] init];
        transition.isPush = true;
        return transition;
    }
    DYCircleTransition *transition = [[DYCircleTransition alloc] init];
    return transition;
}

@end
