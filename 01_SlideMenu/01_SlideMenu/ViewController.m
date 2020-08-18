//
//  ViewController.m
//  01_SlideMenu
//
//  Created by yidai on 2020/8/14.
//  Copyright © 2020 yidai. All rights reserved.
//

#import "ViewController.h"
#import "SlideMenuView.h"

@interface ViewController ()

@property (nonatomic, strong) SlideMenuView *menuView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (SlideMenuView *)menuView {
    if (!_menuView) {
        _menuView = [[SlideMenuView alloc] initWithBtnTitle:@[@"1", @"2", @"3", @"4", @"5", @"6"]];
    }
    return _menuView;
}

- (IBAction)showBtnClicked:(id)sender {
    [self.menuView switchAcition];
}


@end
