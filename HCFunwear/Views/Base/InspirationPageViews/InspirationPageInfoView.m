//
//  InspirationPageInfoView.m
//  HCFunwear
//
//  Created by 刘海川 on 16/7/8.
//  Copyright © 2016年 Haichuan Liu. All rights reserved.
//

#import "InspirationPageInfoView.h"
#import "InspirationStyleScrollView.h"
#import "Masonry.h"
#import "InspirationInfoTableView.h"

@interface InspirationPageInfoView () <InspirationStyleScrollDelegate,InspirationInfoTableDelegate>

@end

@implementation InspirationPageInfoView {
    InspirationStyleScrollView *_styleScrollView;
    InspirationInfoTableView *_infoTableView;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initUI];
    }
    return self;
}

- (void)initUI {
    //h:42
    _styleScrollView = ({
        InspirationStyleScrollView *view = [InspirationStyleScrollView new];
        view.delegate = self;
        [self addSubview:view];
        
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.right.equalTo(self);
            make.height.equalTo(@42);
        }];
    
        view;
    });
    
    _infoTableView = ({
        InspirationInfoTableView *view = [InspirationInfoTableView new];
        view.delegate = self;
        [self addSubview:view];
        
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_styleScrollView.mas_bottom);
            make.left.right.bottom.equalTo(self);
        }];
        
        view;
    });
}

#pragma mark - InspirationStyleScrollDelegate
- (void)inspirationStyleScrollView:(InspirationStyleScrollView *)infoView
                      PageForIndex:(NSInteger)indx {
    _infoTableView.currentIndex = indx;
}

#pragma mark - InspirationInfoTableDelegate
- (void)inspirationInfoTableView:(InspirationInfoTableView *)infoView
                    PageForIndex:(NSInteger)indx {
    _styleScrollView.currentIndex = indx;
}

@end
