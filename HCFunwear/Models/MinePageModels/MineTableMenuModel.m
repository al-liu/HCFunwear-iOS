//
//  MineTableMenuModel.m
//  HCFunwear
//
//  Created by 刘海川 on 16/7/12.
//  Copyright © 2016年 Haichuan Liu. All rights reserved.
//

#import "MineTableMenuModel.h"

@implementation MineTableMenuModel

- (instancetype)initWithTitle:(NSString *)title
                     subTitle:(NSString *)subTitle
                        awake:(BOOL)awake {
    self = [super init];
    if (self) {
        _title = title;
        _subTitle = subTitle;
        _showPoint = awake;
    }
    return self;
}

- (instancetype)initWithTitle:(NSString *)title
                        awake:(BOOL)awake {
    self = [super init];
    if (self) {
        _title = title;
        _subTitle = nil;
        _showPoint = awake;
    }
    return self;
}

- (instancetype)initWithTitle:(NSString *)title {
    self = [super init];
    if (self) {
        _title = title;
        _subTitle = nil;
        _showPoint = NO;
    }
    return self;
}

@end
