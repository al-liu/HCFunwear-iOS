//
//  HCShoppingCartView.m
//  HCFunwear
//
//  Created by 刘海川 on 16/9/2.
//  Copyright © 2016年 Haichuan Liu. All rights reserved.
//

#import "HCShoppingCartView.h"
#import "Masonry.h"
#import "HCTopImageBottpnTitleView.h"
#import "GlobalColors.h"

@implementation HCShoppingCartView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initUI];
    }
    return self;
}

- (void)initUI {
    self.backgroundColor = [UIColor whiteColor];
    //135/320 加入购物袋 f:18
    UIButton *addGoodsBtn = ({
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.backgroundColor = [UIColor colorWithWhite:0.133 alpha:1.000];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        btn.adjustsImageWhenHighlighted = NO;
        [btn setTitle:@"加入购物袋" forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:18];
        [self addSubview:btn];
        
        [btn addTarget:self action:@selector(addGoods) forControlEvents:UIControlEventTouchUpInside];
        
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.right.equalTo(self);
            make.width.equalTo(self.mas_width).multipliedBy(135.0/320);
        }];
        
        btn;
    });
    
    HCTopImageBottpnTitleView *collectView = ({
        HCTopImageBottpnTitleView *view = [HCTopImageBottpnTitleView new];
        [self addSubview:view];
        
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(self);
            make.left.equalTo(self);
        }];
        
        view;
    });
    [collectView setTitle:@"收藏" image:[UIImage imageNamed:@"icon_collect_normal"] count:nil];
    
    HCTopImageBottpnTitleView *shoppingBagView = ({
        HCTopImageBottpnTitleView *view = [HCTopImageBottpnTitleView new];
        [self addSubview:view];
        
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(self);
            make.left.equalTo(collectView.mas_right);
            make.right.equalTo(addGoodsBtn.mas_left);
            make.width.equalTo(collectView.mas_width);
        }];
        
        view;
    });
    [shoppingBagView setTitle:@"购物袋" image:[UIImage imageNamed:@"icon_shopping_bag"] count:nil];
    
    //line
    UIView *line = ({
        UIView *view = [UIView new];
        [self addSubview:view];
       
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(@.5f);
            make.top.equalTo(self).offset(7);
            make.bottom.equalTo(self).offset(-7);
            make.left.equalTo(collectView.mas_right);
        }];
        
        view;
    });
    line.backgroundColor = kCellLineColor;
    
    UIView *line02 = ({
        UIView *view = [UIView new];
        [self addSubview:view];
       
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@.5f);
            make.top.equalTo(self);
            make.left.right.equalTo(self);
        }];
        
        view;
    });
    line02.backgroundColor = kCellLineColor;
}

- (void)addGoods {
    
}

@end
