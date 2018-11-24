//
//  ZKNetLogRecorder.m
 
//
//  Created by ZK-2 on 2018/8/3.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "ZKNetLogRecorder.h"

@interface ZKNetLogRecorder ()

@property(strong, nonatomic) NSLock *lock;
@property(copy, nonatomic) NSString *filePath;/** < */
@property(strong, nonatomic) NSMutableDictionary *logs;
@property (assign, nonatomic) NSInteger totoalLogCount; /**<  */
@end


@implementation ZKNetLogRecorder

+ (instancetype)sharedRecorder{
    static ZKNetLogRecorder * recoder = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        recoder = [ZKNetLogRecorder new];
    });
    return recoder;
}

- (instancetype)init {
    self = [super init];
    if (self) {
//        self.lock = [[NSLock alloc] init];
        self.logs = [NSMutableDictionary dictionary];
    }
    return self;
}

- (void)addLog:(NSDictionary *)log {
    [self.lock lock];
    NSString *key = [NSString stringWithFormat:@"%zd",self.totoalLogCount];
    [self.logs setValue:log forKey:key];
    if (self.totoalLogCount > 20) {
        NSString *firstKey = [NSString stringWithFormat:@"%zd",self.totoalLogCount - 21];
        [self.logs removeObjectForKey:firstKey];
    }
    self.totoalLogCount ++;
    [self.lock unlock];
}

- (NSArray *)fetchLogs{
    NSMutableArray *arr = [NSMutableArray array];
    [self.lock lock];
    NSInteger firstKey = 0;
    if (self.totoalLogCount > 20) {
        firstKey =  self.totoalLogCount - 20;
    }
    for (; firstKey < self.totoalLogCount; firstKey++) {
        NSString *key = [NSString stringWithFormat:@"%zd",firstKey];
        [arr addObject:self.logs[key]];
    }
    [self.lock unlock];
    return arr;
}


@end
