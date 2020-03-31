//
//  NSObject+KVO.m
//  ObserverManagerTest
//
//  Created by wdyzmx on 2020/3/30.
//  Copyright © 2020 wdyzmx. All rights reserved.
//

#import "NSObject+KVO.h"
#import <objc/runtime.h>
#pragma mark- KVOController类
@implementation KVOController

- (NSMutableArray<DeallocBlock> *)blockArray {
    if (!_blockArray) {
        _blockArray = [NSMutableArray array];
    }
    return _blockArray;
}

- (void)dealloc {
    [_blockArray enumerateObjectsUsingBlock:^(DeallocBlock  _Nonnull block, NSUInteger idx, BOOL * _Nonnull stop) {
        block();
    }];
}

@end





#pragma mark- NSObject类
@interface NSObject ()

/// 分类添加mdict属性
@property (nonatomic, strong) NSMutableDictionary <NSString *, KVOCallBack>*mdict;
/// 分类添加kvoController属性
@property (nonatomic, strong) KVOController *kvoController;

@end

static NSString *dictKey = @"dictKey";
static NSString *controllerKey = @"controllerKey";

@implementation NSObject (KVO)

#pragma mark - 接口实现
- (void)my_addObserverToTarget:(NSObject *)obj  keyPath:(NSString *)keyPath callBack:(KVOCallBack)callBack {
    self.mdict[keyPath] = callBack;
    
    self.kvoController.observerObj = obj;
    
    __unsafe_unretained typeof(self)weakSelf = self;
    [self.kvoController.blockArray addObject:^{
        [obj removeObserver:weakSelf forKeyPath:keyPath];
    }];
    // 添加观察者
    [obj addObserver:self forKeyPath:keyPath options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
}

#pragma mark - 通知回调方法
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    KVOCallBack block = self.mdict[keyPath];
    if (block) {
        block([change valueForKey:NSKeyValueChangeNewKey], [change valueForKey:NSKeyValueChangeOldKey]);
    }
}

#pragma mark - 关联属性（setter getter）
- (void)setMdict:(NSMutableDictionary<NSString *,KVOCallBack> *)mdict {
    objc_setAssociatedObject(self, @selector(mdict), mdict, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSMutableDictionary<NSString *,KVOCallBack> *)mdict {
    NSMutableDictionary *tempDict = objc_getAssociatedObject(self, @selector(mdict));
    if (!tempDict) {
        tempDict = [NSMutableDictionary dictionary];
        objc_setAssociatedObject(self, @selector(mdict), tempDict, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return tempDict;
}

- (void)setKvoController:(KVOController *)kvoController {
    objc_setAssociatedObject(self, @selector(kvoController), kvoController, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (KVOController *)kvoController {
    KVOController *controller = objc_getAssociatedObject(self, @selector(kvoController));
    if (!controller) {
        controller = [[KVOController alloc] init];
        objc_setAssociatedObject(self, @selector(kvoController), controller, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return controller;
}


@end
