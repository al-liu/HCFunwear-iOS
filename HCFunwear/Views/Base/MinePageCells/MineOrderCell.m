//
//  MineOrderCell.m
//  HCFunwear
//
//  Created by 刘海川 on 16/7/12.
//  Copyright © 2016年 Haichuan Liu. All rights reserved.
//

#import "MineOrderCell.h"
@interface MineOrderCell() {
    
    __weak IBOutlet UIImageView *iconImageVIew;
    __weak IBOutlet UILabel *iconTitleLabel;
}
@end

@implementation MineOrderCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setMineMenuModel:(MineMenuModel *)mineMenuModel {
    _mineMenuModel = mineMenuModel;
    
    iconImageVIew.image = [UIImage imageNamed:_mineMenuModel.iconImageString];
    iconTitleLabel.text = _mineMenuModel.iconTitleString;
}

@end
