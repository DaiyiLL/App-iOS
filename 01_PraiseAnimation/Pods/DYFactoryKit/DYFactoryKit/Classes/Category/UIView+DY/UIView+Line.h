//
//  UIView+Line.h
//  DYFactory_Example
//
//  Created by yidai on 2020/8/14.
//  Copyright © 2020 870929851. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, DYLineType) {
    DYLineTypeNone,
    DYLineTypeTop,
    DYLineTypeLeft,
    DYLineTypeBottom,
    DYLineTypeRight,
    DYLineTypeVerticalCenter,
    DYLineTypeHorizontalCenter
};
NS_ASSUME_NONNULL_BEGIN

@interface UIView (Line)


@end

NS_ASSUME_NONNULL_END
