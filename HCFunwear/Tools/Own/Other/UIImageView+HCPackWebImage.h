//
//  UIImageView+HCPackWebImage.h
//  HCFunwear
//
//  Created by 刘海川 on 16/9/5.
//  Copyright © 2016年 Haichuan Liu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (HCPackWebImage)

- (void)packSetImageWithURL:(NSURL *)url
                placeholder:(UIImage *)placeholder
                contentMode:(UIViewContentMode)mode;

- (void)packAspectFitModeSetImageWithURL:(NSURL *)url
                placeholder:(UIImage *)placeholder;

- (void)packAspectFillModeSetImageWithURL:(NSURL *)url
                placeholder:(UIImage *)placeholder;

@end
