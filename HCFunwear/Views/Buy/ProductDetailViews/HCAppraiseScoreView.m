//
//  HCAppraiseScoreView.m
//  HCFunwear
//
//  Created by 刘海川 on 16/9/27.
//  Copyright © 2016年 Haichuan Liu. All rights reserved.
//

#import "HCAppraiseScoreView.h"
#import "GlobalImport.h"
#import "Masonry.h"
#import "HCAppraiseStarsView.h"

@implementation HCAppraiseScoreView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //综合评分
        UILabel *synthesizeScoreLable = ({
            UILabel *label = [UILabel new];
            label.textColor = kTextColor404;
            label.font = [UIFont systemFontOfSize:15];
            label.text = @"综合评价：4.3";
            [self addSubview:label];
            
            [label mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(@15);
                make.top.bottom.equalTo(self);
            }];
            
            label;
        });
        
        //星星
        HCAppraiseStarsView *starsView = ({
            HCAppraiseStarsView *view = [HCAppraiseStarsView new];
            [self addSubview:view];
            
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.bottom.equalTo(self);
                make.left.equalTo(synthesizeScoreLable.mas_right).offset(10);
                make.right.equalTo(self).offset(-10);
                make.width.mas_greaterThanOrEqualTo(@125);
            }];
            
            view;
        });
        
        UIView *line02 = ({
            UIView *view = [UIView new];
            [self addSubview:view];
            
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.height.equalTo(@.5f);
                make.bottom.equalTo(self);
                make.left.right.equalTo(self);
            }];
            
            view;
        });
        line02.backgroundColor = kCellLineColor;
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
