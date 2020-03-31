//
//  ViewController.m
//  ObserverManagerTest
//
//  Created by wdyzmx on 2020/3/27.
//  Copyright © 2020 wdyzmx. All rights reserved.
//

#import "ViewController.h"
#import "FirstViewController.h"
#import "SecondViewController.h"

@interface ViewController ()


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *button1 = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 200, 50)];
    CGPoint point = self.view.center;
    point.y -= 50;
    button1.center = point;
    [self.view addSubview:button1];
    button1.backgroundColor = [UIColor redColor];
    [button1 setTitle:@"封装KVO" forState:UIControlStateNormal];
    [button1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button1 addTarget:self action:@selector(button1Action:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *button2 = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 200, 50)];
    point = self.view.center;
    point.y += 50;
    button2.center = point;
    [self.view addSubview:button2];
    button2.backgroundColor = [UIColor redColor];
    [button2 setTitle:@"自定义KVO" forState:UIControlStateNormal];
    [button2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button2 addTarget:self action:@selector(button2Action:) forControlEvents:UIControlEventTouchUpInside];
    
    // Do any additional setup after loading the view.
}

#pragma mark - button点击事件
- (void)button1Action:(UIButton *)btn {
    FirstViewController *viewController = [[FirstViewController alloc] init];
    [self presentViewController:viewController animated:YES completion:nil];
}

- (void)button2Action:(UIButton *)btn {
     SecondViewController *viewController = [[SecondViewController alloc] init];
    [self presentViewController:viewController animated:YES completion:nil];
}



@end
