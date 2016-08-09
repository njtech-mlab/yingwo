//
//  Validate.h
//  yingwo
//
//  Created by apple on 16/7/11.
//  Copyright © 2016年 wangxiaofa. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Validate : NSObject
//手机号验证：0～9的数字,11位
+ (BOOL) validateMobile:(NSString *)mobile;

//验证码
+ (BOOL) validateVerification:(NSString *)verification;
//密码验证：只能是字母、数字,最长20
+ (BOOL) validatePassword:(NSString *)passWord;

//用户名验证：数字、字母、中文、长度1～24
+(BOOL) validateUserName:(NSString *)name;

@end
