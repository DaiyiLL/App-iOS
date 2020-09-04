//
//  SecondViewController.m
//  02_Transition
//
//  Created by yidai on 2020/9/2.
//  Copyright © 2020 yidai. All rights reserved.
//

#import "SecondViewController.h"


@interface SecondViewController ()


@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.redBtn addTarget:self action:@selector(redBtnClicked:) forControlEvents:(UIControlEventTouchUpInside)];
    self.redBtn.accessibilityIdentifier = @"transition.end";
    
}

- (void)redBtnClicked: (UIButton *)sender {
    [self.navigationController popViewControllerAnimated:true];
}



@end
