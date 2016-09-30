//
//  HCTopGoodsDetailView.h
//  HCFunwear
//
//  Created by 刘海川 on 16/9/2.
//  Copyright © 2016年 Haichuan Liu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HCViewModelBindProtocol.h"

@interface HCTopGoodsDetailView : UIView <HCViewModelBindProtocol>

@property (nonatomic, strong) UIScrollView *scrollView;

@end
