//
//  ViewController.m
//  AddressBook
//
//  Created by linxiao101 on 2020/6/23.
//  Copyright © 2020 linxiao101. All rights reserved.
//

#import "ViewController.h"
#import "MyTableViewCell.h"
#import "MyBookDetailViewController.h"
#import "Person.h"
#import "PhoneNumber.h"
#import "PersonGroup.h"
#import "DetailTableViewCell.h"

#import <Contacts/Contacts.h>
#import <ContactsUI/ContactsUI.h>

//CNContactStore


static NSString *KCellIdentifier =@"NameIdentifier";


@interface ViewController () <UITableViewDataSource,UITableViewDelegate>{
    // NSArray* _data;//类的扩展，加入姓名数组
    NSString * givenName ;//名
    NSString * famliyName ;//姓
    NSArray  * phoneArray ;//电话
    NSMutableArray<Person *> *_person;//存储姓名和号码信息的对象
    NSMutableArray<PersonGroup*> *_groups;//存储每个分组联系人的信息
    
}

@property (strong, nonatomic) UITableView *tableView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //数组初始化
    _person= [NSMutableArray array];
    _groups= [NSMutableArray array];
    
    //判断授权状态
    switch([CNContactStore authorizationStatusForEntityType:CNEntityTypeContacts]){
            //还未决定，先请求授权，然后获取数据
        case CNAuthorizationStatusNotDetermined:{
            CNContactStore *store = [[CNContactStore alloc] init];
            [store requestAccessForEntityType:CNEntityTypeContacts completionHandler:^(BOOL granted, NSError * _Nullable error) {
                if (granted) {
                    [self fetchData];
                    // NSLog(@"%@",_usersArrM);
                } else {
                    NSLog(@"授权失败");
                }
            }];
            break;
        }
        case CNAuthorizationStatusAuthorized:{
            [self fetchData];
            break;
        }
            //另外两种状态暂时不考虑
            // case CNAuthorizationStatusDenied:
            // case CNAuthorizationStatusRestricted:
            
            
    }
    
    //tableview初始化
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height) style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [_tableView registerClass:[MyTableViewCell class] forCellReuseIdentifier:KCellIdentifier];
    [self.view addSubview:self.tableView];
}


