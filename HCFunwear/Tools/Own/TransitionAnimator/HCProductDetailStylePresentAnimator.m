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
    
    //半透明浮层
    UIButton *controlView = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    [self.containerView addSubview:controlView];
    [controlView addTarget:self action:@selector(dismissWithControlView) forControlEvents:UIControlEventTouchUpInside];
    
    [self.containerView addSubview:toView];
    
    currentView.transform = CGAffineTransformMakeScale(1, 1);
    toView.top = SCREEN_HEIGHT;
    
    CGFloat toY = SCREEN_HEIGHT * 0.31;

    self.containerView.userInteractionEnabled = YES;
    
    self.transitionDuration = 0.2;
    
    [UIView animateWithDuration:self.transitionDuration animations:^{
        currentView.transform = CGAffineTransformMakeScale(0.9, 0.9);
        toView.top = toY;
        self.containerView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.4];
    } completion:^(BOOL finished) {
        [self completeTransition];
    }];
}


- (void)dismissWithControlView {
    if (_dismissBlock) {
        _dismissBlock();
    }
}

@end
