//
//  HCBottomGoodsDetailView.h
//  HCFunwear
//
//  Created by 刘海川 on 16/9/27.
//  Copyright © 2016年 Haichuan Liu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HCViewModelBindProtocol.h"

@interface HCBottomGoodsDetailView : UIView <HCViewModelBindProtocol>

@property (nonatomic,assign)BOOL isGoBackTop;
@property (nonatomic,copy)void(^goBackBlock)();

@end
