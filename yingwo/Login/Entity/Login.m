//
//  Login.m
//  yingwo
//
//  Created by apple on 16/7/18.
//  Copyright © 2016年 wangxiaofa. All rights reserved.
//

#import "Login.h"

@implementation Login

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{@"customer.userId":@"id"};
}

@end
