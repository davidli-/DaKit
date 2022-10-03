//
//  UIButton+XIB.m
//  DaKit
//
//  Created by davidlii on 2020/7/15.
//  Copyright © 2020 He. All rights reserved.
//

#import "UIButton+XIB.h"
#import <objc/runtime.h>

static const char kTouchInterval;
static const char kMForbidTouch;
static const char kEventName;


@interface UIButton ()
@property (nonatomic, assign) BOOL mForbidTouch; //时间间隔内不能再次点击
@end

@implementation UIButton (XIB)

- (float)touchInterval{
    return [objc_getAssociatedObject(self, &kTouchInterval) floatValue];
}

- (void)setTouchInterval:(float)touchInterval{
  objc_setAssociatedObject(self, &kTouchInterval, @(touchInterval), OBJC_ASSOCIATION_ASSIGN);
}


- (BOOL)mForbidTouch{
    return [objc_getAssociatedObject(self, &kMForbidTouch) boolValue];
}

-(void)setMForbidTouch:(BOOL)mForbidTouch{
    objc_setAssociatedObject(self, &kMForbidTouch, @(mForbidTouch), OBJC_ASSOCIATION_ASSIGN);
}


-(NSString *)eventName{
    return objc_getAssociatedObject(self, &kEventName);
}

-(void)setEventName:(NSString *)eventName{
    objc_setAssociatedObject(self, &kEventName, eventName, OBJC_ASSOCIATION_COPY);
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    // 1.判断下窗口能否接收事件
    if (!self.userInteractionEnabled ||
        self.hidden == YES){
        return nil;
    }
    // 2.判断触摸点在不在窗口上
    if (![self pointInside:point withEvent:event]){
        return nil;
    }
    // 3.从后往前遍历子视图数组
    int count = (int)self.subviews.count;
    
    for (int i = count - 1; i >= 0; i--) {
        // 获取子视图
        UIView *childView = self.subviews[i];
        // 坐标系的转换,把窗口上的点转换为子视图上的点
        // 把自己视图上的点转换成子视图上的点
        CGPoint childP = [self convertPoint:point toView:childView];
        
        UIView *fitView = [childView hitTest:childP withEvent:event];
        if (fitView) {
            return fitView;
        }
    }
    // 4.没有找到更合适的view，返回自己
    // 检查是否还在冷却时间内，不在冷却则上传点击事件
    if (!self.mForbidTouch) {
        if (self.eventName) {
            //Trace(@"+++++++点击了哦~");
            /*****************
            ***自己的埋点逻辑***
            *****************/
        }
        self.mForbidTouch = YES;
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(self.touchInterval * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            self.mForbidTouch = NO;
        });
    }
    return self;
}
@end
