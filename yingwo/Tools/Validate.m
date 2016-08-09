//
//  Validate.m
//  yingwo
//
//  Created by apple on 16/7/11.
//  Copyright © 2016年 wangxiaofa. All rights reserved.
//

#import "Validate.h"

@implementation Validate

+ (BOOL) validateMobile:(NSString *)mobile
{
    //手机号数字字符
    NSString *phoneRegex = @"^[0-9]{11}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    return [phoneTest evaluateWithObject:mobile];
}

+ (BOOL) validateVerification:(NSString *)verification
{
    //手机号数字字符
    NSString *Regex = @"^[0-9]{5}$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",Regex];
    return [predicate evaluateWithObject:verification];
}

+ (BOOL) validatePassword:(NSString *)passWord
{
    NSString *passWordRegex = @"^[a-zA-Z0-9.]{6,20}$";
    NSPredicate *passWordPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",passWordRegex];
    return [passWordPredicate evaluateWithObject:passWord];
}

+(BOOL) validateUserName:(NSString *)name
{
    NSString *userNameRegex = @"^[\\u4e00-\\u9fa5A-Za-z0-9]{1,24}$";
    NSPredicate *userNamePredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",userNameRegex];
    BOOL B = [userNamePredicate evaluateWithObject:name];
    return B;
}

@end
