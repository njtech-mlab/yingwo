//
//  DetailViewModel.m
//  yingwo
//
//  Created by apple on 16/8/7.
//  Copyright © 2016年 wangxiaofa. All rights reserved.
//

#import "DetailViewModel.h"
#import "YWDateTools.h"

@implementation DetailViewModel

- (void)setupModelOfCell:(YWDetailBaseTableViewCell *)cell model:(TieZi *)model {
    
    cell.topView.label.label.text              = @"新鲜事";
    cell.masterView.identifierLabel.label.text = @"楼主";
    cell.masterView.floorLabel.text            = @"1楼";
    cell.contentLabel.text                     = model.content;
    cell.masterView.nicnameLabel.text          = model.nickname;
    NSString *dataString          = [NSString stringWithFormat:@"%d",model.create_time];
    cell.masterView.timeLabel.text =[YWDateTools getDateString:dataString];
    
 //   NSLog(@"model:%@",model.img);

    if (model.img.length > 10) {
        
        NSMutableArray *photoArr = [[NSMutableArray alloc] init];

        for (int i = 0; i < self.imageUrlArr.count; i ++) {
            
            NSString *partUrl = [self.imageUrlArr objectAtIndex:i];
            [self requestImageWithUrl:partUrl ForCell:cell addToArr:photoArr];
            
        }
        
        if (photoArr.count > 0) {
            
            [cell addImageViewByImageArr:photoArr];
            
        }
    }

}

/**
 *  限宽图片
 *
 *  @param urlArr 图片链接
 */
- (void)requestImageWithUrl:(NSString *)partUrl ForCell:(YWDetailBaseTableViewCell *)cell addToArr:(NSMutableArray *)photoArr{
    
        partUrl = [NSString replaceIllegalStringForUrl:partUrl];
    
        UIImageView *imageView = [[UIImageView alloc] init];

        int imageWidth         = (SCREEN_WIDTH-80) * 2;
        NSString *imageMode    = [NSString stringWithFormat:QINIU_PROPORTION_IMAGE_MODEL,imageWidth];
        NSString *fullUrl      = [partUrl stringByAppendingString:imageMode];
        NSURL *imageUrl        = [NSURL URLWithString:fullUrl];
    
        [imageView sd_setImageWithURL:imageUrl placeholderImage:[UIImage imageNamed:@"pic"]];
        
        [photoArr addObject:imageView];
        
}

- (NSString *)idForRowByIndexPath:(NSIndexPath *)indexPath model:(TieZi *)model{
    
    if (indexPath.row == 0) {
        
        self.imageUrlArr = [model.img componentsSeparatedByString:@","];

        return @"detailCell";
    }
    return nil;
}

- (void)requestImageWithUrl:(NSString *)url {
  //  NSURL
}

@end
