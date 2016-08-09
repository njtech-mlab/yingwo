//
//  YWQiNiuUploadHelper.m
//  yingwo
//
//  Created by apple on 16/8/6.
//  Copyright © 2016年 wangxiaofa. All rights reserved.
//

#import "YWQiNiuUploadTool.h"

@implementation YWQiNiuUploadTool

+ (void) getQiNiuUploadToken:(void (^)(NSString *token))token {
    
    NSString *fullUrl     = [BASE_URL stringByAppendingString:QINIU_TOKEN_URL];
    YWHTTPManager *manger = [YWHTTPManager manager];
    
    [manger POST:fullUrl parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary *tokenDic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
        token(tokenDic[@"info"]);
        NSLog(@"tokenDic:%@",tokenDic);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"token 获取失败");
    }];
}

+ (void)uploadImages:(NSArray *)imageArr
            progress:(void (^)(CGFloat))progress
             success:(void (^)(NSArray *))success
             failure:(void (^)())failure {
    
    NSMutableArray *urlArr          = [[NSMutableArray alloc] init];
    __block CGFloat totalProgress   = 1.0;
    __block CGFloat partProgress    = 1.0f / [imageArr count];
    __block NSUInteger currentIndex = 0;

    
    //weakself 避免循环引用，是程序崩溃
    YWQiNiuUploadHelper *uploadHelper             = [YWQiNiuUploadHelper shareInstance];
    __weak typeof (YWQiNiuUploadHelper) *weakself = uploadHelper;

    //匿名block实现，这里通过block回调实现循环调用
    weakself.singleSuccessBlock = ^(NSString *url) {
        [urlArr addObject:url];
        totalProgress += partProgress;
        progress(totalProgress);
        currentIndex ++;
        if (urlArr.count == imageArr.count) {
            success([urlArr copy]);
            return ;
        }else {
            [YWQiNiuUploadTool uploadImage:imageArr[currentIndex] progress:nil success:weakself.singleSuccessBlock failure:weakself.singleFailureBlock];
        }
    };
    
    [YWQiNiuUploadTool uploadImage:imageArr[0] progress:nil success:weakself.singleSuccessBlock failure:weakself.singleFailureBlock];

}

+ (void)uploadImage:(UIImage *)image
           progress:(__autoreleasing QNUpProgressHandler *)progress
            success:(void (^)(NSString *))success
            failure:(void (^)())failure {
    
    [YWQiNiuUploadTool getQiNiuUploadToken:^(NSString *token) {
        
        QNUploadManager *upManager = [[QNUploadManager alloc] init];
        NSData *imageData          = UIImageJPEGRepresentation(image, 0.01);

        [upManager putData:imageData key:nil token:token complete:^(QNResponseInfo *info, NSString *key, NSDictionary *resp) {
            
            if (info.statusCode == SUCCESS_STATUS) {
                
                NSString *url = [NSString stringWithFormat:@"%@/%@",QINIU_BASE_URL,resp[@"key"]];
                //成功后调用singleSuccessBlock（匿名block实现）
                NSLog(@"imageUrl:%@",url);
                success(url);
                
            }else {
                NSLog(@"图片上传失败");
                failure();
            }
            
        } option:nil];
        
    }];
}






















@end
