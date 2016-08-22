//
//  UICollectionViewCell+RACCommand.m
//  HCFunwear
//
//  Created by 刘海川 on 16/8/22.
//  Copyright © 2016年 Haichuan Liu. All rights reserved.
//

#import "UICollectionViewCell+RACCommand.h"
#import <objc/runtime.h>

static const void *kPushPropertyKey = @"kPushPropertyKey";
@implementation UICollectionViewCell (RACCommand)

@dynamic push;

-(void)setPush:(id)push {
    objc_setAssociatedObject(self, kPushPropertyKey, push, OBJC_ASSOCIATION_RETAIN_NONATOMIC );
}

-(id)push{
    return objc_getAssociatedObject(self, kPushPropertyKey);
}

@end
