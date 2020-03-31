//
//  Person.m
//  ObserverManagerTest
//
//  Created by wdyzmx on 2020/3/30.
//  Copyright © 2020 wdyzmx. All rights reserved.
//

#import "Person.h"
#import <objc/runtime.h>
#import <objc/message.h>


@implementation Person

void setterMethod(id self, SEL _cmd, NSString *name) {
    // 调用父类方法
    // 通知观察者调用observeValueForKeyPath
    struct objc_super superClass = {
        self,
        class_getSuperclass([self class]),
    };
    objc_msgSendSuper(&superClass, _cmd, name);
    
    id observer = objc_getAssociatedObject(self, (__bridge const void*)@"objc");
    // 通知改变
    NSString *methodName = NSStringFromSelector(_cmd);
    NSString *key = getValueKey(methodName);
    // 把key作为常量更好
    // 发送消息，调用回调函数
    objc_msgSend(observer, @selector(observeValueForKeyPath:ofObject:change:context:), key, self, @{key:name}, nil);
    
}

// 自定义KVO
- (void)lg_addObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath options:(NSKeyValueObservingOptions)options context:(nullable void *)context {
    // 创建一个派生类
    NSString *oldName = NSStringFromClass([self class]);
    NSString *newName = [NSString stringWithFormat:@"CustomKVO_%@", oldName];
    // 分配class类
    Class customClass = objc_allocateClassPair([self class], newName.UTF8String, 0);
    // 注册clas类
    objc_registerClassPair(customClass);
    // 修改isa指针
    object_setClass(self, customClass);
    // 重写set方法
    NSString *methodName = [NSString stringWithFormat:@"set%@:", getCapitalizedString(keyPath)];
    SEL sel = NSSelectorFromString(methodName);
    // 添加方法
    class_addMethod(customClass, sel, (IMP)setterMethod, "v@:@");
    // 关联属性set
    objc_setAssociatedObject(self, (__bridge const void*)@"objc", observer, OBJC_ASSOCIATION_ASSIGN);
}

NSString *getCapitalizedString(NSString *originString) {
    NSString *letter = [[originString substringToIndex:1] uppercaseString];
    return [originString stringByReplacingCharactersInRange:NSMakeRange(0, 1) withString:letter];
}

NSString *getValueKey(NSString *setter) {
    NSRange range = NSMakeRange(3, setter.length - 4);
    NSString *key = [setter substringWithRange:range];
    NSString *letter = [[key substringToIndex:1] lowercaseString];
    key = [key stringByReplacingCharactersInRange:NSMakeRange(0, 1) withString:letter];
    return key;
}


@end
