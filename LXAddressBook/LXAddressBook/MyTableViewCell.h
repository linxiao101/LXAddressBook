//
//  MyTableViewCell.h
//  AddressBook
//
//  Created by linxiao101 on 2020/6/24.
//  Copyright © 2020 linxiao101. All rights reserved.
//

#import <UIKit/UIKit.h>
#import"Person.h"
#import"PhoneNumber.h"
NS_ASSUME_NONNULL_BEGIN

@interface MyTableViewCell : UITableViewCell

//@property(nonatomic, assign)BOOL isHaha;

//- (void)bindData:(NSString *)name phoneNum:(NSArray<NSString *> *) phones;

-(void)bindData:(Person *)person;
@end

NS_ASSUME_NONNULL_END
