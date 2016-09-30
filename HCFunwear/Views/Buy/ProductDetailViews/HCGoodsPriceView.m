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

@interface HCGoodsPriceView()
{
    UILabel *_goodsName;
    UILabel *_goodsPrice;
    UILabel *_goodsOriginPrice;
}
@end

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
    
    _goodsName = ({
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
    
    _goodsPrice = ({
        UILabel *label = [UILabel new];
        label.font = [UIFont systemFontOfSize:25];
        [self addSubview:label];
        
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@30);
            make.left.equalTo(self).offset(15);
            make.top.equalTo(_goodsName.mas_bottom).offset(25);
            make.bottom.equalTo(self).offset(-38);
        }];
        
        [label setContentHuggingPriority:UILayoutPriorityRequired
                                 forAxis:UILayoutConstraintAxisHorizontal];
        [label setContentCompressionResistancePriority:UILayoutPriorityRequired
                                               forAxis:UILayoutConstraintAxisHorizontal];
        
        label;
    });
    
    _goodsOriginPrice = ({
        UILabel *label = [UILabel new];
        label.textColor = kTextColor325;
        label.font = [UIFont systemFontOfSize:13];
        [self addSubview:label];
        
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@16);
            make.left.equalTo(_goodsPrice.mas_right).offset(10);
            make.bottom.equalTo(_goodsPrice).offset(-3);
            make.right.lessThanOrEqualTo(self).offset(-15);
        }];
        
        [label setContentHuggingPriority:UILayoutPriorityRequired
                                 forAxis:UILayoutConstraintAxisHorizontal];
        [label setContentCompressionResistancePriority:UILayoutPriorityDefaultHigh
                                               forAxis:UILayoutConstraintAxisHorizontal];
        
        label;
    });
    
    UIView *deleteLineView = ({
        UIView *view = [UIView new];
        [_goodsOriginPrice addSubview:view];
        
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@1);
            make.left.right.equalTo(_goodsOriginPrice);
            make.centerY.equalTo(_goodsOriginPrice);
        }];
        
        view;
    });
    deleteLineView.backgroundColor = kTextColor325;
}

- (void)reloadData:(HCClsInfo *)clsInfo {
    _goodsPrice.text = [NSString stringWithFormat:@"%0.2f",[clsInfo.sale_price floatValue]];
    _goodsOriginPrice.text = [NSString stringWithFormat:@"%0.2f",[clsInfo.marketPrice floatValue]];
    
    NSString *str = [NSString stringWithFormat:@"%@ %@",clsInfo.brand,clsInfo.name];
    NSMutableAttributedString *goodsNameString = [[NSMutableAttributedString alloc]initWithString:str];
    [goodsNameString setLineSpacing:10];
    _goodsName.attributedText = goodsNameString;
}

@end
