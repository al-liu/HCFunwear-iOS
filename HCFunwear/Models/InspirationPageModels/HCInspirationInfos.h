//
//  HCInspirationInfos.h
//  HCFunwear
//
//  Created by 刘海川 on 16/8/24.
//  Copyright © 2016年 Haichuan Liu. All rights reserved.
//

#import <Foundation/Foundation.h>
/**
 *  灵感－上方滑动的标签
 */
@interface HCInfoTab : NSObject

@property (nonatomic, copy) NSString *tab_id;
@property (nonatomic, copy) NSString *name;

@end

@interface HCInspInfo : NSObject

@property (nonatomic, copy) NSString *info_id;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, strong) NSURL *img;
@property (nonatomic, strong) NSURL *url;
@property (nonatomic, strong) NSArray *product_list;
@property (nonatomic, strong) NSArray *keywords_list;

@end

/**
 *  灵感－咨询
 */
@interface HCInspirationInfos : NSObject

@property (nonatomic, strong) NSArray *attr;
@property (nonatomic, strong) NSArray *list;
@property (nonatomic, copy) NSString *layoutType;
@property (nonatomic, copy) NSString *total;

@end
