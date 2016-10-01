//
//  HCHudManager.m
//  HCFunwear
//
//  Created by 刘海川 on 16/10/1.
//  Copyright © 2016年 Haichuan Liu. All rights reserved.
//

#import "HCHudManager.h"

@implementation HCHudManager

- (void)addHUDToView:(UIView*)view {
    self.activityHUD = [[MBProgressHUD alloc] initWithView:view];
//    self.activityHUD.margin = 40.0f;
    self.activityHUD.animationType = MBProgressHUDAnimationZoom;
    self.activityHUD.mode = MBProgressHUDModeCustomView;
    self.activityHUD.bezelView.backgroundColor = [UIColor blackColor];
    self.activityHUD.contentColor = [UIColor whiteColor];
    self.activityHUD.label.font = [UIFont systemFontOfSize:14];
    [view addSubview:self.activityHUD];
    
    UIImageView *backview = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];
    backview.image = [UIImage imageNamed:@"pic_loading_white"];
    
    CAMediaTimingFunction *linearCurve = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    animation.fromValue = @(0);
    animation.toValue = @(2*M_PI);
    animation.duration = 1.f;
    animation.repeatCount = INFINITY;
    animation.removedOnCompletion = NO;
    animation.timingFunction = linearCurve;
    animation.fillMode = kCAFillModeForwards;
    animation.autoreverses = NO;
    [backview.layer addAnimation:animation forKey:@"hud_loading"];
    
    self.activityHUD.customView = backview;
    self.activityHUD.label.text = @"    正在帮您加载...    ";
}
- (void)show {
    self.activityCount ++;
    [self.activityHUD showAnimated:YES];
}
- (void)hidden {
    self.activityCount --;
    if (self.activityCount == 0) {
        [self.activityHUD hideAnimated:YES];
    }
}
- (void)close {
    self.activityCount = 0;
    [self.activityHUD hideAnimated:YES];
}

@end
