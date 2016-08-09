//
//  YWDetailBottomView.m
//  yingwo
//
//  Created by apple on 16/8/8.
//  Copyright © 2016年 wangxiaofa. All rights reserved.
//

#import "YWDetailBottomView.h"

@implementation YWDetailBottomView

- (instancetype)init {
    
    self =[super init];
    
    if (self) {
        [self createSubview];
    }
    return self;
}

- (void)createSubview {
    
    self.messageField = [[UITextField alloc] init];
    self.favorBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    self.messageField.placeholder = @"还没有留言～";
    self.messageField.layer.masksToBounds = YES;
    self.messageField.layer.cornerRadius = 10;
    self.messageField.backgroundColor = [UIColor colorWithHexString:THEME_COLOR_5];
    [self.favorBtn setBackgroundImage:[UIImage imageNamed:@"heart_gray"] forState:UIControlStateNormal];
    
    [self addSubview:self.messageField];
    [self addSubview:self.favorBtn];
    
    [self.messageField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.favorBtn.mas_left).offset(-10);
        make.centerY.equalTo(self.mas_centerY);
    }];
    
    [self.favorBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right);
        make.centerY.equalTo(self.mas_centerY);
    }];
    
    
}

@end
