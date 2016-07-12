//
//  MineMenuModel.h
//  HCFunwear
//
//  Created by 刘海川 on 16/7/12.
//  Copyright © 2016年 Haichuan Liu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MineMenuModel : NSObject

@property (nonatomic, copy) NSString *iconImageString;
@property (nonatomic, copy) NSString *iconTitleString;

- (instancetype)initWithImage:(NSString *)image
                        title:(NSString *)title;

@end
