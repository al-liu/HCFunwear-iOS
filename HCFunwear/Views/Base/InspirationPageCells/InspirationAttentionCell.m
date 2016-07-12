//
//  InspirationAttentionCell.m
//  HCFunwear
//
//  Created by 刘海川 on 16/7/9.
//  Copyright © 2016年 Haichuan Liu. All rights reserved.
//

#import "InspirationAttentionCell.h"
@interface InspirationAttentionCell()
{

    __weak IBOutlet UIImageView *userImageView;
    
}
@end

@implementation InspirationAttentionCell

- (void)awakeFromNib {
    // Initialization code
    userImageView.layer.cornerRadius = 22.5f;
    userImageView.layer.masksToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
