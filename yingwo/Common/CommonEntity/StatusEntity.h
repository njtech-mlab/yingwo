//
//  StatusEntity.h
//  yingwo
//
//  Created by apple on 16/9/3.
//  Copyright © 2016年 wangxiaofa. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StatusEntity : NSObject

@property (nonatomic, strong) NSArray   *info;
@property (nonatomic, assign) NSInteger status;
@property (nonatomic, copy  ) NSString  *url;

@end
