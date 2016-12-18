//
//  MenuViewController.m
//  UIPopoverControllerDemo
//
//  Created by 杨晴贺 on 18/12/2016.
//  Copyright © 2016 silence. All rights reserved.
//

#import "MenuViewController.h"

@interface MenuViewController ()

@property (nonatomic,strong) NSArray *dataArray ;

@end

@implementation MenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.dataArray = @[@"第一个选项",@"第二个选项",@"第三个选项"] ;
    
    // 设置控制器在UIPopoverController中显示的尺寸
    self.preferredContentSize = CGSizeMake(120, 44 * self.dataArray.count) ;
}


#pragma mark --- UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count ;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"] ;
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"] ;
    }
    cell.textLabel.text = self.dataArray[indexPath.row] ;
    return cell ;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES] ;
    NSLog(@"%ld",indexPath.row) ;
}

@end
