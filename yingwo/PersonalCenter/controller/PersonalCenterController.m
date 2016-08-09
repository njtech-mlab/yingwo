//
//  PersonalCenterController.m
//  yingwo
//
//  Created by apple on 16/7/17.
//  Copyright © 2016年 wangxiaofa. All rights reserved.
//

#import "PersonalCenterController.h"
#import "YWPersonCenterCell.h"
#import "YWPersonCenterTopView.h"
#import "YWPersonCenterMidCell.h"

@interface PersonalCenterController ()<UINavigationControllerDelegate>

@property (nonatomic, strong) YWPersonCenterTopView *headView;
@property (nonatomic, strong) YWPersonCenterMidCell *midView;
@property (nonatomic, strong) YWPersonCenterCell    *cellView1;
@property (nonatomic, strong) YWPersonCenterCell    *cellView2;
@property (nonatomic, strong) YWPersonCenterCell    *cellView3;
@property (nonatomic, strong) YWPersonCenterCell    *cellView4;
@property (nonatomic, strong) UIBarButtonItem       *rightBarItem;

@end

@implementation PersonalCenterController

#pragma mark 懒加载
- (YWPersonCenterTopView *)headView {
    if (_headView == nil) {
        _headView = [[YWPersonCenterTopView alloc] initWithHeadPortrait:[UIImage imageNamed:@"defaultHead"] username:@"张三" signature:@"nice day" gender:@"male"];
        [_headView setBackgroundImage:[UIImage imageNamed:@"WBG"] forState:UIControlStateNormal];
        _headView.genderImageView.image = [UIImage imageNamed:@"man"];
    }
    return _headView;
}

- (YWPersonCenterMidCell *)midView {
    if (_midView == nil) {
        _midView = [[YWPersonCenterMidCell alloc] initWithFriends:@"20" attentions:@"100" fans:@"20" visitors:@"10"];
        _midView.image = [UIImage imageNamed:@"input_text"];
    }
    return _midView;
}

- (YWPersonCenterCell *)cellView1 {
    if (_cellView1 == nil) {
        _cellView1 = [[YWPersonCenterCell alloc] initWithLeftImage:[UIImage imageNamed:@"#"] labelText:@"我的话题"];
        [_cellView1 setBackgroundImage:[UIImage imageNamed:@"input_top"] forState:UIControlStateNormal];
    }
    return _cellView1;
}


- (YWPersonCenterCell *)cellView2 {
    if (_cellView2 == nil) {
        _cellView2 = [[YWPersonCenterCell alloc] initWithLeftImage:[UIImage imageNamed:@"note"] labelText:@"我的贴子"];
        [_cellView2 setBackgroundImage:[UIImage imageNamed:@"input_mid"] forState:UIControlStateNormal];

    }
    return _cellView2;
}

- (YWPersonCenterCell *)cellView3 {
    if (_cellView3 == nil) {
        _cellView3 = [[YWPersonCenterCell alloc] initWithLeftImage:[UIImage imageNamed:@"mes"] labelText:@"我的评论"];
        [_cellView3 setBackgroundImage:[UIImage imageNamed:@"input_mid"] forState:UIControlStateNormal];

    }
    return _cellView3;
}

- (YWPersonCenterCell *)cellView4 {
    if (_cellView4 == nil) {
        _cellView4 = [[YWPersonCenterCell alloc] initWithLeftImage:[UIImage imageNamed:@"heart"] labelText:@"我的点赞"];
        [_cellView4 setBackgroundImage:[UIImage imageNamed:@"input_col"] forState:UIControlStateNormal];
    }
    return _cellView4;
}

- (UIBarButtonItem *)rightBarItem {
    if (_rightBarItem == nil) {
        _rightBarItem = [[UIBarButtonItem alloc ]initWithImage:[UIImage imageNamed:@"gear"] style:UIBarButtonItemStylePlain target:self action:@selector(jumpToConfigurationPage)];
    }
    return _rightBarItem;
}

#pragma mark UI布局
- (void)setUILayout {
    
    [self.headView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top);
        make.left.equalTo(self.view.mas_left).offset(0);
        make.right.equalTo(self.view.mas_right).offset(0);
    }];
    
    [self.midView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.headView.mas_bottom).offset(10);
        make.centerX.equalTo(self.view);
        make.left.equalTo(self.view.mas_left).offset(10);
        make.right.equalTo(self.view.mas_right).offset(-10);
    }];
    
    [self.cellView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.midView.mas_bottom).offset(10);
        make.centerX.equalTo(self.view);
        make.left.equalTo(self.view.mas_left).offset(10);
        make.right.equalTo(self.view.mas_right).offset(-10);
    }];
    
    [self.cellView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.cellView1.mas_bottom);
        make.centerX.equalTo(self.view);
        make.left.equalTo(self.view.mas_left).offset(10);
        make.right.equalTo(self.view.mas_right).offset(-10);
    }];
    
    [self.cellView3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.cellView2.mas_bottom);
        make.centerX.equalTo(self.view);
        make.left.equalTo(self.view.mas_left).offset(10);
        make.right.equalTo(self.view.mas_right).offset(-10);
    }];
    
    [self.cellView4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.cellView3.mas_bottom);
        make.centerX.equalTo(self.view);
        make.left.equalTo(self.view.mas_left).offset(10);
        make.right.equalTo(self.view.mas_right).offset(-10);
    }];
}

#pragma mark 本地数据加载
- (void)loadDataFromLocalForCustomer {
    
    Customer *customer = [User findCustomer];
    if (customer != nil) {
        
        self.headView.usernameLabel.text  = customer.nickname;
        self.headView.signatureLabel.text = customer.username;
        NSString *imagePath               = [YWSandBoxTool getHeadPortraitPathFromCache];
        
        if (imagePath != nil) {
            
            self.headView.headPortraitImageView.image = [UIImage imageWithContentsOfFile:imagePath];

        }
        
        if ([customer.gender isEqualToString:@"0"]) {
            self.headView.genderImageView.image = [UIImage imageNamed:@"woman"];
        }

    }
    
}

#pragma mark action

- (void)setAllAction {
    [self.headView addTarget:self action:@selector(jumpToBaseInfoPage) forControlEvents:UIControlEventTouchUpInside];
}

- (void)jumpToBaseInfoPage {
  //  [super.navigationController performSegueWithIdentifier:SEGUE_IDENTIFY_BASEINFO sender:self];
    [self performSegueWithIdentifier:SEGUE_IDENTIFY_BASEINFO sender:self];
}

- (void)jumpToConfigurationPage {
    [self performSegueWithIdentifier:SEGUE_IDENTIFY_CONFIGURATION sender:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.headView];
    [self.view addSubview:self.midView];
    [self.view addSubview:self.cellView1];
    [self.view addSubview:self.cellView2];
    [self.view addSubview:self.cellView3];
    [self.view addSubview:self.cellView4];

    [self setUILayout];
    [self setAllAction];
    [self loadDataFromLocalForCustomer];

}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.title = @"我的";
    self.navigationItem.rightBarButtonItem = self.rightBarItem;
    
    [self judgeNetworkStatus];
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
