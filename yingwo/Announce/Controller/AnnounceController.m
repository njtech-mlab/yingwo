//
//  AnnounceController.m
//  yingwo
//
//  Created by apple on 16/8/2.
//  Copyright © 2016年 wangxiaofa. All rights reserved.
//

#import "AnnounceController.h"
#import "YWAnnounceTextView.h"
#import "AnnounceModel.h"
#import "YWKeyboardToolView.h"
#import "PhotoUnitView.h"

@interface AnnounceController ()<LSYAlbumCatalogDelegate>

@property (nonatomic, strong) YWAnnounceTextView *announceTextView;
@property (nonatomic, strong) UIScrollView       *photosBgSrcollView;
@property (nonatomic, strong) UIButton           *addMorePhotosBtn;
@property (nonatomic, strong) UIBarButtonItem    *leftBarItem;
@property (nonatomic, strong) UIBarButtonItem    *rightBarItem;
@property (nonatomic, strong) AnnounceModel      *viewModel;
@property (nonatomic, assign) UIImageView        *lastPhoto;
@property (nonatomic, assign) NSInteger          photoSelectKind;
@property (nonatomic, assign) NSInteger          photoImagesCount;
@property (nonatomic, strong) NSMutableArray     *photoImageViewsArr;
@property (nonatomic, strong) NSMutableArray     *photoImageArr;
@end

static int SELECT_PHOTOS   = 1;
static int ADD_MORE_PHOTOS = 2;

@implementation AnnounceController

- (YWAnnounceTextView *)announceTextView {
    if (_announceTextView == nil ) {
        _announceTextView = [[YWAnnounceTextView alloc] init];
        _announceTextView.layer.masksToBounds = YES;
        _announceTextView.layer.cornerRadius = 10;
        [_announceTextView.keyboardToolView.photo addTarget:self action:@selector(enterIntoAlbumsSelectPhotos) forControlEvents:UIControlEventTouchUpInside];
    }
    return _announceTextView;
}

- (UIBarButtonItem *)rightBarItem {
    if (_rightBarItem == nil) {
        _rightBarItem = [[UIBarButtonItem alloc ]initWithImage:[UIImage imageNamed:@"release"] style:UIBarButtonItemStylePlain target:self action:@selector(releaseContent)];
    }
    return _rightBarItem;
}

- (UIBarButtonItem *)leftBarItem {
    if (_leftBarItem == nil) {
        _leftBarItem = [[UIBarButtonItem alloc ]initWithImage:[UIImage imageNamed:@"nva_con"] style:UIBarButtonItemStylePlain target:self action:@selector(backToMainView)];
    }
    return _leftBarItem;

}

- (AnnounceModel *)viewModel {
    if (_viewModel == nil) {
        _viewModel = [[AnnounceModel alloc] init];
    }
    return _viewModel;
}

- (UIScrollView *)photosBgSrcollView {
    if (_photosBgSrcollView == nil) {
        
        _photosBgSrcollView = [[UIScrollView alloc] init];
        _photosBgSrcollView.showsVerticalScrollIndicator = NO;
        _photosBgSrcollView.showsHorizontalScrollIndicator = YES;
  //      _photosBgSrcollView.backgroundColor = [UIColor greenColor];
        
    }
    return _photosBgSrcollView;
}

- (UIButton *)addMorePhotosBtn {
    if (_addMorePhotosBtn == nil) {
        _addMorePhotosBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_addMorePhotosBtn setBackgroundImage:[UIImage imageNamed:@"+_gray"] forState:UIControlStateNormal];
        [_addMorePhotosBtn addTarget:self action:@selector(addMorePhotos) forControlEvents:UIControlEventTouchUpInside];
    }
    return _addMorePhotosBtn;
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

#pragma mark button action 

