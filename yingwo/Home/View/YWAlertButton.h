//
//  YWAlertButton.h
//  yingwo
//
//  Created by apple on 16/8/14.
//  Copyright © 2016年 wangxiaofa. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol YWAlertButtonProtocol;

@interface YWAlertButton : UIButton

@property (nonatomic, assign)id<YWAlertButtonProtocol>delegate;

- (instancetype)initWithNames:(NSArray *)names ;
@end

@protocol YWAlertButtonProtocol <NSObject>

- (void)seletedAlertViewIndex:(NSInteger)index;

@end