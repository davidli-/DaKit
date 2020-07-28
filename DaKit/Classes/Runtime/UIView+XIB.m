//
//  UIView+XIB.m
//  ASDF
//
//  Created by Macmafia on 2018/8/27.
//  Copyright © 2018年 Macmafia. All rights reserved.
//

#import "UIView+XIB.h"
#import <objc/runtime.h>

static const char mRadius;
static const char mShouldClipCornerByHeight;
static const char mBorderWidth;
static const char mBorderColor;

@implementation UIView (XIB)

-(CGFloat)cornerRadius{
    return [objc_getAssociatedObject(self, &mRadius) floatValue];
}

-(void)setCornerRadius:(CGFloat)cornerRadius{
    self.layer.cornerRadius = cornerRadius;
    self.layer.masksToBounds = YES;
    objc_setAssociatedObject(self, &mRadius, @(cornerRadius), OBJC_ASSOCIATION_ASSIGN);
}

-(BOOL)shouldClipCornerByHeight{
    return [objc_getAssociatedObject(self, &mShouldClipCornerByHeight) boolValue];
}

-(void)setShouldClipCornerByHeight:(BOOL)shouldClipCornerByHeight{
    CGFloat radius = 0;
    if (shouldClipCornerByHeight) {
        radius = self.frame.size.height / 2.0f;
    }
    self.layer.cornerRadius = radius;
    self.layer.masksToBounds = YES;
    objc_setAssociatedObject(self, &mShouldClipCornerByHeight, @(shouldClipCornerByHeight), OBJC_ASSOCIATION_ASSIGN);
}

-(CGFloat)borderWidth{
    return [objc_getAssociatedObject(self, &mBorderWidth) floatValue];
}

- (void)setBorderWidth:(CGFloat)borderWidth{
    self.layer.borderWidth = borderWidth;
    objc_setAssociatedObject(self, &mBorderWidth, @(borderWidth), OBJC_ASSOCIATION_ASSIGN);
}

-(UIColor*)borderColor{
    return objc_getAssociatedObject(self, &mBorderColor);
}

-(void)setBorderColor:(UIColor *)borderColor{
    self.layer.borderColor = borderColor.CGColor;
    objc_setAssociatedObject(self, &mBorderColor, borderColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
