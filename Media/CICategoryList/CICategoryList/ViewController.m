//
//  ViewController.m
//  CICategoryList
//
//  Created by 杨晴贺 on 2017/5/20.
//  Copyright © 2017年 Silence. All rights reserved.
//

#import "ViewController.h"
#import "FilterVc.h"
#import <CoreImage/CoreImage.h>

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) NSArray *dataSource ;

@property (nonatomic,strong) UITableView *tableView ;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"分类" ;
    self.view.backgroundColor = [UIColor whiteColor] ;
    [self initCICategory] ;
    self.tableView = [[UITableView alloc]initWithFrame:self.view.frame] ;
    [self.view addSubview:self.tableView] ;
    self.tableView.delegate = self ;
    self.tableView.dataSource = self ;
}

- (void)initCICategory {
    self.dataSource = @[kCICategoryDistortionEffect,
                        kCICategoryGeometryAdjustment,
                        kCICategoryCompositeOperation,
                        kCICategoryHalftoneEffect,
                        kCICategoryColorAdjustment,
                        kCICategoryColorEffect,
                        kCICategoryTransition,
                        kCICategoryTileEffect,
                        kCICategoryGenerator,
                        kCICategoryReduction,
                        kCICategoryGradient,
                        kCICategoryStylize,
                        kCICategorySharpen,
                        kCICategoryBlur,
                        kCICategoryVideo,
                        kCICategoryStillImage,
                        kCICategoryInterlaced,
                        kCICategoryNonSquarePixels,
                        kCICategoryHighDynamicRange,
                        kCICategoryBuiltIn,
                        kCICategoryFilterGenerator] ;
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
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator ;
    return cell ;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES] ;
    FilterVc *vc = [[FilterVc alloc]init] ;
    vc.category = self.dataSource[indexPath.row] ;
    [self.navigationController pushViewController:vc animated:YES] ;
}


@end
