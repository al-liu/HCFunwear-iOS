//
//  HCAppraiseCell.h
//  HCFunwear
//
//  Created by 刘海川 on 16/9/27.
//  Copyright © 2016年 Haichuan Liu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HCCommentListModel.h"
#import "HCAppraiseCellProtocol.h"

@interface HCAppraiseCell : UITableViewCell <HCAppraiseCellProtocol>

- (void)setData:(HCCommentListModel *)model;

@end
