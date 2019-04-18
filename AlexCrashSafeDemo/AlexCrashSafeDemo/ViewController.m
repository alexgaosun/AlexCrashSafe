//
//  ViewController.m
//  AlexCrashSafeDemo
//
//  Created by 高莹莹 on 2019/4/17.
//  Copyright © 2019年 高莹莹. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self testArrAndMutableArr];
    [self testDictionary];
    [self testUnRecognizedSelector];
    
    // Do any additional setup after loading the view, typically from a nib.
}
- (void)testUnRecognizedSelector
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(100, 100, 200, 100);
    btn.backgroundColor = [UIColor redColor];
    [btn setTitle:@"按钮方法没有实现  " forState:UIControlStateNormal];
    
    [self.view addSubview:btn];
    [btn addTarget:self action:@selector(testAction) forControlEvents:UIControlEventTouchUpInside];
}
- (void)testDictionary
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:nil forKey:nil];
}
- (void)testArrAndMutableArr
{
    
    //arr
    NSArray *arr1 = @[];
    NSString *str1 = [arr1 objectAtIndex:5];
    
    NSArray *arr2 = @[@"1"];
    NSString *str2 = [arr2 objectAtIndex:5];
    
    NSArray *arr3 = @[@"1", @"2", @"3"];
    NSString *str3 = [arr3 objectAtIndex:5];
    
    NSArray *arr4 = @[@"1", @"2", @"3"];
    NSString *str4 = arr4[5];
    
    //mutableArr
    
    NSMutableArray *arr5 = [NSMutableArray array];
    NSObject *ob1 = [arr5 objectAtIndex:1000];
    NSObject *ob2 = arr5[1000];
    NSString *str5 = nil;
    NSString *str6 = @"123";
    [arr5 addObject:str5];
    [arr5 insertObject:str6 atIndex:1000];
    [arr5 removeObjectAtIndex:100];
    
}

@end
