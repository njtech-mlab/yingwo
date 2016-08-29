//
//  YWDiscoveryController.m
//  yingwo
//
//  Created by apple on 16/8/20.
//  Copyright © 2016年 wangxiaofa. All rights reserved.
//

#import "DiscoveryController.h"

#import "UIViewAdditions.h"
#import "DiscoveryViewModel.h"

#import "YWDiscoveryBaseCell.h"
#import "YWBannerTableViewCell.h"
#import "YWSegmentViewCell.h"

//滑动距离
#define NAVBAR_CHANGE_POINT -200
//导航条图片高度
static CGFloat const bannerHeight           = 220;

static NSString *YWBANNER_CELL_IDENTIFIER   = @"bannerCell";
static NSString *YWPAGEVIEW_CELL_IDENTIFIER = @"discoveryCell";

@interface DiscoveryController ()<UITableViewDataSource,UITableViewDelegate,MXScrollViewDelegate>
@property (nonatomic, strong) UITableView        *discoveryTableView;
@property (nonatomic, strong) YWDiscoveryBaseCell *segmentViewCell;
@property (nonatomic, strong) NSMutableArray     *bannerArr;

@property (nonatomic, assign) CGFloat            navgationBarHeight;
@property (nonatomic, strong) DiscoveryViewModel *viewModel;

@end

@implementation DiscoveryController

- (UITableView *)discoveryTableView {
    
    if (_discoveryTableView == nil) {
        
        _discoveryTableView            = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.navgationBarHeight+self.view.height) style:UITableViewStylePlain];
        _discoveryTableView.delegate   = self;
        _discoveryTableView.dataSource = self;
        _discoveryTableView.allowsSelection = NO;
        [_discoveryTableView registerClass:[YWBannerTableViewCell class] forCellReuseIdentifier:YWBANNER_CELL_IDENTIFIER];
        [_discoveryTableView registerClass:[YWSegmentViewCell class] forCellReuseIdentifier:YWPAGEVIEW_CELL_IDENTIFIER];

    }
    return _discoveryTableView;
}

- (DiscoveryViewModel *)viewModel {
    if (_viewModel == nil) {
        _viewModel = [[DiscoveryViewModel alloc] init];
    }
    return _viewModel;
}

- (CGFloat)navgationBarHeight {
    //导航栏＋状态栏高度
    return  self.navigationController.navigationBar.height + [[UIApplication sharedApplication] statusBarFrame].size.height;
}

- (void)viewDidLoad {
    [super viewDidLoad];

  //  [self.discoveryTableView addSubview:self.discoverySegmentView];
    [self.view addSubview:self.discoveryTableView];
    //不能放到viewWillAppear中，否则不起作用
    [self scrollViewDidScroll:self.discoveryTableView];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];

}


- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}


#pragma mark UITableViewDatasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellIdentifier = [self.viewModel idForRowByIndexPath:indexPath];

    YWDiscoveryBaseCell *cell    = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    if (indexPath.section == 0) {
        
        [self.viewModel setupModelOfCell:cell model:nil];
        
    }else if (indexPath.section == 1) {
        
        self.segmentViewCell = cell;
        
    }
    
  //  cell.textLabel.text = @"text";
    return cell;
}

#pragma mark UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return bannerHeight;
    }
    return SCREEN_HEIGHT - 100;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 0;
    }
    return 40;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {

    if (section == 1) {
        return self.segmentViewCell.discoverySegmentView.tabView;
    }
    return nil;
}


#pragma mark UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //导航栏图片允许拉伸
   // [self.mxScrollView stretchingSubviews];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
