//
//  CommentView.m
//  yingwo
//
//  Created by apple on 16/9/6.
//  Copyright © 2016年 wangxiaofa. All rights reserved.
//

#import "YWCommentView.h"

@implementation YWCommentView

- (instancetype)init {
    self = [super init];
    if (self) {
        [self createSubview];

    }
    return self;
}

- (void)createSubview {
    
    self.leftName           = [[UILabel alloc] init];
    self.identfier          = [[YWLabel alloc] init];
    self.content            = [[YWContentLabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    
    _identfier.layer.cornerRadius = 10;
    _identfier.backgroundColor    = [UIColor colorWithHexString:THEME_COLOR_1 alpha:0.5];
    _identfier.label.textColor    = [UIColor whiteColor];
    _identfier.label.font = [UIFont systemFontOfSize:12];
    
    self.leftName.font            = [UIFont systemFontOfSize:14];

    self.leftName.textColor       = [UIColor colorWithHexString:THEME_COLOR_1];

    
    [self addSubview:self.leftName];
    [self addSubview:self.identfier];
    [self addSubview:self.content];

    [self.leftName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(10);
        make.centerY.equalTo(self);
    }];
    
    [self.identfier mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.leftName.mas_right).offset(5).priorityHigh();
        make.centerY.equalTo(self);
        make.height.equalTo(@20);
        make.width.equalTo(@40);
    }];
    
#warning 这里写死的200，有问题
    [self.content mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.identfier.mas_right).offset(5);
  //      make.right.equalTo(self.mas_right);
        make.width.equalTo(@200).priorityLow();
        make.centerY.equalTo(self);
    }];
    
    
}

@end
