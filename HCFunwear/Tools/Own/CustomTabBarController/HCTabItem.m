//
//  HCTabItem.m
//  HCmafengwo
//
//  Created by 刘海川 on 16/4/22.
//  Copyright © 2016年 Haichuan Liu. All rights reserved.
//

#import "HCTabItem.h"

@implementation HCTabItem

- (instancetype)initWithTitle:(NSString *)title
                        image:(UIImage *)image
                selectedImage:(UIImage *)selectedImage
                   titleColor:(UIColor *)color
                selectedColor:(UIColor *)selectedColor{
    self = [super init];
    if (!self) return nil;
    
    _normalImage = image;
    _selectImage = selectedImage;
    _title = title;
    _titleNormalColor = color;
    _titleSelectColor = selectedColor;
    
    return self;
}

@end
