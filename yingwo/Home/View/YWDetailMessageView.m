//
//  YWDetailMessageView.m
//  yingwo
//
//  Created by apple on 16/8/12.
//  Copyright © 2016年 wangxiaofa. All rights reserved.
//

#import "YWDetailMessageView.h"

@implementation YWDetailMessageView

- (instancetype)init {
    
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self createSubview];
    }
    return self;
}

- (void)createSubview {
    
    _radiusCornerView = [[UIView alloc] init];
    _rightFavorBtn    = [[UIButton alloc] init];
    _messsageText     = [[UITextField alloc] init];

    _radiusCornerView.layer.masksToBounds = YES;
    _radiusCornerView.layer.cornerRadius  = 10;
    _radiusCornerView.backgroundColor     = [UIColor colorWithHexString:THEME_COLOR_5];
    _messsageText.font                    = [UIFont systemFontOfSize:12];
    _messsageText.placeholder             = @"请留下你的评论和赞吧～";
    
    [_rightFavorBtn setBackgroundImage:[UIImage imageNamed:@"heart_gray"] forState:UIControlStateNormal];
    
    [self addSubview:_radiusCornerView];
    [self addSubview:_messsageText];
    [self addSubview:_rightFavorBtn];
    
    //debug用的
    _radiusCornerView.mas_key = @"_radiusCornerView";
    _messsageText.mas_key     = @"_messsageText";
    _rightFavorBtn.mas_key    = @"_rightFavorBtn";
    

    
    [_radiusCornerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(10);
        make.right.equalTo(_rightFavorBtn.mas_left).offset(-10);
        make.centerY.equalTo(self.mas_centerY);
        make.top.equalTo(self.mas_top).offset(5);
        make.bottom.equalTo(self.mas_bottom).offset(-5);
    }];

    [_messsageText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(_radiusCornerView).insets(UIEdgeInsetsMake(0, 10, 0, 10));
    }];
    
    [_rightFavorBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).offset(-10);
        make.centerY.equalTo(self.mas_centerY);
    }];
    
}

@end
