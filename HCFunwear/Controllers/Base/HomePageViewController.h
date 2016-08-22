//
//  HomePageViewController.h
//  HCFunwear
//
//  Created by 刘海川 on 16/5/26.
//  Copyright © 2016年 Haichuan Liu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Masonry.h"
#import "HomePageViewModel.h"

@interface HomePageViewController : UIViewController

- (instancetype)initWithViewModel:(HomePageViewModel *)viewModel;

@end
