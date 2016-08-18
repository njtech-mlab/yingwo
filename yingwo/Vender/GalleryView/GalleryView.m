//  GalleryViewDemo
//
//  Created by line0 on 13-5-27.
//  Copyright (c) 2013年 makeLaugh. All rights reserved.
//

#import "GalleryView.h"

@interface GalleryView ()

@property (nonatomic, strong) UIScrollView    *scrollView;
@property (assign, nonatomic) NSInteger       currentPage;


@end

@implementation GalleryView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self defaultInit];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self)
    {
        [self defaultInit];
    }
    return self;
}

- (void)defaultInit
{
    self.scrollView                                = [[UIScrollView alloc] initWithFrame:self.bounds];
    self.scrollView.delegate                       = self;
    self.scrollView.pagingEnabled                  = YES;
    self.scrollView.userInteractionEnabled         = YES;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.showsVerticalScrollIndicator   = NO;
    [self addSubview:self.scrollView];
    
    self.maximumZoomScale = 3;
    self.minimumZoomScale = 1;
    
    [self addSubview:self.pageLabel];
}

- (UILabel *)pageLabel {
    if (_pageLabel == nil) {
        _pageLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
        _pageLabel.center = CGPointMake(self.center.x, 40);
        _pageLabel.textAlignment = NSTextAlignmentCenter;
        _pageLabel.textColor = [UIColor whiteColor];
    }
    return _pageLabel;
}

/*
- (void)setImages:(NSArray *)images
{
    _images = images;
    
    [self.scrollView setContentSize:CGSizeMake(self.scrollView.bounds.size.width * images.count, self.scrollView.bounds.size.height)];

    for (int i = 0; i < images.count; i++)
    {
        CGRect rect = CGRectMake(self.scrollView.frame.size.width * i, 0, self.scrollView.frame.size.width, self.scrollView.frame.size.height);
        ZoomScrollView *zoomScrollView = [[ZoomScrollView alloc] initWithFrame:rect andImage:[images objectAtIndex:i] atIndex:i];
        [self.scrollView addSubview:zoomScrollView];
        
        UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTap:)];
        [singleTap setNumberOfTouchesRequired:1];
        [singleTap setNumberOfTapsRequired:1];
        [zoomScrollView addGestureRecognizer:singleTap];
        
        [singleTap requireGestureRecognizerToFail:zoomScrollView.doubleTapGesture];
    }
}
*/


- (void)setMaximumZoomScale:(CGFloat)maximumZoomScale
{
    _maximumZoomScale = maximumZoomScale;
    
    for (int i = 0; i < self.images.count; i++)
    {
        ZoomScrollView *zoomScrollView = [[ZoomScrollView alloc]init];
        [zoomScrollView setMaximumZoomScale:maximumZoomScale];
    }
}

- (void)setMinimumZoomScale:(CGFloat)minimumZoomScale
{
    _minimumZoomScale = minimumZoomScale;
    
    for (int i = 0; i < self.images.count; i++)
    {
        ZoomScrollView *zoomScrollView = [[ZoomScrollView alloc]init];
        [zoomScrollView setMinimumZoomScale:minimumZoomScale];
    }
}

- (void)setImages:(NSArray *)imageViews showAtIndex:(NSInteger)index{
    
    _imageViews = imageViews;
    
    [self.scrollView setContentSize:CGSizeMake(self.scrollView.bounds.size.width * imageViews.count, self.scrollView.bounds.size.height)];
    self.scrollView.contentOffset = CGPointMake(self.scrollView.frame.size.width*index, 0);
    
    for (int i = 0; i < imageViews.count; i++)
    {
        CGRect rect = CGRectMake(self.scrollView.frame.size.width * i, 0, self.scrollView.frame.size.width, self.scrollView.frame.size.height);
        ZoomScrollView *zoomScrollView = [[ZoomScrollView alloc] initWithFrame:rect andImageView:[imageViews objectAtIndex:i] atIndex:i];
        
        [self.scrollView addSubview:zoomScrollView];
        
        UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTap:)];
        [singleTap setNumberOfTouchesRequired:1];
        [singleTap setNumberOfTapsRequired:1];
        [zoomScrollView addGestureRecognizer:singleTap];
        
        [singleTap requireGestureRecognizerToFail:zoomScrollView.doubleTapGesture];
    }
    
    self.pageLabel.text = [NSString stringWithFormat:@"%lu/%lu",index+1,self.imageViews.count];
    //currentPage 从0开始计算
    self.currentPage = index;
}

- (void)removeImageView{
    
    //获取被放大的小图
    UIImageView *currentSmallView      = [self.imageViews objectAtIndex:self.currentPage];
    //获取放大后的图
    UIImageView *currentBigImageView = [self viewWithTag:self.currentPage+1];
    //先去除背景色
    self.backgroundColor = [UIColor clearColor];
    
    [UIView animateWithDuration:0.3 animations:^{
        currentBigImageView.frame = currentSmallView.frame;
    }completion:^(BOOL finished) {
        [self removeFromSuperview];
        [self.delegate galleryView:self removePageAtIndex:self.currentPage];
    }];
}


#pragma mark ScrollView Delegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    CGFloat   pageWidth   = scrollView.frame.size.width;
    NSInteger currentPage = floor((scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    if (currentPage != self.currentPage)
    {
        for (UIView *view in scrollView.subviews)
        {
            if ([view isKindOfClass:[ZoomScrollView class]])
            {
                ZoomScrollView *zoomScrollView = (ZoomScrollView *)view;
                if (zoomScrollView.zoomScale != 1)
                {
                    [zoomScrollView setZoomScale:1 animated:YES];
                }
            }
        }
    }
        self.currentPage = currentPage;
        
        if ([self.delegate respondsToSelector:@selector(galleryView:didShowPageAtIndex:)])
        {
            [self.delegate galleryView:self didShowPageAtIndex:currentPage];
        }
    
    
    self.pageLabel.text = [NSString stringWithFormat:@"%lu/%lu",currentPage+1,self.imageViews.count];

}


#pragma mark - Tap

- (void)singleTap:(UITapGestureRecognizer *)tap
{
    if (tap.numberOfTapsRequired == 1)
    {
        ZoomScrollView *zoomScrollView = (ZoomScrollView *)tap.view;
        
        if ([self.delegate respondsToSelector:@selector(galleryView:didSelectPageAtIndex:)])
        {
            [self.delegate galleryView:self didSelectPageAtIndex:zoomScrollView.index];
        }
    }
}



@end
