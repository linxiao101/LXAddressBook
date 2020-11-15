//
//  DetailTableViewCell.h
//  AddressBook
//
//  Created by linxiao101 on 2020/7/9.
//  Copyright © 2020 linxiao101. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Person.h"
#import "PhoneNumber.h"
NS_ASSUME_NONNULL_BEGIN

@interface DetailTableViewCell : UITableViewCell
-(void)bind:(Person *)person;
//-(void)bindPicture;

@end

NS_ASSUME_NONNULL_END
