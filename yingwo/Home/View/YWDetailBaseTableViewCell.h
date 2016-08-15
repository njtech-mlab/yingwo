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
#import "YWDetailTopView.h"
#import "YWContentLabel.h"

@protocol YWDetailTabeleViewProtocol;

@interface YWDetailBaseTableViewCell : UITableViewCell

@property (nonatomic, strong) YWDetailTopView            *topView;
@property (nonatomic, strong) YWDetailMasterView         *masterView;
@property (nonatomic, strong) UIView                     *bgImageView;
@property (nonatomic, strong) YWContentLabel             *contentLabel;
@property (nonatomic, assign) NSInteger                  imageCount;
@property (nonatomic,assign ) id<YWDetailTabeleViewProtocol> delegate;

- (void)createSubview;
- (void)addImageViewByImageArr:(NSMutableArray *)imageArr;
@end

@protocol YWDetailTabeleViewProtocol <NSObject>

- (void)didSeletedImageView:(UIImageView *)seletedImageView;

@end
