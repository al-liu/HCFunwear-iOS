//
//  HCGoodsPriceView.m
//  HCFunwear
//
//  Created by 刘海川 on 16/9/2.
//  Copyright © 2016年 Haichuan Liu. All rights reserved.
//

#import "HCGoodsPriceView.h"
#import "Masonry.h"
#import "UIColor+YYAdd.h"
#import "GlobalImport.h"
#import "NSAttributedString+YYText.h"

@implementation HCGoodsPriceView

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
    
    UILabel *goodsName = ({
        UILabel *label = [UILabel new];
        label.textColor = kTextColor325;
        label.font = [UIFont systemFontOfSize:15];
        label.numberOfLines = 0;
        [self addSubview:label];
        
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.equalTo(self).offset(15);
            make.right.equalTo(self).offset(-15);
        }];
        
        label;
    });
    NSString *str = @"puma PUMA中性R698 Block经典生活系列多彩慢跑鞋 ";
    NSMutableAttributedString *goodsNameString = [[NSMutableAttributedString alloc]initWithString:str];
    [goodsNameString setLineSpacing:10];
    goodsName.attributedText = goodsNameString;
    
    UILabel *goodsPrice = ({
        UILabel *label = [UILabel new];
        label.font = [UIFont systemFontOfSize:25];
        [self addSubview:label];
        
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@30);
            make.left.equalTo(self).offset(15);
            make.top.equalTo(goodsName.mas_bottom).offset(25);
            make.bottom.equalTo(self).offset(-38);
        }];
        
        [label setContentHuggingPriority:UILayoutPriorityRequired
                                 forAxis:UILayoutConstraintAxisHorizontal];
        [label setContentCompressionResistancePriority:UILayoutPriorityRequired
                                               forAxis:UILayoutConstraintAxisHorizontal];
        
        label;
    });
    goodsPrice.text = @"30000";
    
    UILabel *goodsOriginPrice = ({
        UILabel *label = [UILabel new];
        label.textColor = kTextColor325;
        label.font = [UIFont systemFontOfSize:13];
        [self addSubview:label];
        
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@16);
            make.left.equalTo(goodsPrice.mas_right).offset(10);
            make.bottom.equalTo(goodsPrice).offset(-3);
            make.right.lessThanOrEqualTo(self).offset(-15);
        }];
        
        [label setContentHuggingPriority:UILayoutPriorityRequired
                                 forAxis:UILayoutConstraintAxisHorizontal];
        [label setContentCompressionResistancePriority:UILayoutPriorityDefaultHigh
                                               forAxis:UILayoutConstraintAxisHorizontal];
        
        label;
    });
    goodsOriginPrice.text = @"500000";
    
    UIView *deleteLineView = ({
        UIView *view = [UIView new];
        view.backgroundColor = kTextColor325;
        [goodsOriginPrice addSubview:view];
        
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@1);
            make.left.right.equalTo(goodsOriginPrice);
            make.centerY.equalTo(goodsOriginPrice);
        }];
        
        view;
    });
    
}

@end
