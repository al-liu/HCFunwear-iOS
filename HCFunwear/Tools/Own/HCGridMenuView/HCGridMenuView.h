//
//  HCGridMenuView.h
//  HCFunwear
//
//  Created by 刘海川 on 16/6/28.
//  Copyright © 2016年 Haichuan Liu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HCModuleData.h"

@class HCGridMenuView,HCGridInfo;
@protocol HCGridMenuViewProtocol <NSObject>

- (void)HCGridMenuView:(HCGridMenuView *)menuView selectedAtGridInfo:(HCModuleData *)gridInfo;

@end

@interface HCGridMenuView : UIView <UICollectionViewDataSource , UICollectionViewDelegate>

@property (nonatomic, weak) id <HCGridMenuViewProtocol> delegate;
/**
 *  Block 回调点击菜单事件
 */
@property (nonatomic, copy) void(^menuClickBlock)(NSInteger index);

/**
 *  直接加载菜单，不用网络获取。
 *
 *  @param list 里面一定要放 HCGridInfo 模型
 *
 *  @return 返回当前实例
 */
- (instancetype)initWithTypes:(NSArray *)list;

/**
 *  网络加载菜单
 *
 *  @param list 里面一定要放 HCGridInfo 模型
 */
- (void)reloadDataWithTypes:(NSArray *)list;

@end

/**
 *  菜单对应的 Cell 视图
 */
@interface HCGridMenuCell : UICollectionViewCell

@property (nonatomic, strong) UIImageView *iconView;
@property (nonatomic, strong) UILabel *titleView;

@end
