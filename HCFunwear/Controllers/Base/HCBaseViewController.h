//
//  HCBaseViewController.h
//  HCFunwear
//
//  Created by 刘海川 on 16/8/29.
//  Copyright © 2016年 Haichuan Liu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HCViewController.h"

@interface HCBaseViewController : HCViewController <UIGestureRecognizerDelegate>

@property (nonatomic, strong) UILabel *titleLabel;

@end
