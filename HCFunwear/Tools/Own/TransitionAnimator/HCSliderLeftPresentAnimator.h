//
//  HCSliderLeftPresentAnimator.h
//  HCFunwear
//
//  Created by 刘海川 on 16/10/20.
//  Copyright © 2016年 Haichuan Liu. All rights reserved.
//

#import "HCBaseTransitionAnimator.h"

@interface HCSliderLeftPresentAnimator : HCBaseTransitionAnimator

//回调 self.containerView 的事件

@property (nonatomic, copy)void(^gobackSliderLeftBlock)();

@end
