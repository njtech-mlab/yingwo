//
//  DetailViewModel.m
//  yingwo
//
//  Created by apple on 16/8/7.
//  Copyright © 2016年 wangxiaofa. All rights reserved.
//

#import "DetailViewModel.h"

@implementation DetailViewModel

- (NSString *)idForRowByIndexPath:(NSIndexPath *)indexPath model:(TieZi *)model{
    
    if (indexPath.row == 0) {
        
        self.imageUrlArr = [model.img componentsSeparatedByString:@","];
        
        return @"detailCell";
    }
    return nil;
}

- (void)setupModelOfCell:(YWDetailBaseTableViewCell *)cell model:(TieZi *)model {
    
    cell.topView.label.label.text              = @"新鲜事";
    cell.masterView.identifierLabel.label.text = @"楼主";
    cell.masterView.floorLabel.text            = @"1楼";
    cell.contentLabel.text                     = model.content;
    cell.masterView.nicnameLabel.text          = model.nickname;
    NSString *dataString          = [NSString stringWithFormat:@"%d",model.create_time];
    cell.masterView.timeLabel.text =[NSDate getDateString:dataString];
    
    if (model.imageUrlArr.count > 0) {
        [self requestImageWithUrls:model.imageUrlArr ForCell:cell];
    }

}

/**
 *  从缓存中取
 *
 *  @param name 名字图片
 *
 *  @return 返回UIImage
 */
- (UIImage *)loadImageInCaheByName:(NSString *)name {
    Boolean isExist = [YWSandBoxTool isExistImageByName:name];
    if (isExist) {
        
        UIImage *image = [UIImage imageWithData:[YWSandBoxTool loadImageDataByImageName:name]];
        return image;
        
    }
    return nil;
}


- (void)requestImageWithUrls:(NSArray *)urls ForCell:(YWDetailBaseTableViewCell *)cell {
    
    [self downloadCompletedImageViewByUrls:urls
                                  progress:^(CGFloat progress) {
                                      
                                  }
                                   success:^(NSMutableArray *imageArr) {
                                       
                                       [cell addImageViewByImageArr:imageArr];

//                                       NSString *imageName    = [urls objectAtIndex:0];
//                                       imageName              = [imageName lastPathComponent];
//                                       Boolean hasExsitImages = [YWSandBoxTool isExistImageByName:imageName];
//                                       //先从沙盒中找图片
//                                       if (hasExsitImages) {
//                                           [cell addImageViewByImageArr:[self getImagesFromCacheByUrlsArr:urls]];
//                                       }

                                       
    } failure:^(NSString *error) {
        
    }];
    
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
     //   progress(1);
    }
    else
    {
        [YWAvatarBrowser downloadImagesWithUrls:imageUrls
                                       progress:^(CGFloat progressNum) {
                                           //这个不能写
                                           progress(progressNum);
                                       }
                                        success:^(NSMutableArray *success) {
                                            
                                            imageArr(success);
                                            
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
