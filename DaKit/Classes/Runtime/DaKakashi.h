//
//  DaKakashi.h
//  DaKit
//
//  Created by Macmafia on 2019/8/30.
//  Copyright © 2019 Macmafia. All rights reserved.
//

#ifndef DaKakashi_h
#define DaKakashi_h

#import <objc/runtime.h>

//目标：自动实现对象的拷贝协议

//示例:

/*
 ******************
 *1、对象头文件中声明NSCopying协议
 *******************
 
 #import <Foundation/Foundation.h>
 
 @interface DaObject : NSObject<NSCopying>
 
 @property (nonatomic, copy) NSString *mName;
 @property (nonatomic) BOOL mIsTrue;
 @property (nonatomic) NSInteger mInteger;
 @property (nonatomic) UIImage *mImage;
 
 @end
 
 *******************
 *2、m文件中导入头文件和宏即可
 *******************
 
 #import "DaObject.h"
 #import "DaKakashi.h"
 
 @implementation DaObject
 
 DaKakashi() //导入工具类中定义的宏
 
 @end
 */


#define DaKakashi() \
\
- (id)copyWithZone:(NSZone *)zone \
{\
    id copy = [[[self class] allocWithZone:zone] init];\
    Class cls = [self class];\
    while (cls != [NSObject class]) {\
        /*判断是自身类还是父类*/ \
        BOOL IsSelfClass = (cls == [self class]); \
        unsigned int iVarCount = 0; \
        unsigned int propVarCount = 0;\
        unsigned int sharedVarCount = 0;\
\
        Ivar *ivarList = IsSelfClass ? class_copyIvarList([cls class], &iVarCount) : NULL;/*变量列表，含属性以及私有变量*/\
        objc_property_t *propList = IsSelfClass ? NULL : class_copyPropertyList(cls, &propVarCount);/*属性列表*/\
        sharedVarCount = IsSelfClass ? iVarCount : propVarCount;\
\
        for (int i = 0; i < sharedVarCount; i++) {\
            const char *varName = IsSelfClass ? ivar_getName(*(ivarList + i)) : property_getName(*(propList + i));\
            NSString *key = [NSString stringWithUTF8String:varName];\
            NSString *firstStr = [key substringToIndex:1]; \
            if (IsSelfClass && [firstStr isEqualToString:@"_"]) { \
                key = [key substringFromIndex:1]; \
            }\
            /*valueForKey只能获取本类所有变量以及所有层级父类的属性，不包含任何父类的私有变量(会崩溃)*/\
            id varValue = [self valueForKey:key];\
            if (varValue) {\
                [copy setValue:varValue forKey:key];\
            }\
        }\
        free(ivarList);\
        free(propList);\
        cls = class_getSuperclass(cls);\
    }\
    return copy;\
}\

#endif /* DaKakashi_h */
