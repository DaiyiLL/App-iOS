//
//  NSThread+Shared.m
//  03_QQDemo
//
//  Created by yidai on 2020/9/11.
//  Copyright © 2020 yidai. All rights reserved.
//

#import "NSThread+Shared.h"

@implementation NSThread (Shared)

+ (NSThread *)shareThread {
    static NSThread *shareThread = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareThread = [[NSThread alloc] initWithTarget:self selector:@selector(threadTest) object:nil];
        shareThread.name = @"threadTest";
        [shareThread start];
    });
    
    return shareThread;
}

+ (void)threadTest {
    @autoreleasepool {
        NSRunLoop *runloop = [NSRunLoop currentRunLoop];
        [runloop addPort:[NSMachPort port] forMode:NSDefaultRunLoopMode];
        
        [runloop run];
    }
}

@end
