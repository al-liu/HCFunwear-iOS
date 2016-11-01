//
//  ProductDetailStyleView.h
//  HCFunwear
//
//  Created by 刘海川 on 16/10/24.
//  Copyright © 2016年 Haichuan Liu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ReactiveCocoa.h"
#import "HCProductDetailStyleViewModel.h"

@interface ProductDetailStyleView : UIView

- (void)bindViewModel:(HCProductDetailStyleViewModel *)viewModel;

@end
