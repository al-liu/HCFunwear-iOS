//
//  NewArrivalsHeadCell.m
//  HCFunwear
//
//  Created by 刘海川 on 16/7/12.
//  Copyright © 2016年 Haichuan Liu. All rights reserved.
//

#import "NewArrivalsHeadCell.h"
#import "CategoryPageHeadTitleView.h"
#import "Masonry.h"

@implementation NewArrivalsHeadCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        CategoryPageHeadTitleView *headView = ({
            CategoryPageHeadTitleView *view = [[CategoryPageHeadTitleView alloc]initWithShowMore:NO];
            view.backgroundColor = [UIColor whiteColor];
            [self.contentView addSubview:view];
            
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.edges.equalTo(self.contentView);
            }];
            
            view;
        });
        headView.titleLabel.text = @"优选新品";
        headView.titleEnLabel.text = @"New Arrivals";
    }
    return self;
}

@end
