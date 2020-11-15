//
//  PhoneNumber.m
//  AddressBook
//
//  Created by linxiao101 on 2020/6/28.
//  Copyright © 2020 linxiao101. All rights reserved.
//

#import "PhoneNumber.h"

@implementation PhoneNumber


-(NSString *)getPhoneNumberTypeString:(PhoneNumberType) t{
    NSString *result=nil;
    switch (t) {
        case NumberiPhone:
            result=@"NumberiPhone:";
            break;
        case NumberMobile:
            result=@"NumberMobile:";
            break;
            case NumberMain:
            result=@"NumberMain:";
            break;
            case HomeFax:
            result=@"HomeFax:";
            break;
            case WorkFax:
            result=@"WorkFax:";
            break;
            case OtherFax:
            result=@"OtherFax:";
            break;
            case Pager:
            result=@"Pager:";
            break;
            case Common:
            result=@"Common:";
            break;
            
        default:
            result=@"Other:";
            break;
    }
    return result;
}

@end
