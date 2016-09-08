//
//  PerfectInfoController.m
//  yingwo
//
//  Created by apple on 16/7/14.
//  Copyright © 2016年 wangxiaofa. All rights reserved.
//

#import "PerfectInfoController.h"
#import "YWSearchController.h"

#import "YWInputButton.h"
#import "CroppingController.h"
#import "GradePickerView.h"

#import "PerfectViewModel.h"
#import "CollegeModel.h"

@interface PerfectInfoController ()<UIPickerViewDelegate,UIPickerViewDataSource>

@property (nonatomic, strong) UIScrollView    *backgroundSrcView;
@property (nonatomic, strong) UIButton        *photoImageBtn;
@property (nonatomic, strong) UIImage         *photoImage;

@property (nonatomic, strong) YWInputButton   *signatureText;
@property (nonatomic, strong) YWInputButton   *nicknameText;
@property (nonatomic, strong) YWInputButton   *sexText;
@property (nonatomic, strong) YWInputButton   *schoolText;
@property (nonatomic, strong) YWInputButton   *academyText;
@property (nonatomic, strong) YWInputButton   *gradeText;

@property (nonatomic, strong) UIButton        *male;
@property (nonatomic, strong) UIButton        *female;
@property (nonatomic, strong) UIButton        *finishedBtn;

@property (nonatomic, strong) GradePickerView *gradePickerView;

@property (nonatomic, assign) Boolean        sex;
@property (nonatomic, copy  ) NSString       *selectedGrade;
@property (nonatomic, strong) NSMutableArray *RecentYears;

@property (nonatomic, strong) PerfectViewModel *viewModel;
@property (nonatomic, strong) CollegeModel     *collegeModel;

@end


@implementation PerfectInfoController

#pragma mark ----------懒加载
- (UIButton *)photoImageBtn {
    if (_photoImageBtn == nil) {
        _photoImageBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        [_photoImageBtn setBackgroundImage:[UIImage imageNamed:@"photo"]
                                  forState:UIControlStateNormal];
        [_photoImageBtn addTarget:self
                           action:@selector(selectHeadPortrait)
                 forControlEvents:UIControlEventTouchUpInside];
    }
    return _photoImageBtn;
}

- (YWInputButton *)signatureText {
    
    if (_signatureText == nil) {
        _signatureText = [[YWInputButton alloc] initWithFrame:CGRectMake(0, 0, 0, 0)
                                                    leftLabel:@"个性签名"
                                                  centerLabel:@"一句话让你更加不一样"];
        [_signatureText setBackgroundImage:[UIImage imageNamed:@"input_text"]
                                  forState:UIControlStateNormal];
        [_signatureText setBackgroundImage:[UIImage imageNamed:@"input_text_selected"]
                                  forState:UIControlStateHighlighted];
        [_signatureText showRightView];
    }
    return _signatureText;
}

- (YWInputButton *)nicknameText {
    
    if (_nicknameText == nil) {
        _nicknameText = [[YWInputButton alloc] initWithFrame:CGRectMake(0, 0, 0, 0)
                                                   leftLabel:@"昵称"
                                                 centerLabel:@"必填"];
        [_nicknameText setBackgroundImage:[UIImage imageNamed:@"input_top"]
         
                                 forState:UIControlStateNormal];
        [_nicknameText setBackgroundImage:[UIImage imageNamed:@"input_top_selected"]
                                 forState:UIControlStateHighlighted];

        [_nicknameText showRightView];
    }
    return _nicknameText;
}

- (YWInputButton *)sexText {
    
    if (_sexText == nil) {
        _sexText = [[YWInputButton alloc] initWithFrame:CGRectMake(0, 0, 0, 0)
                                              leftLabel:@"性别"
                                            centerLabel:@""];
        [_sexText setBackgroundImage:[UIImage imageNamed:@"input_mid"]
                            forState:UIControlStateNormal];
        [_sexText setBackgroundImage:[UIImage imageNamed:@"input_mid_selected"]
                            forState:UIControlStateHighlighted];

    }
    return _sexText;
}

