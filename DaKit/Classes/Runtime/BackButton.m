//
//  BackButton.m
//  DaKit
//
//  Created by Macmafia on 15/6/16.
//  Copyright (c) 2015年 Davidlii-. All rights reserved.
//

#import "BackButton.h"

@implementation BackButton

- (id)initWithBackType:(BACK_BTN_TYPE)mType
                images:(NSArray*)mImageArr
                  text:(NSString*)mText
                target:(id)target
              selector:(SEL)selector
{
    if (self = [super init]) {
        
        UIImage *imageNormal, *imageHighLight;
        if (mImageArr) {
            imageNormal    = [UIImage imageNamed:[mImageArr objectAtIndex:0]];
            imageHighLight = [UIImage imageNamed:[mImageArr objectAtIndex:1]];
        }else{
            imageNormal    = [UIImage imageNamed:@"icon_back_red_n"];
            imageHighLight = [UIImage imageNamed:@"icon_back_red_a"];
        }
        
        if (BACK_BTN_TYPE_IMAGE == mType) {
            [self setImage:imageNormal forState:UIControlStateNormal];
            [self setImage:imageHighLight forState:UIControlStateHighlighted];
        }
        else if (BACK_BTN_TYPE_TEXT == mType) {
            [self.titleLabel setFont:[UIFont systemFontOfSize:16 weight:UIFontWeightHeavy]];
            [self setTitle:mText forState:UIControlStateNormal];
            [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        }
        else
        {
            [self setImage:imageNormal forState:UIControlStateNormal];
            [self setImage:imageHighLight forState:UIControlStateHighlighted];
            [self setTitle:mText forState:UIControlStateNormal];
            [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        }
        
        [self sizeToFit];
        [self addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

@end
