//
//  ViewController.m
//  FoldTableView
//
//  Created by 朱晓峰 on 2018/1/7.
//  Copyright © 2018年 朱晓峰. All rights reserved.
//  可折叠tableView

#import "ViewController.h"
#import "FoldTableViewCell.h"

@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong)UITableView * tableView;

@property(nonatomic,strong)NSArray<NSArray *> * foldTexts;
@property(nonatomic,strong)NSMutableArray<NSString *> * foldStatus;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadData];
    [self loadTableView];
}
//加载数据
-(void)loadData{
    self.foldTexts = @[@[@"最适合的彼此"]
                       ,@[@"最适合的彼此",@"有些事情总是在自然的状态下发生，给我们惊喜，让我们铭记于心。"]
                       ,@[@"最适合的彼此",@"有些事情总是在自然的状态下发生，给我们惊喜，让我们铭记于心。",@"在漫长的未来里，很多人在面临爱情到来的时候总是很迷茫，不知不觉就在半路迷路了"]];
    self.foldStatus = [NSMutableArray arrayWithArray:@[@"yes",@"yes",@"yes"]];
    
}

//加载TableView
-(void)loadTableView{
    self.tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([FoldTableViewCell class]) bundle:nil] forCellReuseIdentifier:@"cell"];
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 44;
    self.tableView.sectionHeaderHeight = 44;
    [self.view addSubview:self.tableView];
    self.tableView.tableFooterView = [[UIView alloc]init];
}
-(void)foldSection:(UIButton *)btn{
    if ([self.foldStatus[btn.tag - 100] isEqualToString:@"yes"]) {
        self.foldStatus[btn.tag - 100] = @"no";
    } else {
        self.foldStatus[btn.tag - 100] = @"yes";
    }
    NSIndexSet * set = [[NSIndexSet alloc]initWithIndex:btn.tag - 100];
    [self.tableView reloadSections:set withRowAnimation:UITableViewRowAnimationFade];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if ([self.foldStatus[section] isEqualToString:@"yes"]) {
        return 0;
    }
    return self.foldTexts[section].count;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return  self.foldTexts.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    FoldTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.foldTextLable.text = self.foldTexts[indexPath.section][indexPath.row];
    return cell;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"header"];
    if (!view) {
        view = [[UITableViewHeaderFooterView alloc]initWithReuseIdentifier:@"header"];
    }
    UILabel * lable = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 44)];
    [view addSubview:lable];
    lable.text = [NSString stringWithFormat:@"%ld",(long)section];
    UIButton * btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 44)];
    btn.tag = section + 100;
    [btn addTarget:self action:@selector(foldSection:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:btn];
    return view;
}


@end

