Array *clothes = @[
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

