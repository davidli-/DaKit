//
//  DaSerialize.h
//  DaKit
//
//  Created by davidli on 15/12/10.
//  Copyright © 2015年 X. All rights reserved.
//

#ifndef DaSerialize_h
#define DaSerialize_h

#import <objc/runtime.h>

//目标：自动实现对象序列化

//示例:

/*
 ******************
 *1、对象头文件中声明NSCoding协议
 *******************

#import <Foundation/Foundation.h>

@interface DaObject : NSObject<NSCoding>

@property (nonatomic, copy) NSString *mName;
@property (nonatomic) BOOL mIsTrue;
@property (nonatomic) NSInteger mInteger;
@property (nonatomic) UIImage *mImage;

@end

 *******************
 *2、m文件中导入头文件和宏即可
 *******************

#import "DaObject.h"
#import "DaSerialize.h"

@implementation DaObject

DaSerialize() //导入工具类中定义的宏

@end
 */


#define DaSerialize() \
\
- (id)initWithCoder:(NSCoder *)coder \
{ \
    Class cls = [self class]; \
    while (cls != [NSObject class]) { \
        /*判断是自身类还是父类 自身时取IvaList 父类时取properList*/ \
        BOOL isSelfClass = (cls == [self class]); \
        unsigned int iVarCount = 0;    /*私有变量+属性的数量*/ \
        unsigned int propVarCount = 0; /*属性的数量*/ \
        unsigned int sharedVarCount = 0; \
\
        Ivar *ivarList = isSelfClass ? class_copyIvarList([cls class], &iVarCount) : NULL;/*变量列表，含属性以及私有变量*/ \
        objc_property_t *propList = isSelfClass ? NULL : class_copyPropertyList(cls, &propVarCount);/*属性列表*/ \
        sharedVarCount = isSelfClass ? iVarCount : propVarCount; \
\
        for (int i = 0; i < sharedVarCount; i++) { \
            /*私有变量或属性名*/ \
            const char *varName = isSelfClass ? ivar_getName(*(ivarList + i)) : property_getName(*(propList + i)); \
            NSString *key = [NSString stringWithUTF8String:varName]; \
            NSString *firstStr = [key substringToIndex:1]; \
            /*如果是自身类 取的是IvaList 属性名前会带下划线“_” 为了统一 序列化时去掉下划线*/ \
            if (isSelfClass && [firstStr isEqualToString:@"_"]) { \
                key = [key substringFromIndex:1]; \
            } \
            /*私有变量或属性值*/ \
            id varValue = [coder decodeObjectForKey:key]; \
            if (varValue) { \
                [self setValue:varValue forKey:key]; \
            } \
        } \
        /*释放*/ \
        free(ivarList); \
        free(propList); \
        /*指针指向父类 对父类属性进行序列化*/ \
        cls = class_getSuperclass(cls); \
    } \
    return self; \
} \
\
- (void)encodeWithCoder:(NSCoder *)coder \
{ \
    Class cls = [self class]; \
    while (cls != [NSObject class]) { \
        /*判断是自身类还是父类 同上*/ \
        BOOL isSelfClass = (cls == [self class]); \
        unsigned int iVarCount = 0;    /*私有变量+属性的总数*/ \
        unsigned int propVarCount = 0; /*属性的总数*/ \
        unsigned int sharedVarCount = 0; \
\
        Ivar *ivarList = isSelfClass ? class_copyIvarList([cls class], &iVarCount) : NULL;/*变量列表，含属性以及私有变量*/ \
        objc_property_t *propList = isSelfClass ? NULL : class_copyPropertyList(cls, &propVarCount);/*属性列表*/ \
        sharedVarCount = isSelfClass ? iVarCount : propVarCount; \
\
        for (int i = 0; i < sharedVarCount; i++) { \
            /*私有变量或属性名*/ \
            const char *varName = isSelfClass ? ivar_getName(*(ivarList + i)) : property_getName(*(propList + i)); \
            NSString *key = [NSString stringWithUTF8String:varName]; \
            NSString *firstStr = [key substringToIndex:1]; \
            /*如果是自身类 取的是IvaList 属性名前会带下划线“_” 为了统一 序列化时去掉下划线*/ \
            if (isSelfClass && [firstStr isEqualToString:@"_"]) { \
                key = [key substringFromIndex:1]; \
            } \
            /*注：valueForKey只获取本类所有变量以及所有层级父类的属性，不包含任何父类的私有变量(获取父类私有变量会崩溃)*/ \
            id varValue = [self valueForKey:key]; \
            if (varValue) { \
                [coder encodeObject:varValue forKey:key]; \
            } \
        } \
        /*释放*/ \
        free(ivarList); \
        free(propList); \
        /*指针指向父类 对父类属性进行序列化*/ \
        cls = class_getSuperclass(cls); \
    } \
} \

#endif /* DaSerialize_h */
