//
//  TieZiResult.h
//  yingwo
//
//  Created by apple on 16/8/3.
//  Copyright © 2016年 wangxiaofa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TieZi.h"

@interface TieZiResult : NSObject

@property (nonatomic, strong) NSArray *info;
@property (nonatomic, assign) int            status;
@property (nonatomic, copy  ) NSString       *url;


@end
