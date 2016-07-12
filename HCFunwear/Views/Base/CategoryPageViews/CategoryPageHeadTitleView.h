//
//  CategoryPageHeadTitleView.h
//  HCFunwear
//
//  Created by 刘海川 on 16/7/8.
//  Copyright © 2016年 Haichuan Liu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CategoryPageHeadTitleView : UIView {
    UILabel *_titleLabel;
    UILabel *_titleEnLabel;
}

- (instancetype)initWithShowMore:(BOOL)flag;

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *titleEnLabel;

@property (nonatomic, assign) BOOL isShowMore;

@end
