//
//  HCProductDetailStylePresentAnimator.m
//  HCFunwear
//
//  Created by 刘海川 on 16/10/25.
//  Copyright © 2016年 Haichuan Liu. All rights reserved.
//

#import "HCProductDetailStylePresentAnimator.h"
#import "UIView+YYAdd.h"
#import "GlobalConstant.h"

@implementation HCProductDetailStylePresentAnimator

- (void)animateTransitionEvent {
    UIView *currentView = self.fromViewController.view;
    UIView *toView = self.toViewController.view;
    [self.containerView addSubview:toView];
    
    currentView.transform = CGAffineTransformMakeScale(1, 1);
    toView.top = SCREEN_HEIGHT;
    
    CGFloat toY = SCREEN_HEIGHT * 0.31;
    
    self.containerView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.4];
    
    [UIView animateWithDuration:self.transitionDuration animations:^{
        currentView.transform = CGAffineTransformMakeScale(0.9, 0.9);
        toView.top = toY;
    } completion:^(BOOL finished) {
        [self completeTransition];
    }];
}

@end
