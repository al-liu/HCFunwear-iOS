//
//  TopStyleButton.h
//  HCFunwear
//
//  Created by 刘海川 on 16/5/26.
//  Copyright © 2016年 Haichuan Liu. All rights reserved.
//

#import <UIKit/UIKit.h>

//TODO:要看这里是不是动态的，如果是则不适合定义枚举。
typedef NS_ENUM(NSInteger,FunwearStyle) {
    ManFunwearStyle = 0,
    WomenFunwearStyle,
    LifeFunwearStyle
};

@class TopStyleButton;
@protocol TopStyleDelegate <NSObject>

- (NSString *)topStyleButton:(TopStyleButton *)button cellForTitleAtIndexPath:(NSIndexPath *)indexPath;

- (void)topStyleButton:(TopStyleButton *)button didSelectStyle:(FunwearStyle )style;

@end

@interface TopStyleButton : UIButton <UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, assign) FunwearStyle funwearStyle;
@property (nonatomic, assign, readonly) BOOL isShow;
@property (nonatomic, weak) id delegate;

@end
