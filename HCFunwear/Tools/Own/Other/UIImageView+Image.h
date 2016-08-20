//
//  UIImageView+Image.h
//  HCFunwear
//
//  Created by 刘海川 on 16/8/20.
//  Copyright © 2016年 Haichuan Liu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (Image)

- (void)toloadImageWithURL:(NSURL *)url placeholder:(UIImage *)placeholder;

@end
