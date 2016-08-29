//
//  YWDiscoverySegmentView.h
//  yingwo
//
//  Created by apple on 16/8/27.
//  Copyright © 2016年 wangxiaofa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SMPagerTabView.h"

@interface YWDiscoverySegmentView : UIView<SMPagerTabViewDelegate>

@property (nonatomic, strong) SMPagerTabView     *discoverySegmentView;
@property (nonatomic, strong) NSMutableArray     *catalogVcArr;

@end
