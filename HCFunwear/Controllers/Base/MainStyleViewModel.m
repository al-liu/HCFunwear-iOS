//
//  MainStyleViewModel.m
//  HCFunwear
//
//  Created by 刘海川 on 16/10/10.
//  Copyright © 2016年 Haichuan Liu. All rights reserved.
//

#import "MainStyleViewModel.h"
#import "NSObject+YYModel.h"
#import "SDWebImageDownloader.h"
/*
 [ ]请求广告的接口
 [ ]对应的数据模型
 [ ]保存广告图片的接口
 [ ]按钮跳转的逻辑
 [ ]ImageView 的动画，按钮隐藏显示的逻辑
 
 */

static NSString *lanuch_banner_image_key = @"launchBanner_img";

@interface MainStyleViewModel ()

@property (strong, nonatomic) id <HCHomeViewModelServices> services;

@end

@implementation MainStyleViewModel

- (instancetype)initWithServices:(id<HCHomeViewModelServices>)services {
    self = [super init];
    if (self) {
        _services = services;
        [self initialize];
    }
    return self;
}

- (void)initialize {
    
    //先去获取之前存好的广告
    NSData *bannerImageData = [[NSUserDefaults standardUserDefaults] objectForKey:lanuch_banner_image_key];
    self.launchBannerImage = [UIImage imageWithData:bannerImageData];
    if (self.launchBannerImage == nil) {
        NSString *pic_enter_path = [[NSBundle mainBundle] pathForResource:@"pic_enter_empt@2x" ofType:@"png"];
        NSData *pic_enter_data = [NSData dataWithContentsOfFile:pic_enter_path];
        UIImage *pic_enter = [UIImage imageWithData:pic_enter_data];
        self.launchBannerImage = pic_enter;
    }
    
    self.appConfigRequestCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        return [self executeConfigSignal];
    }];
    
    self.pushCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        return [self executePushSignal:input];
    }];

}

- (RACSignal *)executeConfigSignal {
    return [[[self.services getMainStyleApiService] getAppConfig] map:^id(id value) {
        self.appConfigModel = [AppConfigModel modelWithJSON:value[@"data"][@"config"]];
        
        //保存广告
        [[SDWebImageDownloader sharedDownloader]downloadImageWithURL:self.appConfigModel.launchBanner.img options:SDWebImageDownloaderHighPriority progress:nil completed:^(UIImage *image, NSData *data, NSError *error, BOOL finished) {
            self.launchBannerImage = image;
            [[NSUserDefaults standardUserDefaults] setObject:data forKey:lanuch_banner_image_key];
            [[NSUserDefaults standardUserDefaults] synchronize];
        }];
        
        return self.appConfigModel;
    }];
}

- (RACSignal *)executePushSignal:(id)viewModel {
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [self.services pushViewModel:viewModel];
        [subscriber sendCompleted];
        return nil;
    }];
}

@end
