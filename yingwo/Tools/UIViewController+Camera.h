//
//  UIViewController+Camera.h
//  YWPhoto
//
//  Created by apple on 16/7/16.
//  Copyright © 2016年 wangxiaofa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController(Camera)<UIImagePickerControllerDelegate,UINavigationControllerDelegate>

- (BOOL) startMediaBrowserFromViewController: (UIViewController*) controller;
- (void)albumImageChoosed:(UIImage*)img;//必须覆盖方法

@end
