//
//  HCViewController.h
//  HCFunwear
//
//  Created by 刘海川 on 16/11/14.
//  Copyright © 2016年 Haichuan Liu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HCBaseViewModel.h"

@interface HCViewController : UIViewController

@property (nonatomic, strong, readonly) HCBaseViewModel *viewModel;

- (instancetype)initWithViewModel:(HCBaseViewModel *)viewModel;

- (void)bindViewModel;


@end
