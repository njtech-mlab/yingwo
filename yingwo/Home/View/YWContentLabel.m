//
//  YWContentLabel.m
//  yingwo
//
//  Created by apple on 16/8/14.
//  Copyright © 2016年 wangxiaofa. All rights reserved.
//

#import "YWContentLabel.h"

@implementation YWContentLabel

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.font = [UIFont systemFontOfSize:14];
        self.numberOfLines = 4;
        self.lineSpacing = 5.f;
        self.textColor = [UIColor colorWithHexString:THEME_COLOR_2];
    }
    return self;
}

@end
