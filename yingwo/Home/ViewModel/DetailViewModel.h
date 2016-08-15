//
//  DetailViewModel.h
//  yingwo
//
//  Created by apple on 16/8/7.
//  Copyright © 2016年 wangxiaofa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YWDetailBaseTableViewCell.h"
#import "TieZi.h"

/**
 *  DetailViewController 的ViewModel
 */
@interface DetailViewModel : NSObject

@property (nonatomic, strong) RACCommand *fetchDetailEntityCommand;
@property (nonatomic, strong) NSArray    *imageUrlArr;

/**
 *  初始化cell
 *
 *  @param cell  YWDetailBaseTableViewCell
 *  @param model TieZi
 */
- (void)setupModelOfCell:(YWDetailBaseTableViewCell *)cell model:(TieZi *)model;

/**
 *  寻找相对应的id
 *
 *  @param indexPath NSIndexPath
 *  @param model     TieZi
 *
 *  @return 返回id
 */
- (NSString *)idForRowByIndexPath:(NSIndexPath *)indexPath model:(TieZi *)model;

@end
