//
//  PhoneNumber.h
//  AddressBook
//
//  Created by linxiao101 on 2020/6/28.
//  Copyright © 2020 linxiao101. All rights reserved.
//

#import <Foundation/Foundation.h>

//使用一个枚举，存储号码类型
typedef NS_ENUM(NSUInteger, PhoneNumberType) {
    NumberiPhone,
    NumberMobile,
    NumberMain,
    HomeFax,
    WorkFax,
    OtherFax,
    Pager,
    Common
};

NS_ASSUME_NONNULL_BEGIN
//存储联系人所有联系号码的类
@interface PhoneNumber : NSObject

@property (nonatomic,copy) NSString *phonenumber;
@property (nonatomic,assign) PhoneNumberType type;

-(NSString *)getPhoneNumberTypeString:(PhoneNumberType) t;


@end

NS_ASSUME_NONNULL_END
