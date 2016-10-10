//
//  AppConfigModel.h
//  HCFunwear
//
//  Created by 刘海川 on 16/10/10.
//  Copyright © 2016年 Haichuan Liu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class LaunchBanner;
@interface AppConfigModel : NSObject

@property (nonatomic, strong) LaunchBanner *launchBanner;

@end

@interface LaunchBanner : NSObject

@property (nonatomic, strong) NSURL *img;

@property (nonatomic, strong) NSURL *url;

@end
