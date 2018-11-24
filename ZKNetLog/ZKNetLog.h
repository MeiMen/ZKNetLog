//
//  ZKNetLog.h
//  ZKWallet
//
//  Created by mac on 2018/5/30.
//  Copyright © 2018年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZKNetLog : NSObject

+ (void)enableLog:(BOOL)enable;
+ (BOOL)enabledLog;
+ (void)enableCommandLineLog:(BOOL)enable;
@end
