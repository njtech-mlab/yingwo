//
//  CommentView.h
//  yingwo
//
//  Created by apple on 16/9/6.
//  Copyright © 2016年 wangxiaofa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YWLabel.h"
#import "YWContentLabel.h"

@interface YWCommentView : UIView

@property (nonatomic, strong) UILabel            *leftName;
@property (nonatomic, strong) YWLabel            *identfier;
@property (nonatomic, strong) YWContentLabel     *content;


@end
