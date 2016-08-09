//
//  YWQiNiuUploadHelper.h
//  yingwo
//
//  Created by apple on 16/8/6.
//  Copyright © 2016年 wangxiaofa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YWQiNiuUploadHelper.h"

@interface YWQiNiuUploadTool : NSObject

/**
 *  获取七牛的token
 *
 *  @param token 回调token
 */
+ (void) getQiNiuUploadToken:(void (^)(NSString *token))token;

/**
 *  上传一张图片
 *
 *  @param image    tupian
 *  @param progress 进度
 *  @param success  成功
 *  @param failure  失败
 */
+ (void) uploadImage:(UIImage *)image
            progress:(QNUpProgressHandler *)progress
             success:(void(^)(NSString *url))success
             failure:(void (^)())failure;

/**
 *  上传多张图片
 *
 *  @param imageArr 图片数组
 *  @param progress 进度
 *  @param success  成功
 *  @param failure  失败
 */
+ (void) uploadImages:(NSArray *)imageArr
            progress:(void (^)(CGFloat))progress
             success:(void(^)(NSArray *arr))success
             failure:(void (^)())failure;


@end
