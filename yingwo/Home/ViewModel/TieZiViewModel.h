//
//  ViewModel.h
//  yingwo
//
//  Created by apple on 16/8/1.
//  Copyright © 2016年 wangxiaofa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YWHomeTableViewCellBase.h"
#import "TieZi.h"
#import "TieZiResult.h"
#import "HomeController.h"

@interface TieZiViewModel : NSObject

@property (nonatomic, strong)RACCommand *fecthTieZiEntityCommand;
@property (nonatomic, assign)NSArray *imageUrlArr;

/**
 *  找cell的id
 *
 *  @param model TieZi
 *  return 返回id
 */
- (NSString *)idForRowByModel:(TieZi *)model;

/**
 *  CellModel
 *
 *  @param cell YWHomeTableViewCell
 *  @param model TieZi
 */
- (void)setupModelOfCell:(YWHomeTableViewCellBase *)cell model:(TieZi *)model;

/**
 *  不分类获取所有新鲜事、贴子信息
 *
 *  @param url
 *  @param paramaters nil
 *  @param success 返回数组
 *  @param failure 失败
 */
- (void)requesAllThingsWithUrl:(NSString *)url
                    paramaters:(id)paramaters
                       success:(void (^)(NSArray *tieZi))success
                         error:(void (^)(NSURLSessionDataTask *task,NSError *error))failure;


/**
 *  获取贴子
 *
 *  @param url
 *  @param paramaters cat_id = 1
 *  @param success    返回数组
 *  @param failure    失败
 */
- (void)requestTieZiWithUrl:(NSString *)url
                      paramaters:(id)paramaters
                         success:(void (^)(NSArray *tieZi))success
                           error:(void (^)(NSURLSessionDataTask *task,NSError *error))failure;


/**
 *  新鲜事请求
 *
 *  @param url        http://yw.zhibaizhi.com/yingwophp/post/get_post_list
 *  @param paramaters cat_id
 *  @param success    返回数组
 *  @param failure    失败
 */
- (void)requestFreshThingWithUrl:(NSString *)url
                 paramaters:(id)paramaters
                    success:(void (^)(NSArray *tieZi))success
                      error:(void (^)(NSURLSessionDataTask *task,NSError *error))failure;



@end
