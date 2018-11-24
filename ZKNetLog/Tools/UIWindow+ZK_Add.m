//
//  UIWindow+ZK_Add.m
//  ZKNetLogDemoOC
//
//  Created by admin on 2018/11/23.
//  Copyright © 2018 ZK. All rights reserved.
//

#import "UIWindow+ZK_Add.h"
#import <objc/runtime.h>
#import "ZKNetLog.h"
#import "ZKShowNetLogView.h"
@implementation UIWindow (ZK_Add)

+ (void)load {
    Method fromMethod = class_getInstanceMethod([self class], @selector(makeKeyAndVisible));
    Method toMethod = class_getInstanceMethod([self class], @selector(zk_makeKeyAndVisible));
    
    method_exchangeImplementations(fromMethod, toMethod);
    
}
- (void)zk_makeKeyAndVisible {
    [self zk_makeKeyAndVisible];
    if ([ZKNetLog enabledLog]) {
        [ZKShowNetLogView showLogViewInView:[UIApplication sharedApplication].keyWindow];
    }
}
@end
