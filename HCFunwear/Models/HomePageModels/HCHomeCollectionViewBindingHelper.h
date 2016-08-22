//
//  HCHomeCollectionViewBindingHelper.h
//  HCFunwear
//
//  Created by 刘海川 on 16/8/22.
//  Copyright © 2016年 Haichuan Liu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ReactiveCocoa.h"

@interface HCHomeCollectionViewBindingHelper : NSObject <UICollectionViewDataSource,UICollectionViewDelegate>

- (instancetype) initWithCollectionView:(UICollectionView *)collectionView
                           sourceSignal:(RACSignal *)source
                         productsSignal:(RACSignal *)products
                            pushCommand:(RACCommand *)push;

+ (instancetype) initWithCollectionView:(UICollectionView *)collectionView
                           sourceSignal:(RACSignal *)source
                         productsSignal:(RACSignal *)products
                            pushCommand:(RACCommand *)push;

@end
