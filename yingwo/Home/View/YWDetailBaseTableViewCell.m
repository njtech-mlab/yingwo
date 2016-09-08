//
//  YWDetailBaseTableViewCell.m
//  yingwo
//
//  Created by apple on 16/8/7.
//  Copyright © 2016年 wangxiaofa. All rights reserved.
//

#import "YWDetailBaseTableViewCell.h"

@implementation YWDetailBaseTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style
              reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self createSubview];
        
        self.backgroundColor                    = [UIColor clearColor];
        self.backgroundView.backgroundColor     = [UIColor whiteColor];
        self.backgroundView.layer.masksToBounds = YES;
        self.backgroundView.layer.cornerRadius  = 10;        
    }
    return self;
}

- (void)createSubview {
    
}

- (void)addImageViewByImageArr:(NSMutableArray *)imageArr {
    
}

- (void)addCommentViewByCommentArr:(NSMutableArray *)commentArr withMasterId:(NSInteger)master_id {

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
