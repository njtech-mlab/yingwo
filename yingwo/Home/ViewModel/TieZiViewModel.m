//
//  ViewModel.m
//  yingwo
//
//  Created by apple on 16/8/1.
//  Copyright © 2016年 wangxiaofa. All rights reserved.
//

#import "TieZiViewModel.h"
#import "YWHomeTableViewCellNoImage.h"
#import "YWHomeTableViewCellOneImage.h"
#import "YWHomeTableViewCellTwoImage.h"
#import "YWHomeTableViewCellThreeImage.h"
#import "YWHomeTableViewCellFourImage.h"
#import "YWHomeTableViewCellSixImage.h"
#import "YWHomeTableViewCellNineImage.h"
#import "YWHomeTableViewCellMoreNineImage.h"

@implementation TieZiViewModel

- (instancetype)init {
    self = [super init];
    if (self) {
        
        [self setupRACComand];
        
    }
    return self;
}

- (void)setupRACComand {
    
    @weakify(self);
    _fecthTieZiEntityCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            
            @strongify(self);
            NSInteger model = [(NSNumber *)input integerValue];
            
            if (model == AllThingModel) {
                
                [self requesAllThingsWithUrl:TIEZI_URL
                                  paramaters:nil
                                     success:^(NSArray *tieZi) {
                    
                    [subscriber sendNext:tieZi];
                    [subscriber sendCompleted];
                    
                } error:^(NSURLSessionDataTask *task, NSError *error) {
                    [subscriber sendError:error];
                }];
                
            }else if (model == FreshThingModel) {
                
                NSDictionary *paramaters = @{@"cat_id":@0};
                
                [self requestFreshThingWithUrl:TIEZI_URL
                                    paramaters:paramaters
                                       success:^(NSArray *tieZi) {
                   
                    [subscriber sendNext:tieZi];
                    [subscriber sendCompleted];
                    
                } error:^(NSURLSessionDataTask *task, NSError *error) {
                    
                    [subscriber sendError:error];

                }];
                
            }else if (model == ConcernedTopicModel) {
                
            }else if (model == FriendActivityModel) {
                
            }
            
            return nil;
        }];
    }];
    
}

- (void)setupModelOfCell:(YWHomeTableViewCellBase *)cell model:(TieZi *)model {
    
    //cell.model = model;
    cell.contentText.text         = model.content;
    cell.bottemView.nickname.text = model.nickname;
    NSString *dataString          = [NSString stringWithFormat:@"%d",model.create_time];
    cell.bottemView.time.text     = [NSDate getDateString:dataString];
    
    if (model.imageUrlArr.count > 0) {
        
        for (int i = 0; i < model.imageUrlArr.count; i ++) {
            
            NSString *partUrl = [model.imageUrlArr objectAtIndex:i];
            
            [self requestImageForCell:cell WithUrl:partUrl withModel:model imageViewTag:i+1];
        }
        
        
    }
    
}

- (void)requestImageForCell:(YWHomeTableViewCellBase *)cell WithUrl:(NSString *)partUrl withModel:(TieZi *)model imageViewTag:(NSInteger)tag{
    
    int imageWidth;
    
    //这里算出的宽度值要乘以2变成像素值
    if (tag == 1) {
        imageWidth = (SCREEN_WIDTH - 10*2 - 5 *2)*2;
    }else if (tag == 2 || tag == 4) {
        imageWidth = (SCREEN_WIDTH - 10*2 - 5 *2 - 5 * 1)/2*2;
    }else if(tag > 4) {
        imageWidth = (SCREEN_WIDTH - 10*2 - 5 *2 - 5 * 2)/3*2;
    }
    //图片模式，这里请求的是正方形图片
    NSString *imageMode    = [NSString stringWithFormat:QINIU_SQUARE_IMAGE_MODEL,imageWidth];
    NSString *fullurl      = [partUrl stringByAppendingString:imageMode];
    NSURL *imageUrl        = [NSURL URLWithString:fullurl];
    
    UIImageView *imageView = [cell.middleView viewWithTag:tag];
    
    [imageView sd_setImageWithURL:imageUrl placeholderImage:[UIImage imageNamed:@"ying"]];
    
}

- (NSString *)idForRowByModel:(TieZi *)model {
    
    //不能用model.imageUrlArr.count 返回的是<nil>,系统默认为1😭
    if (model.imageUrlArr == nil) {
        return @"noImageCell";
    }else if (model.imageUrlArr.count == 1) {
        return @"oneImageCell";
    }else if (model.imageUrlArr.count == 2) {
        return @"twoImageCell";
    }else if (model.imageUrlArr.count == 3) {
        return @"threeImageCell";
    }else if (model.imageUrlArr.count == 4) {
        return @"fourImageCell";
    }else if (model.imageUrlArr.count <= 6) {
        return @"sixImageCell";
    }else if (model.imageUrlArr.count <= 9) {
        return @"nineImageCell";
    }else if (model.imageUrlArr.count > 9) {
        return @"moreNineImageCell";
    }
    
    return @"noImageCell";

}

