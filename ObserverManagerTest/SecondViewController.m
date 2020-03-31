//
//  SecondViewController.m
//  ObserverManagerTest
//
//  Created by wdyzmx on 2020/3/31.
//  Copyright © 2020 wdyzmx. All rights reserved.
//

#import "SecondViewController.h"
#import "Person.h"

@interface SecondViewController ()

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    // 测试自定义的观察者
    Person *p1 = [Person new];
    p1.name = @"xiaoming";
    [p1 lg_addObserver:self forKeyPath:@"name" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
    p1.name = @"xiao";
    
    // Do any additional setup after loading the view.
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context  {
    if ([keyPath isEqualToString:@"name"]) {
        NSLog(@"%@", [change valueForKey:keyPath]);
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
