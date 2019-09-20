//
//  YungLoadingView.h
//  YungLoading
//
//  Created by zhangyaoyuan on 2019/9/19.
//  Copyright © 2019 Yung. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YungLoadingView : UIView

+ (instancetype)createLoadingView;

- (void)showLoadingInView:(UIView *)view;

- (void)stopLoading;

@end

NS_ASSUME_NONNULL_END
