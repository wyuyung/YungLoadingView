//
//  YungLoadingCircleLineView.h
//  YungLoading
//
//  Created by zhangyaoyuan on 2019/9/19.
//  Copyright © 2019 Yung. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface YungLoadingCircleLineView : UIView

@property(nonatomic,weak) CAShapeLayer *shapeLayer;

/** 设置线条颜色
 */
- (void)setRefreshColor:(UIColor *)color;

/** 初始化
 @param top 是否为最外层线条
 */
- (id)initWithFrame:(CGRect)frame isTop:(BOOL)top;

@end

NS_ASSUME_NONNULL_END
