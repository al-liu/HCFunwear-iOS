//
//  HCGoodsKindSelectFooterView.m
//  GoodsStyleView
//
//  Created by 刘海川 on 16/10/25.
//  Copyright © 2016年 Haichuan Liu. All rights reserved.
//

#import "HCGoodsKindSelectFooterView.h"

@implementation HCGoodsKindSelectFooterView

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    _counterView.minCount = 1;
    [_counterView resetCount:1];
    
}

@end
