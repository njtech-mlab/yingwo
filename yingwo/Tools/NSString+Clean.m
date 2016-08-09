//
//  NSString+Clean.m
//  yingwo
//
//  Created by apple on 16/8/8.
//  Copyright © 2016年 wangxiaofa. All rights reserved.
//

#import "NSString+Clean.h"

@implementation NSString (Clean)

+ (NSString *)replaceIllegalStringForUrl:(NSString *)urlString {
    
    urlString = [urlString stringByReplacingOccurrencesOfString:@"[" withString:@""];
    urlString = [urlString stringByReplacingOccurrencesOfString:@"]" withString:@""];
    urlString = [urlString stringByReplacingOccurrencesOfString:@"\"" withString:@""];
    urlString = [urlString stringByReplacingOccurrencesOfString:@"\\" withString:@""];

    return urlString;
}

@end
