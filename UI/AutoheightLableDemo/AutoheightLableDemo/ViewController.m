//
//  ViewController.m
//  AutoheightLableDemo
//
//  Created by 杨晴贺 on 22/12/2016.
//  Copyright © 2016 silence. All rights reserved.
//

#import "ViewController.h"
#import "DemoCell.h"
#import "SDAutoLayout.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UITableView *tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain] ;
    tableView.delegate = self ;
    tableView.dataSource = self ;
    [self.view addSubview:tableView] ;
    [tableView registerNib:[UINib nibWithNibName:@"DemoCell" bundle:nil] forCellReuseIdentifier:@"cell"] ;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1 ;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10 ;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    DemoCell *demoCell = [tableView dequeueReusableCellWithIdentifier:@"cell"] ;
    demoCell.contentStr = @"If YES, telephone number detection is on; otherwise, NO. If a webpage contains numbers that can be interpreted as phone numbers, but are not phone numbers, you can turn off telephone number detection by setting this property to NO. The default value is YES on devices that have phone capabilities.If YES, telephone number detection is on; otherwise, NO. If a webpage contains numbers that can be interpreted as phone numbers, but are not phone numbers, you can turn off telephone number detection by setting this property to NO. The default value is YES on devices that have phone capabilities." ;
    return demoCell ;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [self cellHeightForIndexPath:indexPath cellContentViewWidth:[UIScreen mainScreen].bounds.size.width tableView:tableView] ;
}



@end
