//
//  NSString+Clean.m
//  yingwo
//
//  Created by apple on 16/8/8.
//  Copyright © 2016年 wangxiaofa. All rights reserved.
//

#import "NSString+Url.h"

@implementation NSString (Url)

+ (NSString *)replaceIllegalStringForUrl:(NSString *)urlString {
    
    urlString = [urlString stringByReplacingOccurrencesOfString:@"[" withString:@""];
    urlString = [urlString stringByReplacingOccurrencesOfString:@"]" withString:@""];
    urlString = [urlString stringByReplacingOccurrencesOfString:@"\"" withString:@""];
    urlString = [urlString stringByReplacingOccurrencesOfString:@"\"" withString:@""];
    urlString = [urlString stringByReplacingOccurrencesOfString:@"\\" withString:@""];
    urlString = [urlString stringByReplacingOccurrencesOfString:@"," withString:@""];

    return urlString;
}

+ (NSMutableArray *)separateImageViewURLString:(NSString *)urlString {
    
    NSMutableArray *newImageUrl = [[NSMutableArray alloc] init];
    NSArray *imageUrlArr        = [urlString componentsSeparatedByString:@","];

    for (NSString *url in imageUrlArr) {
        
        NSArray *urlArr                  = [url componentsSeparatedByString:@"&amp;"];
        if (urlArr.count == 1) {
            return nil;
        }
        ImageViewEntity *imageViewEntity = [[ImageViewEntity alloc] init];
        imageViewEntity.imageName        = [urlArr objectAtIndex:0];
        imageViewEntity.width            = [[urlArr objectAtIndex:1] floatValue];
        imageViewEntity.height           = [[urlArr objectAtIndex:2] floatValue];

        [newImageUrl addObject:imageViewEntity];
    }
    return newImageUrl;
}

@end
