//
//  InspirationPageViewController.h
//  HCFunwear
//
//  Created by 刘海川 on 16/7/8.
//  Copyright © 2016年 Haichuan Liu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "InspirationPageViewModel.h"

@interface InspirationPageViewController : UIViewController <UIScrollViewDelegate>

@property (nonatomic, strong) InspirationPageViewModel *viewModel;

- (instancetype)initWithViewModel:(InspirationPageViewModel *)viewModel;

@end
