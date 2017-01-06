//
//  ViewController.m
//  LuaViewDemo
//
//  Created by 杨晴贺 on 05/01/2017.
//  Copyright © 2017 silence. All rights reserved.
//

#import "ViewController.h"
#import "SILuaViewController.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *names;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configLuaView] ;
}

- (void)configLuaView{
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"LuaViewDemo";
    CGRect rect = self.view.bounds;
    self.tableView = [[UITableView alloc]initWithFrame:rect];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.view addSubview:self.tableView];
    NSArray *urlArray = [[NSBundle mainBundle]URLsForResourcesWithExtension:@"lua" subdirectory:nil];
    NSMutableArray *namesArray = [[NSMutableArray alloc]init];
    for (int i = 0;  i < urlArray.count; i ++) {
        NSURL *url = urlArray[i];
        NSString *name = url.relativeString;
        [namesArray addObject:name];
    }
    self.names = namesArray;
    [SILuaViewController disableReloadKeyCommand:YES];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.names.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString* identifier = @"default.identifier";
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if( cell==nil ) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    cell.textLabel.text = self.names[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 64;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES] ;
    NSString* name =  self.names[indexPath.row];
    SILuaViewController* c = [[SILuaViewController alloc] initWithPackage:nil mainScript:name];
    [self.navigationController pushViewController:c animated:YES];
}



@end
