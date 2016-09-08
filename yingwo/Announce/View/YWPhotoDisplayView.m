//
//  YWPhotoDisplayView.m
//  yingwo
//
//  Created by apple on 16/9/3.
//  Copyright © 2016年 wangxiaofa. All rights reserved.
//

#import "YWPhotoDisplayView.h"
#import "PhotoUnitView.h"

@implementation YWPhotoDisplayView

- (instancetype)init {
    if (self = [super init]) {
        
        self.showsVerticalScrollIndicator   = NO;
        self.showsHorizontalScrollIndicator = NO;
        [self addSubview:self.addMorePhotosBtn];
    }
    return self;
}

/**
 *  将photo放入数组中
 */
- (void)putPhotosToImagesArr {
    
    for (int i = 0; i < self.photoImageViewsArr.count; i++) {
        
        PhotoUnitView *photo = [self.photoImageViewsArr objectAtIndex:i];
        UIImage *image       = photo.photoImageView.image;
        
        [self.photoImageArr addObject:image];
    }
    
}

- (void)addPhotoInScrollViewWithImage:(UIImage *)photoImage andImageCount:(NSInteger)count {
    
    PhotoUnitView *photo    = [[PhotoUnitView alloc] initWithImage:photoImage];
    photo.deleteViewBtn.tag = _photoImagesCount;
    
    [photo.deleteViewBtn addTarget:self action:@selector(deletePhotoImageView:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.photoImageViewsArr addObject:photo];
    
    [self setPhotoImageViewLayout:photo byPhotoImagesCount:count];
 
}

/**
 *  将照片显示在UIScrollView上
 *
 *  @param photo            图片
 *  @param photoImagesCount 图片数量
 */
- (void)setPhotoImageViewLayout:(PhotoUnitView *)photo byPhotoImagesCount:(NSInteger)photoImagesCount {
    
    [self addSubview:photo];
    [photo mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(photoImagesCount * self.photoWidth).priorityLow();
        make.width.height.equalTo(@(self.photoWidth));
        make.centerY.equalTo(self.mas_centerY);

    }];
    
    if (_photoImagesCount != 0) {
        
        [self.addMorePhotosBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(photo.mas_right);
            make.centerY.equalTo(photo.mas_centerY);
        }];
        
    }

    if (_photoImagesCount > 4) {
        
        //photosBgSrcollView 滑动
        self.contentSize = CGSizeMake(SCREEN_WIDTH + (photoImagesCount-4) * 80, 100);
    
    }
    
    _photoImagesCount = photoImagesCount;
}

/**
 *  删除选中的照片
 *
 *  @param sender 删除按钮
 */
- (void)deletePhotoImageView:(UIButton *)sender {
    
    PhotoUnitView *photo = (PhotoUnitView *)sender.superview;
    [photo removeFromSuperview];
    
    NSUInteger index = [self.photoImageViewsArr indexOfObject:photo];
    
    [self.photoImageViewsArr removeObject:photo];
    
    _photoImagesCount--;
    
    [self removeAllPhotos:self.photoImageViewsArr AtIndex:index];
    
}

/**
 *  重新排列图片
 *
 *  @param photosArr 图片数组
 *  @param index     index 后的全部重新排列
 */
- (void)removeAllPhotos:(NSMutableArray *)photosArr AtIndex:(NSUInteger)index {
    
    
    
    for (NSInteger i = index; i < photosArr.count; i++) {
        PhotoUnitView *photo = [photosArr objectAtIndex:i];
        
        [photo mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@(self.photoWidth*i)).priorityLow();
        }];
        
        [UIView animateWithDuration:0.3 animations:^{
            [photo layoutIfNeeded];
        }];
    }
    
}


/**
 *  添加照片
 *
 *  @param assets     照片数组
 *  @param scrollView 滑动背景
 */
- (void)addImages:(NSArray *)assets{
    
    for (ALAsset *asset in assets) {
        
        if ([[asset valueForProperty:@"ALAssetPropertyType"] isEqual:@"ALAssetTypePhoto"]) {
            
            UIImage * photoImage    = [UIImage imageWithCGImage:asset.defaultRepresentation.fullResolutionImage];
            
            [self addPhotoInScrollViewWithImage:photoImage andImageCount:_photoImagesCount];
            
            _photoImagesCount ++;
            
        }
        else if ([[asset valueForProperty:@"ALAssetPropertyType"] isEqual:@"ALAssetTypeVideo"]){
            //  NSURL *url = asset.defaultRepresentation.url;
            //  视频不处理
        }
    }
    
}


/**
 *  继续添加图片
 *
 *  @param assets     图片数组
 *  @param scrollView 滑动背景
 */
- (void)addMoreImages:(NSArray *)assets {
    
    for (ALAsset *asset in assets) {
        
        if ([[asset valueForProperty:@"ALAssetPropertyType"] isEqual:@"ALAssetTypePhoto"]) {
            
            UIImage * photoImage    = [UIImage imageWithCGImage:asset.defaultRepresentation.fullResolutionImage];
            
            [self addPhotoInScrollViewWithImage:photoImage andImageCount:self.photoImagesCount];
            
        }
        else if ([[asset valueForProperty:@"ALAssetPropertyType"] isEqual:@"ALAssetTypeVideo"]){
            //  NSURL *url = asset.defaultRepresentation.url;
            //  视频不处理
        }
    }
    
    
    if (_photoImagesCount > 4) {
        //photosBgSrcollView 滑动
           self.contentSize = CGSizeMake(SCREEN_WIDTH + (_photoImagesCount-4) * self.photoWidth, 100);
        
    }
}

- (NSMutableArray *)photoImageViewsArr {
    if (_photoImageViewsArr == nil) {
        _photoImageViewsArr = [[NSMutableArray alloc] init];
    }
    return _photoImageViewsArr;
}

- (NSMutableArray *)photoImageArr {
    if (_photoImageArr == nil) {
        _photoImageArr = [[NSMutableArray alloc] init];
    }
    return _photoImageArr;
}

- (UIButton *)addMorePhotosBtn {
    if (_addMorePhotosBtn == nil) {
        _addMorePhotosBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_addMorePhotosBtn setBackgroundImage:[UIImage imageNamed:@"+_gray"] forState:UIControlStateNormal];

    }
    return _addMorePhotosBtn;
}




@end
