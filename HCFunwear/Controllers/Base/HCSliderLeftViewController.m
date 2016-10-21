//
//  HCSliderLeftViewController.m
//  HCFunwear
//
//  Created by 刘海川 on 16/10/20.
//  Copyright © 2016年 Haichuan Liu. All rights reserved.
//

#import "HCSliderLeftViewController.h"
#import "Masonry.h"
#import "GlobalImport.h"

@interface HCSliderLeftViewController () <UITableViewDataSource,UITableViewDelegate>

@end

@implementation HCSliderLeftViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    //cell h:48 v-line:17 top:84 font:15 数据写死
    
    CGFloat toX = SCREEN_WIDTH * 0.26;
    UITableView *menuTableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    menuTableView.dataSource = self;
    menuTableView.delegate = self;
    menuTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:menuTableView];
    
    [menuTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@84);
        make.right.equalTo(self.view);
        make.left.equalTo(@(toX));
        make.height.equalTo(@(48*3));
    }];
    
    UIView *line = [UIView new];
    line.backgroundColor = kCellLineColor;
    [self.view addSubview:line];
    
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(menuTableView.mas_left).offset(24);
        make.right.equalTo(menuTableView.mas_right).offset(-24);
        make.height.equalTo(@.5f);
        make.top.equalTo(menuTableView.mas_bottom).offset(17);
    }];
}

- (void)pop {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellId = @"mainStyleCellId";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.textLabel.font = [UIFont systemFontOfSize:15];
        cell.textLabel.textColor = kTextColor325;
    }
    switch (indexPath.row) {
        case 0:
            cell.textLabel.text = @"  女士    WOMEN";
            break;
            
        case 1:
            cell.textLabel.text = @"  男士    MEN";
            break;
            
        case 2:
            cell.textLabel.text = @"  生活    LIFESTYLE";
            break;
            
        default:
            break;
    }
    
    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 48;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.0001;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.0001;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //功能没做
    [self dismissViewControllerAnimated:YES completion:nil];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
