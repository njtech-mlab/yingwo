//
//  User.h
//  yingwo
//
//  Created by apple on 16/7/19.
//  Copyright © 2016年 wangxiaofa. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  网络请求时，用户数据的对应模型类，与coredata的模型类Customer对应
 *  为什么有了Customer类还要有User类呢？解释：因为Customer类不能直接使用
 *  不能通过MJExtension键值转换
 */
@interface User : NSObject

@property (nonatomic, copy)NSString *userId;
@property (nonatomic, copy)NSString *username;
@property (nonatomic, copy)NSString *nickname;
@property (nonatomic, copy)NSString *nickname_py;
@property (nonatomic, copy)NSString *head_img;
@property (nonatomic, copy)NSString *age;
@property (nonatomic, copy)NSString *telphone;
@property (nonatomic, copy)NSString *address;
@property (nonatomic, copy)NSString *register_time;
@property (nonatomic, copy)NSString *status;
@property (nonatomic, copy)NSString *college;
@property (nonatomic, copy)NSString *major;
@property (nonatomic, copy)NSString *grade;
@property (nonatomic, copy)NSString *gender;
@property (nonatomic, copy)NSString *school;
@property (nonatomic, copy)NSString *sessionid;

@end
