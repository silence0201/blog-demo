//
//  FilterVc.m
//  CICategoryList
//
//  Created by 杨晴贺 on 2017/5/20.
//  Copyright © 2017年 Silence. All rights reserved.
//

#import "FilterVc.h"
#import <CoreImage/CoreImage.h>

@interface FilterVc ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *tableView ;

@property (nonatomic,strong) NSArray *dataSource ;

@end

@implementation FilterVc

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = self.category;
    self.view.backgroundColor = [UIColor whiteColor] ;
    self.dataSource = [CIFilter filterNamesInCategory:self.category];
    self.tableView = [[UITableView alloc]initWithFrame:self.view.frame] ;
    self.tableView.allowsSelection = NO ;
    [self.view addSubview:self.tableView] ;
    self.tableView.delegate = self ;
    self.tableView.dataSource = self ;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count ;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"] ;
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"] ;
    }
    cell.textLabel.text = self.dataSource[indexPath.row] ;
    return cell ;
}


@end
