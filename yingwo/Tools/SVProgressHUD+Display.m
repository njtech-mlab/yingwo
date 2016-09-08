//
//  SVProgressHUD+Display.m
//  yingwo
//
//  Created by apple on 16/9/2.
//  Copyright © 2016年 wangxiaofa. All rights reserved.
//

#import "SVProgressHUD+Display.h"

@implementation SVProgressHUD (Display)

+ (void)showSuccessStatus:(NSString *)string  {
    [SVProgressHUD setCustomDefaultStyle];
    [SVProgressHUD showSuccessWithStatus:string];
}

#pragma private method

+ (void)setCustomDefaultStyle {
    
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];

}

@end
