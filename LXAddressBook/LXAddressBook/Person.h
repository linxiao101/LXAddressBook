//
//  Person.h
//  AddressBook
//
//  Created by linxiao101 on 2020/6/28.
//  Copyright © 2020 linxiao101. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface FrameModel : NSObject

// nameHeight
// phoneHeight;
// totalHeight;

@end

@class PhoneNumber;

NS_ASSUME_NONNULL_BEGIN
//存储联系人信息的类
@interface Person : NSObject

@property (nonatomic,copy) NSString *name;
@property (nonatomic,strong) NSArray<PhoneNumber *> *phoneNumbers;

// frameModel;

@end

NS_ASSUME_NONNULL_END
