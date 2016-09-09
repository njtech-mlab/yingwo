//
//  SVProgressHUD+Display.m
//  yingwo
//
//  Created by apple on 16/9/2.
//  Copyright © 2016年 wangxiaofa. All rights reserved.
//

#import "SVProgressHUD+Display.h"

@implementation SVProgressHUD (Display)

+ (void)showSuccessStatus:(NSString *)string afterDelay:(NSInteger)delay{
    
    [SVProgressHUD setCustomDefaultStyleWithDelay:delay];
    [SVProgressHUD showSuccessWithStatus:string];

}

+ (void)showErrorStatus:(NSString *)string afterDelay:(NSInteger)delay{
    
    [SVProgressHUD setCustomDefaultStyleWithDelay:delay];
    [SVProgressHUD showErrorWithStatus:string];
}

+ (void)showInfoStatus:(NSString *)string afterDelay:(NSInteger)delay{
    
    [SVProgressHUD setCustomDefaultStyleWithDelay:delay];
    [SVProgressHUD showInfoWithStatus:string];
}

#pragma private method

+ (void)setCustomDefaultStyleWithDelay:(NSInteger) delay{
    
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    [SVProgressHUD setMinimumDismissTimeInterval:delay];
}

@end
