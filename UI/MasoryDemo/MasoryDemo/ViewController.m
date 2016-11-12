//
//  ViewController.m
//  MasoryDemo
//
//  Created by 杨晴贺 on 12/11/2016.
//  Copyright © 2016 silence. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic,strong) NSArray<NSString *>* titleArray ;
@property (nonatomic,strong) NSArray<NSString *>* classArray ;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Masonry的简单使用" ;
     [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:0.164 green:0.657 blue:0.915 alpha:1.000]];
    
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:[UIScreen mainScreen].bounds] ;
    imageView.image = [UIImage imageNamed:@"4"] ;
    imageView.contentMode = UIViewContentModeScaleAspectFill ;
    UIVisualEffectView *visualView = [[UIVisualEffectView alloc]initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleLight]] ;
    visualView.frame = [UIScreen mainScreen].bounds ;
    [imageView addSubview:visualView] ;
    self.tableView.backgroundView = imageView ;
    
    [self initData] ;
}

- (void)initData{
    self.titleArray = @[@"基本使用",@"等间距排布",@"更新约束动画"] ;
    self.classArray = @[@"BasicController",@"EqualMarginController",@"UpdateConstraintsController"] ;
}

#pragma mark --- delegetw 
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1 ;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.titleArray.count ;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"cell" ;
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier] ;
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier] ;
    }
    cell.backgroundColor = [UIColor clearColor] ;
    cell.textLabel.text = self.titleArray[indexPath.row] ;
    return cell ;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    Class vcClass = NSClassFromString(self.classArray[indexPath.row]) ;
    UIViewController *vc = [[vcClass alloc]init] ;
    [self showViewController:vc sender:self] ;
}

@end
