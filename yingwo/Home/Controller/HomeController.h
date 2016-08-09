//
//  HomeController.h
//  yingwo
//
//  Created by apple on 16/8/1.
//  Copyright © 2016年 wangxiaofa. All rights reserved.
//

#import "BaseViewController.h"

typedef NS_ENUM(NSInteger, ContentCategory){
    
    //不分类，所有帖子
    AllThingModel = -1,
    //新鲜事
    FreshThingModel = 0,
    //关注的话题
    ConcernedTopicModel = 1,
    //好友动态
    FriendActivityModel = 2,

};

@interface HomeController : BaseViewController

@property (nonatomic, strong) YWTabBar        *tabBar;
@property (nonatomic, assign) NSUInteger      index;
@property (nonatomic, assign) ContentCategory contentCategoryModel;

@end
