//
//  LoginModel.m
//  yingwo
//
//  Created by apple on 16/7/18.
//  Copyright © 2016年 wangxiaofa. All rights reserved.
//

#import "LoginModel.h"

@implementation LoginModel

- (void)requestForLoginWithUrl:(NSString *)url
                    parameters:(id)parameters
                       success:(void (^)(Login *log))success
                       failure:(void (^)(NSURLSessionDataTask *task,NSError *error))failure {
    
    NSString *fullUrl = [BASE_URL stringByAppendingString:url];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager POST:fullUrl
       parameters:parameters
         progress:nil
          success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
             
            NSString *result      = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
              
            NSString *subString   = [result substringWithRange:NSMakeRange(1, result.length-2)];//去掉外面的括号

            NSData *data          = [subString dataUsingEncoding:NSUTF8StringEncoding];
            NSDictionary *content = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
           //    NSLog(@"%@",content);
            Login *loginInfo      = [Login mj_objectWithKeyValues:content];
            success(loginInfo);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(task,error);
        NSLog(@"%@",error);
    }];
}

- (void)requestForHeadImageWithUrl:(NSString *)imageUrl{
    
    NSString *partUrlString = [BASE_URL2 stringByAppendingString:HEADIMAGE_URL];
    NSString *fullUrl       = [partUrlString stringByAppendingString:imageUrl];

    NSURL *url              = [NSURL URLWithString:fullUrl];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionTask *task = [session dataTaskWithURL:url
                                    completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
           
                                        UIImage *headImage = [UIImage imageWithData:data];
            
                                        [YWSandBoxTool saveHeadPortraitIntoCache:headImage];
        
    }];
    
    [task resume];


}

@end
