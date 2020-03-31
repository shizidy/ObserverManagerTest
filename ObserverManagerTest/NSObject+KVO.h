//
//  NSObject+KVO.h
//  ObserverManagerTest
//
//  Created by wdyzmx on 2020/3/30.
//  Copyright © 2020 wdyzmx. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^DeallocBlock)(void);

@interface KVOController : NSObject

/// 记录被观察对象
@property (nonatomic, strong) NSObject *observerObj;
/// 存储 DeallocBlock
@property (nonatomic, strong) NSMutableArray <DeallocBlock>*blockArray;

@end





typedef void(^KVOCallBack)(id newValue, id oldValue);

@interface NSObject (KVO)

/// 添加观察者
/// @param obj 观察者
/// @param keyPath keyPath
/// @param callBack block回调
- (void)my_addObserverToTarget:(NSObject *)obj keyPath:(NSString *)keyPath callBack:(KVOCallBack)callBack;

@end

