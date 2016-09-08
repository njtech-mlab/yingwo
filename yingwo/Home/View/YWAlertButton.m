//
//  YWAlertButton.m
//  yingwo
//
//  Created by apple on 16/8/14.
//  Copyright © 2016年 wangxiaofa. All rights reserved.
//

#import "YWAlertButton.h"

NSInteger cancelCode = -1;

@implementation YWAlertButton
{
    NSArray *_names;
}
- (instancetype)initWithNames:(NSArray *)names {
    self = [super init];
    if (self) {
        _names = names;
        [self setBackgroundImage:[UIImage imageNamed:@"more_gray"] forState:UIControlStateNormal];
        [self addTarget:self action:@selector(showAlertViewController) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

- (void)showAlertViewController {
    UIAlertController *alertView = [UIAlertController alertControllerWithTitle:@"操作" message:@"" preferredStyle:UIAlertControllerStyleActionSheet];
    NSMutableAttributedString *title = [[NSMutableAttributedString alloc] initWithString:@"操作"];
    [title addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} range:NSMakeRange(0, 2)];
    //改变title的字体大小
    [alertView setValue:title forKey:@"attributedTitle"];
    for (int i = 0; i < _names.count; i ++) {
        
        UIAlertAction *action = [UIAlertAction actionWithTitle:_names[i] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self.delegate seletedAlertViewIndex:i];
        }];
        [action setValue:[UIColor blackColor] forKey:@"titleTextColor"];
        [alertView addAction:action];
    }
    
    [alertView addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        [self.delegate seletedAlertViewIndex:cancelCode];
    }]];
    
    /**
     *  其他弹出框
     *  这里需要注意应该用 self.view.window.rootViewController 作为弹出视图的第一响应者
     *  不能使用self，因为HomeViewController是被 MainTabbarController添加上去de （addSubview）子 view，
     *  因此不能再作为第一响应者，如果使用会报错
     *
     */
    [self.window.rootViewController presentViewController:alertView animated:YES completion:^{
        
    }];
}

@end
