//
//  HCProductDetailAppraiseView.h
//  HCFunwear
//
//  Created by 刘海川 on 16/9/27.
//  Copyright © 2016年 Haichuan Liu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HCProductDetailProtocol.h"

@interface HCProductDetailAppraiseView : UIView

@property (nonatomic,weak)id <HCProductDetailProtocol> delegate;

@end
