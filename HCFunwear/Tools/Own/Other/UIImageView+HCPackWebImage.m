//
//  UIImageView+HCPackWebImage.m
//  HCFunwear
//
//  Created by 刘海川 on 16/9/5.
//  Copyright © 2016年 Haichuan Liu. All rights reserved.
//

#import "UIImageView+HCPackWebImage.h"
#import "UIImageView+YYWebImage.h"
#import "RACEXTScope.h"
#import "UIImageView+WebCache.h"

@implementation UIImageView (HCPackWebImage)

- (void)packSetImageWithURL:(NSURL *)url
                placeholder:(UIImage *)placeholder
                contentMode:(UIViewContentMode)mode {
    @weakify(self);
    self.contentMode = UIViewContentModeCenter;
    /*
    [self setImageWithURL:url placeholder:placeholder options:YYWebImageOptionAllowBackgroundTask completion:^(UIImage * _Nullable image, NSURL * _Nonnull url, YYWebImageFromType from, YYWebImageStage stage, NSError * _Nullable error) {
        @strongify(self);
        self.image = image;
        self.contentMode = mode;
    }];
     */
    
    [self sd_setImageWithURL:url placeholderImage:placeholder completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        @strongify(self);
        self.image = image;
        self.contentMode = mode;
    }];
}

- (void)packAspectFitModeSetImageWithURL:(NSURL *)url
                             placeholder:(UIImage *)placeholder {
    [self packSetImageWithURL:url placeholder:placeholder contentMode:UIViewContentModeScaleAspectFit];
}

- (void)packAspectFillModeSetImageWithURL:(NSURL *)url
                              placeholder:(UIImage *)placeholder {
    [self packSetImageWithURL:url placeholder:placeholder contentMode:UIViewContentModeScaleAspectFill];
}


@end
