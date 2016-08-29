//
//  YWHomeCellTopSubview.m
//  yingwo
//
//  Created by apple on 16/8/2.
//  Copyright © 2016年 wangxiaofa. All rights reserved.
//

#import "YWHomeCellLabelView.h"

@implementation YWHomeCellLabelView

- (instancetype)init {
    self = [super init];
    if (self) {
        [self createSubView];
    }
    return self;
}


- (void)createSubView {
    
    _labelImage               = [[UIImageView alloc] init];
    _label                    = [[YWLabel alloc] init];

    _labelImage.image         = [UIImage imageNamed:@"#_gray"];
    _label.label.text         = @"新鲜事";
    _label.layer.cornerRadius = 12;

    [self addSubview:_labelImage];
    [self addSubview:_label];
    
    [_labelImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.equalTo(self.mas_left).offset(10);
    }];
    
    [_label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_labelImage.mas_right).offset(10);
        make.centerY.equalTo(self);
    }];

}
@end