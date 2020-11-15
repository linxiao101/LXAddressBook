//
//  PersonGroup.m
//  AddressBook
//
//  Created by linxiao101 on 2020/6/29.
//  Copyright © 2020 linxiao101. All rights reserved.
//

#import "PersonGroup.h"
#import "Person.h"
@implementation PersonGroup

- (instancetype)init {
    if (self = [super init]) {
        _persons = [NSMutableArray array];
    }
    
    return self;
}

@end
