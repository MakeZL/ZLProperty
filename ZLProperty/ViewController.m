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
    NSArray *clothes2 = @[
                          @{@"name":@"anta",@"price":@(222)},
                          @{@"name":@"senma",@"price":@(3333)},
                          ];
    
    NSArray *animation = @[
                           @{@"name":@"哈士奇",@"age":@(7)},
                           @{@"name":@"金毛",@"age":@(10)},
                           ];
    
    NSArray *persons = @[
                         @{
                             @"name" : @"abcccc",
                             @"nick" : @"zlaaa",
                             @"clothes" : clothes2,
                             @"animals": animation
                             },
                         
                         @{
                             @"name" : @"eeeee",
                             @"nick" : @"zlaaa",
                             @"clothes" : clothes2,
                             @"animals": animation
                             },
                         ];
    
    
    NSDictionary *dict = @{
                           @"name" : @"zhangleo",
                           @"nick" : @"zl",
                           @"animals": animation,
                           @"clothes" : clothes,
                           @"persons" : persons
                           };
    
    Person *p = [Person objPropertyWithDict:dict];
    for (Clother *clother in p.clothes) {
        NSLog(@"%@ -- %f",clother.name , clother.price);
    }
    
    for (Animal *animal in p.animals) {
        NSLog(@"%@ -- %ld",animal.name , animal.age);
    }
    
    
    
    for (Person *xp in p.persons) {
        NSLog(@"%@ -- %@",xp.name , xp.nick);
        for (Clother *clother in xp.clothes) {
            NSLog(@"%@ -- %f",clother.name , clother.price);
        }
        
        for (Animal *animal in xp.animals) {
            NSLog(@"%@ -- %ld",animal.name , animal.age);
        }
    }
}

@end
