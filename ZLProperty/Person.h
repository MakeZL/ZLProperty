//
//  Person.h
//  ZLProperty
//
//  Created by 张磊 on 14-12-1.
//  Copyright (c) 2014年 com.zixue101.www. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Person : NSObject

@property (nonatomic , copy) NSString *name;
@property (nonatomic , copy) NSString *nick;
@property (nonatomic , strong) NSArray *clothes;
@property (nonatomic , strong) NSArray *animals;

@end
