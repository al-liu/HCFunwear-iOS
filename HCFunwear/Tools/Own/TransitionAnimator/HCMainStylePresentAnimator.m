//
//  HCMainStylePresentAnimator.m
//  HCFunwear
//
//  Created by 刘海川 on 16/10/20.
//  Copyright © 2016年 Haichuan Liu. All rights reserved.
//

#import "HCMainStylePresentAnimator.h"
#import "UIView+YYAdd.h"
#import "GlobalConstant.h"

@implementation HCMainStylePresentAnimator

- (void)animateTransitionEvent {
    UIView *currentView = self.fromViewController.view;
    UIView *toView = self.toViewController.view;
    [self.containerView addSubview:toView];
    

    toView.left = SCREEN_WIDTH;
    toView.top = 0;
    toView.width = SCREEN_WIDTH;
    toView.height = SCREEN_HEIGHT;
//    self.transitionDuration = 0.7;
    [UIView animateWithDuration:self.transitionDuration animations:^{
        toView.left = 0;
        currentView.right = 0;
    } completion:^(BOOL finished) {
        [self completeTransition];
    }];
}

@end
