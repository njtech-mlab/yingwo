//
//  YWDetailMasterView.m
//  yingwo
//
//  Created by apple on 16/8/7.
//  Copyright © 2016年 wangxiaofa. All rights reserved.
//

#import "YWDetailMasterView.h"

@implementation YWDetailMasterView

- (instancetype)init {
    self = [super init];
    if (self) {
        [self createSubview];
    }
    return self;
}

- (void)createSubview {
    
    self.headImageView              = [[UIImageView alloc] init];
    self.nicnameLabel               = [[UILabel alloc] init];
    self.floorLabel                 = [[UILabel alloc] init];
    self.timeLabel                  = [[UILabel alloc] init];
    self.identifierLabel            = [[YWLabel alloc] init];

    self.identifierLabel.label.font = [UIFont systemFontOfSize:12];
    self.nicnameLabel.font          = [UIFont systemFontOfSize:15];
    self.floorLabel.font            = [UIFont systemFontOfSize:12];
    self.timeLabel.font             = [UIFont systemFontOfSize:12];

    self.nicnameLabel.textColor     = [UIColor colorWithHexString:THEME_COLOR_3];
    self.floorLabel.textColor       = [UIColor colorWithHexString:THEME_COLOR_5];
    self.timeLabel.textColor        = [UIColor colorWithHexString:THEME_COLOR_5];

    self.identifierLabel.label.height = 14;
    self.identifierLabel.layer.cornerRadius = 10;
    self.identifierLabel.alpha = 0.5;
    self.identifierLabel.backgroundColor    = [UIColor colorWithHexString:THEME_COLOR_1];
    self.identifierLabel.label.textColor    = [UIColor whiteColor];

    
    self.headImageView.image = [UIImage imageNamed:@"touxiang"];

    [self addSubview:self.headImageView];
    [self addSubview:self.nicnameLabel];
    [self addSubview:self.floorLabel];
    [self addSubview:self.timeLabel];
    [self addSubview:self.identifierLabel];
    
    [self.headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left);
        make.top.equalTo(self.mas_top);
        make.height.with.equalTo(@40);
        make.bottom.equalTo(self.mas_bottom);
    }];
    
    [self.nicnameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top);
        make.left.equalTo(self.headImageView.mas_right).offset(7.5);
    }];
    
    [self.identifierLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top);
        make.left.equalTo(self.nicnameLabel.mas_right).offset(7.5);
    }];
    
    [self.floorLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.nicnameLabel.mas_left);
        make.bottom.equalTo(self.mas_bottom);
    }];
    
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.floorLabel.mas_right).offset(7.5);
        make.bottom.equalTo(self.mas_bottom);
    }];
    
}

@end
