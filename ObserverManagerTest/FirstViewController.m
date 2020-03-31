//
//  FirstViewController.m
//  ObserverManagerTest
//
//  Created by wdyzmx on 2020/3/31.
//  Copyright © 2020 wdyzmx. All rights reserved.
//

#import "FirstViewController.h"
#import "NSObject+KVO.h"

@interface FirstViewController ()


@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    // 测试封装的观察者
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 100, 50)];
    [self.view addSubview:button];
    button.backgroundColor = [UIColor grayColor];
    [button setTitle:@"click" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self my_addObserverToTarget:button keyPath:@"titleLabel.text" callBack:^(id newValue, id oldValue) {
        NSLog(@"\nnewValue == %@\noldValue == %@", newValue, oldValue);
    }];
    [self my_addObserverToTarget:button keyPath:@"frame" callBack:^(id newValue, id oldValue) {
        NSLog(@"\nnewValue == %@\noldValue == %@", newValue, oldValue);
    }];
    
    // Do any additional setup after loading the view.
}

- (void)buttonClick:(UIButton *)btn {
    if ([btn.titleLabel.text isEqualToString:@"click"]) {
        [btn setTitle:@"I am button" forState:UIControlStateNormal];
        btn.frame = CGRectMake(100, 100, 100, 100);
    } else {
        [btn setTitle:@"click" forState:UIControlStateNormal];
        btn.frame = CGRectMake(100, 100, 100, 50);
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
