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

static NSString *lanuch_banner_image_key = @"launchBanner_img";

@interface MainStyleViewModel ()

@property (strong, nonatomic, readonly) id <HCMainStyleViewModelService> services;

@property (nonatomic, strong, readwrite) RACCommand *appConfigRequestCommand;

@property (nonatomic, strong, readwrite) RACCommand *pushCommand;

@property (nonatomic, strong, readwrite) RACCommand *tapCommand;

@property (nonatomic, strong, readwrite) AppConfigModel *appConfigModel;

@property (nonatomic, strong, readwrite) UIImage *launchBannerImage;

@end

@implementation MainStyleViewModel

@dynamic services;

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
    
    self.tapCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal *(id input) {
        return [self executeTapSignal:input];
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
        [self.services pushViewModel:viewModel animated:YES];
        [subscriber sendCompleted];
        return nil;
    }];
}

- (RACSignal *)executeTapSignal:(NSNumber *)tag {
    return [self.services selectedStyle:[tag integerValue]];
}

@end
