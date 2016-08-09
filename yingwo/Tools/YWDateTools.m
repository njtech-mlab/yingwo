//
//  YWDateTools.m
//  yingwo
//
//  Created by apple on 16/8/7.
//  Copyright © 2016年 wangxiaofa. All rights reserved.
//

#import "YWDateTools.h"

@implementation YWDateTools

+ (NSString *)getDateString:(NSString *)spString
{
    NSString *dateString;

    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:[spString intValue]];
    NSDateFormatter *dateFormat=[[NSDateFormatter alloc]init];

    [dateFormat setDateFormat:@"yyyy"];
    NSString *year        = [dateFormat stringFromDate:confromTimesp];
    NSString *nowYear     = [dateFormat stringFromDate:[NSDate new]];

    [dateFormat setDateFormat:@"MM"];
    NSString *month       = [dateFormat stringFromDate:confromTimesp];
    NSString *nowMonth    = [dateFormat stringFromDate:[NSDate new]];

    [dateFormat setDateFormat:@"dd"];
    NSString *day         = [dateFormat stringFromDate:confromTimesp];
    NSString *nowDay      = [dateFormat stringFromDate:[NSDate new]];

    [dateFormat setDateFormat:@"HH"];
    NSString *hour        = [dateFormat stringFromDate:confromTimesp];
    NSString *nowHour     = [dateFormat stringFromDate:[NSDate new]];

    if ([year isEqualToString:nowYear] && [month isEqualToString:nowMonth] && [day isEqualToString:nowDay]) {
        dateString = [NSString stringWithFormat:@"%ld小时前",nowHour.integerValue - hour.integerValue];
        
    }else {
        
        [dateFormat setDateFormat:@"yyyy年MM月dd日"];
        dateString = [dateFormat stringFromDate:confromTimesp];
    }
    
    return dateString;
}



@end
