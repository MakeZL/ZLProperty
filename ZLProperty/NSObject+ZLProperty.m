//
//  NSObject+ZLProperty.m
//  ZLProperty
//
//  Created by 张磊 on 14-12-1.
//  Copyright (c) 2014年 com.zixue101.www. All rights reserved.
//

#import "NSObject+ZLProperty.h"
#import "Clother.h"
#import <objc/runtime.h>

@implementation NSObject (ZLProperty)

+ (instancetype) objPropertyWithDict:(NSDictionary *)dict{
    
    id obj = [[self alloc] init];
    
    return [self objPropertyWithSuperObj:obj currentObj:obj childPropertyModel:nil withDict:dict];
}


+ (instancetype) objPropertyWithSuperObj:(id)superObj currentObj:(id)currentObj childPropertyModel:(NSString *)childPropertyKey withDict:(NSDictionary *)dict{
    
    unsigned int count = 0;
    unsigned int methodCount = 0;
    
    Class myClass = [currentObj class];
    Method *methods = class_copyMethodList(myClass, &methodCount);
    Ivar *ivars = class_copyIvarList(myClass, &count);
    
    NSDictionary *methodDict = nil;
    for (int i = 0; i < methodCount; i++) {
        NSString *methodName = NSStringFromSelector(method_getName(methods[i]));
        if ([methodName isEqualToString:@"modelWithProperty"]) {
            NSDictionary *dict = [[[myClass alloc] init] performSelector:method_getName(methods[i])];
            if (![dict isKindOfClass:[NSDictionary class]]) {
                return nil;
            }
            methodDict = dict;
        }
    }
    
    if ([dict isKindOfClass:[NSArray class]]) {
        NSMutableArray *objs = [NSMutableArray array];
        for (NSDictionary *contentDict in dict) {
            id obj = [[[currentObj class] alloc] init];
            for (int i = 0; i < count; i++) {
                NSString *key = [NSString stringWithUTF8String:ivar_getName(ivars[i])];
                // 把下划线给去掉
                if([[key substringWithRange:NSMakeRange(0, 1)] isEqualToString:@"_"]){
                    key = [key stringByReplacingCharactersInRange:NSMakeRange(0, 1) withString:@""];
                }
                
                NSString *val = [contentDict valueForKey:key];
                
                // 判断是否有问题
                NSAssert(![val isEqual:[NSNull null]], @"key值在模型中不存在 或者 val值不能为空！");
                [obj setValue:val forKey:key];
                
            }
            [objs addObject:obj];
        }
        
        [superObj setValue:objs forKey:childPropertyKey];
        
    }else if ([dict isKindOfClass:[NSDictionary class]]){
        for (int i = 0; i < count; i++) {
            NSString *key = [NSString stringWithUTF8String:ivar_getName(ivars[i])];
            
            // 把下划线给去掉
            if([[key substringWithRange:NSMakeRange(0, 1)] isEqualToString:@"_"]){
                key = [key stringByReplacingCharactersInRange:NSMakeRange(0, 1) withString:@""];
            }
            
            NSString *val = [dict valueForKey:key];
            [currentObj setValue:val forKey:key];
            
            if ([methodDict allKeys].count > 0) {
                for (NSString *methodKey in [methodDict allKeys]) {
                    if ([key isEqualToString:methodKey]) {
                        Class otherClass = [methodDict valueForKey:key];
                        
                        [self objPropertyWithSuperObj:superObj currentObj:[[otherClass alloc] init] childPropertyModel:key withDict:[dict valueForKey:key]];
                        break;
                    }
                }
            }
        }
    }
    return superObj;
}

@end
