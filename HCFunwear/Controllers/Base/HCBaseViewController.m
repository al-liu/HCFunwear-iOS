//
//  HCBaseViewController.m
//  HCFunwear
//
//  Created by 刘海川 on 16/8/29.
//  Copyright © 2016年 Haichuan Liu. All rights reserved.
//

#import "HCBaseViewController.h"
#import "GlobalContext.h"
#import "GlobalConstant.h"

@implementation HCBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configNavigationBar];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [GlobalContext ShareInstance].rootController.interactivePopGestureRecognizer.delegate = self;
}

- (void)configNavigationBar {
    //top-back 44x44 22
    UIButton *leftButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 60, 44)];
    [leftButton addTarget:self action:@selector(goBack) forControlEvents:UIControlEventTouchUpInside];
    leftButton.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 38);
    [leftButton setImage:[UIImage imageNamed:@"top_back"] forState:UIControlStateNormal];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithCustomView:leftButton];
    self.navigationItem.leftBarButtonItem = leftItem;
        
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH-180, 44)];
    _titleLabel.font = [UIFont systemFontOfSize:15];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    self.navigationItem.titleView = _titleLabel;

}

- (void)goBack {
    [[GlobalContext ShareInstance].rootController popViewControllerAnimated:YES];
}

//navigation 的 leftItem 替换 backItem，对滑动返回的处理
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
}
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldBeRequiredToFailByGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return [gestureRecognizer isKindOfClass:UIScreenEdgePanGestureRecognizer.class];
}
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    if ([self isRootViewController]) {
        return NO;
    } else {
        return YES;
    }
}
- (BOOL)isRootViewController
{
    return (self == self.navigationController.viewControllers.firstObject);
}


@end
