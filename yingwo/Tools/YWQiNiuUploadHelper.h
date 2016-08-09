//
//  YWQiNiuUploadHelper.h
//  yingwo
//
//  Created by apple on 16/8/6.
//  Copyright © 2016年 wangxiaofa. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YWQiNiuUploadHelper : NSObject

@property (nonatomic,copy) void (^singleSuccessBlock)(NSString *);
@property (nonatomic,copy) void (^singleFailureBlock)(NSString *);

//单例
+ (instancetype)shareInstance;

@end
