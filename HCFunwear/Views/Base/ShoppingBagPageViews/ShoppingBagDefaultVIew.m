//
//  ShoppingBagDefaultVIew.m
//  HCFunwear
//
//  Created by 刘海川 on 16/7/11.
//  Copyright © 2016年 Haichuan Liu. All rights reserved.
//

#import "ShoppingBagDefaultVIew.h"
@interface ShoppingBagDefaultVIew ()
{
    __weak IBOutlet UIButton *loginButton;
    
}
@end

//TODO:购物图片，可以根据 SizeClass 显示不显示
#warning SizeClass 再布局
@implementation ShoppingBagDefaultVIew

- (void)awakeFromNib {
    loginButton.layer.borderWidth = .5f;
    loginButton.layer.borderColor = [UIColor blackColor].CGColor;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
