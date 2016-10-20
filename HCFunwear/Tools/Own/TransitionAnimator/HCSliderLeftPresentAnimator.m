//
//  HCSliderLeftPresentAnimator.m
//  HCFunwear
//
//  Created by 刘海川 on 16/10/20.
//  Copyright © 2016年 Haichuan Liu. All rights reserved.
//

#import "HCSliderLeftPresentAnimator.h"
#import "GlobalConstant.h"
#import "UIView+YYAdd.h"

@implementation HCSliderLeftPresentAnimator

- (void)animateTransitionEvent {
    UIView *currentView = self.fromViewController.view;
    UIView *toView = self.toViewController.view;
    [self.containerView addSubview:toView];
    
    //0.74 占比 
    CGFloat toX = SCREEN_WIDTH * 0.74;
    
    toView.right = 0;
    self.transitionDuration = 0.5;
    [UIView animateWithDuration:self.transitionDuration animations:^{
        toView.right = toX;
        currentView.left = toX;
    } completion:^(BOOL finished) {
        [self completeTransition];
    }];
    
}

@end
