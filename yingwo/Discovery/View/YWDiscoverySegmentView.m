//
//  YWDiscoverySegmentView.m
//  yingwo
//
//  Created by apple on 16/8/27.
//  Copyright © 2016年 wangxiaofa. All rights reserved.
//

#import "YWDiscoverySegmentView.h"
#import "SchoolLifeController.h"
#import "HobbyController.h"
#import "SkillController.h"

@implementation YWDiscoverySegmentView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self createSubview];
    }
    return self;
}

- (void)createSubview {
    
    _discoverySegmentView = [[SMPagerTabView alloc]initWithFrame:CGRectMake(0,
                                                                            0,
                                                                            SCREEN_WIDTH,
                                                                            SCREEN_HEIGHT - 100)];
    _discoverySegmentView.delegate = self;
    
    [self addSubview:_discoverySegmentView];
    
    _catalogVcArr              = [[NSMutableArray alloc] init];
    SchoolLifeController *slVc = [[SchoolLifeController alloc] init];
    HobbyController *hVc       = [[HobbyController alloc] init];
    SkillController *sVc       = [[SkillController alloc] init];
    
    [_catalogVcArr addObject:slVc];
    [_catalogVcArr addObject:hVc];
    [_catalogVcArr addObject:sVc];
    
    //开始构建UI
    [_discoverySegmentView buildUI];
    //起始选择一个tab
    [_discoverySegmentView selectTabWithIndex:0 animate:NO];
    //显示红点，点击消失
    // [self.discoverySegmentView showRedDotWithIndex:0];
}

#pragma mark - DBPagerTabView Delegate
- (NSUInteger)numberOfPagers:(SMPagerTabView *)view {
    return [self.catalogVcArr count];
}
- (UIViewController *)pagerViewOfPagers:(SMPagerTabView *)view indexOfPagers:(NSUInteger)number {
    return self.catalogVcArr[number];
}

- (void)whenSelectOnPager:(NSUInteger)number {
    NSLog(@"页面 %lu",(unsigned long)number);
}

@end
