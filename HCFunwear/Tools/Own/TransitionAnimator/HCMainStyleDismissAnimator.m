//
//  HCMainStyleDismissAnimator.m
//  HCFunwear
//
//  Created by 刘海川 on 16/10/20.
//  Copyright © 2016年 Haichuan Liu. All rights reserved.
//

#import "HCMainStyleDismissAnimator.h"
#import "UIView+YYAdd.h"
#import "GlobalConstant.h"

@implementation HCMainStyleDismissAnimator

- (void)animateTransitionEvent {
    UIView *currentView = self.fromViewController.view;
    UIView *toView = self.toViewController.view;
    
    toView.right = 0;
    
//    self.transitionDuration = 0.7;
    [UIView animateWithDuration:self.transitionDuration animations:^{
        toView.left = 0;
        currentView.left = SCREEN_WIDTH;
    } completion:^(BOOL finished) {
        [self completeTransition];
    }];

}

@end
