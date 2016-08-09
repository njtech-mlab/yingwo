//
//  MainController.m
//  yingwo
//
//  Created by apple on 16/7/18.
//  Copyright © 2016年 wangxiaofa. All rights reserved.
//

#import "MainController.h"
#import "YWTabBarController.h"
#import "PersonalCenterController.h"
#import "HomeController.h"
#import "AnnounceController.h"

@interface MainController ()

@property (nonatomic, strong)YWTabBarController *mainTabBarController;

@end

@implementation MainController

#pragma mark action


- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    HomeController *pcVc1 = [self.storyboard instantiateViewControllerWithIdentifier:CONTROLLER_OF_HOME_IDENTIFIER];
    MainNavController *nav1 = [[MainNavController alloc] initWithRootViewController:pcVc1];
    

    PersonalCenterController *pcVc2 = [self.storyboard instantiateViewControllerWithIdentifier:CONTROLLER_OF_PERSONNAL_CENTER_IDENTIFY];
    MainNavController *nav2 = [[MainNavController alloc] initWithRootViewController:pcVc2];
    
    NSArray *controllerArr = [NSArray arrayWithObjects:nav1,nav2,nav1,nav1,nav2, nil];
    
    NSMutableDictionary *imgDic1 = [NSMutableDictionary dictionaryWithCapacity:2];
    [imgDic1 setObject:[UIImage imageNamed:@"home_G"] forKey:@"Default"];
    [imgDic1 setObject:[UIImage imageNamed:@"home"] forKey:@"Seleted"];

    NSMutableDictionary *imgDic2 = [NSMutableDictionary dictionaryWithCapacity:2];
    [imgDic2 setObject:[UIImage imageNamed:@"find_G"] forKey:@"Default"];
    [imgDic2 setObject:[UIImage imageNamed:@"find"] forKey:@"Seleted"];

    NSMutableDictionary *imgDic3 = [NSMutableDictionary dictionaryWithCapacity:2];
    [imgDic3 setObject:[UIImage imageNamed:@"add"] forKey:@"Default"];
  //  [imgDic3 setObject:[UIImage imageNamed:@""] forKey:@"Seleted"];

    NSMutableDictionary *imgDic4 = [NSMutableDictionary dictionaryWithCapacity:2];
    [imgDic4 setObject:[UIImage imageNamed:@"bub_G"] forKey:@"Default"];
    [imgDic4 setObject:[UIImage imageNamed:@"bub"] forKey:@"Seleted"];

    NSMutableDictionary *imgDic5 = [NSMutableDictionary dictionaryWithCapacity:2];
    [imgDic5 setObject:[UIImage imageNamed:@"head_G"] forKey:@"Default"];
    [imgDic5 setObject:[UIImage imageNamed:@"head"] forKey:@"Seleted"];
    
    NSArray *imgArr = [NSArray arrayWithObjects:imgDic1,imgDic2,imgDic3,imgDic4,imgDic5,nil];

    _mainTabBarController = [[YWTabBarController alloc] initWithViewControllers:controllerArr imageArray:imgArr];
    _mainTabBarController.delegate = self;
    
    [self.view addSubview:_mainTabBarController.view];
    
    [self stopSystemPopGestureRecognizer];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    //[self initNavigationBar];
    
    //去掉导航栏下的下划线
    [self.navigationController.navigationBar hideNavigationBarBottomLine];
}




#pragma mark 禁止pop手势
- (void)stopSystemPopGestureRecognizer {
    self.fd_interactivePopDisabled = YES;
}

- (BOOL)tabBarController:(YWTabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController {
    return YES;
}

- (void)tabBarController:(YWTabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController {
}

- (void)didSelectedViewController:(UIViewController *)viewController AtIndex:(NSInteger)index {
    if (index == 2) {
        
        [self performSegueWithIdentifier:@"announce" sender:self];

    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
