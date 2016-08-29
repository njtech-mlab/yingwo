//
//  DiscoveryViewModel.h
//  yingwo
//
//  Created by apple on 16/8/27.
//  Copyright © 2016年 wangxiaofa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YWDiscoveryBaseCell.h"

@interface DiscoveryViewModel : NSObject

@property (nonatomic, strong) NSMutableArray *bannerArr;

- (void)setupModelOfCell:(YWDiscoveryBaseCell *)cell model:(DiscoveryViewModel *)model;

- (NSString *)idForRowByIndexPath:(NSIndexPath *)indexPath;

@end
