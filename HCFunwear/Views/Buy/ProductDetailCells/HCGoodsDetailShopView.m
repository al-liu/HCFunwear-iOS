//
//  HCGoodsDetailShopView.m
//  HCFunwear
//
//  Created by 刘海川 on 16/9/25.
//  Copyright © 2016年 Haichuan Liu. All rights reserved.
//

#import "HCGoodsDetailShopView.h"

@implementation HCGoodsDetailShopView

- (void)awakeFromNib {
    [super awakeFromNib];
    _shopLogoImageView.layer.borderWidth = 0.5f;
    _shopLogoImageView.layer.borderColor = [UIColor blackColor].CGColor;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
