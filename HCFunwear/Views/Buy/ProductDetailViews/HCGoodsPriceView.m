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
    UILabel *goodsName = ({
        UILabel *label = [UILabel new];
        label.textColor = [UIColor colorWithHexString:@"#FF666666"];
        label.font = [UIFont systemFontOfSize:15];
        [self addSubview:label];
        
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.equalTo(self).offset(15);
            make.right.equalTo(self).offset(-15);
        }];
        
        label;
    });
    goodsName.text = @"puma PUMA中性R698 Block经典生活系列多彩慢跑鞋";
    
    UILabel *goodsPrice = ({
        UILabel *label = [UILabel new];
        label.textColor = [UIColor colorWithHexString:@"#FF333333"];
        label.font = [UIFont systemFontOfSize:25];
        [self addSubview:label];
        
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@30);
            make.left.equalTo(self).offset(15);
            make.top.equalTo(goodsName).offset(15);
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
        label.textColor = [UIColor colorWithHexString:@"#FF999999"];
        label.font = [UIFont systemFontOfSize:13];
        [self addSubview:label];
        
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@16);
            make.left.equalTo(goodsPrice.mas_right).offset(10);
            make.bottom.equalTo(goodsPrice).offset(-3);
            make.right.equalTo(self).offset(-15);
        }];
        
        [label setContentHuggingPriority:UILayoutPriorityDefaultHigh
                                 forAxis:UILayoutConstraintAxisHorizontal];
        [label setContentCompressionResistancePriority:UILayoutPriorityDefaultHigh
                                               forAxis:UILayoutConstraintAxisHorizontal];
        
        label;
    });
    goodsOriginPrice.text = @"500000";
    
    UIView *deleteLineView = ({
        UIView *view = [UIView new];
        view.backgroundColor = [UIColor colorWithHexString:@"#FF999999"];
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
