//
//  HotCategoryViewCell.m
//  HCFunwear
//
//  Created by 刘海川 on 16/7/4.
//  Copyright © 2016年 Haichuan Liu. All rights reserved.
//

#import "HotCategoryViewCell.h"
#import "HotCategoryView.h"
#import "Masonry.h"

@implementation HotCategoryViewCell {
    HotCategoryView *_hotGategoryView;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _hotGategoryView = ({
            HotCategoryView *view = [HotCategoryView new];
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
