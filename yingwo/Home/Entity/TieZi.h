//
//  TieZi.h
//  yingwo
//
//  Created by apple on 16/8/1.
//  Copyright © 2016年 wangxiaofa. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TieZi : NSObject

@property (nonatomic, assign) int       post_id;
@property (nonatomic, assign) int       cat_id;
@property (nonatomic, assign) int       user_id;
@property (nonatomic, assign) int       create_time;
@property (nonatomic, copy  ) NSString  *topic;
@property (nonatomic, copy  ) NSString  *nickname;
@property (nonatomic, copy  ) NSString  *content;
@property (nonatomic, strong) NSString  *img;
@property (nonatomic, strong) NSArray   *imageUrlArr;

@end
