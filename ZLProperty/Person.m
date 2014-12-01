//
//  Person.m
//  ZLProperty
//
//  Created by 张磊 on 14-12-1.
//  Copyright (c) 2014年 com.zixue101.www. All rights reserved.
//

#import "Person.h"
#import "Clother.h"
#import "Animal.h"

@implementation Person

- (NSDictionary *) modelWithProperty{
    return @{@"clothes":[Clother class],@"animals":[Animal class]};
}

- (NSString *)description{
    return [NSString stringWithFormat:@"<%p> name : %@ nick :%@ clothes:%@",self, self.name, self.nick, self.clothes];
}

@end
