//
//  UIFont+DY.h
//  DY
//
//  Created by yidai on 2019/6/11.
//  Copyright © yidai. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIFont (DY)

+ (UIFont *)regularFont:(CGFloat)fontSize;

+ (UIFont *)ultraLightFont: (CGFloat)fontSize;

+ (UIFont *)thinFont: (CGFloat)fontSize;

+ (UIFont *)lightFont: (CGFloat)fontSize;

+ (UIFont *)mediumFont: (CGFloat)fontSize;

+ (UIFont *)semiboldFont: (CGFloat)fontSize;

+ (UIFont *)boldFont: (CGFloat)fontSize;

+ (UIFont *)heavyFont: (CGFloat)fontSize;

+ (UIFont *)blackFont: (CGFloat)fontSize;

@end

NS_ASSUME_NONNULL_END
