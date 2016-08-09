//
//  YWHomeTableViewCellBase.h
//  yingwo
//
//  Created by apple on 16/8/7.
//  Copyright © 2016年 wangxiaofa. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "YWHomeCellLabelView.h"
#import "YWHomeCellBottomView.h"

@interface YWHomeTableViewCellBase : UITableViewCell

//@property (nonatomic, strong) UIView               *backgroundView;
@property (nonatomic, strong) YWHomeCellLabelView  *labelView;
@property (nonatomic, strong) YWHomeCellBottomView *bottemView;
@property (nonatomic, strong) UILabel              *contentText;

/**
 *  添加子视图（需重写）
 */
- (void)createSubview;

/**
 *  加载图片（需重写）
 *
 *  @param imageArr  UIImageView 数组
 */
- (void)addImageViewByImageArr:(NSMutableArray *)imageArr;

@end
