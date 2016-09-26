//
//  HCTopImageBottpnTitleView.m
//  HCFunwear
//
//  Created by 刘海川 on 16/9/25.
//  Copyright © 2016年 Haichuan Liu. All rights reserved.
//

#import "HCTopImageBottpnTitleView.h"
#import "GlobalImport.h"
#import "Masonry.h"
#import "UIColor+YYAdd.h"

@interface HCTopImageBottpnTitleView ()
{
    UIImageView *_imageView;
    UILabel *_titleLabel;
    UILabel *_countLabel;
}
@end

@implementation HCTopImageBottpnTitleView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //icon imageview
        _imageView = ({
            UIImageView *view = [UIImageView new];
            view.contentMode = UIViewContentModeCenter;
            [self addSubview:view];
            
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(@10);
                make.left.right.equalTo(self);
                make.height.equalTo(@20);
            }];
            
            view;
        });
        
        //title label
        _titleLabel = ({
            UILabel *view = [UILabel new];
            view.textAlignment = NSTextAlignmentCenter;
            view.font = [UIFont systemFontOfSize:10];
            [self addSubview:view];
            
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(_imageView.mas_bottom).offset(5);
                make.left.right.equalTo(self);
                make.height.equalTo(@10);
            }];
            
            view;
        });
        
        //count label
        _countLabel = ({
            UILabel *view = [UILabel new];
            view.textAlignment = NSTextAlignmentCenter;
            view.font = [UIFont systemFontOfSize:9];
            view.textColor = [UIColor whiteColor];
            view.text = @"9";
            view.layer.cornerRadius = 15/2.0;
            view.backgroundColor = [UIColor colorWithHexString:@"#FFFD5B5E"];
            [self addSubview:view];
            
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerX.equalTo(_imageView.mas_right);
                make.centerY.equalTo(_imageView.mas_top);
                make.height.width.equalTo(@15);
            }];
            
            view;
        });
    }
    return self;
}

- (void)setTitle:(NSString *)title image:(UIImage *)image count:(NSString *)count {
    _titleLabel.text = title;
    _imageView.image = image;
    [self setCount:count];
}

- (void)setCount:(NSString *)count {
    if ([count isEqualToString:@"0"] || count == nil) {
        _countLabel.hidden = YES;
    }
    else {
        _countLabel.text = count;
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
