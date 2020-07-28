//
//  UIView+ClipCorners.m
//  DaKit
//
//  Created by davidlii on 2020/7/8.
//  Copyright © 2020 He. All rights reserved.
//

#import "UIView+ClipCorners.h"

@implementation UIView (ClipCorners)

- (void)clipRoundCornerAtCorner:(UIRectCorner)corners radius:(float)radius{
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect: self.bounds byRoundingCorners: corners cornerRadii: CGSizeMake(radius, radius)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = self.bounds;
    maskLayer.path = maskPath.CGPath;
    self.layer.mask = maskLayer;
}

- (void)clipCornerAtCorners:(UIRectCorner)corners radius:(float)radius color:(UIColor*)color{
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:self.bounds];
    // 创建圆形
    if (UIRectCornerTopLeft & corners) {
        CGRect rect = CGRectMake(-(radius / 2.0f), -(radius / 2.0f), radius, radius);
        UIBezierPath *circlePath = [UIBezierPath bezierPathWithOvalInRect:rect].bezierPathByReversingPath;
        [path appendPath:circlePath];
    }
    if (UIRectCornerTopRight & corners){
        CGRect rect = CGRectMake(self.bounds.size.width-(radius / 2.0f), -(radius / 2.0f), radius, radius);
        UIBezierPath *circlePath = [UIBezierPath bezierPathWithOvalInRect:rect].bezierPathByReversingPath;
        [path appendPath:circlePath];
    }
    if (UIRectCornerBottomLeft & corners){
        CGRect rect = CGRectMake(-(radius / 2.0f), self.bounds.size.height-(radius / 2.0f), radius, radius);
        UIBezierPath *circlePath = [UIBezierPath bezierPathWithOvalInRect:rect].bezierPathByReversingPath;
        [path appendPath:circlePath];
    }
    if (UIRectCornerBottomRight & corners){
        CGRect rect = CGRectMake(self.bounds.size.width-(radius / 2.0f), self.bounds.size.height-(radius / 2.0f), radius, radius);
        UIBezierPath *circlePath = [UIBezierPath bezierPathWithOvalInRect:rect].bezierPathByReversingPath;
        [path appendPath:circlePath];
    }
    
    // 创建layer
    CAShapeLayer *shaperLayer = [CAShapeLayer layer];
    shaperLayer.frame = self.bounds;
    shaperLayer.fillColor = color.CGColor;
    // 设置填充规则
    shaperLayer.fillRule = kCAFillRuleEvenOdd;
    shaperLayer.path = path.CGPath;

    self.layer.mask =  shaperLayer;
}

@end
