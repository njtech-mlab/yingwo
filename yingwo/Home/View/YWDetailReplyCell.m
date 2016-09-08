//
//  YWDetailReplyCell.m
//  yingwo
//
//  Created by apple on 16/9/3.
//  Copyright © 2016年 wangxiaofa. All rights reserved.
//

#import "YWDetailReplyCell.h"
#import "TieZiComment.h"
#import "YWCommentView.h"
#import "YWCommentReplyView.h"

@implementation YWDetailReplyCell

- (void)createSubview {
    
    self.backgroundView             = [[UIView alloc] init];
    self.masterView                 = [[YWDetailMasterView alloc] init];
    self.contentLabel               = [[YWContentLabel alloc] initWithFrame:CGRectZero];
    self.bgImageView                = [[UIView alloc] init];
    self.bgCommentView              = [[UIView alloc] init];
    self.moreBtn                    = [[YWAlertButton alloc] initWithNames:[NSArray arrayWithObjects:@"复制",@"举报" ,nil]];

    self.contentLabel.font          = [UIFont systemFontOfSize:15];
    self.contentLabel.numberOfLines = 0;
    self.bottomView                 = [[YWDetailCellBottomView alloc] init];

    [self.masterView.identifierLabel removeFromSuperview];
    
    [self.contentView addSubview:self.backgroundView];
    [self.backgroundView addSubview:self.masterView];
    [self.backgroundView addSubview:self.contentLabel];
    [self.backgroundView addSubview:self.bottomView];
    [self.backgroundView addSubview:self.bgImageView];
    [self.backgroundView addSubview:self.bgCommentView];
    [self.backgroundView addSubview:self.moreBtn];
    
    [self.backgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView).insets(UIEdgeInsetsMake(2.5, 10, 2.5, 10));
    }];
    
    [self.moreBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.backgroundView.mas_top).offset(10);
        make.right.equalTo(self.backgroundView.mas_right).offset(-10);
    }];
    
    [self.masterView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.backgroundView.mas_left).offset(10);
        make.right.equalTo(self.backgroundView.mas_right).offset(-10);
        make.top.equalTo(self.backgroundView.mas_top).offset(10);
    }];
    
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.masterView.mas_bottom).offset(10);
        make.left.equalTo(self.masterView.mas_left);
        make.right.equalTo(self.masterView.mas_right);
    }];
    
    [self.bgImageView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentLabel.mas_bottom).offset(10);
        make.left.equalTo(self.contentLabel.mas_left);
        make.right.equalTo(self.contentLabel.mas_right);
    }];

    
    [self.bottomView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bgImageView.mas_bottom).offset(10);
        make.height.equalTo(@40);
        make.left.equalTo(self.contentLabel.mas_left);
        make.right.equalTo(self.contentLabel.mas_right);
     //   make.bottom.equalTo(self.bgCommentView.mas_top).offset(-20).priorityLow();
    }];
    
    [self.bgCommentView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bottomView.mas_bottom).offset(10);
        make.left.right.equalTo(self.backgroundView);
        make.bottom.equalTo(self.backgroundView.mas_bottom).offset(-20).priorityLow();
    }];
    
}

- (void)addImageViewByImageArr:(NSMutableArray *)entities {
    
    UIImageView *lastView;
    
    for (int i = 0; i < entities.count; i ++) {
        
        ImageViewEntity *entity           = [entities objectAtIndex:i];
        CGFloat imageHeight = SCREEN_WIDTH/entity.width *entity.height;
        
        UIImageView *imageView           = [[UIImageView alloc] init];
        imageView.tag                    = i+1;
        imageView.userInteractionEnabled = YES;
        
        //添加单击放大事件
        UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singelTap:)];
        singleTap.numberOfTouchesRequired = 1;
        singleTap.numberOfTapsRequired    = 1;
        [imageView addGestureRecognizer:singleTap];
        
        imageView.mas_key                = [NSString stringWithFormat:@"DetailImageView%d:",i+1];
        
        [self.bgImageView addSubview:imageView];
        
        if (!lastView) {
            
            [imageView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.contentLabel.mas_bottom).offset(10);
                make.left.equalTo(self.bgImageView.mas_left);
                make.right.equalTo(self.bgImageView.mas_right);
                make.height.equalTo(@(imageHeight)).priorityHigh();
            }];
            lastView = imageView;
            
        }else {
            [imageView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.left.right.equalTo(lastView);
                make.top.equalTo(lastView.mas_bottom).offset(10).priorityHigh();
                make.height.equalTo(@(imageHeight)).priorityHigh();
            }];
            lastView = imageView;
        }
        
        [imageView sd_setImageWithURL:[NSURL URLWithString:entity.imageName]
                     placeholderImage:[UIImage imageNamed:@"ying"]];
    }
    
    [lastView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.bottomView.mas_top).offset(-20).priorityLow();
    }];

    
}

- (void)singelTap:(UITapGestureRecognizer *)sender {
    
    if ([self.delegate respondsToSelector:@selector(didSeletedImageView:)]) {
        [self.delegate didSeletedImageView:(UIImageView *)sender.view];
        
    }
}

//添加评论
- (void)addCommentViewByCommentArr:(NSMutableArray *)commentArr withMasterId:(NSInteger)master_id{

    UIView *lastView;
    
    for (int i = 0; i < commentArr.count; i ++) {
        
        TieZiComment *entity            = [commentArr objectAtIndex:i];

        YWCommentView *commentView;
        
        if ([entity.user_id integerValue] == master_id) {
            
            commentView                      = [[YWCommentView alloc] init];
            commentView.leftName.text        = [entity.user_name stringByAppendingString:@":"];
            commentView.content.text         = entity.content;
            commentView.identfier.label.text = @"楼主";

        }
        else
        {
            commentView               = [[YWCommentReplyView alloc] init];
            commentView.leftName.text = [entity.user_name stringByAppendingString:@":"];
            commentView.content.text  = entity.content;
        }

        [self.bgCommentView addSubview:commentView];
        
        if (!lastView) {
            [commentView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.bgCommentView.mas_top).offset(10).priorityHigh();
                make.left.equalTo(self.contentLabel.mas_left);
                make.right.equalTo(self.contentLabel.mas_right).priorityLow();
                make.height.equalTo(@20);
            }];
        }
        else
        {
            [commentView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(lastView.mas_bottom).offset(10).priorityHigh();
                make.left.equalTo(self.contentLabel.mas_left);
                make.right.equalTo(self.contentLabel.mas_right);
                make.height.equalTo(@20);
            }];
        }
        lastView = commentView;
    }
    
    [lastView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.bgCommentView.mas_bottom).offset(-20).priorityHigh();
    }];
    
}


@end
