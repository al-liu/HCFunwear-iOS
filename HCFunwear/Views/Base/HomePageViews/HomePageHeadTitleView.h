//
//  HomePageHeadTitleView.h
//  HCFunwear
//
//  Created by 刘海川 on 16/7/1.
//  Copyright © 2016年 Haichuan Liu. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HeadTitleModel;
@interface HomePageHeadTitleView : UIView {
    UILabel *_titleLabel;
    UILabel *_titleEnLabel;
}

- (instancetype)initWithShowMore:(BOOL)flag;
@property (nonatomic, assign) BOOL isShowMore;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *titleEnLabel;

@property (nonatomic, strong) HeadTitleModel *headModel;

@end

@interface HeadTitleModel : NSObject

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *titleEn;
@property (nonatomic, assign) BOOL isShowMore;

- (instancetype)initWithTitle:(NSString *)title
                 englishTitle:(NSString *)titleEn
                   isShowMore:(BOOL)flag;

@end