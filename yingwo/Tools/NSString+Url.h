//
//  NSString+Clean.h
//  yingwo
//
//  Created by apple on 16/8/8.
//  Copyright © 2016年 wangxiaofa. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  url过滤非法字符类
 */
@interface NSString (Url)

/**
 *  url非法字符清除
 *
 *  @param urlString 资源标志符
 *
 *  @return 返回合法url
 */
+ (NSString *)replaceIllegalStringForUrl:(NSString *)urlString;

@end
