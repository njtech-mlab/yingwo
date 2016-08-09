//
//  YWHomeTableViewCellNoImage.m
//  yingwo
//
//  Created by apple on 16/8/7.
//  Copyright © 2016年 wangxiaofa. All rights reserved.
//

#import "YWHomeTableViewCellNoImage.h"

@implementation YWHomeTableViewCellNoImage

- (void)createSubview {
    
    self.backgroundView = [[UIView alloc] init];
    self.labelView      = [[YWHomeCellLabelView alloc] init];
    self.contentText    = [[UILabel alloc] init];
    self.bottemView     = [[YWHomeCellBottomView alloc] init];
    
    self.contentText.font = [UIFont systemFontOfSize:14];
    self.contentText.numberOfLines = 4;
    self.contentText.layer.masksToBounds = YES;
   // self.contentText.text = @"的方式发那就十分拉风吗兰副卡房间打扫；发哈是非法哈佛卷发肯定十分拉风叫阿爽";
    
    [self.contentView addSubview:self.backgroundView];
    [self.backgroundView addSubview:self.labelView];
    [self.backgroundView addSubview:self.contentText];
    [self.backgroundView addSubview:self.bottemView];
    
    [self.backgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView).insets(UIEdgeInsetsMake(2.5, 10, 2.5, 10));
    }];
    
    [self.labelView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@30);
        make.top.equalTo(self.backgroundView.mas_top).offset(10);
        make.left.equalTo(self.backgroundView.mas_left).offset(5);
        make.right.equalTo(self.backgroundView.mas_right).offset(-5);
    }];
    
    [self.contentText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.backgroundView.mas_left).offset(15);
        make.right.equalTo(self.backgroundView.mas_right).offset(-15);
        make.top.equalTo(self.labelView.mas_bottom).offset(5);
    }];
    
    [self.bottemView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentText.mas_bottom).offset(5);
        make.left.equalTo(self.backgroundView.mas_left).offset(15);
        make.right.equalTo(self.backgroundView.mas_right).offset(-15);
        make.bottom.mas_equalTo(self.backgroundView.mas_bottom).offset(-10);
    }];
    
}

@end
