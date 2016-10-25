//
//  ProductDetailStyleView.m
//  HCFunwear
//
//  Created by 刘海川 on 16/10/24.
//  Copyright © 2016年 Haichuan Liu. All rights reserved.
//

#import "ProductDetailStyleView.h"
#import "GlobalImport.h"
#import "Masonry.h"

@interface ProductDetailStyleView ()

{
    UIImageView *_productImageView;
    UILabel *_priceLabel;
    UILabel *_goodsCodeLabel;
    UILabel *_preferentialInfoLabel;
}

@end

@implementation ProductDetailStyleView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initUI];
    }
    return self;
}

- (void)initUI {
    //Product Info h：103
    //goods image  w:93 h:103
    _productImageView = ({
        UIImageView *view = [UIImageView new];
        view.contentMode = UIViewContentModeCenter;
        view.image = [UIImage imageNamed:@"fan_default_03"];
        [self addSubview:view];
        
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.equalTo(self);
            make.width.equalTo(@93);
            make.height.equalTo(@103);
        }];
        
        view;
    });
    
    //price label font 27
    _priceLabel = ({
        UILabel *view = [UILabel new];
        [view sizeToFit];
        view.font = [UIFont boldSystemFontOfSize:27];
        view.text = @"¥ 2789";
        view.numberOfLines = 1;
        [self addSubview:view];
        
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_productImageView.mas_right).offset(10);
            make.top.equalTo(self).offset(10);
        }];
        
        view;
    });
    
    //close button
    UIButton *closeButton = ({
        UIButton *view = [UIButton buttonWithType:UIButtonTypeCustom];
        [view setImage:[UIImage imageNamed:@"cameraclose"] forState:UIControlStateNormal];
        [self addSubview:view];
        
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(_priceLabel);
            make.right.equalTo(self).offset(-10);
        }];
        
        view;
    });
    
    //goods code
    _goodsCodeLabel = ({
        UILabel *view = [UILabel new];
        [view sizeToFit];
        view.font = [UIFont boldSystemFontOfSize:13];
        view.text = @"商品编号:832323";
        view.numberOfLines = 1;
        [self addSubview:view];
        
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_priceLabel);
            make.top.equalTo(_priceLabel.mas_bottom);
        }];
        
        view;
    });
    
    //preferential info
    _preferentialInfoLabel = ({
        UILabel *view = [UILabel new];
        [view sizeToFit];
        view.numberOfLines = 0;
        view.font = [UIFont systemFontOfSize:11];
        view.textColor = kFlagQABG;
        view.text = @"任意搭配1件，本商品可减56元 / 任意搭配2件，本商品可减56元";
        [self addSubview:view];
        
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_goodsCodeLabel);
            make.right.equalTo(self).offset(-10);
            make.top.equalTo(_goodsCodeLabel.mas_bottom).offset(10);
        }];
        
        view;
    });
    
    //line
    UIView *lineView = ({
        UIView *view = [UIView new];
        view.backgroundColor = kCellLineColor;
        [self addSubview:view];
        
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self);
            make.top.equalTo(self).offset(103);
            make.height.equalTo(@.5f);
        }];
        
        view;
    });
    
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end