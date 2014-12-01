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
    
    
//    unsigned int count = 0;
//    unsigned int methodCount = 0;
//    Ivar *ivars = class_copyIvarList([Person class], &count);
//
//    Method *methods = class_copyMethodList([Person class], &methodCount);
//
//    NSDictionary *methodDict = nil;
//    
//    for (int i = 0; i < methodCount; i++) {
//        NSString *methodName = NSStringFromSelector(method_getName(methods[i]));
//        
//        if ([methodName isEqualToString:@"modelWithProperty"]) {
//            NSDictionary *dict = [[[Person alloc] init] performSelector:method_getName(methods[i])];
//            if (![dict isKindOfClass:[NSDictionary class]]) {
//                return ;
//            }
//            methodDict = dict;
//        }
//    }
//
//    
//    
//    Person *p = [[[Person class] alloc] init];
//
//    for (int i = 0; i < count; i++) {
//        NSString *key = [NSString stringWithUTF8String:ivar_getName(ivars[i])];
//        
//        // 把下划线给去掉
//        if([[key substringWithRange:NSMakeRange(0, 1)] isEqualToString:@"_"]){
//            key = [key stringByReplacingCharactersInRange:NSMakeRange(0, 1) withString:@""];
//        }
//        
//        NSString *val = [dict valueForKey:key];
//        [p setValue:val forKey:key];
//
//        
//        
//        
//        
//        for (NSString *methodKey in [methodDict allKeys]) {
//            if ([key isEqualToString:methodKey]) {
//                Class objClass = [methodDict valueForKey:key];
//                
//                break;
//            }
//        }
//
//    }
    
//    NSLog(@"%@",p);
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    // 第一种情况是字典带字典
    // 第二种情况是字典带模型
    
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
