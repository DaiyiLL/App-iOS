//
//  slideMenuView.h
//  侧滑动画001
//
//  Created by Dean on 2018/7/12.
//  Copyright © 2018年 tz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SlideMenuView : UIView

- (id)initWithBtnTitle:(NSArray *)btnTitles;
- (void)switchAcition;

- (void)bringToFront;
@end
