
//
//  HCSliderLeftDismissAnimator.m
//  HCFunwear
//
//  Created by 刘海川 on 16/10/20.
//  Copyright © 2016年 Haichuan Liu. All rights reserved.
//

#import "HCSliderLeftDismissAnimator.h"
#import "GlobalConstant.h"
#import "UIView+YYAdd.h"

@implementation HCSliderLeftDismissAnimator

- (void)animateTransitionEvent {
    UIView *currentView = self.fromViewController.view;
    UIView *toView = self.toViewController.view;
    
    //0.74 占比
    CGFloat originX = 0;
    CGFloat toX = SCREEN_WIDTH * 0.74;
    
    toView.left = toX;
    
    self.containerView.backgroundColor = [UIColor clearColor];
    self.transitionDuration = 0.3;
    [UIView animateWithDuration:self.transitionDuration animations:^{
        toView.left = originX;
        currentView.right = originX;
    } completion:^(BOOL finished) {
        [self completeTransition];
    }];

}

@end
