//
//  UIView+ClipCorners.h
//  DaKit
//
//  Created by davidlii on 2020/7/8.
//  Copyright © 2020 He. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (ClipCorners)


/// 裁剪四周圆角
/// @param corners 圆角位置
/// @param radius 圆角半径
- (void)clipRoundCornerAtCorner:(UIRectCorner)corners
                         radius:(float)radius;

/// 边角镂空效果
/// @param corners 位置
/// @param radius 半径
/// @param color 颜色
- (void)clipCornerAtCorners:(UIRectCorner)corners
                     radius:(float)radius
                      color:(UIColor*)color;

@end

NS_ASSUME_NONNULL_END
