//
//  CustomSegue.m
//  yingwo
//
//  Created by apple on 16/7/15.
//  Copyright © 2016年 wangxiaofa. All rights reserved.
//

#import "CustomPresentSegue.h"

@implementation CustomPresentSegue

//- (void)performSegueWithIndentifier:(NSString *)destinationIndentifier sender:(id)destinationVc {
//
//}

- (void)perform {
    [self presentPerform];
}

- (void)presentPerform {
    
    UIViewController *sourceVc = self.sourceViewController;
    UIViewController *destinationVc = self.destinationViewController;
    
    [[UIApplication sharedApplication] keyWindow].backgroundColor = [UIColor whiteColor];

    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            sourceVc.view.transform = CGAffineTransformMakeScale(0.9, 0.9);
                [sourceVc presentViewController:destinationVc animated:YES completion:^{
                    sourceVc.view.transform = CGAffineTransformMakeScale(1, 1);
                }];
    } completion:nil];
}

@end
