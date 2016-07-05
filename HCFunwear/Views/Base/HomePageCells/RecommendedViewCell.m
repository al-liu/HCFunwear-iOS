//
//  RecommendedViewCell.m
//  HCFunwear
//
//  Created by 刘海川 on 16/7/5.
//  Copyright © 2016年 Haichuan Liu. All rights reserved.
//

#import "RecommendedViewCell.h"
#import "HomePageHeadTitleView.h"
#import "Masonry.h"
#import "GlobalColors.h"

@implementation RecommendedViewCell {
    HomePageHeadTitleView *_headTitleView;
    UIView *_line;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        _headTitleView = ({
            HomePageHeadTitleView *view = [[HomePageHeadTitleView alloc] initWithShowMore:NO];
            [self addSubview:view];
            view.titleLabel.text = @"猜你喜欢";
            view.titleEnLabel.text = @"Recommended";
            
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.right.top.equalTo(self);
                make.height.equalTo(@43);
            }];
            
            view;
        });
        
        _line = ({
            UIView *view = [UIView new];
            view.backgroundColor = kCellLineColor;
            [_headTitleView addSubview:view];
            
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(_headTitleView).offset(15);
                make.height.equalTo(@.5);
                make.right.bottom.equalTo(_headTitleView);
            }];
            view;
        });
    }
    return self;
}

@end
