//
//  YWKeyboardToolView.m
//  yingwo
//
//  Created by apple on 16/8/2.
//  Copyright © 2016年 wangxiaofa. All rights reserved.
//

#import "YWKeyboardToolView.h"

@implementation YWKeyboardToolView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self createSubview];
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)createSubview {

    _face           = [UIButton buttonWithType:UIButtonTypeCustom];
    _photo          = [UIButton buttonWithType:UIButtonTypeCustom];
    _returnKeyBoard = [UIButton buttonWithType:UIButtonTypeCustom];

    _face.frame  = CGRectMake(20, 8.5, 30, 30);
    _photo.frame = CGRectMake(70, 8.5, 35, 30);
    _returnKeyBoard.frame = CGRectMake(SCREEN_WIDTH-53, 15, 33, 21);

    [_face setBackgroundImage:[UIImage imageNamed:@"emoji"] forState:UIControlStateNormal];
    [_photo setBackgroundImage:[UIImage imageNamed:@"picture_gray"] forState:UIControlStateNormal];
    [_returnKeyBoard setBackgroundImage:[UIImage imageNamed:@"keyboard_gray"] forState:UIControlStateNormal];
    
    [self addSubview:_face];
    [self addSubview:_photo];
    [self addSubview:_returnKeyBoard];

}



@end
