//
//  XWNetworkTools.h
//  yingwo
//
//  Created by apple on 16/7/13.
//  Copyright © 2016年 wangxiaofa. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>

@interface YWNetworkTools : AFHTTPSessionManager

//+ (instancetype)shareNetworkTools;
+ (instancetype)shareNetworkToolsWithBaseUrl;

/**
 *  检测网络状态
 */
+ (void)AFNetworkStatus;

/**
 *  检测是否有网络
 *
 *  @return YES/NO
 */
+ (BOOL)networkStauts;

@end
