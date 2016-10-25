//
//  HCProductDetailStyleViewController.h
//  HCFunwear
//
//  Created by 刘海川 on 16/10/24.
//  Copyright © 2016年 Haichuan Liu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HCProductDetailStyleViewModel.h"

@interface HCProductDetailStyleViewController : UIViewController

@property (nonatomic, strong, readonly) HCProductDetailStyleViewModel *productDetailStyleViewModel;

- (instancetype)initWithViewModel:(HCProductDetailStyleViewModel *)viewModel;

@end
