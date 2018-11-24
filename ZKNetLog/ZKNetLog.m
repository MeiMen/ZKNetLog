//
//  ZKNetLog.m
 
//
//  Created by mac on 2018/5/30.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "ZKNetLog.h"
#import "ZKNetLogRecorder.h"

static BOOL ZKEnableLog = YES;

static BOOL ZKEnableCommandLineLog = YES;

@implementation ZKNetLog

+(void)load {
    #if DEBUG
    ZKEnableLog = YES;
    ZKEnableCommandLineLog = YES;
    #else
    ZKEnableLog = NO;
    ZKEnableCommandLineLog = NO;
    #endif
    
    //AFN
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(dataTaskDidComplete:) name:@"com.alamofire.networking.task.complete" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(dataTaskDidResume:) name:@"com.alamofire.networking.task.resume" object:nil];
    
 
    //Alamofire
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(alamofireDataTaskDidComplete:) name:@"org.alamofire.notification.name.task.didComplete" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(alamofireDataTaskDidResume:) name:@"org.alamofire.notification.name.task.didResume" object:nil];
    
}


+ (void)enableLog:(BOOL)enable {
    ZKEnableLog = enable;
}

+ (BOOL)enabledLog {
    return ZKEnableLog;
}

+ (void)enableCommandLineLog:(BOOL)enable {
    ZKEnableCommandLineLog = enable;
}
+ (void)dataTaskDidResume:(NSNotification *)notificaion {
    
    NSURLSessionTask *task = notificaion.object;
    NSString *absoluteString = task.originalRequest.URL.absoluteString;
    NSArray *arr = [absoluteString componentsSeparatedByString:@"?"];
    NSString *urlString = arr.firstObject;
    NSString *paramStr = arr.lastObject;
    if ([task.originalRequest.HTTPMethod isEqualToString:@"GET"]) {
        NSMutableDictionary *keyValues = [NSMutableDictionary dictionary];
        NSArray *paramKeyValueStrs = [paramStr componentsSeparatedByString:@"&"];
        for (NSString *string in paramKeyValueStrs) {
            NSArray *keyValue = [string componentsSeparatedByString:@"="];
            NSString *value = keyValue.lastObject;
            if (value == nil || [value isKindOfClass:[NSNull class]]) {
                value = @"(null)";
            }
            [keyValues setValue:value forKey: keyValue.firstObject];
        }
        [self logRequestUrl:urlString baseURL:@"" param:keyValues];
    }else {
        id responseObject = [NSJSONSerialization JSONObjectWithData:task.originalRequest.HTTPBody options:0 error:nil];
        [self logRequestUrl:urlString baseURL:@"" param:responseObject];
    }
}

+ (void)dataTaskDidComplete:(NSNotification *)notificaion {
    NSURLSessionTask *task = notificaion.object; 
    NSString *absoluteString = task.originalRequest.URL.absoluteString;
    NSArray *arr = [absoluteString componentsSeparatedByString:@"?"];
    NSString *urlString = arr.firstObject;
    NSError *err = notificaion.userInfo[@"com.alamofire.networking.task.complete.error"];
    
    id responseObj = notificaion.userInfo[@"com.alamofire.networking.task.complete.serializedresponse"];
    [self logResponseUrl:urlString baseURL:@"" response:responseObj errCode:err.code errMsg:[err localizedDescription] ];
}

+ (void)alamofireDataTaskDidResume:(NSNotification *)notificaion {
    
    NSURLSessionTask *task = notificaion.userInfo[@"org.alamofire.notification.key.task"];
    NSString *absoluteString = task.originalRequest.URL.absoluteString;
    NSArray *arr = [absoluteString componentsSeparatedByString:@"?"];
    NSString *urlString = arr.firstObject;
    NSString *paramStr = arr.lastObject;
    if ([task.originalRequest.HTTPMethod isEqualToString:@"GET"]) {
        NSMutableDictionary *keyValues = [NSMutableDictionary dictionary];
        NSArray *paramKeyValueStrs = [paramStr componentsSeparatedByString:@"&"];
        for (NSString *string in paramKeyValueStrs) {
            NSArray *keyValue = [string componentsSeparatedByString:@"="];
            NSString *value = keyValue.lastObject;
            if (value == nil || [value isKindOfClass:[NSNull class]]) {
                value = @"(null)";
            }
            [keyValues setValue:value forKey: keyValue.firstObject];
        }
        [self logRequestUrl:urlString baseURL:@"" param:keyValues];
    }else {
        id responseObject = [NSJSONSerialization JSONObjectWithData:task.originalRequest.HTTPBody options:0 error:nil];
        [self logRequestUrl:urlString baseURL:@"" param:responseObject];
    }
}

+ (void)alamofireDataTaskDidComplete:(NSNotification *)notificaion {
    
    NSURLSessionTask *task = notificaion.userInfo[@"org.alamofire.notification.key.task"];
    NSString *absoluteString = task.originalRequest.URL.absoluteString;
    NSArray *arr = [absoluteString componentsSeparatedByString:@"?"];
    NSString *urlString = arr.firstObject;
    NSError *err = task.error;
    
    id responseObj = notificaion.userInfo[@"org.alamofire.notification.key.responseData"];
    if (err){
        
        responseObj = [NSJSONSerialization JSONObjectWithData:responseObj options:0 error:nil];
    }else {
        
        responseObj = [NSJSONSerialization JSONObjectWithData:responseObj options:0 error:&err];
    }
    [self logResponseUrl:urlString baseURL:@"" response:responseObj errCode:err.code errMsg:[err localizedDescription] ];
}


+(void)logRequestUrl:(NSString *)url baseURL:(NSString *)baseURL param:(id)param {
    if (ZKEnableLog == NO) {
        return;
    }
    
    if ([url containsString:@"uploadPic"]) {
        return;
    }
    NSString *prefix = @"\n============================= request ============================\n";
    NSString *log = [NSString stringWithFormat:@"URL :  %@\
                     \nBaseURL : %@\
                     \nParam : %@\n",url,baseURL,param];
    NSString *subfix = @"===================================================================";
    
    if (ZKEnableCommandLineLog) {
        NSString *logString = [NSString stringWithFormat:@"%@%@%@",prefix,log,subfix];
        NSLog(@"%@",logString);
    }
  
    [[ZKNetLogRecorder sharedRecorder] addLog:@{@"title":@"request",
                                                 @"content":log
                                                 }];
}

+ (void)logResponseUrl:(NSString *)url  baseURL:(NSString *)baseURL response:(id )responseObj errCode:(NSInteger)errCode errMsg:(NSString *)errMsg {
    if (ZKEnableLog == NO) {
        return;
    }
    
    NSString *prefix = @"\n============================= response ============================\n";
    NSString *log = [NSString stringWithFormat:@"URL :  %@\
                     \nBaseURL : %@\
                     \nerrorCode : %ld\
                     \nmessage : %@\
                     \ndata : %@\n",url,baseURL,(long)errCode,errMsg,responseObj];
    NSString *subfix = @"===================================================================";
    
    NSString *logString = [NSString stringWithFormat:@"%@%@%@",prefix,log,subfix];
    NSLog(@"%@",logString);
    [[ZKNetLogRecorder sharedRecorder] addLog:@{@"title":@"response",
                                                 @"content":log
                                                 }];
}


@end
