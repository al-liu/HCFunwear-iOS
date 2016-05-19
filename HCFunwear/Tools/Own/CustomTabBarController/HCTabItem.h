//
//  HCTabItem.h
//  HCmafengwo
//
//  Created by 刘海川 on 16/4/22.
//  Copyright © 2016年 Haichuan Liu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface HCTabItem : NSObject

@property (nonatomic, strong) UIImage *normalImage;
@property (nonatomic, strong) UIImage *selectImage;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, strong) UIColor *titleNormalColor;
@property (nonatomic, strong) UIColor *titleSelectColor;

/**
 *  初始化标签模型 需要的参数
 *
 *  @param title         显示文字
 *  @param image         正常显示的图片
 *  @param selectedImage 选中显示的图片
 *  @param color         正常显示的文字颜色
 *  @param selectedColor 选中显示的文字颜色
 *
 *  @return TabItem 用于配置标签信息
 */
- (instancetype)initWithTitle:(NSString *)title
                        image:(UIImage *)image
                selectedImage:(UIImage *)selectedImage
                   titleColor:(UIColor *)color
                selectedColor:(UIColor *)selectedColor;

@end