- (YWInputButton *)schoolText {
    
    if (_schoolText == nil) {
        _schoolText = [[YWInputButton alloc] initWithFrame:CGRectMake(0, 0, 0, 0)
                                                 leftLabel:@"学校"
                                               centerLabel:@"必填"];
        [_schoolText setBackgroundImage:[UIImage imageNamed:@"input_mid"]
                               forState:UIControlStateNormal];
        [_schoolText setBackgroundImage:[UIImage imageNamed:@"input_mid_selected"]
                               forState:UIControlStateHighlighted];
        [_schoolText showRightView];
    }
    return _schoolText;
}

- (YWInputButton *)academyText {
    
    if (_academyText == nil) {
        _academyText = [[YWInputButton alloc] initWithFrame:CGRectMake(0, 0, 0, 0)
                                                  leftLabel:@"学院"
                                                centerLabel:@"选填"];
        [_academyText setBackgroundImage:[UIImage imageNamed:@"input_mid"]
                                forState:UIControlStateNormal];
        [_academyText setBackgroundImage:[UIImage imageNamed:@"input_mid_selected"]
                                forState:UIControlStateHighlighted];

        [_academyText showRightView];
    }
    return _academyText;
}

- (YWInputButton *)gradeText {
    
    if (_gradeText == nil) {
        _gradeText = [[YWInputButton alloc] initWithFrame:CGRectMake(0, 0, 0, 0)
                                                leftLabel:@"年级"
                                              centerLabel:@"选填"];
        [_gradeText setBackgroundImage:[UIImage imageNamed:@"input_col"]
                              forState:UIControlStateNormal];
        [_gradeText setBackgroundImage:[UIImage imageNamed:@"input_col_selected"]
                              forState:UIControlStateHighlighted];

    }
    return _gradeText;
}

- (UIButton *)male {
    if (_male == nil) {
        _male = [[UIButton alloc] init];
        [_male setBackgroundImage:[UIImage imageNamed:@"male-show"]
                         forState:UIControlStateNormal];
    }
    return _male;
}

- (UIButton *)female {
    if (_female == nil) {
        _female = [[UIButton alloc] init];
        [_female setBackgroundImage:[UIImage imageNamed:@"female-hide"]
                           forState:UIControlStateNormal];
    }
    return _female;
}

- (UIButton *)finishedBtn {
    if (_finishedBtn == nil) {
        _finishedBtn = [[UIButton alloc] init];
        [_finishedBtn setBackgroundImage:[UIImage imageNamed:@"NewButton"]
                                forState:UIControlStateNormal];
        [_finishedBtn setTitle:@"完成" forState:UIControlStateNormal];
    }
    return _finishedBtn;
}

- (UIScrollView *)backgroundSrcView {
    if (_backgroundSrcView == nil) {
        
        _backgroundSrcView = [[UIScrollView alloc] init];
        _backgroundSrcView.frame = [self.view bounds];
        _backgroundSrcView.center = self.view.center;
        _backgroundSrcView.showsHorizontalScrollIndicator = NO;
        _backgroundSrcView.showsVerticalScrollIndicator = NO;
        
        //iphone 5需要扩张长度，否则屏幕不够用😢
        if (IS_IPHONE_5) {
            _backgroundSrcView.contentSize= CGSizeMake(320, 650);

        }
    }
    return _backgroundSrcView;
}

- (GradePickerView *)gradePickerView {
    if (_gradePickerView == nil) {
        _gradePickerView            = [[GradePickerView alloc] initWithFrame:CGRectMake(0, self.view.height, self.view.width, 150)];
        _gradePickerView.pickerView.delegate   = self;
        _gradePickerView.pickerView.dataSource = self;
        _gradePickerView.backgroundColor = [UIColor colorWithHexString:THEME_COLOR_5 alpha:0.7];
        [_gradePickerView.finishedBtn addTarget:self action:@selector(closeGradePickerView) forControlEvents:UIControlEventTouchUpInside];
    }
    return _gradePickerView;
}

- (NSMutableArray *)RecentYears {
    
    if (_RecentYears == nil) {
        
        _RecentYears = [[NSMutableArray alloc] init];
        
        NSArray *tempArr = [NSDate gradeInRecentYears];
        
        for (NSNumber *number in tempArr) {
            [_RecentYears addObject:number.description];
        }
    }
    return _RecentYears;
}

- (NSString *)selectedGrade {
    if (_selectedGrade == nil) {
        //默认是第一年
        _selectedGrade = [self.RecentYears objectAtIndex:0];
    }
    return _selectedGrade;
}

