//
//  ViewController.m
//  ZLProperty
//
//  Created by 张磊 on 14-12-1.
//  Copyright (c) 2014年 com.zixue101.www. All rights reserved.
//

#import "ViewController.h"
#import "Person.h"
#import "Clother.h"
#import "Animal.h"
#import "NSObject+ZLProperty.h"

@interface ViewController ()

@property (nonatomic , strong) NSMutableDictionary *dictM;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 衣服模型，人可以拥有多件衣服，狗也能拥有多件衣服
    NSArray *clothes = @[
                         @{@"name":@"Meters/Bonwe",@"price":@(125)},
                         @{@"name":@"nike",@"price":@(255)},
                         ];
    
    NSArray *animation = @[
                           @{@"name":@"哈士奇",@"age":@(7)},
                           @{@"name":@"金毛",@"age":@(10)},
                           ];
    
    NSDictionary *dict = @{
                           @"name" : @"zhangleo",
                           @"nick" : @"zl",
                           @"clothes" : clothes,
                           @"animals": animation
                           };
    
    Person *p = [Person objPropertyWithDict:dict];
    
    for (Clother *clother in p.clothes) {
        NSLog(@"%@ -- %f",clother.name , clother.price);
    }
    
    for (Animal *animal in p.animals) {
        NSLog(@"%@ -- %ld",animal.name , animal.age);
    }

}

@end
