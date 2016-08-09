//
//  Login.h
//  yingwo
//
//  Created by apple on 16/7/18.
//  Copyright © 2016年 wangxiaofa. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Login : NSObject

@property (nonatomic, assign) Boolean  status;
@property (nonatomic, copy  ) NSString *info;

@property (nonatomic, strong) User *customer;

@end
