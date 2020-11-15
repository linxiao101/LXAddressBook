//
//  DetailTableViewCell.m
//  AddressBook
//
//  Created by linxiao101 on 2020/7/9.
//  Copyright © 2020 linxiao101. All rights reserved.
//

#import "DetailTableViewCell.h"
#import "Person.h"
#import "PersonGroup.h"
#import "PhoneNumber.h"
@interface DetailTableViewCell(){
    NSString *nameTitle;
    NSString *phoneTypeTitle;
}

@property(nonatomic,strong)UILabel *nameType;//Name:
@property(nonatomic,strong)UILabel *nameLabel;//姓名
@property(nonatomic,strong)UILabel *phoneTypeLabel;//电话号码类型1
@property(nonatomic,strong)UILabel *phoneLabel;//电话号码1
@property(nonatomic,strong)UILabel *phoneTypeLabel2;//电话号码类型2
@property(nonatomic,strong)UILabel *phoneLabel2;//电话号码2
@property(nonatomic,strong)UILabel *phoneTypeLabel3;//电话号码类型3
@property(nonatomic,strong)UILabel *phoneLabel3;//电话号码3
//@property(nonatomic,strong)UIView *line;//分割线
//@property(nonatomic,strong)UIImageView *NameimageView;
@end

@implementation DetailTableViewCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if(self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        _nameType=[[UILabel alloc] initWithFrame:CGRectMake(20, 0, 300, 50)];
        _nameLabel=[[UILabel alloc] initWithFrame:CGRectMake(20, 50, 300, 50)];
        _nameLabel.numberOfLines = 0;
        //        _line=[[UIView alloc]initWithFrame:CGRectMake(0, 100, CGRectGetWidth(self.bounds), 1)];
        //        _line.backgroundColor=UIColor.blackColor;
        _phoneTypeLabel=[[UILabel alloc] initWithFrame:CGRectMake(20, 100, 300, 50)];
        _phoneLabel=[[UILabel alloc] initWithFrame:CGRectMake(20, 150, 300, 50)];
        _phoneTypeLabel2=[[UILabel alloc] initWithFrame:CGRectMake(20, 200, 300, 50)];
        _phoneLabel2=[[UILabel alloc] initWithFrame:CGRectMake(20, 250, 300, 50)];
        _phoneTypeLabel3=[[UILabel alloc] initWithFrame:CGRectMake(20, 300, 300, 50)];
        _phoneLabel3=[[UILabel alloc] initWithFrame:CGRectMake(20, 350, 300, 50)];
        [self.contentView addSubview:self.nameType];
        [self.contentView addSubview:self.nameLabel];
        //        [self.contentView addSubview:self.line];
        [self.contentView addSubview:self.phoneTypeLabel];
        [self.contentView addSubview:self.phoneLabel];
        [self.contentView addSubview:self.phoneTypeLabel2];
        [self.contentView addSubview:self.phoneLabel2];
        [self.contentView addSubview:self.phoneTypeLabel3];
        [self.contentView addSubview:self.phoneLabel3];
        //        [self.contentView addSubview:self.NameimageView];
        
    }
    return self;
}

//为了调整原先图片的位置，现在图片已经移走
//- (void)layoutSubviews {
//    [super layoutSubviews];
//
//    _NameimageView.frame = CGRectMake((CGRectGetWidth(self.bounds) - 100) * 0.5, (CGRectGetHeight(self.bounds) - 100) * 0.5, 100, 100);
//}


#pragma mark 绑定数据
//绑定各个label的数据
-(void)bind:(Person *)person{
    nameTitle =@ "Name :   ";
    self.nameType.text=nameTitle;
    self.nameLabel.text = person.name;
    self.phoneLabel.text = person.phoneNumbers[0].phonenumber;
    phoneTypeTitle=[person.phoneNumbers[0] getPhoneNumberTypeString:person.phoneNumbers[0].type];
    self.phoneTypeLabel.text=phoneTypeTitle;
    
    if(person.phoneNumbers.count>=2){
        self.phoneLabel2.text = person.phoneNumbers[1].phonenumber;
        phoneTypeTitle=[person.phoneNumbers[1] getPhoneNumberTypeString:person.phoneNumbers[1].type];
        self.phoneTypeLabel2.text=phoneTypeTitle;
    }
    if(person.phoneNumbers.count>=3){
        self.phoneLabel3.text =person.phoneNumbers[2].phonenumber;
        phoneTypeTitle=[person.phoneNumbers[2] getPhoneNumberTypeString:person.phoneNumbers[2].type];
        self.phoneTypeLabel3.text=phoneTypeTitle;
    }
    
    
    
    
    //计算label的高度，达到300就换行，这里不需要用
    //   CGFloat height = [nameTitle boundingRectWithSize:CGSizeMake(300, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName: _nameLabel.font} context:nil].size.height;
    //    _nameLabel.frame = CGRectMake(0, 0, 300, height);
    //    _phoneLabel.frame = CGRectMake(0, height, 300, 50);
}

//-(void)bindPicture{
//    self.NameimageView.image = [UIImage imageNamed:@"11"];
//
//}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
