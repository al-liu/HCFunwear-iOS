//
//  MineMenuModel.m
//  HCFunwear
//
//  Created by 刘海川 on 16/7/12.
//  Copyright © 2016年 Haichuan Liu. All rights reserved.
//

#import "MineMenuModel.h"

@implementation MineMenuModel

- (instancetype)initWithImage:(NSString *)image
                        title:(NSString *)title {
    self = [super init];
    if (self) {
        _iconImageString = image;
        _iconTitleString = title;
    }
    return self;
}

@end
