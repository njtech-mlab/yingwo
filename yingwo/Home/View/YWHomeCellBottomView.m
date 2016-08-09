//
//  YWHomeCellBottomView.m
//  yingwo
//
//  Created by apple on 16/8/1.
//  Copyright © 2016年 wangxiaofa. All rights reserved.
//

#import "YWHomeCellBottomView.h"

@implementation YWHomeCellBottomView

- (instancetype)init {
    self = [super init];
    if (self) {
        self.userInteractionEnabled = YES;
        [self createSubView];
    }
    return self;
}

- (void)createSubView {
    
    _headImageView = [[UIImageView alloc] init];
    _nickname = [[UILabel alloc] init];
    _time          = [[UILabel alloc] init];
    _favour        = [[UIButton alloc ]init];
    _message       = [[UIButton alloc] init];
    _more          = [[UIButton alloc] init];
    _favourLabel = [[UILabel alloc] init];
    _messageLabel = [[UILabel alloc] init];
    
    //_favour = [[CatZanButton alloc] initWithFrame:CGRectMake(0, 0, 0, 0) zanImage:[UIImage imageNamed:@"heart_red"] unZanImage:[UIImage imageNamed:@"heart_gray"]];
   // _favour = [[CatZanButton alloc] init];
   // [_favour setType:CatZanButtonTypeFirework];

//    _nickname.text = @"HaHa";
//    _time.text = @"2小时前";
//    _favourLabel.text = @"11";
//    _messageLabel.text = @"22";
    _headImageView.image = [UIImage imageNamed:@"touxiang"];
    
    [_favour setBackgroundImage:[UIImage imageNamed:@"heart_red"] forState:UIControlStateNormal];
    [_message setBackgroundImage:[UIImage imageNamed:@"bub"] forState:UIControlStateNormal];
    [_more setBackgroundImage:[UIImage imageNamed:@"more_gray"] forState:UIControlStateNormal];
    
    _nickname.font = [UIFont systemFontOfSize:12];
    _time.font     = [UIFont systemFontOfSize:10];

    _nickname.textColor     = [UIColor colorWithHexString:THEME_COLOR_2];
    _time.textColor         = [UIColor colorWithHexString:THEME_COLOR_3];
    _favourLabel.textColor  = [UIColor colorWithHexString:THEME_COLOR_4];
    _messageLabel.textColor = [UIColor colorWithHexString:THEME_COLOR_4];
    
    [self addSubview:_headImageView];
    [self addSubview:_nickname];
    [self addSubview:_time];
    [self addSubview:_favour];
    [self addSubview:_message];
    [self addSubview:_more];
    [self addSubview:_favourLabel];
    [self addSubview:_messageLabel];
    
    [_headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top);
        make.bottom.equalTo(self.mas_bottom);
        make.left.equalTo(self.mas_left);
        make.height.with.equalTo(@40);
    }];
    
    [_nickname mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_headImageView.mas_right).offset(7.5);
        make.centerY.equalTo(_headImageView.mas_centerY).offset(-7.5);
    }];
    
    [_time mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_nickname.mas_left);
        make.top.equalTo(_nickname.mas_bottom).offset(7.5);
    }];
    
    [_more mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_headImageView);
        make.right.equalTo(self.mas_right);
    }];
    
    [_messageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_headImageView);
        make.right.equalTo(_more.mas_left).offset(-10);
    }];
    
    [_message mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_messageLabel.mas_left).offset(-5);
        make.centerY.equalTo(_headImageView);
    }];
    
    [_favourLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_headImageView);
        make.right.equalTo(_message.mas_left).offset(-10);
    }];
    
    [_favour mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_favourLabel.mas_left).offset(-5);
        make.centerY.equalTo(_headImageView);
    }];

    

    
}

@end











