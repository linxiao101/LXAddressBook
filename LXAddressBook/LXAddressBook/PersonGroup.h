//
//  PersonGroup.h
//  AddressBook
//
//  Created by linxiao101 on 2020/6/29.
//  Copyright © 2020 linxiao101. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Person;

NS_ASSUME_NONNULL_BEGIN

@interface PersonGroup : NSObject

@property(nonatomic,copy) NSString *title;//姓名首字母
@property(nonatomic,strong) NSMutableArray<Person *> *persons;

@end

NS_ASSUME_NONNULL_END