- (PerfectViewModel *)viewModel {
    if (_viewModel == nil) {
        _viewModel = [[PerfectViewModel alloc] init];
    }
    return _viewModel;
}

- (CollegeModel *)collegeModel {
    if (_collegeModel == nil) {
        _collegeModel = [[CollegeModel alloc] init];
    }
    return _collegeModel;
}

#pragma mark -----初始化UI布局,布局约束

- (void)setUILayout {
    
    [self.photoImageBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.backgroundSrcView.mas_top).offset(25);
        make.centerX.equalTo(self.backgroundSrcView);
    }];
        
    [self.signatureText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.photoImageBtn.mas_bottom).offset(25);
        make.left.equalTo(self.view.mas_left).offset(10);
        make.right.equalTo(self.view.mas_right).offset(-10);
    }];
    

    [self.nicknameText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.signatureText.mas_bottom).offset(15);
        make.left.mas_equalTo(self.signatureText.mas_left);
        make.right.mas_equalTo(self.signatureText.mas_right);
    }];
    
    [self.sexText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.nicknameText.mas_bottom);
        make.left.mas_equalTo(self.signatureText.mas_left);
        make.right.mas_equalTo(self.signatureText.mas_right);
    }];
    
    [self.schoolText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.sexText.mas_bottom);
        make.left.mas_equalTo(self.signatureText.mas_left);
        make.right.mas_equalTo(self.signatureText.mas_right);
    }];
    
    [self.academyText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.schoolText.mas_bottom);
        make.left.mas_equalTo(self.signatureText.mas_left);
        make.right.mas_equalTo(self.signatureText.mas_right);
    }];
    
    [self.gradeText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.academyText.mas_bottom);
        make.left.mas_equalTo(self.signatureText.mas_left);
        make.right.mas_equalTo(self.signatureText.mas_right);
    }];
    
    [self.finishedBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.gradeText.mas_bottom).offset(20);
        make.left.mas_equalTo(self.signatureText.mas_left);
        make.right.mas_equalTo(self.signatureText.mas_right);
    }];
    
    [self.male mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.sexText);
        make.centerX.equalTo(self.sexText.mas_centerX).offset(-18);
    }];
    
    [self.female mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.sexText);
        make.centerX.equalTo(self.sexText.mas_centerX).offset(18);
    }];
    
}

#pragma mark ---------AllAction

- (void)setAllAction {
    [self.signatureText addTarget:self
                           action:@selector(jumpToWriteSignaturePage)
                 forControlEvents:UIControlEventTouchUpInside];
    
    [self.male addTarget:self
                  action:@selector(sexToMale)
        forControlEvents:UIControlEventTouchUpInside];
    
    [self.female addTarget:self
                    action:@selector(sexToFemale)
          forControlEvents:UIControlEventTouchUpInside];
    
    [self.nicknameText addTarget:self
                          action:@selector(jumpToWirteNicknamePage)
                forControlEvents:UIControlEventTouchUpInside];
    
    [self.schoolText addTarget:self
                        action:@selector(selectSchool)
              forControlEvents:UIControlEventTouchUpInside];
    
    [self.academyText addTarget:self action:@selector(selectAcademy) forControlEvents:UIControlEventTouchUpInside];
    
    [self.gradeText addTarget:self
                       action:@selector(selectGrade)
             forControlEvents:UIControlEventTouchUpInside];
    
   [self.finishedBtn addTarget:self
                        action:@selector(finishBaseInfo)
              forControlEvents:UIControlEventTouchUpInside];
}

//性别判断
- (void)sexToMale {
        [self.male setBackgroundImage:[UIImage imageNamed:@"male-show"]
                             forState:UIControlStateNormal];
        [self.female setBackgroundImage:[UIImage imageNamed:@"female-hide"]
                               forState:UIControlStateNormal];
    _sex = NO;
}

- (void)sexToFemale {
    [self.male setBackgroundImage:[UIImage imageNamed:@"male-hide"]
                         forState:UIControlStateNormal];
    [self.female setBackgroundImage:[UIImage imageNamed:@"female-show"]
                           forState:UIControlStateNormal];
    _sex = YES;
}

