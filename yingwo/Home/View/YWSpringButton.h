//
//  YWSpringButton.h
//  yingwo
//
//  Created by apple on 16/8/14.
//  Copyright © 2016年 wangxiaofa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YWSpringButton : UIButton

@property (nonatomic,assign ) BOOL    isSpring;
@property (nonatomic, strong) UIImage *seletedImage;
@property (nonatomic, strong) UIImage *cancelImage;

- (instancetype)initWithSelectedImage:(UIImage *)seletedImage andCancelImage:(UIImage *)cancelImage ;

@end
