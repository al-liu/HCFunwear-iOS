//
//  HCInspirationApiService.h
//  HCFunwear
//
//  Created by 刘海川 on 16/8/24.
//  Copyright © 2016年 Haichuan Liu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ReactiveCocoa.h"

@protocol HCInspirationApiService <NSObject>

/**
 *  获取灵感页的咨询
 *
 *  @param indexPage 第几页，1，2...
 *  @param pageSize  一页几个 item
 *  @param aid       对应的类型 id，cid是大类型 id ，比如 man ，woman ， life.
 *
 *  @return 信号
 */
- (RACSignal *)getInspInfoDataWithIndexPage:(NSInteger)indexPage
                                pageSize:(NSInteger)pageSize
                                  typeId:(NSString *)aid;

- (RACSignal *)getInspInfoFunerDataWithIndexPage:(NSInteger)indexPage;

@end
