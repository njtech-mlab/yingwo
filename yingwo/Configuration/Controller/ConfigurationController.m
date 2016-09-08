//
//  ConfigurationController.m
//  yingwo
//
//  Created by apple on 16/7/20.
//  Copyright © 2016年 wangxiaofa. All rights reserved.
//

#import "ConfigurationController.h"
#import "YWConfigurationCell.h"
@interface ConfigurationController ()

@property (nonatomic, strong) YWConfigurationCell *phoneBindedCell;
@property (nonatomic, strong) YWConfigurationCell *modifyPasswordCell;
@property (nonatomic, strong) YWConfigurationCell *messagePushCell;
@property (nonatomic, strong) YWConfigurationCell *cleanCacheCell;
@property (nonatomic, strong) YWConfigurationCell *userDelegateCell;
@property (nonatomic, strong) YWConfigurationCell *adviceCell;
@property (nonatomic, strong) YWConfigurationCell *pointCell;
@property (nonatomic, strong) YWConfigurationCell *aboutUsCell;
@property (nonatomic, strong) UIButton            *exitAccountBtn;
@property (nonatomic, strong) UIScrollView        *backgroundSrcView;
@end

@implementation ConfigurationController

#pragma mark 懒加载
- (YWConfigurationCell *)phoneBindedCell {
    if (_phoneBindedCell == nil) {
        _phoneBindedCell = [[YWConfigurationCell alloc] initWithLeftLabel:@"手机绑定" isHasRightView:YES];
        [_phoneBindedCell setBackgroundImage:[UIImage imageNamed:@"input_top"] forState:UIControlStateNormal];
        [_phoneBindedCell setBackgroundImage:[UIImage imageNamed:@"input_top_selected"] forState:UIControlStateHighlighted];
    }
    return _phoneBindedCell;
}

- (YWConfigurationCell *)modifyPasswordCell {
    if (_modifyPasswordCell == nil) {
        _modifyPasswordCell = [[YWConfigurationCell alloc] initWithLeftLabel:@"修改密码" isHasRightView:YES];
        [_modifyPasswordCell setBackgroundImage:[UIImage imageNamed:@"input_mid"] forState:UIControlStateNormal];
        [_modifyPasswordCell setBackgroundImage:[UIImage imageNamed:@"input_mid_selected"] forState:UIControlStateHighlighted];
    }
    return _modifyPasswordCell;
}

- (YWConfigurationCell *)messagePushCell {
    if (_messagePushCell == nil) {
        _messagePushCell = [[YWConfigurationCell alloc] initWithLeftLabel:@"消息推送" isHasRightView:YES];
        [_messagePushCell setBackgroundImage:[UIImage imageNamed:@"input_mid"] forState:UIControlStateNormal];
        [_messagePushCell setBackgroundImage:[UIImage imageNamed:@"input_mid_selected"] forState:UIControlStateHighlighted];

    }
    return _messagePushCell;
}

- (YWConfigurationCell *)cleanCacheCell {
    if (_cleanCacheCell == nil) {
        _cleanCacheCell = [[YWConfigurationCell alloc] initWithLeftLabel:@"清除缓存" isHasRightView:NO];
        [_cleanCacheCell setBackgroundImage:[UIImage imageNamed:@"input_col"] forState:UIControlStateNormal];
        [_cleanCacheCell setBackgroundImage:[UIImage imageNamed:@"input_col_selected"] forState:UIControlStateHighlighted];

    }
    return _cleanCacheCell;
}

- (YWConfigurationCell *)userDelegateCell {
    if (_userDelegateCell == nil) {
        _userDelegateCell = [[YWConfigurationCell alloc] initWithLeftLabel:@"用户协议" isHasRightView:YES];
        [_userDelegateCell setBackgroundImage:[UIImage imageNamed:@"input_top"] forState:UIControlStateNormal];
        [_userDelegateCell setBackgroundImage:[UIImage imageNamed:@"input_top_selected"] forState:UIControlStateHighlighted];
    }
    return _userDelegateCell;
}

- (YWConfigurationCell *)adviceCell {
    if (_adviceCell == nil) {
        _adviceCell = [[YWConfigurationCell alloc] initWithLeftLabel:@"意见反馈" isHasRightView:YES];
        [_adviceCell setBackgroundImage:[UIImage imageNamed:@"input_mid"] forState:UIControlStateNormal];
        [_adviceCell setBackgroundImage:[UIImage imageNamed:@"input_mid_selected"] forState:UIControlStateHighlighted];
    }
    return _adviceCell;
}

- (YWConfigurationCell *)pointCell {
    if (_pointCell == nil) {
        _pointCell = [[YWConfigurationCell alloc] initWithLeftLabel:@"给APP评分" isHasRightView:YES];
        [_pointCell setBackgroundImage:[UIImage imageNamed:@"input_mid"] forState:UIControlStateNormal];
        [_pointCell setBackgroundImage:[UIImage imageNamed:@"input_mid_selected"] forState:UIControlStateHighlighted];
    }
    return _pointCell;
}

- (YWConfigurationCell *)aboutUsCell {
    if (_aboutUsCell == nil) {
        _aboutUsCell = [[YWConfigurationCell alloc] initWithLeftLabel:@"关于我们" isHasRightView:YES];
        [_aboutUsCell setBackgroundImage:[UIImage imageNamed:@"input_col"] forState:UIControlStateNormal];
        [_aboutUsCell setBackgroundImage:[UIImage imageNamed:@"input_col_selected"] forState:UIControlStateHighlighted];
    }
    return _aboutUsCell;
}

