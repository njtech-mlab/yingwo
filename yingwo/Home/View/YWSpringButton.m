//
//  YWSpringButton.m
//  yingwo
//
//  Created by apple on 16/8/14.
//  Copyright © 2016年 wangxiaofa. All rights reserved.
//

#import "YWSpringButton.h"

@implementation YWSpringButton


- (instancetype)initWithSelectedImage:(UIImage *)seletedImage andCancelImage:(UIImage *)cancelImage {
    
    self = [super init];
    
    if (self) {
        
        self.seletedImage = seletedImage;
        self.cancelImage  = cancelImage;
        [self setBackgroundImage:cancelImage forState:UIControlStateNormal];
        [self addTarget:self action:@selector(selectedScale) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}
/**
 *  选择放大，当用户确定为选择时的状态
 */
- (void)selectedScale {
    
    [self setBackgroundImage:self.seletedImage forState:UIControlStateNormal];
    
    POPSpringAnimation *anim = [POPSpringAnimation animationWithPropertyNamed:kPOPViewScaleXY];
    anim.toValue = [NSValue valueWithCGPoint:CGPointMake(2, 2)];
    anim.springBounciness    = 0;
    anim.springSpeed         = 20;
    [self pop_addAnimation:anim forKey:@"Center"];
    
    anim.completionBlock = ^(POPAnimation *animation, BOOL finished){
        self.isSpring = YES;
        [self addTarget:self action:@selector(cancelScale) forControlEvents:UIControlEventTouchUpInside];
        [self revivificationFavour];
    };
}

/**
 *  取消放大，当用户为取消状态的放大
 */
- (void)cancelScale {
    
    [self setBackgroundImage:self.cancelImage forState:UIControlStateNormal];
    
    POPSpringAnimation *anim = [POPSpringAnimation animationWithPropertyNamed:kPOPViewScaleXY];
    anim.toValue = [NSValue valueWithCGPoint:CGPointMake(2, 2)];
    anim.springBounciness    = 0;
    anim.springSpeed         = 20;
    [self pop_addAnimation:anim forKey:@"Center"];
    anim.completionBlock = ^(POPAnimation *animation, BOOL finished){
        self.isSpring = NO;
        [self addTarget:self action:@selector(selectedScale) forControlEvents:UIControlEventTouchUpInside];
        [self revivificationFavour];
    };
}

/**
 *  还原图片大小
 */
- (void)revivificationFavour {
    
    POPSpringAnimation *anim = [POPSpringAnimation animationWithPropertyNamed:kPOPViewScaleXY];
    anim.toValue = [NSValue valueWithCGPoint:CGPointMake(1, 1)];
    anim.springBounciness    = 0;
    anim.springSpeed         = 20;
    [self pop_addAnimation:anim forKey:@"Center"];
    
}

@end
