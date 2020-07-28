//
//  UIView+XIB.h
//  ASDF
//
//  Created by Macmafia on 2018/8/27.
//  Copyright © 2018年 Macmafia. All rights reserved.
//

#import <UIKit/UIKit.h>

IB_DESIGNABLE
@interface UIView (XIB)
@property (nonatomic, assign) IBInspectable CGFloat cornerRadius;
@property (nonatomic, assign) IBInspectable BOOL shouldClipCornerByHeight;
@property (nonatomic, assign) IBInspectable CGFloat borderWidth;
@property (nonatomic, strong) IBInspectable UIColor *borderColor;
@end
