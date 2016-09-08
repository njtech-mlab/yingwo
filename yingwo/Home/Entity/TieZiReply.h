//
//  TiZiReply.h
//  yingwo
//
//  Created by apple on 16/9/4.
//  Copyright © 2016年 wangxiaofa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TieZi.h"

@interface TieZiReply : TieZi

//	回复ID
@property (nonatomic, assign) NSInteger reply_id;
//	帖子ID
@property (nonatomic, assign) NSInteger post_id;
//无
@property (nonatomic, assign) NSInteger del;

//评论数
@property (nonatomic, assign) NSInteger comment_cnt;

@property (nonatomic, strong)NSMutableArray *commentArr;

@end
