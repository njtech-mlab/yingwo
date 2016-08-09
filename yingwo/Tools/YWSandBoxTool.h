//
//  YWSandBoxTool.h
//  AvatarPhoto
//
//  Created by apple on 16/7/16.
//  Copyright © 2016年 chenyufengweb. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface YWSandBoxTool : NSObject

+ (NSString *)homePath;
+ (NSString *)docPath;
+ (NSString *)libCachePath;
+ (NSString *)tempPath;

//头像沙盒存储
+ (void)saveHeadPortraitIntoCache:(UIImage *)headPortrait;

+ (NSString *)getHeadPortraitPathFromCache;

@end
