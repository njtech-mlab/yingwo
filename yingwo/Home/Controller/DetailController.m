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
#import "YWDetailMessageView.h"

@interface DetailController ()<UITableViewDelegate,UITableViewDataSource,YWDetailTabeleViewProtocol,GalleryViewDelegate>

@property (nonatomic, strong) UITableView         *detailTableView;
@property (nonatomic, strong) DetailViewModel     *viewModel;
@property (nonatomic, strong) UIBarButtonItem     *leftBarItem;
@property (nonatomic, strong) UIBarButtonItem     *rightBarItem;
@property (nonatomic, strong) YWDetailMessageView *messageView;
@property (nonatomic, strong) GalleryView         *galleryView;

@property (nonatomic,assign ) CGFloat        navgationBarHeight;

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
        _detailTableView.contentInset = UIEdgeInsetsMake(0, 0, 40, 0);
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

- (UIBarButtonItem *)rightBarItem {
    if (_rightBarItem == nil) {
        _rightBarItem = [[UIBarButtonItem alloc ]initWithImage:[UIImage imageNamed:@"share"] style:UIBarButtonItemStylePlain target:self action:nil];
    }
    return _rightBarItem;
}

- (YWDetailMessageView *)messageView {
    if (_messageView == nil) {
        _messageView = [[YWDetailMessageView alloc] init];
    }
    return _messageView;
}

- (GalleryView *)galleryView {
    if (_galleryView == nil) {
        _galleryView                 = [[GalleryView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        _galleryView.backgroundColor = [UIColor blackColor];
        _galleryView.delegate        = self;
    }
    return _galleryView;
}

- (CGFloat)navgationBarHeight {
    //导航栏＋状态栏高度
    return  self.navigationController.navigationBar.height + [[UIApplication sharedApplication] statusBarFrame].size.height;
}

#pragma mark Button action

- (void)jumpToConfigurationPage {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma  mark UI布局

- (void)setAllUILayout {
    self.messageView.mas_key = @"messageView";
    
    [self.messageView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(40);
        make.bottom.equalTo(self.view.mas_bottom);
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.detailTableView];
    [self.view addSubview:self.messageView];
    
    __weak DetailController *weakSelf = self;
    self.detailTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf loadData];
    }];
    
    self.detailTableView.mj_footer = [MJRefreshAutoFooter footerWithRefreshingBlock:^{
    }];
    
    [self.detailTableView.mj_header beginRefreshing];
    
    [self setAllUILayout];

}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.title = @"帖子";
    self.navigationItem.leftBarButtonItem  = self.leftBarItem;
    self.navigationItem.rightBarButtonItem = self.rightBarItem;

    [self judgeNetworkStatus];
    

}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];

}
/**
 *  下拉刷新
 */
- (void)loadData {
    [self.detailTableView.mj_header endRefreshing];
    [self.detailTableView reloadData];
}

/**
 *  上拉加载
 */
- (void)loadMoreData {
    
}

#define mark UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *cellIdentifier        = [self.viewModel idForRowByIndexPath:indexPath model:self.model];

    YWDetailBaseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    cell.selectionStyle             = UITableViewCellSelectionStyleNone;
    cell.delegate                   = self;

    [self.viewModel setupModelOfCell:cell model:self.model];

    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *cellIdentifier = [self.viewModel idForRowByIndexPath:indexPath model:self.model];

    return [tableView fd_heightForCellWithIdentifier:cellIdentifier cacheByIndexPath:indexPath configuration:^(id cell) {
        
        [self.viewModel setupModelOfCell:cell model:self.model];
    }];
}

//  tableview header高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10;
}

#pragma mark YWDetailTabeleViewProtocol

- (void)didSeletedImageView:(UIImageView *)seletedImageView {
    
    [self covertImageView:seletedImageView];
}

/**
 *  坐标转换
 *
 *  @param imageView
 */
- (void)covertImageView:(UIImageView *)imageView {
    
    UIImageView *newImageView = [[UIImageView alloc] init];
    newImageView.frame        = [imageView.superview convertRect:imageView.frame toView:self.view];
    newImageView.image        = imageView.image;
    newImageView.y            += self.navgationBarHeight;
    newImageView.tag          = 1;

    [self showImageView:newImageView];
    
}
/**
 *  展示图片
 *
 *  @param imageView
 */
- (void)showImageView:(UIImageView *)imageView {
    
    NSMutableArray *imageViewArr = [NSMutableArray arrayWithCapacity:1];
    [imageViewArr addObject:imageView];
    
    [self.galleryView setImages:imageViewArr showAtIndex:0];
    [self.navigationController.view addSubview:self.galleryView];

}

#pragma mark - GalleryView Delegate

- (void)galleryView:(GalleryView *)galleryView didShowPageAtIndex:(NSInteger)pageIndex
{
}

- (void)galleryView:(GalleryView *)galleryView didSelectPageAtIndex:(NSInteger)pageIndex
{
    [self.galleryView removeImageView];
    
}

- (void)galleryView:(GalleryView *)galleryView removePageAtIndex:(NSInteger)pageIndex {
    self.galleryView = nil;
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
