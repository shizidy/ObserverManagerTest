//
//  Person.h
//  ObserverManagerTest
//
//  Created by wdyzmx on 2020/3/30.
//  Copyright © 2020 wdyzmx. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Person : NSObject

@property (nonatomic, copy) NSString *name;

- (void)lg_addObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath options:(NSKeyValueObservingOptions)options context:(nullable void *)context;

@end



NS_ASSUME_NONNULL_END
