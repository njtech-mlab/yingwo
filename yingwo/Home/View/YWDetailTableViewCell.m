//
//  YWDetailTableViewCell.m
//  yingwo
//
//  Created by apple on 16/8/7.
//  Copyright © 2016年 wangxiaofa. All rights reserved.
//

#import "YWDetailTableViewCell.h"

@implementation YWDetailTableViewCell


- (void)createSubview {
    
    self.backgroundView             = [[UIView alloc] init];
    self.topView                    = [[YWHomeCellLabelView alloc] init];
    self.masterView                 = [[YWDetailMasterView alloc] init];
    self.bottomView                 = [[YWDetailBottomView alloc] init];
    self.contentLabel               = [[UILabel alloc] init];
    self.bgImageView                = [[UIView alloc] init];

    self.contentLabel.font          = [UIFont systemFontOfSize:15];
    self.contentLabel.numberOfLines = 0;

    [self.contentView addSubview:self.backgroundView];
    [self.backgroundView addSubview:self.topView];
    [self.backgroundView addSubview:self.masterView];
    [self.backgroundView addSubview:self.contentLabel];
    [self.backgroundView addSubview:self.bgImageView];
    [self.backgroundView addSubview:self.bottomView];
    
    [self.backgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView).insets(UIEdgeInsetsMake(2.5, 10, 2.5, 10));
    }];
    
    [self.topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.backgroundView.mas_top).offset(5);
        make.left.equalTo(self.backgroundView.mas_left).offset(10);
        make.right.equalTo(self.backgroundView.mas_right).offset(-10);
        make.height.equalTo(@30);
    }];
    

    [self.masterView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.topView.mas_left).offset(10);
        make.right.equalTo(self.topView.mas_right).offset(-10);
        make.top.equalTo(self.topView.mas_bottom).offset(10);
    }];
    
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       make.top.equalTo(self.masterView.mas_bottom).offset(10);
        make.left.equalTo(self.masterView.mas_left);
        make.right.equalTo(self.masterView.mas_right);
       // make.height.equalTo(@30).priorityLow();
    }];
    
    [self.bgImageView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentLabel.mas_bottom).offset(10);
        make.left.right.equalTo(self.contentLabel);
     //   make.bottom.equalTo(self.backgroundView.mas_bottom).priorityLow();
    }];
        
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@40);
        make.top.equalTo(self.bgImageView.mas_bottom);
        make.bottom.equalTo(self.backgroundView.mas_bottom).offset(-20);
        make.left.right.equalTo(self.bgImageView);
    }];
    
   // self.contentLabel.backgroundColor = [UIColor greenColor];
  //  self.bgImageView.backgroundColor  = [UIColor blueColor];
}

- (void)addImageViewByImageArr:(NSMutableArray *)imageArr {
    
    UIImageView *lastView;
    
    for (int i = 0; i < imageArr.count; i ++) {
        
        UIImageView *imageView = [imageArr objectAtIndex:i];
        imageView.tag          = i+1;
        NSLog(@"imageView.image.size.height:%f", imageView.image.size.height);
        NSLog(@"imageView.image.size.width:%f", imageView.image.size.width);

        [self.bgImageView addSubview:imageView];
        
        if (!lastView) {
            
            [imageView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.contentLabel.mas_bottom).offset(10);
                make.left.equalTo(self.bgImageView.mas_left);
                make.right.equalTo(self.bgImageView.mas_right);
                make.height.equalTo(@(imageView.image.size.height));
              //  make.bottom.equalTo(self.backgroundView.mas_bottom);
            }];
            lastView = imageView;
            
        }else {
            [imageView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.left.right.equalTo(lastView);
                make.top.equalTo(lastView.mas_bottom).offset(10);
                make.height.equalTo(@(imageView.image.size.height));
              //  make.bottom.equalTo(lastView.mas_bottom).priorityLow();
            }];
            lastView = imageView;
        }
    }
    
    [lastView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.bottomView.mas_top).offset(10);
    }];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
