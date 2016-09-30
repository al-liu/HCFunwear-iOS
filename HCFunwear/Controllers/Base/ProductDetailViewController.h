//
//  ProductDetailViewController.h
//  HCFunwear
//
//  Created by 刘海川 on 16/8/22.
//  Copyright © 2016年 Haichuan Liu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProductDetailViewModel.h"
#import "HCBaseViewController.h"

@interface ProductDetailViewController : HCBaseViewController

- (instancetype)initWithViewModel:(ProductDetailViewModel *)viewModel;

@end
