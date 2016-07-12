//
//  MineTableMenuModel.h
//  HCFunwear
//
//  Created by 刘海川 on 16/7/12.
//  Copyright © 2016年 Haichuan Liu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MineTableMenuModel : NSObject

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *subTitle;
@property (nonatomic, assign) BOOL showPoint;

- (instancetype)initWithTitle:(NSString *)title
                     subTitle:(NSString *)subTitle
                        awake:(BOOL)awake;

- (instancetype)initWithTitle:(NSString *)title
                        awake:(BOOL)awake;

- (instancetype)initWithTitle:(NSString *)title;

@end