- (void)selectSchool {
    [self.viewModel requestForCollegeWithUrl:SCHOOL_URL success:^(College *colleges) {
        
        if (colleges.status == YES) {
            [self.collegeModel saveCollegeDataInUserDefault:colleges.info];
            YWSearchController *schoolSearchVc = [[YWSearchController alloc] init];
            schoolSearchVc.searchModel         = SchoolSearchModel;
            [self.navigationController pushViewController:schoolSearchVc animated:YES];
        }
        
    } failure:^(NSString *error) {
        
    }];
}

- (void)selectAcademy {
    
    if (![self hasSelectedSchool]) {
        [MBProgressHUD showErrorHUDToAddToView:self.view labelText:@"请先选择学校" animated:YES afterDelay:1.5];
        return;
    }
    
    NSDictionary *paramaters = @{@"school_id":self.school_id};
    
    [self.viewModel requestForAcademyWithUrl:ACADEMY_URL
                                  paramaters:paramaters
                                     success:^(College *colleges) {
        
        if (colleges.status == YES) {
            [self.collegeModel saveCollegeDataInUserDefault:colleges.info];
            YWSearchController *academySearchVc = [[YWSearchController alloc] init];
            academySearchVc.searchModel         = AcademySearchModel;
            [self.navigationController pushViewController:academySearchVc animated:YES];
        }
        
    } failure:^(NSString *error) {
        
    }];
}

/**
 *  判断学校是否选择了
 *
 *  @return 没选择返回NO
 */
- (BOOL)hasSelectedSchool {
    if (self.school.length == 0) {
        return NO;
    }
    return YES;
}

//年级选择
- (void)selectGrade {
    
    [self.backgroundSrcView addSubview:self.gradePickerView];

    [UIView animateWithDuration:0.3 animations:^{
        self.gradePickerView.center = CGPointMake(self.view.center.x, self.view.height-self.gradePickerView.height/2);
    }];
}

//关闭年级选择
- (void)closeGradePickerView {
    
    [UIView animateWithDuration:0.3 animations:^{
        self.gradePickerView.center = CGPointMake(self.view.center.x, self.view.height+self.gradePickerView.height/2);

    } completion:^(BOOL finished) {
        self.gradeText.centerLabel.text = self.selectedGrade;
        [self.gradePickerView removeFromSuperview];
    }];
    
}


- (void)selectHeadPortrait {
    
    CroppingController *cropVC = [[CroppingController alloc] initWithCompleteBlock:^(UIImage *img) {
        NSLog(@"imageSize%@",[NSValue valueWithCGSize:img.size]);
        if (img != nil) {
            self.photoImage = img;
            [self.photoImageBtn setBackgroundImage:[UIImage circleImage:img] forState:UIControlStateNormal];
        }
    }];
    [self.navigationController pushViewController:cropVC animated:NO];
}

- (void)finishBaseInfo {
    
    NSString *requestUrl = @"";
    
    if (self.isModfiyInfo == YES) {
        requestUrl = UPDATE_INFO_URL;
    }
    else
    {
        requestUrl = BASE_INFO_URL;
    }

    [self requestFinishedBaseInfoWithUrl:requestUrl];
}

- (void)requestFinishedBaseInfoWithUrl:(NSString *)urlString {
    
    if (self.photoImage == nil) {
        
        NSDictionary *paramaters = @{@"name":self.nicknameText.centerLabel.text,
                                     @"grade":self.gradeText.centerLabel.text,
                                     @"signature":self.signatureText.centerLabel.text,
                                     @"school_id":self.schoolText.centerLabel.text,
                                     @"academy_id":self.academyText.centerLabel.text};
        
        [self.viewModel requestForFinishUserBaseInfoWithUrl:urlString
                                                 paramaters:paramaters
                                                    success:^(College *info) {
                                                        if (info.status == YES) {
                                                            NSLog(@"成功");
                                                            
                                                            [self finishedUserInfo];
                                                            
                                                        }
                                                        
                                                    } failure:^(NSString *error) {
                                                        NSLog(@"完善信息失败");
                                                    }];
        
    }
    else {
        
        [YWQiNiuUploadTool uploadImage:self.photoImage
                              progress:nil
                               success:^(NSString *url) {
                                   
                                   NSDictionary *paramaters = @{@"name":self.name,
                                                                @"grade":self.gradeText.centerLabel.text,
                                                                @"signature":self.signature,
                                                                @"face_img":url,
                                                                @"school_id":self.school,
                                                                @"academy_id":self.academy};
                                   
                                   [self.viewModel requestForFinishUserBaseInfoWithUrl:urlString
                                                                            paramaters:paramaters
                                                                               success:^(College *info) {
                                                                                   if (info.status == YES) {
                                                                                       NSLog(@"成功");
                                                                                       [self finishedUserInfo];
                                                                                   }
                                                                                   
                                                                               } failure:^(NSString *error) {
                                                                                   
                                                                               }];
                               } failure:^{
                                   NSLog(@"完善信息失败");
                               }];
    }
}