#pragma mark 获取联系人信息
//获取联系人信息
- (void)fetchData {
    // 2. 获取联系人仓库
    CNContactStore * store = [[CNContactStore alloc] init];
    
    // 3. 创建联系人信息的请求对象
    NSArray * keys = @[CNContactGivenNameKey, CNContactFamilyNameKey, CNContactPhoneNumbersKey];
    
    // 4. 根据请求Key, 创建请求对象
    CNContactFetchRequest * request = [[CNContactFetchRequest alloc] initWithKeysToFetch:keys];
    //用词典来存储联系人首字母和信息，如果已存在相同首字母，则将这个联系人先拉去group
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    
    
    // 5. 发送请求
    [store enumerateContactsWithFetchRequest:request error:nil usingBlock:^(CNContact * _Nonnull contact, BOOL * _Nonnull stop) {
        
        //临时对象存储联系人信息，待存入对象数组
        Person *tempPerson=[[Person alloc] init];
        
        //临时存储联系人群组
        PersonGroup *tempGroup=[[PersonGroup alloc] init];
        
        
        //临时存储联系人所有号码
        NSMutableArray<PhoneNumber *> *tempPhoneNumberArray=[NSMutableArray array];
        
        
        //6.3获取联系人邮箱,隐私保护，除非contact的UI否则无法获取
//        NSArray *emailArray=contact.emailAddresses;
//        for(CNLabeledValue *labelValue in emailArray) {
//            tempEmailAddress = labelValue.value;
//
//        }

        
        
        // 6.1 获取姓名
        NSString * givenName = contact.givenName;
        NSString * familyName = contact.familyName;
        NSString *connect=@" ";
        //   NSLog(@"%@--%@", givenName, familyName);
        NSString *fullName = [givenName stringByAppendingString:connect];
        fullName=[fullName stringByAppendingString:familyName];
        tempPerson.name=fullName;
        
        
        //获取邮箱地址
        
        // 6.2 获取电话
        //NSMutableArray *tempArrM = [NSMutableArray array];
        NSArray * phoneArray = contact.phoneNumbers;
        for (CNLabeledValue * labelValue in phoneArray) {
            
            //临时对象存储联系人号码
            PhoneNumber *tempPhoneNumber=[[PhoneNumber alloc]init];
            
            CNPhoneNumber * number = labelValue.value;
            //  NSLog(@"%@--%@", number.stringValue, labelValue.label);
            if ([labelValue.label isEqualToString: CNLabelPhoneNumberiPhone]) {
                tempPhoneNumber.type=NumberiPhone;
                tempPhoneNumber.phonenumber=number.stringValue;
            }
            else if ([labelValue.label isEqualToString:CNLabelPhoneNumberMobile]){
                tempPhoneNumber.type=NumberMobile;
                tempPhoneNumber.phonenumber=number.stringValue;
            }
            else if ([labelValue.label isEqualToString:CNLabelPhoneNumberMain]){
                tempPhoneNumber.type=NumberMain;
                tempPhoneNumber.phonenumber=number.stringValue;
            }
            else if ([labelValue.label isEqualToString:CNLabelPhoneNumberHomeFax]){
                tempPhoneNumber.type=HomeFax;
                tempPhoneNumber.phonenumber=number.stringValue;
            }
            else if ([labelValue.label isEqualToString:CNLabelPhoneNumberWorkFax]){
                tempPhoneNumber.type=WorkFax;
                tempPhoneNumber.phonenumber=number.stringValue;
            }
            else if ([labelValue.label isEqualToString:CNLabelPhoneNumberOtherFax]){
                tempPhoneNumber.type=OtherFax;
                tempPhoneNumber.phonenumber=number.stringValue;
            }
            else if ([labelValue.label isEqualToString:CNLabelPhoneNumberPager]){
                tempPhoneNumber.type=Pager;
                tempPhoneNumber.phonenumber=number.stringValue;
            } else {
                tempPhoneNumber.type = Common;
                tempPhoneNumber.phonenumber = number.stringValue;
            }
            
            [tempPhoneNumberArray addObject:tempPhoneNumber];
            //  [tempArrM addObject:number.stringValue];
        }
        
        // 10 [tempPhoneNumberArray addObject:0xbbb];
        tempPerson.phoneNumbers=[tempPhoneNumberArray copy];
        
        //获取名字首字母，并大写
        NSString *firstnumber= [[fullName substringToIndex:1] uppercaseString];
        //如果首字母未出现过，新建一个group
        if([dict objectForKey:firstnumber]==nil){
            [dict setValue:tempGroup forKey:firstnumber];
            tempGroup.title=firstnumber;
            [tempGroup.persons addObject:tempPerson] ;
            [_groups addObject:tempGroup];
        }
        //如果首字母已出现过，找到group然后添加成员
        else{
            PersonGroup *group = [dict objectForKey:firstnumber];
            [group.persons addObject:tempPerson];
        }
        
        /*
         *添加当前获取的联系人
         [_person addObject:tempPerson];
         [tempPhoneNumberArray removeAllObjects];
         */
        
        
    }];
    
    
#pragma mark 按名字首字母排序
    
    //给group数组排序
    //语法块排序，+号按照升序排序，-号降序，注意是字符串，数字得先变成字符串
    [_groups sortUsingComparator:^(PersonGroup *obj1,PersonGroup *obj2){
        return +[[obj1 title] compare: [obj2 title]];
    }];
    
    
    //    NSString *firstChar = @"A";
    //按title属性查找等于firstchar的自带方法
    //    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"%K IN {%@}",@"title",firstChar];
    //    NSArray *result = [_groups filteredArrayUsingPredicate:predicate];
    //     NSLog(@"%@",predicate);
    
    
    
    /**
     用_person数组存储排序过的联系人信息
     for(int i=0,k=0;i<_groups.count;i++) {
     for(int j=0;j<_groups[i].persons.count;j++) {
     _person[k++]=_groups[i].persons[j];
     }
     }
     */
    
    
    /*
     *排序失败方法
     //先构造一个排序描述器
     NSSortDescriptor *groupTitleDesc = [NSSortDescriptor sortDescriptorWithKey:@"_groups.title" ascending:YES ];
     //把排序描述器放进数组里
     NSArray *descriptorArray = [NSArray arrayWithObjects:groupTitleDesc, nil];
     [_groups sortedArrayUsingDescriptors:descriptorArray];
     */
    
    
    
    
    
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.tableView reloadData];
    });
    
    
}

#pragma mark 实现tabelView



//实现两个数据源的核心方法

//告诉tableview有多少组数据（分组时新加的）

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _groups.count;
}

/**
 *告诉tableView第section组有多少行
 */
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _groups[section].persons.count;
}

/**
 * 告诉tableView第indexPath行显示怎样的cell
 */

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MyTableViewCell *cell =[tableView
                            dequeueReusableCellWithIdentifier:KCellIdentifier
                            forIndexPath:indexPath];
    
    [cell bindData:_groups[indexPath.section].persons[indexPath.row]];
    return cell;
}

//行的间距
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50.0f;
}

//设置指定的section的header的title
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return _groups[section].title;
}

//设置并返回指定的section的header view的高度（分组新加的）
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 30.0f;
}

//设置并返回指定section的footer view的高度（分组新加的）
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 20.0f;
}



#pragma mark 选中联系人
/**
 * 在TableViewz上选中某个Cell会触发
 */
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //声明一个UIAlertView
    //    [self presentViewController:alert animated:YES completion:nil];
    MyBookDetailViewController *vc = [MyBookDetailViewController new];
    vc.person =_groups[indexPath.section].persons[indexPath.row];
    [self.navigationController pushViewController:vc animated:YES];
    vc.view.backgroundColor =UIColor.whiteColor;
    
    
    
}

/*
 *在groups中查找首字母为firstchar的group的方法
 - (PersonGroup *)personGroupFromTitle:(NSString *)firstChar {
 for (PersonGroup *group in _groups) {
 if ([group.title isEqualToString:firstChar]) {
 return group;
 }
 }
 
 return nil;
 }
 */

@end

