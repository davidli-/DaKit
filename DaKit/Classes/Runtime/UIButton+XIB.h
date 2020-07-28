//
//  UIButton+XIB.m
//  DaKit
//
//  Created by davidlii on 2020/7/15.
//  Copyright © 2020 He. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

IB_DESIGNABLE
@interface UIButton (XIB)
@property (nonatomic, assign) IBInspectable float touchInterval; //两次点击之间的最小间隔
@property (nonatomic, copy)   IBInspectable NSString *eventName; //点击事件的名字（统计点击事件时使用）
@end

NS_ASSUME_NONNULL_END
