//
//  HCTabButton.m
//  HCmafengwo
//
//  Created by 刘海川 on 16/4/22.
//  Copyright © 2016年 Haichuan Liu. All rights reserved.
//

#import "HCTabButton.h"

@implementation HCTabButton

- (instancetype)initWithItem:(HCTabItem *)item style:(HCTabButtonStyle)style {
    self = [super init];
    if (!self) return nil;
    
    [self configButtonStateWithItem:item];
    _tabButtonStyle = style;
    
    return self;
}

- (instancetype)initWithItem:(HCTabItem *)item {
    self = [super init];
    if (!self) return nil;
    
    [self configButtonStateWithItem:item];
    _tabButtonStyle = HCTabButtonStyleVertical;
    
    return self;
}

- (void)updateItem:(HCTabItem *)item {
    [self configButtonStateWithItem:item];
}

- (void)configButtonStateWithItem:(HCTabItem *)item {
    [self setImage:item.normalImage forState:UIControlStateNormal];
    [self setImage:item.selectImage forState:UIControlStateSelected];
    [self setTitle:item.title forState:UIControlStateNormal];
    [self setTitleColor:item.titleNormalColor forState:UIControlStateNormal];
    [self setTitleColor:item.titleSelectColor forState:UIControlStateSelected];
}

- (void)configButtonLayout {
    if (_tabButtonStyle == HCTabButtonStyleHorizontal) {
        [self setImageEdgeInsets:UIEdgeInsetsMake(0, -5, 0, 0)];
        [self setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, -5)];
    }
    else if (_tabButtonStyle == HCTabButtonStyleVertical) {
        CGSize buttonSize = self.frame.size;
        CGRect imageRect = CGRectMake(5, 5, buttonSize.width-10, 28);
        self.imageView.frame = imageRect;
        self.imageView.contentMode = UIViewContentModeBottom;
        //4+10+4 = 18 h  49-18 = 31
        CGRect titleRect = CGRectMake(5, CGRectGetMaxY(imageRect), buttonSize.width-10, 16);
        self.titleLabel.frame = titleRect;
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.font = [UIFont systemFontOfSize:10];
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self configButtonLayout];
}

- (void)setHighlighted:(BOOL)highlighted {
    
}

@end
