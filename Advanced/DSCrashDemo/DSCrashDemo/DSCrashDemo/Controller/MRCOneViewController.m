//
//  MRCOneViewController.m
//  DSCrashDemo
//
//  Created by dasheng on 16/4/11.
//  Copyright © 2016年 dasheng. All rights reserved.
//

#import "MRCOneViewController.h"
#import "MyMrcView.h"

@interface MRCOneViewController ()


@end

@implementation MRCOneViewController

- (void)viewDidLoad {

    [super viewDidLoad];
    
    UIScrollView  *contentScroller = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    contentScroller.contentSize = CGSizeMake(self.view.frame.size.width, self.view.frame.size.height*1.5);
    [self.view addSubview:contentScroller];

    UIButton *crashSignalEGVButton = [[UIButton alloc] initWithFrame:CGRectMake(60, 200, 200, 100)];
    crashSignalEGVButton.backgroundColor = [UIColor redColor];
    [crashSignalEGVButton setTitle:@"提高了野指针的崩溃率" forState:UIControlStateNormal];
    [crashSignalEGVButton addTarget:self action:@selector(crashSignalEGVClick) forControlEvents:UIControlEventTouchUpInside];
    [contentScroller addSubview:crashSignalEGVButton];
}

- (void)crashSignalEGVClick{
    
    //EXC_BAD_ACCESS(code=1,address=0x155555560)：表示0x155555560此内存并不合法，内部实现为已经被释放，为垃圾内存。
    MyMrcView *myview = [[MyMrcView alloc]init]; //导致SIGSEGV的错误，一般会导致进程流产
}

- (void)viewWillDisappear:(BOOL)animated{
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
