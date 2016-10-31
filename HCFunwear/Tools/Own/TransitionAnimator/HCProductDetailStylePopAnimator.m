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
    
    toView.transform = CGAffineTransformMakeScale(0.90, 0.90);
    
    self.containerView.backgroundColor = [UIColor clearColor];
    [UIView animateWithDuration:self.transitionDuration animations:^{
        toView.transform = CGAffineTransformMakeScale(1, 1);
        currentView.top = SCREEN_HEIGHT;
    } completion:^(BOOL finished) {
        [self completeTransition];
    }];
}

@end
