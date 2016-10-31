//
//  HCShoppingCartView.h
//  HCFunwear
//
//  Created by 刘海川 on 16/9/2.
//  Copyright © 2016年 Haichuan Liu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ReactiveCocoa.h"

@interface HCShoppingCartView : UIView

- (void)bindAddGoodsCommand:(RACCommand *)command;

@end
