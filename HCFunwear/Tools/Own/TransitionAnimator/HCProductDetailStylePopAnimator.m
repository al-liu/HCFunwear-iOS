//
//  HCProductDetailStylePopAnimator.m
//  HCFunwear
//
//  Created by 刘海川 on 16/10/25.
//  Copyright © 2016年 Haichuan Liu. All rights reserved.
//

#import "HCProductDetailStylePopAnimator.h"
#import "UIView+YYAdd.h"
#import "GlobalConstant.h"

@implementation HCProductDetailStylePopAnimator

- (void)animateTransitionEvent {
    UIView *currentView = self.fromViewController.view;
    UIView *toView = self.toViewController.view;
    [self.containerView addSubview:toView];
    
    toView.transform = CGAffineTransformMakeScale(0.90, 0.90);
    
    [UIView animateWithDuration:self.transitionDuration animations:^{
        toView.transform = CGAffineTransformMakeScale(1, 1);
        currentView.top = SCREEN_HEIGHT;
    } completion:^(BOOL finished) {
        [self completeTransition];
    }];
}

@end
