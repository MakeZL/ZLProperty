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
//    
//    NSArray *clothes = @[
//                              @{@"name":@"anta",@"price":@(222)},
//                              @{@"name":@"senma",@"price":@(3333)},
//                              ];
//    NSDictionary *dict = @{@"name":@"hallo",@"age":@(12),@"clothes":clothes};
//    Animal *dog = [Animal objPropertyWithDict:dict];
//    NSLog(@"%@--%ld--%@",dog.name,dog.age,dog.clothes);
//    for (Clother *clother in dog.clothes) {
//        NSLog(@"%@",clother.name);
//    }
    
    NSDictionary *animal = @{@"name":@"hashiqi"};
//
//    
//    NSDictionary *dict = @{
//                           @"dog":animal,
//                           @"name":@"zl"
//                           };
//    
//    Person *p = [Person objPropertyWithDict:dict];
//    
//    NSLog(@"%@",p);
    
    NSArray *clothes = @[
                         @{@"name":@"Meters/Bonwe",@"price":@(125)},
                         @{@"name":@"nike",@"price":@(255)},
                         ];
    NSArray *clothes2 = @[
                          @{@"name":@"anta",@"price":@(222)},
                          @{@"name":@"senma",@"price":@(3333)},
                          ];
    
    NSArray *dogClothes = @[
                                 @{@"name":@"海绵宝宝",@"price":@(222)},
                                 @{@"name":@"海绵宝宝2",@"price":@(22)},
                                 ];
    
    NSArray *dogClothes2 = @[
                                 @{@"name":@"天线宝宝1",@"price":@(222)},
                                 @{@"name":@"天线宝宝2",@"price":@(3333)},
                                 ];
    
    NSArray *animation = @[
                           @{@"name":@"哈士奇",@"age":@(7),@"clothes":dogClothes},
                           @{@"name":@"金毛",@"age":@(10),@"clothes":dogClothes2},
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
    
    NSDictionary *personDict = @{
                                 @"name":@"mY1"
                                 };
    
    NSDictionary *dict = @{
                           @"name" : @"zhangleo",
                           @"nick" : @"zl",
                           @"animals": animation,
                           @"clothes" : clothes,
                           @"persons" : persons,
                           @"myPerson" : personDict,
                           @"dog" : animal
                           };
    
    Person *p = [Person objPropertyWithDict:dict];
    for (Clother *clother in p.clothes) {
        NSLog(@"%@ -- %f",clother.name , clother.price);
    }
    
    for (Animal *animal in p.animals) {
        NSLog(@"%@ -- %ld",animal.name , animal.age);
    }
    
    NSLog(@" ZLPerson : %@",p.myPerson.name);
    
    
    for (Person *xp in p.persons) {
        NSLog(@"%@ -- %@",xp.name , xp.nick);
        for (Clother *clother in xp.clothes) {
            NSLog(@"%@ -- %f",clother.name , clother.price);
        }
        
        for (Animal *animal in xp.animals) {
            NSLog(@"%@ -- %ld",animal.name , animal.age);
        }
    }
    
    NSLog(@"%@",[p.dog name]);
}







@end
