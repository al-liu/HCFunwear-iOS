//
//  ProductShowBrandPriceCell.m
//  HCFunwear
//
//  Created by 刘海川 on 16/6/29.
//  Copyright © 2016年 Haichuan Liu. All rights reserved.
//

#import "ProductShowBrandPriceCell.h"
#import "RACEXTScope.h"
#import "GlobalConstant.h"
#import "UIImageView+HCPackWebImage.h"

@implementation ProductShowBrandPriceCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setProduct:(HCProduct *)product {
    _product = product;
    [_imageView packAspectFillModeSetImageWithURL:_product.product_url placeholder:defaultImage02];
    _brandLabel.text = _product.brandName;
    _nameLabel.text = _product.product_name;
    _priceLabel.text = [NSString stringWithFormat:@"%.2f",[_product.price doubleValue]];
}

@end
