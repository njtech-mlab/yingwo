//
//  ViewModel.m
//  yingwo
//
//  Created by apple on 16/8/1.
//  Copyright © 2016年 wangxiaofa. All rights reserved.
//

#import "TieZiViewModel.h"

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
    cell.bottemView.time.text     = [YWDateTools getDateString:dataString];
    
    if (model.img.length > 10) {
        
        NSMutableArray *photoArr = [[NSMutableArray alloc] init];
        
        for (int i = 0; i < self.imageUrlArr.count; i ++) {
            
            NSString *partUrl = [self.imageUrlArr objectAtIndex:i];
            [self requestImageWithUrl:partUrl ForCell:cell addToArr:photoArr];

        }
        
        if (photoArr.count > 0) {
            
            [cell addImageViewByImageArr:photoArr];
            //   NSLog(@"photo:%@",photoArr);
        }

    }
    
}

- (void)requestImageWithUrl:(NSString *)partUrl ForCell:(YWHomeTableViewCellBase *)cell addToArr:(NSMutableArray *)photoArr{

    partUrl = [NSString replaceIllegalStringForUrl:partUrl];
    
    int imageWidth;

    if (self.imageUrlArr.count == 1) {
        imageWidth = (SCREEN_WIDTH - 10*2 - 5 *2);
    }else if (self.imageUrlArr.count == 2 || self.imageUrlArr.count == 4) {
        imageWidth = (SCREEN_WIDTH - 10*2 - 5 *2 - 5 * 1)/2;
    }else if(self.imageUrlArr.count > 4) {
        imageWidth = (SCREEN_WIDTH - 10*2 - 5 *2 - 5 * 2)/3;
    }
    
    NSString *imageMode    = [NSString stringWithFormat:QINIU_SQUARE_IMAGE_MODEL,imageWidth];
    NSString *fullurl      = [partUrl stringByAppendingString:imageMode];
    NSURL *imageUrl        = [NSURL URLWithString:fullurl];

    UIImageView *imageView = [[UIImageView alloc] init];

    [imageView sd_setImageWithURL:imageUrl];
    
    [photoArr addObject:imageView];
}

- (NSString *)idForRowByModel:(TieZi *)model {
    
    //两张图片情况
    if ([model.img containsString:@","]) {
     
        self.imageUrlArr    = [model.img componentsSeparatedByString:@","];

        if (self.imageUrlArr.count == 1) {
            return @"oneImageCell";
        }else if (self.imageUrlArr.count == 2) {
            return @"twoImageCell";
        }else if (self.imageUrlArr.count == 3) {
            return @"threeImageCell";
        }else if (self.imageUrlArr.count == 4) {
            return @"fourImageCell";
        }else if (self.imageUrlArr.count <= 6) {
            return @"sixImageCell";
        }else if (self.imageUrlArr.count <= 9) {
            return @"nineImageCell";
        }else if (self.imageUrlArr.count > 9) {
            return @"moreNineImageCell";
        }
    //一张图片情况
    }else if ([model.img containsString:@"http"]) {
        
        NSString *imageUrl = [NSString replaceIllegalStringForUrl:model.img];
        self.imageUrlArr   = [NSArray arrayWithObject:imageUrl];

        return @"oneImageCell";
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
             
              success(tieZiArr);
              
            //  NSLog(@"content:%@",content);
            //  NSLog(@"tieZiArr:%@",tieZiResult.info);
              
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"error:%@",error);
        failure(task,error);

    }];
}

@end
