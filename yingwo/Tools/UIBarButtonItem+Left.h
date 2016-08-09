//
//  UIBarButtonItem+(Left).h
//  yingwo
//
//  Created by apple on 16/7/28.
//  Copyright © 2016年 wangxiaofa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (Left)

- (instancetype)initLeftBarButtonItemWithImage;
/**
 *  返回上个界面（pop返回）
 *
 *  @param sender 当前界面
 */
- (void)popToForwardControllerWithSender:(UIViewController *) sender;

@end
