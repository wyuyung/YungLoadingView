//
//  YungLoadingClockAnimateView.h
//  YungLoading
//
//  Created by zhangyaoyuan on 2019/9/19.
//  Copyright © 2019 Yung. All rights reserved.
//

#import <UIKit/UIKit.h>

#define YungLoadingClockAnimateViewAnimateSpeed 2.5

NS_ASSUME_NONNULL_BEGIN

@interface YungLoadingClockAnimateView : UIView

/** 设置线条颜色
 */
- (void)setRefreshColor:(UIColor *)color;

- (void)startAnimate;

- (void)stopAnimate;

@end

NS_ASSUME_NONNULL_END
