//
//  NSObject+ZLProperty.h
//  ZLProperty
//
//  Created by 张磊 on 14-12-1.
//  Copyright (c) 2014年 com.zixue101.www. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (ZLProperty)

/**
 *  字典转模型
 */
+ (instancetype) objPropertyWithDict:(NSDictionary *)dict;

/**
 *  Json转模型
 */
+ (instancetype) objPropertyWithJsonData:(NSData *)jsonData;

@end
