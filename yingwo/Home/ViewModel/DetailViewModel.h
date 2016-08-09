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

@interface DetailViewModel : NSObject

@property (nonatomic, assign) NSArray        *imageUrlArr;

- (void)setupModelOfCell:(YWDetailBaseTableViewCell *)cell model:(TieZi *)model;
- (NSString *)idForRowByIndexPath:(NSIndexPath *)indexPath model:(TieZi *)model;
@end
