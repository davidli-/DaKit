# DaKit

[![CI Status](https://img.shields.io/travis/davidli-/DaKit.svg?style=flat)](https://travis-ci.org/davidli-/DaKit)
[![Version](https://img.shields.io/cocoapods/v/DaKit.svg?style=flat)](https://cocoapods.org/pods/DaKit)
[![License](https://img.shields.io/cocoapods/l/DaKit.svg?style=flat)](https://cocoapods.org/pods/DaKit)
[![Platform](https://img.shields.io/cocoapods/p/DaKit.svg?style=flat)](https://cocoapods.org/pods/DaKit)

## Example

自定义对象：

```
#import "Card.h"

//引入头文件
#import <DaKit/DaSerialize.h>
#import <DaKit/DaKakashi.h>

@implementation Card

//使用宏
DaSerialize() //serialize
DaKakashi()   //copy

@end
```

使用示例：

```
#import "Card.h"
#import <DaKit/DaClassInfo.h>

- (void)example{
    Card *card = [[Card alloc] init];
    card.cardNumber = 100;
    card.money = 50000000;

    // 序列化
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:card];
    Card *card2 = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    
    // 复制
    Card *card3 = [card2 copy];

    // 获取类的信息
    NSArray *ivars = [DaClassInfo ivarListWithClass:[Card class]];
    NSArray *props = [DaClassInfo propertyListWithClass:[Card class]];
    NSArray *meths = [DaClassInfo methodListWithClass:[Card class]];
}
```

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

## Installation

DaKit is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'DaKit'
```

## Author

davidlii, macmafia@sina.cn

## License

DaKit is available under the MIT license. See the LICENSE file for more info.
