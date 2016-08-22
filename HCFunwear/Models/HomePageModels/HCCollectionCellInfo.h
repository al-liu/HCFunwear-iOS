//
//  HCCollectionCellInfo.h
//  HCFunwear
//
//  Created by 刘海川 on 16/8/16.
//  Copyright © 2016年 Haichuan Liu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface HCCollectionCellInfo : NSObject

@property (nonatomic ,assign) CGSize sizeItem;
@property (nonatomic ,assign) CGFloat minimumLineSpacing;
@property (nonatomic ,assign) CGSize referenceSizeForHeader;
@property (nonatomic ,assign) UIEdgeInsets insetForSection;
@property (nonatomic ,copy) NSString *identifier;
@property (nonatomic ,copy) NSString *cellClass;

- (instancetype)initWithIdentifier:(NSString *)cellId
                          sizeItem:(CGSize)cellSize
                minimumLineSpacing:(CGFloat)spacingSize
            referenceSizeForHeader:(CGSize)headerSize
                   insetForSection:(UIEdgeInsets)inset
                         cellClass:(NSString *)cellClass;

@end
