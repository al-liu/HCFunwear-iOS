//
//  HCGoodsKindSelectFooterView.h
//  GoodsStyleView
//
//  Created by 刘海川 on 16/10/25.
//  Copyright © 2016年 Haichuan Liu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HCCounterView.h"

@interface HCGoodsKindSelectFooterView : UICollectionReusableView

@property (weak, nonatomic) IBOutlet UILabel *stockAmountLabel;

@property (weak, nonatomic) IBOutlet HCCounterView *counterView;

@end
