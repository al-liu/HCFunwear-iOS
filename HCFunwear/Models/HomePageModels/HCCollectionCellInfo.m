//
//  HCCollectionCellInfo.m
//  HCFunwear
//
//  Created by 刘海川 on 16/8/16.
//  Copyright © 2016年 Haichuan Liu. All rights reserved.
//

#import "HCCollectionCellInfo.h"

@implementation HCCollectionCellInfo

- (instancetype)initWithIdentifier:(NSString *)cellId
                          sizeItem:(CGSize)cellSize
                minimumLineSpacing:(CGFloat)spacingSize
            referenceSizeForHeader:(CGSize)headerSize
                   insetForSection:(UIEdgeInsets)inset
                         cellClass:(NSString *)cellClass;{
    self = [super init];
    if (self) {
        _identifier = cellId;
        _sizeItem = cellSize;
        _minimumLineSpacing = spacingSize;
        _referenceSizeForHeader = headerSize;
        _insetForSection = inset;
        _cellClass = cellClass;
    }
    return self;
}

@end
