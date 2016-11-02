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
    
    self.containerView.userInteractionEnabled = YES;
    //0.74 占比
    CGFloat toX = SCREEN_WIDTH * 0.74;
    
    toView.right = 0;
    self.transitionDuration = 0.2;
    
    //半透明浮层
    UIButton *controlView = [[UIButton alloc]initWithFrame:CGRectMake(toX, 0, SCREEN_WIDTH-toX, SCREEN_HEIGHT)];
    [self.containerView addSubview:controlView];
    [controlView addTarget:self action:@selector(gobackSliderLeft) forControlEvents:UIControlEventTouchUpInside];
    
    [self.containerView addSubview:toView];
    
    [UIView animateWithDuration:self.transitionDuration animations:^{
        toView.right = toX;
        currentView.left = toX;
        self.containerView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.4];

    } completion:^(BOOL finished) {
        [self completeTransition];
    }];
    
}

- (void)gobackSliderLeft {
    if (_gobackSliderLeftBlock) {
        _gobackSliderLeftBlock();
    }
}

@end
