//
//  HCGoodsDetailShopPlanCell.m
//  HCFunwear
//
//  Created by 刘海川 on 16/9/25.
//  Copyright © 2016年 Haichuan Liu. All rights reserved.
//

#import "HCGoodsDetailShopPlanCell.h"

@implementation HCGoodsDetailShopPlanCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    _pointFlagView.layer.cornerRadius = 2;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