- (void)releaseContent {
    
    if (self.photoImageViewsArr.count == 0 && [self.announceTextView.text isEqualToString:@""]) {
        
    }else if (self.photoImageViewsArr.count == 0) {
        
        [self postFreshThingWithContentWithoutImages:self.announceTextView.text];
        
    }else if ([self.announceTextView.text isEqualToString:@""]) {
        
        [self putPhotosToImagesArr];
        [self postFreshThingWithImagesWithoutContent:self.photoImageArr];
        
    }else {
        
        [self putPhotosToImagesArr];
        [self postFreshThingWithImages:self.photoImageArr andContent:self.announceTextView.text];
        
    }

    
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

CGFloat delay = 1.5f;

/**
 *  只有图片发布
 *
 *  @param photoArr 图片数组
 */
- (void)postFreshThingWithImagesWithoutContent:(NSArray *)photoArr {
    
    MBProgressHUD *hud = [MBProgressHUD showProgressViewToView:self.view animated:YES];

    [YWQiNiuUploadTool uploadImages:photoArr progress:^(CGFloat progress) {
        
        hud.progress = YES;
        
    } success:^(NSArray *arr) {
        
        hud.hidden = YES;
        [MBProgressHUD showHUDToAddToView:self.view labelText:@"发布成功" animated:YES afterDelay:delay success:^{
            [self backToMainView];
        }];
    } failure:^{
        
    }];
}

/**
 *  只有文字内容
 *
 *  @param content 贴子内容
 */
- (void)postFreshThingWithContentWithoutImages:(NSString *)content {
    
    
    NSMutableDictionary *paramaters = [[NSMutableDictionary alloc] init];
    paramaters[@"user_id"]          = @123;
    paramaters[@"cat_id"]           = @0;
    paramaters[@"content"]          = content;
    
    [self.viewModel postFreshThingWithUrl:ANNOUNCE_FRESH_THING_URL paramaters:paramaters success:^(NSString *result) {
        
        [MBProgressHUD showHUDToAddToView:self.view labelText:@"发布成功" animated:YES afterDelay:delay success:^{
            [self backToMainView];
        }];
        
    } failure:^(NSError *error) {
        
    }];
    
}

/**
 *  既有图片又有内容
 *
 *  @param photoArr 图片数组
 *  @param content  贴子内容
 */
- (void)postFreshThingWithImages:(NSArray *)photoArr andContent:(NSString *)content {
    
    MBProgressHUD *hud = [MBProgressHUD showProgressViewToView:self.view animated:YES];
    
    [YWQiNiuUploadTool uploadImages:photoArr progress:^(CGFloat progress) {
        
        hud.progress = progress;
        
    } success:^(NSArray *arr) {
        
        NSMutableDictionary *paramaters = [[NSMutableDictionary alloc] init];
        
        paramaters[@"user_id"]          = @123;
        paramaters[@"cat_id"]           = @0;
        paramaters[@"content"]          = content;
        paramaters[@"img"]              = arr;
        
        [self.viewModel postFreshThingWithUrl:ANNOUNCE_FRESH_THING_URL paramaters:paramaters success:^(NSString *result) {
          
            hud.hidden = YES;
            
            [MBProgressHUD showHUDToAddToView:self.view labelText:@"发布成功" animated:YES afterDelay:delay success:^{
                
                [self backToMainView];
            }];
            
        } failure:^(NSError *error) {
            
        }];
        
    } failure:^{
        
    }];
    
}

/**
 *  进入相册
 */
- (void)enterIntoAlbumsSelectPhotos {

    _photoSelectKind = SELECT_PHOTOS;
    
    LSYAlbumCatalog *albumCatalog              = [[LSYAlbumCatalog alloc] init];
    albumCatalog.delegate                      = self;
    LSYNavigationController *navigation        = [[LSYNavigationController alloc] initWithRootViewController:albumCatalog];
    albumCatalog.maximumNumberOfSelectionMedia = 15;
    
    [self presentViewController:navigation animated:YES completion:^{
        
    }];
}

/**
 *  这里是点击加号，继续添加图片
 */
- (void)addMorePhotos {
    
    _photoSelectKind = ADD_MORE_PHOTOS;
    
    LSYAlbumCatalog *albumCatalog              = [[LSYAlbumCatalog alloc] init];
    albumCatalog.delegate                      = self;
    LSYNavigationController *navigation        = [[LSYNavigationController alloc] initWithRootViewController:albumCatalog];
    albumCatalog.maximumNumberOfSelectionMedia = 15;
    
    [self presentViewController:navigation animated:YES completion:^{
        
    }];
    
}

- (void)backToMainView {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark setLayout

- (void)setAllLayout {
    
    [self.announceTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(self.view).offset(10);
        make.right.equalTo(self.view.mas_right).offset(-10);
        make.height.equalTo(@(self.view.height * 0.33));
    }];
    
    [self.photosBgSrcollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.announceTextView.mas_bottom).offset(20);
        make.left.equalTo(self.announceTextView.mas_left);
        make.right.equalTo(self.announceTextView.mas_right);
        make.height.equalTo(@100);
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.announceTextView];
    [self.view addSubview:self.photosBgSrcollView];
    [self.view addSubview:self.addMorePhotosBtn];
    
    [self setAllLayout];
  
//    
  /*  [self.viewModel requestForQiNiuCertificateSerialNumberWithUrl:QINIU_CERTIFICSTE_URL sucess:^(NSString *certfifcate) {
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];*/
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.title = @"新鲜事";
    self.navigationItem.rightBarButtonItem = self.rightBarItem;
    self.navigationItem.leftBarButtonItem  = self.leftBarItem;
}