- (UIButton *)exitAccountBtn {
    if (_exitAccountBtn == nil) {
        _exitAccountBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_exitAccountBtn setTitle:@"退出帐号" forState:UIControlStateNormal];
        _exitAccountBtn.titleLabel.font = [UIFont systemFontOfSize:16];
        [_exitAccountBtn setTitleColor:[UIColor colorWithHexString:RED_COLOR] forState:UIControlStateNormal];
        [_exitAccountBtn setBackgroundImage:[UIImage imageNamed:@"input_text"] forState:UIControlStateNormal];
    }
    return _exitAccountBtn;
}

- (UIScrollView *)backgroundSrcView {
    if (_backgroundSrcView == nil) {
        
        _backgroundSrcView = [[UIScrollView alloc] init];
        _backgroundSrcView.frame = [self.view bounds];
        _backgroundSrcView.center = self.view.center;
        _backgroundSrcView.showsHorizontalScrollIndicator = NO;
        _backgroundSrcView.showsVerticalScrollIndicator = NO;
        
        //iphone 5需要扩张长度，否则屏幕不够用😢，布局太长了
        if (IS_IPHONE_5) {
            _backgroundSrcView.contentSize= CGSizeMake(320, 650);
            
        }
    }
    return _backgroundSrcView;
}

#pragma mark 本地数据加载
- (void)loadDataFromLocalForCustomer {
    
    Customer *customer = [User findCustomer];
    [self dispalyPhone:customer.mobile];
}

- (void)dispalyPhone:(NSString *)phone {
    
    NSString *fourStars = @"****";
    NSString *frontPart = [phone substringToIndex:3];
    NSString *tailPart  = [phone substringFromIndex:7];
    NSString *newPhone  = [NSString stringWithFormat:@"%@%@%@",frontPart,fourStars,tailPart];
    
    self.phoneBindedCell.rightLabel.text = newPhone;
}

#pragma mark UI布局
- (void)setAllUILayout {
    
    [self.phoneBindedCell mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.backgroundSrcView.mas_top).offset(15);
        make.left.equalTo(self.view.mas_left).offset(10);
        make.right.equalTo(self.view.mas_right).offset(-10);
    }];
    
    [self.modifyPasswordCell mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.phoneBindedCell.mas_bottom);
        make.left.equalTo(self.view.mas_left).offset(10);
        make.right.equalTo(self.view.mas_right).offset(-10);

    }];
    
    [self.messagePushCell mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.modifyPasswordCell.mas_bottom);
        make.left.equalTo(self.view.mas_left).offset(10);
        make.right.equalTo(self.view.mas_right).offset(-10);

    }];
    
    [self.cleanCacheCell mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.messagePushCell.mas_bottom);
        make.left.equalTo(self.view.mas_left).offset(10);
        make.right.equalTo(self.view.mas_right).offset(-10);

    }];
    
    [self.userDelegateCell mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.cleanCacheCell.mas_bottom).offset(15);
        make.left.equalTo(self.view.mas_left).offset(10);
        make.right.equalTo(self.view.mas_right).offset(-10);

    }];
    
    [self.adviceCell mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.userDelegateCell.mas_bottom);
        make.left.equalTo(self.view.mas_left).offset(10);
        make.right.equalTo(self.view.mas_right).offset(-10);

    }];
    
    [self.pointCell mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.adviceCell.mas_bottom);
        make.left.equalTo(self.view.mas_left).offset(10);
        make.right.equalTo(self.view.mas_right).offset(-10);

    }];
    
    [self.aboutUsCell mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.pointCell.mas_bottom);
        make.left.equalTo(self.view.mas_left).offset(10);
        make.right.equalTo(self.view.mas_right).offset(-10);

    }];
    
    [self.exitAccountBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.aboutUsCell.mas_bottom).offset(15);
        make.left.equalTo(self.view.mas_left).offset(10);
        make.right.equalTo(self.view.mas_right).offset(-10);

    }];
    
}

#pragma mark set all cell's action in here

- (void)setAllAction {
    [self.modifyPasswordCell addTarget:self action:@selector(jumpToModifyPasswordPage) forControlEvents:UIControlEventTouchUpInside];
    [self.exitAccountBtn addTarget:self action:@selector(exitAccount) forControlEvents:UIControlEventTouchUpInside];
}

- (void)jumpToModifyPasswordPage {
    [self performSegueWithIdentifier:SEGUE_IDENTIFY_RESET sender:self];
}

- (void)jumpToLoginPage {
    LoginController *loginVC  = [self.storyboard instantiateViewControllerWithIdentifier:CONTROLLER_OF_LOGINVC_IDENTIFIER];
    [self.navigationController pushViewController:loginVC animated:YES];
}

//退出帐号，返回登录界面
- (void)exitAccount {
    
    [User deleteCustoer];
    [User deleteLoginInformation];
    [self jumpToLoginPage];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.backgroundSrcView];
    [self.backgroundSrcView addSubview:self.phoneBindedCell];
    [self.backgroundSrcView addSubview:self.modifyPasswordCell];
    [self.backgroundSrcView addSubview:self.messagePushCell];
    [self.backgroundSrcView addSubview:self.cleanCacheCell];
    [self.backgroundSrcView addSubview:self.userDelegateCell];
    [self.backgroundSrcView addSubview:self.adviceCell];
    [self.backgroundSrcView addSubview:self.pointCell];
    [self.backgroundSrcView addSubview:self.aboutUsCell];
    [self.backgroundSrcView addSubview:self.exitAccountBtn];

    [self setAllUILayout];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.title  = @"设置";
    
    [self loadDataFromLocalForCustomer];
    [self setAllAction];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
