//
//  HCCirculateScrollView.h
//  HCFunwear
//
//  Created by 刘海川 on 16/6/23.
//  Copyright © 2016年 Haichuan Liu. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HCCirculateScrollView;

@protocol HCCirculateScrollViewProtocol <NSObject>
/**
 *  将 URL 和 ImageView 回调出去 不局限使用什么方法加载图片
 *
 *  @param circulateSctollView 滚动视图
 *  @param url                 加载的 URL
 *  @param imageView           加载的 ImageView
 */
@optional
- (void)circulateScrollView:(HCCirculateScrollView *)circulateSctollView
               loadImageUrl:(NSURL *)url
              withImageView:(UIImageView *)imageView;
- (void)circulateScrollViewDidSelectedAtIndex:(NSInteger)index;
- (void)circulateScrollViewPageControlAtIndex:(NSInteger)index;
@end

@interface HCCirculateScrollView : UIImageView {
    __weak id _delegate;
}

@property (nonatomic, weak) id <HCCirculateScrollViewProtocol> delegate;
@property (nonatomic, assign) BOOL isAutomatic;
@property (nonatomic, strong) UIImage *placeholderImage;

/**
 *  重新加载视图
 *
 *  @param imageUrlStrings url字符串，该方法 urlString->URL
 */
- (void)loadView:(NSArray *)imageUrlStrings;

@end
