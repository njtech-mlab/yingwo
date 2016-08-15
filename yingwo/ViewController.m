//
//  ViewController.m
//  yingwo
//
//  Created by apple on 16/8/9.
//  Copyright © 2016年 wangxiaofa. All rights reserved.
//

#import "ViewController.h"
#import "YWAvatarBrowser.h"

@interface ViewController ()<UIScrollViewDelegate>

@property (nonatomic, strong)UIScrollView *avatarSrcllView;
@property (nonatomic, assign)NSInteger avatarPage;
@property (nonatomic, strong)UILabel *avatarPageLabel;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"pic"]];
    imageView.tag = 2;
    imageView.frame = CGRectMake(0, 0, 200, 200);
    imageView.center = self.view.center;
    imageView.userInteractionEnabled = YES;
    [self.view addSubview:imageView];
    
   // [self showImage:imageView WithImageViewArr:arr];
    UITapGestureRecognizer *tap  = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(magnifyImage:)];
    [imageView addGestureRecognizer:tap];
    
//    YWAvatarBrowser *avater = [[YWAvatarBrowser alloc] init];
//    [avater showImage:nil WithImageViewArr:arr];
}

static CGRect avatarImageViewOldFrame;
static int avatarImageViewOldTag;

- (void)showImage:(UIImageView *)avatarImageView WithImageViewArr:(NSArray *)imageArr{
    
    //avatarImageViewTag tag从1开始的，所以这里要减1，从0开始计算
    avatarImageViewOldTag        = (int)avatarImageView.tag;
    NSInteger avatarImageViewTag = avatarImageView.tag - 1;

    //页数
    _avatarPageLabel                 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
    _avatarPageLabel.center          = CGPointMake(self.view.center.x, 50);
    _avatarPageLabel.textColor       = [UIColor whiteColor];
    _avatarPageLabel.textAlignment   = NSTextAlignmentCenter;
    _avatarPageLabel.text            = [NSString stringWithFormat:@"%d/%d",avatarImageViewOldTag,(int)imageArr.count];

    //背景滑动
    _avatarSrcllView                 = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    _avatarSrcllView.pagingEnabled   = YES;
    //_avatarSrcllView 的初始位置
    _avatarSrcllView.contentSize     = CGSizeMake(imageArr.count*SCREEN_WIDTH, SCREEN_HEIGHT);
    _avatarSrcllView.contentOffset   = CGPointMake(SCREEN_WIDTH*avatarImageViewTag, _avatarSrcllView.contentOffset.y);
    _avatarSrcllView.backgroundColor = [UIColor blackColor] ;
    _avatarSrcllView.alpha           = 1;
    _avatarSrcllView.delegate        = self;

    //创建新的ImageView代替点击的avatarImageView,这里一定要设置好初始位置！！！
    UIImageView *avatarNewImageView = [[UIImageView alloc] initWithFrame:CGRectMake(avatarImageView.x+SCREEN_WIDTH*avatarImageViewTag, avatarImageView.y, avatarImageView.width, avatarImageView.height)];

    //保存点击view之后的位置
    avatarImageViewOldFrame         = CGRectMake(avatarNewImageView.x, avatarImageView.y, avatarImageView.width, avatarImageView.height);

    avatarNewImageView.image        = avatarImageView.image;
    avatarNewImageView.tag          = avatarImageViewOldTag;

    [_avatarSrcllView addSubview:avatarNewImageView];
    [self.view addSubview:_avatarSrcllView];
    [self.view addSubview:_avatarPageLabel];
    
    //点击后的缩放动画
    POPSpringAnimation *anim = [POPSpringAnimation animationWithPropertyNamed:kPOPViewFrame];
    anim.toValue             = [NSValue valueWithCGRect:CGRectMake(SCREEN_WIDTH*avatarImageViewTag,(SCREEN_HEIGHT-avatarNewImageView.image.size.height/2)/2, SCREEN_WIDTH, avatarNewImageView.image.size.height/2)];
    anim.springBounciness    = 12;
    anim.springSpeed         = 12;
    [avatarNewImageView pop_addAnimation:anim forKey:@"Center"];
    anim.completionBlock = ^(POPAnimation *anim, BOOL finished)  {
        
        if (finished) {
            
            for (int i = 0; i < imageArr.count; i++) {
                
                //这个位置已经被avatarImageView占有
                if (i == avatarImageViewTag) {
                    continue;
                }
                
                UIImage *image         = [imageArr objectAtIndex:i];
                UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH * i, 0, image.size.width/2, image.size.height/2)];
                imageView.image        = image;
                imageView.tag          = i + 1;
                imageView.center       = CGPointMake((SCREEN_WIDTH/2 + SCREEN_WIDTH*i), SCREEN_HEIGHT/2);
                
                [_avatarSrcllView addSubview:imageView];
            }
        }

    };
    /*
    //动画显示
    [UIView animateWithDuration:0.3 animations:^{
        
        avatarNewImageView.frame = CGRectMake(SCREEN_WIDTH*avatarImageViewTag,(SCREEN_HEIGHT-avatarNewImageView.image.size.height/2)/2, SCREEN_WIDTH, avatarNewImageView.image.size.height/2);

        for (int i = 0; i < imageArr.count; i++) {
            
            //这个位置已经被avatarImageView占有
            if (i == avatarImageViewTag) {
                continue;
            }
            
            UIImage *image         = [imageArr objectAtIndex:i];
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH * i, 0, image.size.width/2, image.size.height/2)];
            imageView.image        = image;
            imageView.center       = CGPointMake((SCREEN_WIDTH/2 + SCREEN_WIDTH*i), SCREEN_HEIGHT/2);
            
            [_avatarSrcllView addSubview:imageView];
            
        }

    }];*/
    
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideImage:)];
    [_avatarSrcllView addGestureRecognizer: tap];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    self.avatarPage = scrollView.contentOffset.x/scrollView.frame.size.width + 1;
    self.avatarPageLabel.text = [NSString stringWithFormat:@"%d/%d",self.avatarPage,4];
}

- (void)magnifyImage:(UIGestureRecognizer *)sender {
    UIImage *image1 = [UIImage imageNamed:@"pic"];
    UIImage *image2 = [UIImage imageNamed:@"pic"];
    UIImage *image3 = [UIImage imageNamed:@"pic"];
    UIImage *image4 = [UIImage imageNamed:@"pic"];

    NSArray *arr = [NSArray arrayWithObjects:image1,image2,image3,image4, nil];

    [self showImage:sender.view WithImageViewArr:arr];
}

- (void)hideImage:(UITapGestureRecognizer*)tap{
    
    _avatarSrcllView.backgroundColor = [UIColor clearColor];

    UIImageView *imageView           = (UIImageView*)[_avatarSrcllView viewWithTag:self.avatarPage];
    POPSpringAnimation *anim         = [POPSpringAnimation animationWithPropertyNamed:kPOPViewFrame];
    anim.toValue                     = [NSValue valueWithCGRect:CGRectMake(imageView.x, imageView.y, 600, 600)];
    anim.springBounciness            = 8;
    anim.springSpeed                 = 12;
    
    [imageView pop_addAnimation:anim forKey:@"Center"];
    
    anim.completionBlock = ^(POPAnimation *anim, BOOL finished){
        if (finished) {
            [_avatarSrcllView removeFromSuperview];
        }
    };
//    [UIView animateWithDuration:0.3 animations:^{
//        
//        imageView.frame      = avatarImageViewOldFrame;
//        backgroundView.alpha = 0;
//        
//    } completion:^(BOOL finished) {
//        [backgroundView removeFromSuperview];
//    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
