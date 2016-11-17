//
//  OneTableViewController.m
//  CustomDeleteDemo
//
//  Created by 杨晴贺 on 17/11/2016.
//  Copyright © 2016 silence. All rights reserved.
//

#import "OneTableViewController.h"
#import "OneCustomCell.h"

@interface OneTableViewController ()

@end

@implementation OneTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title  = @"第一种方法" ;
    [self.tableView registerClass:[OneCustomCell class]forCellReuseIdentifier:@"cell"] ;
    self.tableView.separatorInset = UIEdgeInsetsZero ;
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1 ;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10 ;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    OneCustomCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"] ;
    cell.textLabel.text = [NSString stringWithFormat:@"text_%zd",indexPath.row] ;
    return cell;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"CLick:%ld",indexPath.row) ;
}

@end
