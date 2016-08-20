//
//  UIImageView+Image.m
//  HCFunwear
//
//  Created by 刘海川 on 16/8/20.
//  Copyright © 2016年 Haichuan Liu. All rights reserved.
//

#import "UIImageView+Image.h"
#import "UIImageView+YYWebImage.h"
#import "RACEXTScope.h"

@implementation UIImageView (Image)

- (void)toloadImageWithURL:(NSURL *)url placeholder:(UIImage *)placeholder {
    @weakify(self);
    self.contentMode = UIViewContentModeCenter;
    [self setImageWithURL:url placeholder:placeholder options:YYWebImageOptionAllowBackgroundTask completion:^(UIImage * _Nullable image, NSURL * _Nonnull url, YYWebImageFromType from, YYWebImageStage stage, NSError * _Nullable error) {
        @strongify(self);
        self.image = image;
        self.contentMode = UIViewContentModeScaleAspectFit;
    }];
}

@end
