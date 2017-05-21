//
//  ViewController.m
//  DataSourceDemo
//
//  Created by 杨晴贺 on 2017/5/21.
//  Copyright © 2017年 Silence. All rights reserved.
//

#import "ViewController.h"
#import "ArrayDataSource.h"

@interface ViewController ()

@property (nonatomic,strong) ArrayDataSource *dataSource ;

@property (nonatomic,strong) UITableView *tableView ;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView] ;

}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds] ;
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"] ;
        _tableView.dataSource = self.dataSource ;
    }
    return _tableView ;
}

- (ArrayDataSource *)dataSource {
    if (!_dataSource) {
        NSArray *strs = @[@"第一行",@"第二行",@"第三行",@"第四行",@"第五行",@"第六行"] ;
        self.dataSource = [[ArrayDataSource alloc]initWithItems:strs cellIdentifier:@"cell" configureCellBlock:^(UITableViewCell *cell, NSString *item) {
            cell.textLabel.text = item ;
        }] ;
    }
    return _dataSource ;
}

@end
