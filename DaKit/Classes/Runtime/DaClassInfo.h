//
//  DaClassInfo.h
//  DaKit
//
//  Created by Macmafia on 2017/8/17.
//  Copyright © 2017年 Macmafia. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface DaClassInfo : NSObject


/**
 获取类中所有成员变量的名称与类型

 @param aClass 目标类名
 @return 返回一个数组，{键：变量名，值：类型}
 */
+ (NSArray *)ivarListWithClass:(Class)aClass;



/**
 获取类中所有属性的名称与类型

 @param aClass 目标类名
 @return 返回一个数组，{键：属性名，值：类型}
 */
+ (NSArray *)propertyListWithClass:(Class)aClass;


/**
 获取类中所有方法名

 @param aClass 目标类
 @return 返回所有方法名组成的一个数组
 */
+ (NSArray *)methodListWithClass:(Class)aClass;

@end
