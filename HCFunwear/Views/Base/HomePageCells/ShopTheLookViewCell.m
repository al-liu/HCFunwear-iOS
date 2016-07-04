//
//  ShopTheLookViewCell.m
//  HCFunwear
//
//  Created by 刘海川 on 16/7/4.
//  Copyright © 2016年 Haichuan Liu. All rights reserved.
//

#import "ShopTheLookViewCell.h"
#import "Masonry.h"
#import "ShopTheLookView.h"

@implementation ShopTheLookViewCell {
    ShopTheLookView *_shopTheLookView;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _shopTheLookView = ({
            ShopTheLookView *view = [ShopTheLookView new];
            [self.contentView addSubview:view];
            
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.edges.equalTo(self.contentView);
            }];
            
            view;
        });
    }
    return self;
}

@end
