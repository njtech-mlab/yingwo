//
//  RigisterModel.m
//  yingwo
//
//  Created by apple on 16/7/15.
//  Copyright © 2016年 wangxiaofa. All rights reserved.
//

#import "RegisterModel.h"


@implementation RegisterModel

- (instancetype)init {
    
    if (self = [super init]) {
        
    }
    return self;
}

- (void)requestForRegisterWithUrl:(NSString *)url
                       parameters:(id)parameters
                          success:(void (^)(Register *reg))success
                          failure:(void (^)(NSURLSessionDataTask *task,NSError *error))failure {
    
    NSString *fullUrl = [BASE_URL stringByAppendingString:url];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager GET:fullUrl
      parameters:parameters
        progress:nil
         success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSString *result      = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSString *subString      = [result substringWithRange:NSMakeRange(1, result.length-2)];//去掉外面的括号
        NSData *data          = [subString dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *content = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        Register *reg = [Register mj_objectWithKeyValues:content];
        success(reg);

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(task,error);
    }];
}

- (void)requestForSMSWithUrl:(NSString *)url
                  paramaters:(id)paramaters
                     success:(void (^)(SmsMessage *sms))success
                     failure:(void (^)(NSURLSessionDataTask *task,NSError *error))failure {
    
    NSString *fullUrl = [BASE_URL stringByAppendingString:url];
    
    //返回的不是Object，因此文本序列化
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];

    [manager POST:fullUrl parameters:paramaters
                            progress:nil
                            success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                     
        NSString *result      = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];

        NSString *subString   = [result substringWithRange:NSMakeRange(1, result.length-2)];
        NSData *data          = [subString dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *content = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        SmsMessage *sms       = [SmsMessage mj_objectWithKeyValues:content];

        success(sms);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(task,error);
    }];
}

@end