- (void)requesAllThingsWithUrl:(NSString *)url
                    paramaters:(id)paramaters
                       success:(void (^)(NSArray *))success
                         error:(void (^)(NSURLSessionDataTask *, NSError *))failure {
    
    NSString *fullUrl      = [BASE_URL stringByAppendingString:url];
    YWHTTPManager *manager =[YWHTTPManager manager];
    
    [manager POST:fullUrl
       parameters:paramaters
         progress:nil
          success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
              
              NSDictionary *content = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
              
              TieZiResult *tieZiResult = [TieZiResult mj_objectWithKeyValues:content];
              NSArray *tieZiArr        = [TieZi mj_objectArrayWithKeyValuesArray:tieZiResult.info];
              
              success(tieZiArr);
              TieZi *tieZi = tieZiArr[0];
              //  NSLog(@"content:%@",content);
              NSLog(@"tieZi.content:%@",tieZi.content);
              
          } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
              
              NSLog(@"error:%@",error);
              failure(task,error);
              
          }];
}

- (void)requestTieZiWithUrl:(NSString *)url
                 paramaters:(id)paramaters
                    success:(void (^)(NSArray *))success
                      error:(void (^)(NSURLSessionDataTask *, NSError *))failure {
    
}

- (void)requestFreshThingWithUrl:(NSString *)url
                 paramaters:(id)paramaters
                    success:(void (^)(NSArray *tieZi))success
                      error:(void (^)(NSURLSessionDataTask *task,NSError *error))failure {
    
    NSString *fullUrl      = [BASE_URL stringByAppendingString:url];
    YWHTTPManager *manager =[YWHTTPManager manager];
    
    [manager POST:fullUrl
       parameters:paramaters
         progress:nil
          success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
              
              NSDictionary *content = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
              
              TieZiResult *tieZiResult = [TieZiResult mj_objectWithKeyValues:content];
              NSArray *tieZiArr        = [TieZi mj_objectArrayWithKeyValuesArray:tieZiResult.info];
              
              //需要将返回的url字符串，转化为imageUrl数组
              [self changeImageUrlModelFor:tieZiArr];
              
              success(tieZiArr);
              
            //  NSLog(@"content:%@",content);
            //  NSLog(@"tieZiArr:%@",tieZiResult.info);
              
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"error:%@",error);
        failure(task,error);

    }];
}

/**
 *  过滤image的url数组
 *  服务器放回的URL数组不能直接使用，需要过滤
 *  @param tieZiArr image url数组
 */
- (void)changeImageUrlModelFor:(NSArray *)tieZiArr {
    
    for (TieZi *tie in tieZiArr) {
        
        if ([tie.img containsString:@","]) {
            
            NSArray *imageUrls = [tie.img componentsSeparatedByString:@","];
            tie.imageUrlArr    = [self changeImageUrlsFor:imageUrls];
            
        }else if( [tie.img containsString:@"http"]){
            
            NSString *urlString  = [NSString replaceIllegalStringForUrl:tie.img];
            NSArray *imageUrlArr = [NSArray arrayWithObject:urlString];
            tie.imageUrlArr      = imageUrlArr;
            
        }
    }

}

/**
 *  过滤image url
 *
 *  @param imageUrls url数组
 *
 *  @return 返回过滤后的数组
 */
- (NSArray *)changeImageUrlsFor:(NSArray *)imageUrls {
    
    NSMutableArray *urlsArr = [[NSMutableArray alloc] init];
    
    for (NSString *urlString in imageUrls) {
        
       NSString *url = [NSString replaceIllegalStringForUrl:urlString];
        
        [urlsArr addObject:url];
    }
    return urlsArr;
}

- (void)downloadCompletedImageViewByUrls:(NSArray *)imageUrls
                                progress:(void (^)(CGFloat))progress
                                 success:(void (^)(NSMutableArray *imageArr))imageArr
                                 failure:(void (^)(NSString *error))failure{
    
    
   NSString *imageName    = [imageUrls objectAtIndex:0];
   imageName              = [imageName lastPathComponent];
   Boolean hasExsitImages = [YWSandBoxTool isExistImageByName:imageName];
    //先从沙盒中找图片
    if (hasExsitImages) {
        imageArr([self getImagesFromCacheByUrlsArr:imageUrls]);
        progress(1);
    }
    else
    {
        [YWAvatarBrowser downloadImagesWithUrls:imageUrls
                                       progress:^(CGFloat progressNum) {
                                           progress(progressNum);
                                       }
                                        success:^(NSMutableArray *success) {
                                            
                                            imageArr(success);
                                            //  [YWAvatarBrowser showImage:avatarImageView WithImageViewArr:success];
                                            
                                        } failure:^(NSString *error) {
                                            failure(error);
                                            NSLog(@"failure:%@",error);
                                        }];
    }

}

/**
 *  从缓存中读取图片
 *
 *  @param urlArr 图片url数组
 *
 *  @return 返回保存UIImage的数组
 */
- (NSMutableArray *)getImagesFromCacheByUrlsArr:(NSArray *)urlArr {
    
    NSMutableArray *cacheimageArr = [NSMutableArray arrayWithCapacity:urlArr.count];
    
    for (NSString *url in urlArr) {
        
        NSString *name    = [url lastPathComponent];
        NSData *imageData = [YWSandBoxTool loadImageDataByImageName:name];
        UIImage *image    = [UIImage imageWithData:imageData];

        [cacheimageArr addObject:image];
    }
    
    return cacheimageArr;
}

@end
