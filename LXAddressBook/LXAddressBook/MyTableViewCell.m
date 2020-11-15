//
//  MyTableViewCell.m
//  AddressBook
//
//  Created by linxiao101 on 2020/6/24.
//  Copyright © 2020 linxiao101. All rights reserved.
//

#import "MyTableViewCell.h"
#import "PersonGroup.h"

@interface MyTableViewCell ()

@property(nonatomic, strong)UILabel *nameLabel;
@property(nonatomic, strong)UILabel *telLabel;


@end

@implementation MyTableViewCell

/**
 - (instancetype)init{
 return [self initWithFrame:CGRectZero];
 }
 
 - (instancetype)initWithFrame:(CGRect)frame reuseIdentifier:(NSString *)reuseIdentifier{
 return [self initWithFrame:frame];
 }
 
 - (instancetype)initWithFrame:(CGRect)frame{
 if (self = [super initWithFrame:frame]) {
 _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 50, frame.size.height)];
 _telLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 0, 100, frame.size.height)];
 [self.contentView addSubview:self.nameLabel];
 [self.contentView addSubview:self.telLabel];
 }
 return self;
 }
 *自定义cell使用initWithStyle，不用initWithFrame
 */

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 150, 50)];
        _telLabel = [[UILabel alloc] initWithFrame:CGRectMake(160, 0, 300, 50)];
        [self.contentView addSubview:self.nameLabel];
        [self.contentView addSubview:self.telLabel];
        
    }
    return self;
}

#pragma mark 绑定数据
-(void)bindData:(Person *)person{
    self.nameLabel.text=person.name;
    self.telLabel.text=person.phoneNumbers[0].phonenumber;
    
    
}


//不用类的传参方法
/*- (void)bindData:(NSString *)name phoneNum:(NSArray<NSString *> *) phones{
 
 // if (!([data isKindOfClass:[NSDictionary class]] && data.count > 0)) {
 //      return;
 //   }
 
 
 //  self.nameLabel.text =name;
 
 //直接两个号码拼接成整体
 // NSString *phoneTemp=[phones componentsJoinedByString:@" "];
 self.telLabel.text = phones;
 }*/


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
