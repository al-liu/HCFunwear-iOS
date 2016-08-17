//
//  HomePageHeadTitleView.h
//  HCFunwear
//
//  Created by 刘海川 on 16/7/1.
//  Copyright © 2016年 Haichuan Liu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HCModule.h"

@interface HomePageHeadTitleView : UIView {
    UILabel *_titleLabel;
    UILabel *_titleEnLabel;
}

- (instancetype)initWithShowMore:(BOOL)flag;
@property (nonatomic, assign) BOOL isShowMore;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *titleEnLabel;

@property (nonatomic, strong) HCModule *headModule;

@end