//
//  MyBookDetailViewController.m
//  AddressBook
//
//  Created by linxiao101 on 2020/6/24.
//  Copyright © 2020 linxiao101. All rights reserved.
//

#import "MyBookDetailViewController.h"
#import "MyTableViewCell.h"
#import "MyBookDetailViewController.h"
#import "Person.h"
#import "PhoneNumber.h"
#import "PersonGroup.h"
#import "DetailTableViewCell.h"

static NSString *BCellIdentifier =@"Cell";

@interface MyBookDetailViewController ()<UITableViewDataSource,UITableViewDelegate>//这边删除了之前用的<CNContactPickerDelegate>

@property (strong, nonatomic) UITableView *tableView;
@property (strong,nonatomic) UIView *headerView;
@property (strong, nonatomic) UIImageView *headerImageView;
@property(strong,nonatomic)UILabel *headerLabel;

@end

@implementation MyBookDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //初始化tableview
    _tableView=[[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)  style:UITableViewStylePlain ];
    _tableView.dataSource=self;
    _tableView.delegate=self;
    [_tableView registerClass:[DetailTableViewCell class] forCellReuseIdentifier:BCellIdentifier];
    [self.view addSubview:self.tableView];
    
    _headerView=[[UIView alloc] init];
    _headerView.frame =CGRectMake(0, 0, self.view.bounds.size.width, 200.0f);
    _headerImageView=[[UIImageView alloc] init];
    _headerLabel=[[UILabel alloc] init];
    
    [self setHeader];
    [self.headerView addSubview:_headerImageView];
    [self.headerView addSubview:_headerLabel];
    _headerLabel.textAlignment = NSTextAlignmentCenter;
}


-(void)setHeader {
    _headerImageView.frame=CGRectMake((CGRectGetWidth(_headerView.bounds)-125)*0.5, (CGRectGetHeight(_headerView.bounds)-125)*0.5, 125, 125);
    //    _headerImageView.image=[UIImage imageNamed:@"11"];
    _headerImageView.layer.backgroundColor = [UIColor grayColor].CGColor;
    _headerImageView.layer.masksToBounds=YES;
    _headerImageView.layer.cornerRadius=62.5;
    //    _headerLabel.frame=CGRectMake((CGRectGetWidth(_headerView.bounds)-100)*0.5, (CGRectGetHeight(_headerView.bounds)-100)*0.5, 100, 100);
    _headerLabel.frame = CGRectMake(0, (CGRectGetHeight(_headerView.bounds)-125)*0.5, CGRectGetWidth(self.tableView.bounds), 125);
    _headerLabel.text=_person.name;
    
}

#pragma mark tableView的实现
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

//每个cell要传显示的内容
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    DetailTableViewCell *cell=[tableView
                               dequeueReusableCellWithIdentifier:BCellIdentifier
                               forIndexPath:indexPath];
    
    [cell bind:_person];
    
    return cell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100.0f;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return _headerView;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 200.0f;
}


/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */



@end
