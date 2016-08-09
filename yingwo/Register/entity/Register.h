//
//  Register.h
//  yingwo
//
//  Created by apple on 16/7/15.
//  Copyright © 2016年 wangxiaofa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Customer.h"

@interface Register : NSObject

@property (nonatomic, strong)Customer *custoer;

@property (nonatomic, assign)Boolean  result;
@property (nonatomic, copy)NSString *info;

@end