//action跳转
- (void)jumpToWriteSignaturePage {
    [self performSegueWithIdentifier:SEGUE_IDENTIFY_WRITESIGNATURE sender:self];
}

- (void)jumpToWirteNicknamePage {
    [self performSegueWithIdentifier:SEGUE_IDENTIFY_WRITENICKNAME sender:self];
}

- (void)finishedUserInfo{
    
    if (self.isModfiyInfo == YES) {
        [SVProgressHUD setMinimumDismissTimeInterval:1];
        [SVProgressHUD showSuccessStatus:@"修改成功"];
    }
    else
    {
        [SVProgressHUD setMinimumDismissTimeInterval:1];
        [SVProgressHUD showSuccessWithStatus:@"完善成功"];
    }
    [self backToForward];
}

- (void)backToForward {
    [self performSelector:@selector(dismiss) withObject:nil afterDelay:1.5];
}

- (void)dismiss {
    if (self.isModfiyInfo == YES) {
        [self.navigationController popViewControllerAnimated:YES];
    }
    else
    {
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
}

#pragma mark - UIPickerView Delegate
// returns the number of 'columns' to display.
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {

    return self.RecentYears.count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    
    return [self.RecentYears objectAtIndex:row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    self.selectedGrade = [self.RecentYears objectAtIndex:row];
}


- (void)viewDidLoad {
    [super viewDidLoad];

    [self.view addSubview:self.backgroundSrcView];
    
    [self.backgroundSrcView addSubview:self.photoImageBtn];
    [self.backgroundSrcView addSubview:self.signatureText];
    [self.backgroundSrcView addSubview:self.nicknameText];
    [self.backgroundSrcView addSubview:self.sexText];
    [self.backgroundSrcView addSubview:self.schoolText];
    [self.backgroundSrcView addSubview:self.academyText];
    [self.backgroundSrcView addSubview:self.gradeText];
    [self.backgroundSrcView addSubview:self.finishedBtn];
    [self.backgroundSrcView addSubview:self.male];
    [self.backgroundSrcView addSubview:self.female];
    [self.backgroundSrcView addSubview:self.finishedBtn];
    
    [self setUILayout];
    [self setAllAction];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self setNavigationBar];
    //设置签名、姓名、学校
    [self setCustomerInfo];
    
}

#pragma mark  private-method

- (void)setNavigationBar {
    
    self.title = @"完善个人信息";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"nva_con"]
                                                                            style:UIBarButtonItemStylePlain
                                                                           target:self action:@selector(dismiss)];
    //去除导航栏下的一条横线
}

/**
 *  设置详细信息
 */
- (void)setCustomerInfo {
    if (self.name.length != 0) {
        self.nicknameText.centerLabel.text = self.name;
    }
    if (self.signature.length != 0) {
        self.signatureText.centerLabel.text = self.signature;
    }
    if (self.grade.length != 0) {
        self.gradeText.centerLabel.text = self.grade;
    }
    if (self.school.length != 0) {
        self.schoolText.centerLabel.text  = self.school;
    }
    if (self.academy.length != 0) {
        self.academyText.centerLabel.text = self.academy;
    }
    if (self.headImagePath.length != 0) {
        [self.photoImageBtn setBackgroundImage:[UIImage imageWithContentsOfFile:self.headImagePath]
                                      forState:UIControlStateNormal];
    }
    if (self.gender.length != 0) {
        if ([self.gender isEqualToString:@"1"]) {
            [self sexToMale];
        }
        else
        {
            [self sexToFemale];
        }
    }
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
