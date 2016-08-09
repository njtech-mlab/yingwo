//
//  YWAnnounceTextView.m
//  yingwo
//
//  Created by apple on 16/8/2.
//  Copyright © 2016年 wangxiaofa. All rights reserved.
//

#import "YWAnnounceTextView.h"

@implementation YWAnnounceTextView
{
}

- (instancetype)init {
    self = [super init];
    if (self) {
        self.delegate = self;
        
        [self createSubview];
    }
    return self;
}

- (void)createSubview {
    
    _placeholder         = [[UILabel alloc] init];
    _placeholder.font    = [UIFont systemFontOfSize:15];
    _placeholder.enabled = NO;
    _placeholder.text    = @"请输入内容...";

    _keyboardToolView = [[YWKeyboardToolView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 45)];
    
    [_keyboardToolView.returnKeyBoard addTarget:self action:@selector(resignKeyboard) forControlEvents:UIControlEventTouchUpInside];
    self.inputAccessoryView = _keyboardToolView;
    
    [self addSubview:_placeholder];
    
    [_placeholder mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(15);
        make.top.equalTo(self.mas_top).offset(10);
    }];
    
}

- (void)textViewDidBeginEditing:(UITextView *)textView {


}

- (void)textViewDidChange:(UITextView *)textView {

    
    if (textView.text.length == 0) {
        self.placeholder.hidden = NO;
    }
    else {
        self.placeholder.hidden = YES;
    }
    
    //TextView 首行缩进
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.firstLineHeadIndent      = 15.0;
    paragraphStyle.lineSpacing              = 3;//行间距
    paragraphStyle.alignment                = NSTextAlignmentJustified;

    NSDictionary *attributes                = @{NSParagraphStyleAttributeName:paragraphStyle,NSFontAttributeName:[UIFont systemFontOfSize:15]};
    self.attributedText                     = [[NSAttributedString alloc] initWithString:textView.text attributes:attributes];

}
//收起键盘
- (void)resignKeyboard {
    [self resignFirstResponder];
}

@end
