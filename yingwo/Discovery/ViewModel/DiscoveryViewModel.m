//
//  DiscoveryViewModel.m
//  yingwo
//
//  Created by apple on 16/8/27.
//  Copyright © 2016年 wangxiaofa. All rights reserved.
//

#import "DiscoveryViewModel.h"

@implementation DiscoveryViewModel

- (NSString *)idForRowByIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return @"bannerCell";
    }
    return @"discoveryCell";
}

- (void)setupModelOfCell:(YWDiscoveryBaseCell *)cell model:(DiscoveryViewModel *)model {
    if (model == nil) {
        
         _bannerArr = [[NSMutableArray alloc] init];
        
        [_bannerArr addObject:[UIImage imageNamed:@"picture_1"]];
        [_bannerArr addObject:[UIImage imageNamed:@"picture_2"]];
        [_bannerArr addObject:[UIImage imageNamed:@"picture_3"]];
        
      //  cell.images = _bannerArr;
        cell.mxScrollView.images = _bannerArr;
      //  cell.backgroundColor = [UIColor blueColor];
    }
}

@end
