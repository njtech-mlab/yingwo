//
//  HomeController.m
//  yingwo
//
//  Created by apple on 16/8/1.
//  Copyright © 2016年 wangxiaofa. All rights reserved.
//

#import "HomeController.h"
#import "DetailController.h"

#import "TieZi.h"
#import "TieZiViewModel.h"
#import "YWDropDownView.h"
#import "YWHomeTableViewCellNoImage.h"
#import "YWHomeTableViewCellOneImage.h"
#import "YWHomeTableViewCellTwoImage.h"
#import "YWHomeTableViewCellThreeImage.h"
#import "YWHomeTableViewCellFourImage.h"
#import "YWHomeTableViewCellSixImage.h"
#import "YWHomeTableViewCellNineImage.h"
#import "YWHomeTableViewCellMoreNineImage.h"

@interface HomeController ()<UITableViewDataSource,UITableViewDelegate,YWDropDownViewDelegate>

@property (nonatomic, strong) UITableView     *homeTableview;
@property (nonatomic, strong) UIBarButtonItem *rightBarItem;
@property (nonatomic, strong) UIBarButtonItem *leftBarItem;
@property (nonatomic, strong) TieZi           *model;
@property (nonatomic, strong) TieZiViewModel  *viewModel;
@property (nonatomic, strong) NSMutableArray  *tieZiList;
@property (nonatomic, strong) YWDropDownView  *drorDownView;
@end


@implementation HomeController

/**
 *  cell identifier
 */
static NSString *YWHomeCellNoImageIdentifier       = @"noImageCell";
static NSString *YWHomeCellOneImageIdentifier      = @"oneImageCell";
static NSString *YWHomeCellTwoImageIdentifier      = @"twoImageCell";
static NSString *YWHomeCellThreeImageIdentifier    = @"threeImageCell";
static NSString *YWHomeCellFourImageIdentifier     = @"fourImageCell";
static NSString *YWHomeCellSixImageIdentifier      = @"sixImageCell";
static NSString *YWHomeCellNineImageIdentifier     = @"nineImageCell";
static NSString *YWHomeCellMoreNineImageIdentifier = @"moreNineImageCell";


#pragma mark 懒加载

- (UITableView *)homeTableview {
    if (_homeTableview == nil) {
        _homeTableview                 = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        _homeTableview.delegate        = self;
        _homeTableview.dataSource      = self;
        _homeTableview.separatorStyle  = UITableViewCellSeparatorStyleNone;
        _homeTableview.backgroundColor = [UIColor clearColor];
      //  _homeTableview.fd_debugLogEnabled = YES;

        [_homeTableview registerClass:[YWHomeTableViewCellNoImage class] forCellReuseIdentifier:YWHomeCellNoImageIdentifier];
        [_homeTableview registerClass:[YWHomeTableViewCellOneImage class] forCellReuseIdentifier:YWHomeCellOneImageIdentifier];
        [_homeTableview registerClass:[YWHomeTableViewCellTwoImage class] forCellReuseIdentifier:YWHomeCellTwoImageIdentifier];
        [_homeTableview registerClass:[YWHomeTableViewCellThreeImage class] forCellReuseIdentifier:YWHomeCellThreeImageIdentifier];
        [_homeTableview registerClass:[YWHomeTableViewCellFourImage class] forCellReuseIdentifier:YWHomeCellFourImageIdentifier];
        [_homeTableview registerClass:[YWHomeTableViewCellSixImage class] forCellReuseIdentifier:YWHomeCellSixImageIdentifier];
        [_homeTableview registerClass:[YWHomeTableViewCellNineImage class] forCellReuseIdentifier:YWHomeCellNineImageIdentifier];
        [_homeTableview registerClass:[YWHomeTableViewCellMoreNineImage class] forCellReuseIdentifier:YWHomeCellMoreNineImageIdentifier];

    }
    return _homeTableview;
}

- (TieZi *)model {
    if (_model == nil) {
        
        _model = [[TieZi alloc] init];
        _model.topic = @"新鲜事";
    }
    return _model;
}

- (TieZiViewModel *)viewModel {
    if (_viewModel == nil) {
        
        _viewModel = [[TieZiViewModel alloc] init];
        
    }
    return _viewModel;
}

- (UIBarButtonItem *)leftBarItem {
    if (_leftBarItem == nil) {
        _leftBarItem = [[UIBarButtonItem alloc ]initWithImage:[UIImage imageNamed:@"screen"] style:UIBarButtonItemStylePlain target:self action:@selector(showDropDownView:)];
    }
    return _leftBarItem;
}

- (UIBarButtonItem *)rightBarItem {
    if (_rightBarItem == nil) {
        _rightBarItem = [[UIBarButtonItem alloc ]initWithImage:[UIImage imageNamed:@"magni"] style:UIBarButtonItemStylePlain target:self action:nil];
    }
    return _rightBarItem;
}

- (YWDropDownView *)drorDownView {
    if (_drorDownView == nil) {
        
        NSMutableArray *titles = [NSMutableArray arrayWithCapacity:4];
        [titles addObject:@"全部"];
        [titles addObject:@"新鲜事"];
        [titles addObject:@"关注的话题"];
        [titles addObject:@"好友动态"];

        _drorDownView = [[YWDropDownView alloc] initWithTitlesArr:titles height:140 width:100];
    }
    return _drorDownView;
}

- (NSMutableArray *)tieZiList {
    if (_tieZiList == nil) {
        _tieZiList = [[NSMutableArray alloc] init];
    }
    return _tieZiList;
}

#pragma mark button action

