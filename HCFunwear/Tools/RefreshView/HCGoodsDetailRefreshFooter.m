//
//  HCGoodsDetailRefreshFooter.m
//  HCFunwear
//
//  Created by 刘海川 on 16/9/26.
//  Copyright © 2016年 Haichuan Liu. All rights reserved.
//

#import "HCGoodsDetailRefreshFooter.h"

@interface HCGoodsDetailRefreshFooter ()
{
    UIView *_stateView;
}
@end

@implementation HCGoodsDetailRefreshFooter

- (void )setStateView
{
    if (!_stateView) {
        _stateView = [[UIView alloc]initWithFrame:self.bounds];
        CGFloat width = self.bounds.size.width;
        CGFloat height = self.bounds.size.height;
        //l-10 w-50 t-30
        UIView *line01 = [[UIView alloc]initWithFrame:CGRectMake(10, height/2, 50, 0.5)];
        line01.backgroundColor = [UIColor colorWithWhite:0.827 alpha:1.000];
        [self addSubview:line01];
        
        UIView *line02 = [[UIView alloc]initWithFrame:CGRectMake(width-50-10, height/2, 50, 0.5)];
        line02.backgroundColor = [UIColor colorWithWhite:0.827 alpha:1.000];
        [self addSubview:line02];
        
        UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(line01.frame)+10, 0, width-140, height)];
        titleLabel.font = [UIFont systemFontOfSize:12];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.text = @"继续拖动,查看图文详情";
        titleLabel.textColor = [UIColor colorWithWhite:0.537 alpha:1.000];
        [self addSubview:titleLabel];
        
        [self addSubview:_stateView];
    }
}

- (void)placeSubviews
{
    [super placeSubviews];
    
    [self setStateView];
}

@end
