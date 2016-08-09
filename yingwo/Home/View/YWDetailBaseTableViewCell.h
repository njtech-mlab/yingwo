//
//  YWDetailBaseTableViewCell.h
//  yingwo
//
//  Created by apple on 16/8/7.
//  Copyright © 2016年 wangxiaofa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YWHomeCellLabelView.h"
#import "YWDetailMasterView.h"
#import "YWDetailBottomView.h"

@interface YWDetailBaseTableViewCell : UITableViewCell

@property (nonatomic, strong) YWHomeCellLabelView *topView;
@property (nonatomic, strong) YWDetailMasterView  *masterView;
@property (nonatomic, strong) YWDetailBottomView  *bottomView;
@property (nonatomic, strong) UIView              *bgImageView;
@property (nonatomic, strong) UILabel             *contentLabel;
@property (nonatomic, assign) NSInteger           imageCount;

- (void)createSubview;
- (void)addImageViewByImageArr:(NSMutableArray *)imageArr;
@end
