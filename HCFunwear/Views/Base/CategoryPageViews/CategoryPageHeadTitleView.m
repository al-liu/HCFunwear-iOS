//
//  CategoryPageHeadTitleView.m
//  HCFunwear
//
//  Created by 刘海川 on 16/7/8.
//  Copyright © 2016年 Haichuan Liu. All rights reserved.
//

#import "CategoryPageHeadTitleView.h"
#import "Masonry.h"
#import "GlobalColors.h"

@implementation CategoryPageHeadTitleView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initUI];
    }
    return self;
}

- (void)initUI {
    //header h:34
    _titleLabel = ({
        UILabel *label = [UILabel new];
        label.font = [UIFont systemFontOfSize:12];
        [self addSubview:label];
        label.text = @"热门品牌";
        
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(15);
            make.top.bottom.equalTo(self);
        }];
        
        [label setContentCompressionResistancePriority:UILayoutPriorityDefaultLow
                                               forAxis:UILayoutConstraintAxisHorizontal];
        [label setContentHuggingPriority:UILayoutPriorityDefaultHigh
                                 forAxis:UILayoutConstraintAxisHorizontal];
        
        label;
    });
    //43-30 h:13
    UIView *verticalLine = ({
        UIView *view = [UIView new];
        view.backgroundColor = kCellLineColor;
        [self addSubview:view];
        
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(@1);
            make.top.equalTo(@10);
            make.bottom.equalTo(self).offset(-10);
            make.left.equalTo(_titleLabel.mas_right).offset(5);
        }];
        view;
    });
    
    //更多 >
    UIButton *moreButton = ({
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self addSubview:button];
        
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.right.equalTo(self);
            make.width.equalTo(@60);
        }];
        
        button;
    });
    
    UIImageView *allowImageView = ({
        UIImageView *view = [UIImageView new];
        view.backgroundColor = [UIColor grayColor];
        [moreButton addSubview:view];
        
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(moreButton).offset(-10);
            make.centerY.equalTo(moreButton);
        }];
        
        view;
    });
    allowImageView.image = [UIImage imageNamed:@"btn_more"];

    UILabel *moreTitle = ({
        UILabel *label = [UILabel new];
        label.font = [UIFont systemFontOfSize:12];
        label.textColor = kCellLineColor;
        [self addSubview:label];
        
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(allowImageView.mas_left).offset(-5);
            make.top.bottom.equalTo(self);
        }];
        
        label;
    });
    moreTitle.text = @"更多";
    
    
    _titleEnLabel = ({
        UILabel *label = [UILabel new];
        label.font = [UIFont systemFontOfSize:15];
        label.textColor = kCellLineColor;
        [self addSubview:label];
        label.text = @"New";
        
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(verticalLine.mas_right).offset(5);
            make.top.bottom.equalTo(self);
            //width >= 50
            make.width.greaterThanOrEqualTo(@50);
            make.right.equalTo(moreButton.mas_left);
        }];
        
        [label setContentCompressionResistancePriority:UILayoutPriorityDefaultLow-1
                                               forAxis:UILayoutConstraintAxisHorizontal];
        [label setContentHuggingPriority:UILayoutPriorityDefaultLow
                                 forAxis:UILayoutConstraintAxisHorizontal];
        
        label;
    });
    
    UIView *horizontalLine = ({
        UIView *view = [UIView new];
        [self addSubview:view];
        
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@.5f);
            make.bottom.equalTo(self);
            make.left.equalTo(self).offset(15);
            make.right.equalTo(self);
        }];
        view;
    });
    horizontalLine.backgroundColor = kCellLineColor;

}

@end
