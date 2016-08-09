//
//  NSDate+Grade.h
//  yingwo
//
//  Created by apple on 16/7/30.
//  Copyright © 2016年 wangxiaofa. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Grade)

/**
 *  获取年级
 *
 *  @return 返回前后七年的时间段
 */
+ (NSArray *)gradeInRecentYears;

@end
