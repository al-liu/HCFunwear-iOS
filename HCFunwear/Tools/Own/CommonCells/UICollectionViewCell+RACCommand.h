//
//  UICollectionViewCell+RACCommand.h
//  HCFunwear
//
//  Created by 刘海川 on 16/8/22.
//  Copyright © 2016年 Haichuan Liu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NSObject+YYAdd.h"
#import "ReactiveCocoa.h"

@interface UICollectionViewCell (RACCommand)

@property (nonatomic, strong) RACCommand *push;

@end
