//
//  TopStyleButton.m
//  HCFunwear
//
//  Created by 刘海川 on 16/5/26.
//  Copyright © 2016年 Haichuan Liu. All rights reserved.
//

#import "TopStyleButton.h"

@implementation TopStyleButton

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setTitle:@"WOMEN" forState:UIControlStateNormal];
        [self setImage:[UIImage imageNamed:@"top_filter_down_arrow"] forState:UIControlStateNormal];
        [self addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

- (void)clickAction:(UIButton *)button {
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