#pragma mark -- LSYAlbumCatalogDelegate

-(void)AlbumDidFinishPick:(NSArray *)assets {
    
    if (_photoSelectKind == SELECT_PHOTOS) {
        
        [self addImages:assets onPhotoBgSrcollView:self.photosBgSrcollView];
        
    }else if (_photoSelectKind == ADD_MORE_PHOTOS) {
        
        [self addMoreImages:assets onPhotoBgSrcollView:self.photosBgSrcollView];
        
    }
}

/**
 *  添加照片
 *
 *  @param assets     照片数组
 *  @param scrollView 滑动背景
 */
- (void)addImages:(NSArray *)assets onPhotoBgSrcollView:(UIScrollView *)scrollView {
    
    for (ALAsset *asset in assets) {
        
        if ([[asset valueForProperty:@"ALAssetPropertyType"] isEqual:@"ALAssetTypePhoto"]) {

            UIImage * photoImage    = [UIImage imageWithCGImage:asset.defaultRepresentation.fullResolutionImage];
            PhotoUnitView *photo    = [[PhotoUnitView alloc] initWithImage:photoImage];
            photo.deleteViewBtn.tag = _photoImagesCount;
            
            [photo.deleteViewBtn addTarget:self action:@selector(deletePhotoImageView:) forControlEvents:UIControlEventTouchUpInside];
            
            [self.photoImageViewsArr addObject:photo];
            
            [self setPhotoImageViewLayout:photo byPhotoImagesCount:_photoImagesCount];

        }
        else if ([[asset valueForProperty:@"ALAssetPropertyType"] isEqual:@"ALAssetTypeVideo"]){
            //  NSURL *url = asset.defaultRepresentation.url;
            //  视频不处理
        }
    }
    
    if (_photoImagesCount != 0) {
        
        [self.addMorePhotosBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.photosBgSrcollView.mas_left);
            make.top.equalTo(self.photosBgSrcollView.mas_bottom);
        }];
        
        if (_photoImagesCount > 4) {
            //photosBgSrcollView 滑动
            self.photosBgSrcollView.contentSize = CGSizeMake(SCREEN_WIDTH + (_photoImagesCount-4) * 80, 100);

        }
    }
    
}

static CGFloat photoWidth = 80;

/**
 *  继续添加图片
 *
 *  @param assets     图片数组
 *  @param scrollView 滑动背景
 */
- (void)addMoreImages:(NSArray *)assets onPhotoBgSrcollView:(UIScrollView *)scrollView {
    
    for (ALAsset *asset in assets) {
        
        if ([[asset valueForProperty:@"ALAssetPropertyType"] isEqual:@"ALAssetTypePhoto"]) {
            
            UIImage * photoImage    = [UIImage imageWithCGImage:asset.defaultRepresentation.fullResolutionImage];
            PhotoUnitView *photo    = [[PhotoUnitView alloc] initWithImage:photoImage];
            photo.deleteViewBtn.tag = _photoImagesCount;

            [photo.deleteViewBtn addTarget:self action:@selector(deletePhotoImageView:) forControlEvents:UIControlEventTouchUpInside];
            
            [self.photoImageViewsArr addObject:photo];

            [self setPhotoImageViewLayout:photo byPhotoImagesCount:_photoImagesCount];
            
        }
        else if ([[asset valueForProperty:@"ALAssetPropertyType"] isEqual:@"ALAssetTypeVideo"]){
            //  NSURL *url = asset.defaultRepresentation.url;
            //  视频不处理
        }
    }
    
    
    if (_photoImagesCount > 4) {
        //photosBgSrcollView 滑动
        self.photosBgSrcollView.contentSize = CGSizeMake(SCREEN_WIDTH + (_photoImagesCount-4) * photoWidth, 100);
            
        }
}

/**
 *  将照片显示在UIScrollView上
 *
 *  @param photo            图片
 *  @param photoImagesCount 图片数量
 */
- (void)setPhotoImageViewLayout:(PhotoUnitView *)photo byPhotoImagesCount:(NSInteger)photoImagesCount {
    
    [self.photosBgSrcollView addSubview:photo];
    
    [photo mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.photosBgSrcollView.mas_left).offset(_photoImagesCount * photoWidth).priorityLow();
        make.width.height.equalTo(@(photoWidth));
        make.centerY.equalTo(self.photosBgSrcollView.mas_centerY);
    }];
    _photoImagesCount ++;
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
            make.left.equalTo(@(photoWidth*i)).priorityLow();
        }];
        
        [UIView animateWithDuration:0.3 animations:^{
            [photo layoutIfNeeded];
        }];
    }
    
}


//- (void)updateViewConstraints {
//    
//}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
