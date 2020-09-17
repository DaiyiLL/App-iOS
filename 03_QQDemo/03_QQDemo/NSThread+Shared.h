//
//  NSThread+Shared.h
//  03_QQDemo
//
//  Created by yidai on 2020/9/11.
//  Copyright © 2020 yidai. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSThread (Shared)

+ (NSThread *)shareThread;

@end

NS_ASSUME_NONNULL_END
