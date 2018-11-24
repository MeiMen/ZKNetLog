//
//  ZKNetLogRecorder.h
 
//
//  Created by ZK-2 on 2018/8/3.
//  Copyright © 2018年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZKNetLogRecorder : NSObject

+ (instancetype)sharedRecorder;
- (void)addLog:(NSDictionary *)log;
- (NSArray *)fetchLogs;
@end
