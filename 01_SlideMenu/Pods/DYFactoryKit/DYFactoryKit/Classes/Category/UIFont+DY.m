//
//  UIFont+DY.m
//  DY
//
//  Created by szdjy on 2019/6/11.
//  Copyright © 2019 yidai. All rights reserved.
//

#import "UIFont+DY.h"

@implementation UIFont (DY)

+ (UIFont *)regularFont:(CGFloat)fontSize {
    return [UIFont systemFontOfSize:fontSize weight:(UIFontWeightRegular)];
}

+ (UIFont *)ultraLightFont: (CGFloat)fontSize {
    return [UIFont systemFontOfSize:fontSize weight:(UIFontWeightUltraLight)];
}

+ (UIFont *)thinFont: (CGFloat)fontSize {
    return [UIFont systemFontOfSize:fontSize weight:(UIFontWeightThin)];
}

+ (UIFont *)lightFont: (CGFloat)fontSize {
    return [UIFont systemFontOfSize:fontSize weight:(UIFontWeightLight)];
}

+ (UIFont *)mediumFont: (CGFloat)fontSize {
    return [UIFont systemFontOfSize:fontSize weight:(UIFontWeightMedium)];
}

+ (UIFont *)semiboldFont: (CGFloat)fontSize {
    return [UIFont systemFontOfSize:fontSize weight:(UIFontWeightSemibold)];
}

+ (UIFont *)boldFont: (CGFloat)fontSize {
    return [UIFont systemFontOfSize:fontSize weight:(UIFontWeightBold)];
}
+ (UIFont *)heavyFont: (CGFloat)fontSize {
    return [UIFont systemFontOfSize:fontSize weight:(UIFontWeightHeavy)];
}

+ (UIFont *)blackFont: (CGFloat)fontSize {
    return [UIFont systemFontOfSize:fontSize weight:(UIFontWeightBlack)];
}

@end
