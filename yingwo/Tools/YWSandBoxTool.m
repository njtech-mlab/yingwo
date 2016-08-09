//
//  YWSandBoxTool.m
//  AvatarPhoto
//
//  Created by apple on 16/7/16.
//  Copyright © 2016年 chenyufengweb. All rights reserved.
//

#import "YWSandBoxTool.h"

static YWSandBoxTool *instance = nil;

@implementation YWSandBoxTool

//多线程单例

+ (instancetype)shareInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[super allocWithZone:NULL]init];
    });
    return instance;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    return [YWSandBoxTool shareInstance];
}

+ (id)copyWithZone:(struct _NSZone *)zone {
    return [YWSandBoxTool shareInstance];
}

//沙盒各路径

+ (NSString *)homePath {
    
    NSLog(@"home:%@",NSHomeDirectory());
    return NSHomeDirectory();
}

+ (NSString *)docPath {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    return [paths objectAtIndex:0];
}

+ (NSString *)libCachePath {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    return [paths objectAtIndex:0];
}

+ (NSString *)tempPath {
    return [NSHomeDirectory() stringByAppendingString:@"/tmp"];
}

+ (void)saveHeadPortraitIntoCache:(UIImage *)headPortrait {
    
    //先创建文件夹
    NSFileManager *fileManager          = [NSFileManager defaultManager];
    NSString *headPortraitDirectoryPath = [[YWSandBoxTool libCachePath] stringByAppendingString:@"/head"];
    Boolean isExist = [fileManager fileExistsAtPath:headPortraitDirectoryPath];
    
    if (!isExist) {
        
        [fileManager createDirectoryAtPath:headPortraitDirectoryPath withIntermediateDirectories:YES attributes:nil error:nil];

    }

    //再存储头像
    NSString *imagePath                 = [[YWSandBoxTool libCachePath] stringByAppendingString:@"/head/head_portrait.png"];
    Boolean isSave                      = [UIImagePNGRepresentation(headPortrait) writeToFile:imagePath atomically:YES];
    
    if (isSave) {
        
        NSLog(@"头像保存成功");
        
    }else{
        
        NSLog(@"头像保存失败");
        
    }
}

+ (NSString *)getHeadPortraitPathFromCache {
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *headPortraitPath = [[YWSandBoxTool libCachePath] stringByAppendingString:@"/head/head_portrait.png"];
    Boolean isExist            = [fileManager fileExistsAtPath:headPortraitPath];
 
    if (isExist) {
        
        return headPortraitPath;
        
    }else {
        
        NSLog(@"头像不存在");
        
    }
    
    return nil;
}

@end
