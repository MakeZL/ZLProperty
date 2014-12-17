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

static NSString *_keyName = nil;
static id _prevObj = nil;

@implementation NSObject (ZLProperty)

+ (instancetype) objPropertyWithDict:(NSDictionary *)dict{
    id obj = [[self alloc] init];
    return [self objPropertyWithSuperObj:obj currentObj:obj dict:dict];
}

+ (instancetype)objPropertyWithSuperObj:(id)superObj currentObj:(id)currentObj dict:(NSDictionary *)dict{
    
    unsigned int count = 0;
    unsigned int methodCount = 0;
    // 1. 获取当前的类的所有方法
    Class currentClass = [currentObj class];
    Method *methods = class_copyMethodList(currentClass, &methodCount);
    
    // 2. 获取当前类的所有属性
    NSDictionary *methodDict = nil;
    Ivar *ivars = class_copyIvarList(currentClass, &count);
    
    // 3. 判断对象里面是否包含其他模型对象
    for (int i = 0; i < methodCount; i++) {
        NSString *methodName = NSStringFromSelector(method_getName(methods[i]));
        if ([methodName isEqualToString:@"modelWithProperty"]) {
            NSDictionary *dict = [currentObj performSelector:method_getName(methods[i])];
            if (![dict isKindOfClass:[NSDictionary class]]) {
                return nil;
            }
            methodDict = dict;
        }
    }
    // 如果是字典，并且没有methodDict 就直接转成模型
    if ([dict isKindOfClass:[NSDictionary class]]) {
        for (int i = 0; i < count; i++) {
            NSString *key = [NSString stringWithUTF8String:ivar_getName(ivars[i])];
            key = [self getRealNameWithKey:key];

            NSString *val = [dict valueForKey:key];
            
            if (val) {
                [currentObj setValue:val forKey:key];
            }
            

            NSString *ivarStr = [NSString stringWithCString:ivar_getTypeEncoding(ivars[i]) encoding:NSUTF8StringEncoding];
            
            ivarStr = [ivarStr stringByReplacingOccurrencesOfString:@"@\"" withString:@""];
            ivarStr = [ivarStr stringByReplacingOccurrencesOfString:@"\"" withString:@""];
            
            Class keyClass = NSClassFromString(ivarStr);
            if ([currentObj isKindOfClass:keyClass] && [dict valueForKeyPath:key]) {
                
                id crtObj = [[keyClass alloc] init];
                [currentObj setValue:crtObj forKey:key];
                [self objPropertyWithSuperObj:superObj currentObj:crtObj dict:dict[key]];
            }
            else if ([methodDict allKeys].count > 0) {
                for (NSString *methodKey in [methodDict allKeys]) {

                    if ([key isEqualToString:methodKey]) {
                        _keyName = key;
                        
                        if (![dict valueForKeyPath:key]) {
                            break;
                        }
                        
                        _prevObj = currentObj;
                        
                        
                        
                        Class otherClass = [methodDict valueForKey:key];
                        id nowObj = [[otherClass alloc] init];
                        
                        if ([[dict valueForKeyPath:key] isKindOfClass:[NSArray class]] && currentObj != superObj) {
                            [self objPropertyWithSuperObj:superObj currentObj:nowObj dict:[dict valueForKeyPath:key]];
                        }else{
                            [currentObj setValue:nowObj forKey:key];
                            [self objPropertyWithSuperObj:superObj currentObj:nowObj dict:[dict valueForKeyPath:key]];
                        }
                        break;
                        
                    }
                }
            }
        }
        // 如果是数组的情况下
    }else if ([dict isKindOfClass:[NSArray class]]){
        NSMutableArray *objs = [NSMutableArray array];
        for (NSDictionary *d in dict) {
            id newObj = [[[currentObj class] alloc] init];
            [objs addObject:newObj];
            [self objPropertyWithSuperObj:superObj currentObj:newObj dict:d];
        }
        
        BOOL varFlag = [self getVariableWithClass:[_prevObj class] varName:_keyName];
        
        if (![objs containsObject:_prevObj] && varFlag) {
            [_prevObj setValue:objs forKey:_keyName];
        }else{
            [superObj setValue:objs forKey:_keyName];
        }
    }
    
    return superObj;
    
}

+ (BOOL) getVariableWithClass:(Class) myClass varName:(NSString *)name{    unsigned int outCount, i;
    Ivar *ivars = class_copyIvarList(myClass, &outCount);
    for (i = 0; i < outCount; i++) {
        Ivar property = ivars[i];
        NSString *keyName = [NSString stringWithCString:ivar_getName(property) encoding:NSUTF8StringEncoding];
        keyName = [keyName stringByReplacingOccurrencesOfString:@"_" withString:@""];
        if ([keyName isEqualToString:name]) {
            return YES;
        }
        
    }
    
    return NO;
}

#pragma mark - 获取真实的属性名
+ (NSString *)getRealNameWithKey:(NSString *)key{
    // 把下划线给去掉
    if([[key substringWithRange:NSMakeRange(0, 1)] isEqualToString:@"_"]){
        key = [key stringByReplacingCharactersInRange:NSMakeRange(0, 1) withString:@""];
    }
    return key;
}

+ (instancetype) objPropertyWithJsonData:(NSData *)jsonData{
    NSAssert(jsonData.length > 0, @"Json不能为空！");
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableLeaves error:nil];
    NSAssert(dict != nil, @"Json可能存在问题");
    return [self objPropertyWithDict:dict];
}

- (NSDictionary *)modelWithProperty{
    return nil;
}
@end
