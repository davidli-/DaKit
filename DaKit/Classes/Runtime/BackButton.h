//
//  BackButton.m
//  DaKit
//
//  Created by Macmafia on 15/6/16.
//  Copyright (c) 2015年 Davidlii-. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum
{
    BACK_BTN_TYPE_IMAGE,     //图片
    BACK_BTN_TYPE_TEXT,      //文字
    BACK_BTN_TYPE_IMAGE_TEXT //图文
    
}BACK_BTN_TYPE;

@interface BackButton : UIButton

/**
 *  返回按钮
 *
 *  @param mType     返回按钮类型
 *  @param mImageArr 图片数组
 *  @param mText     文字
 *  @param target    target
 *  @param selector  selector
 *
 *  @return 按钮
 */
- (id)initWithBackType:(BACK_BTN_TYPE)mType images:(NSArray*)mImageArr text:(NSString*)mText target:(id)target selector:(SEL)selector;

@end
