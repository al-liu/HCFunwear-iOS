//
//  HCAppraiseStarsView.m
//  HCFunwear
//
//  Created by 刘海川 on 16/9/27.
//  Copyright © 2016年 Haichuan Liu. All rights reserved.
//

#import "HCAppraiseStarsView.h"
#import "Masonry.h"

@interface HCAppraiseStarsView ()
{
    NSMutableArray *_starMutableArray;
}
@end

@implementation HCAppraiseStarsView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _starMutableArray = [[NSMutableArray alloc]initWithCapacity:5];
        self.backgroundColor = [UIColor whiteColor];
        //w-25 h-15
        UIView *lastView = self;
        for (int i = 0; i < 5; i++) {
            UIImageView *starView = ({
                UIImageView *view = [UIImageView new];
                view.image = [UIImage imageNamed:@"add1"];
                [self addSubview:view];
                
                [view mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.width.equalTo(@25);
                    make.height.equalTo(@15);
                    if (i == 0) {
                        make.left.equalTo(lastView);
                    }
                    else {
                        make.left.equalTo(lastView.mas_right);
                    }
                    make.centerY.equalTo(self);
                }];
                
                view;
            });
            lastView = starView;
            [_starMutableArray addObject:starView];
        }
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