- (void)showDropDownView:(UIBarButtonItem *)sender {
    
    if (self.drorDownView.isPopDropDownView == NO) {
        
        [self.drorDownView showDropDownView];
        self.drorDownView.isPopDropDownView = YES;
        
    }else {
        
        [self.drorDownView hideDropDownView];
        self.drorDownView.isPopDropDownView = NO;
        
    }
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self.tabBar selectTabAtIndex:self.index];
    
//    NSDictionary *dic = @{CAT_ID:@0};
    
    [self.viewModel requestFreshThingWithUrl:TIEZI_URL paramaters:nil success:^(NSArray *tieZi) {
        
    } error:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
    
    __weak HomeController *weakSelf = self;
    self.homeTableview.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf loadDataWithModel:self.contentCategoryModel];
    }];
    
    self.homeTableview.mj_footer = [MJRefreshAutoFooter footerWithRefreshingBlock:^{
        [weakSelf loadMoreDataWithModel:self.contentCategoryModel];
    }];
    
    [self.homeTableview.mj_header beginRefreshing];
    
    [self.view addSubview:self.homeTableview];
    [self.view addSubview:self.drorDownView];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.title = @"南京工业大学";
    self.navigationItem.leftBarButtonItem = self.leftBarItem;
    self.navigationItem.rightBarButtonItem = self.rightBarItem;
    
    [self judgeNetworkStatus];
}

/**
 *  下拉刷新
 */
- (void)loadDataWithModel:(ContentCategory)model {
    
    [self loadForType:1 model:model];
}

/**
 *  上拉刷新
 */
- (void)loadMoreDataWithModel:(ContentCategory)model {
    [self loadForType:2 model:model];
}

/**
 *  下拉、上拉刷新
 *
 *  @param type  上拉or下拉
 *  @param model 刷新类别：所有帖、新鲜事、好友动态、关注的话题
 */
- (void)loadForType:(int)type model:(ContentCategory)model {
    
    @weakify(self);
    [[self.viewModel.fecthTieZiEntityCommand execute:[NSNumber numberWithInteger:model]] subscribeNext:^(NSArray *tieZis) {
        @strongify(self);
        if (type == 1) {
            
            self.tieZiList = [tieZis mutableCopy];
            [self.homeTableview.mj_header endRefreshing];
            [self.homeTableview reloadData];
            
        }else {
            
            [self.tieZiList addObjectsFromArray:tieZis];
            [self.homeTableview.mj_footer endRefreshing];
            [self.homeTableview reloadData];
            
        }
    } error:^(NSError *error) {
        NSLog(@"%@",error.userInfo);
    }];
    
}


#pragma mark UITableViewDataSoure
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.tieZiList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    self.model                    = [self.tieZiList objectAtIndex:indexPath.row];
    NSString *cellIdentifier      = [self.viewModel idForRowByModel:self.model];
    YWHomeTableViewCellBase *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    cell.selectionStyle           = UITableViewCellSelectionStyleNone;

    [self.viewModel setupModelOfCell:cell model:self.model];

    
    return cell;
}

#pragma mark UITableViewDelegate 自适应高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    self.model               = [self.tieZiList objectAtIndex:indexPath.row];
    NSString *cellIdentifier = [self.viewModel idForRowByModel:self.model];

    return [tableView fd_heightForCellWithIdentifier:cellIdentifier cacheByIndexPath:indexPath configuration:^(id cell) {
        
        [self.viewModel setupModelOfCell:cell model:self.model];
    }];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
   // [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    self.model = [self.tieZiList objectAtIndex:indexPath.row];

    [self performSegueWithIdentifier:@"detail" sender:self];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10;
}

#pragma mark -- UIScrollViewDelegate

CGFloat lastPosition = 0;

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    if (scrollView == self.homeTableview) {
        
        CGFloat currentPosition = scrollView.contentOffset.y;
        if ( currentPosition - lastPosition > 50 ) {
            
            lastPosition = currentPosition;
            [self hidesTabBar:YES animated:YES];
            
        }else if(lastPosition - currentPosition > 50){
            
            lastPosition = currentPosition;
            [self showTabBar:YES animated:YES];
            
        }
    }
}

#pragma mark ---- DropDownViewDelegate
- (void)seletedDropDownViewAtIndex:(NSInteger)index {
    
}

- (void)hidesTabBar:(BOOL)yesOrNo animated:(BOOL)animated {
    
    //动画隐藏
    if (animated == yesOrNo) {
        if (yesOrNo == YES) {
            
            [UIView animateWithDuration:0.3 animations:^{
                self.tabBar.center = CGPointMake(self.view.center.x, SCREEN_HEIGHT);
            }];
            
        }
    }else {
        if (yesOrNo == YES)
        {
            self.tabBar.center = CGPointMake(self.view.center.x, SCREEN_HEIGHT);

        }

    }
}

- (void)showTabBar:(BOOL)yesOrNo animated:(BOOL)animated {
    
    //动画隐藏
    if (animated == yesOrNo) {
        if (yesOrNo == YES) {
            
            [UIView animateWithDuration:0.3 animations:^{
                
                self.tabBar.center = CGPointMake(self.view.center.x, SCREEN_HEIGHT-self.tabBar.height*2+15);
            }];
            
        }
    }else {
        if (yesOrNo == YES)
        {
            self.tabBar.center = CGPointMake(self.view.center.x, SCREEN_HEIGHT-self.tabBar.height*2-20);

        }
        
    }

}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.destinationViewController isKindOfClass:[DetailController class]]) {
        
        if ([segue.identifier isEqualToString:@"detail"]) {
            DetailController *detailVc = segue.destinationViewController;
            detailVc.model = self.model;
        }
    }
}

/**
 *  网路监测
 */
- (void)judgeNetworkStatus {
    [YWNetworkTools networkStauts];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
