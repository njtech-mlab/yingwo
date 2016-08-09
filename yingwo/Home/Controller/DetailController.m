//
//  DetailController.m
//  yingwo
//
//  Created by apple on 16/8/7.
//  Copyright © 2016年 wangxiaofa. All rights reserved.
//

#import "DetailController.h"
#import "YWDetailTableViewCell.h"
#import "YWDetailBaseTableViewCell.h"
#import "DetailViewModel.h"

@interface DetailController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView     *detailTableView;
@property (nonatomic, strong) DetailViewModel *viewModel;
@property (nonatomic, strong) UIBarButtonItem *leftBarItem;

@end

@implementation DetailController

static NSString *detailCellIdentifier = @"detailCell";

#pragma mark 懒加载

- (UITableView *)detailTableView {
    if (_detailTableView == nil) {
        _detailTableView                 = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        _detailTableView.separatorStyle  = UITableViewCellSeparatorStyleNone;
        _detailTableView.backgroundColor = [UIColor clearColor];
        _detailTableView.delegate        = self;
        _detailTableView.dataSource      = self;
      //  _detailTableView.fd_debugLogEnabled = YES;
        [_detailTableView registerClass:[YWDetailTableViewCell class] forCellReuseIdentifier:detailCellIdentifier];
        
    }
    return _detailTableView;
}

- (DetailViewModel *)viewModel {
    if (_viewModel == nil) {
        _viewModel = [[DetailViewModel alloc] init];
    }
    return _viewModel;
}

- (TieZi *)model {
    if (_model == nil) {
        _model = [[TieZi alloc] init];
    }
    return _model;
}

- (UIBarButtonItem *)leftBarItem {
    if (_leftBarItem == nil) {
        _leftBarItem = [[UIBarButtonItem alloc ]initWithImage:[UIImage imageNamed:@"nva_con"] style:UIBarButtonItemStylePlain target:self action:@selector(jumpToConfigurationPage)];
    }
    return _leftBarItem;
}

#pragma mark Button action

- (void)jumpToConfigurationPage {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma  mark UI布局

- (void)setAllUILayout {
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.detailTableView];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.title = @"帖子";
    self.navigationItem.leftBarButtonItem = self.leftBarItem;
    
    [self judgeNetworkStatus];

}

#define mark UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *cellIdentifier        = [self.viewModel idForRowByIndexPath:indexPath model:self.model];

    YWDetailBaseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    cell.selectionStyle             = UITableViewCellSelectionStyleNone;
    [self.viewModel setupModelOfCell:cell model:self.model];

    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *cellIdentifier = [self.viewModel idForRowByIndexPath:indexPath model:self.model];

    return [tableView fd_heightForCellWithIdentifier:cellIdentifier cacheByIndexPath:indexPath configuration:^(id cell) {
        
        [self.viewModel setupModelOfCell:cell model:self.model];
    }];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/**
 *  网路监测
 */
- (void)judgeNetworkStatus {
    [YWNetworkTools networkStauts];
}


@end
