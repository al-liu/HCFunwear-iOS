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
    CGFloat originX = 0;
    CGFloat toX = SCREEN_WIDTH * 0.74;
    
    toView.right = 0;
    self.transitionDuration = 0.3;
    [UIView animateWithDuration:self.transitionDuration
                          delay:0.f
         usingSpringWithDamping:1.f
          initialSpringVelocity:0.f
                        options:UIViewAnimationOptionCurveLinear
                     animations:^{
                         toView.right = toX;
                         currentView.left = toX;
                    } completion:^(BOOL finished) {
                        [self completeTransition];
                    }];
}

@end
