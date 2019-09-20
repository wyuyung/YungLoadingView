//
//  YungLoadingClockLineView.h
//  YungLoading
//
//  Created by zhangyaoyuan on 2019/9/19.
//  Copyright © 2019 Yung. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

// 内容偏移枚举
typedef NS_ENUM(NSInteger, YungLoadingClockLineViewType) {
    YungLoadingClockLineViewTypeHour = 0,     // 时针
    YungLoadingClockLineViewTypeMinute,       // 分针
    YungLoadingClockLineViewTypeCircle,        // 外圈框
};

NS_ASSUME_NONNULL_BEGIN

@interface YungLoadingClockLineView : UIView

@property(nonatomic,weak) CAShapeLayer *shapeLayer;

/** 设置线条颜色
 */
- (void)setRefreshColor:(UIColor *)color;

/** 初始化
 @param type 哪种线条,详情看YungLoadingClockLineViewType
 */
- (id)initWithFrame:(CGRect)frame lineType:(YungLoadingClockLineViewType)type;

@end

NS_ASSUME_NONNULL_END
