//
//  InspirationPageFunerView.h
//  HCFunwear
//
//  Created by 刘海川 on 16/7/8.
//  Copyright © 2016年 Haichuan Liu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HCViewModelBindProtocol.h"
#import "InspirationPageViewModel.h"
#import "HCInspirationByUsers.h"

@interface InspirationPageFunerView : UIView <UICollectionViewDataSource,UICollectionViewDelegate,HCViewModelBindProtocol>

@property (nonatomic, strong) InspirationPageViewModel *viewModel;
@property (nonatomic, strong) NSMutableArray *funerDataList;

- (void)header_beginRefreshing;

@end
