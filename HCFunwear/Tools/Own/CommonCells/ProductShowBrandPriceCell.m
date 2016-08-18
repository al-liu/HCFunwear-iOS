//
//  ProductShowBrandPriceCell.m
//  HCFunwear
//
//  Created by 刘海川 on 16/6/29.
//  Copyright © 2016年 Haichuan Liu. All rights reserved.
//

#import "ProductShowBrandPriceCell.h"
#import "UIImageView+YYWebImage.h"
#import "RACEXTScope.h"
#import "GlobalConstant.h"

@implementation ProductShowBrandPriceCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setProduct:(HCProduct *)product {
    _product = product;
    @weakify(self);
    _imageView.contentMode = UIViewContentModeCenter;
    [_imageView setImageWithURL:_product.product_url placeholder:defaultImage02 options:YYWebImageOptionAvoidSetImage completion:^(UIImage * _Nullable image, NSURL * _Nonnull url, YYWebImageFromType from, YYWebImageStage stage, NSError * _Nullable error) {
        @strongify(self)
        self.imageView.image = image;
        self.imageView.contentMode = UIViewContentModeScaleAspectFill;
    }];
    _brandLabel.text = _product.brandName;
    _nameLabel.text = _product.product_name;
    _priceLabel.text = [NSString stringWithFormat:@"%.2f",[_product.price doubleValue]];
}

@end
