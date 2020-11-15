//
//  MyBookDetailViewController.h
//  AddressBook
//
//  Created by linxiao101 on 2020/6/24.
//  Copyright © 2020 linxiao101. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import <Contacts/Contacts.h>
//#import <ContactsUI/ContactsUI.h>
NS_ASSUME_NONNULL_BEGIN

@class Person;

@interface MyBookDetailViewController :
UIViewController<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong) Person *person;


@end

NS_ASSUME_NONNULL_END
