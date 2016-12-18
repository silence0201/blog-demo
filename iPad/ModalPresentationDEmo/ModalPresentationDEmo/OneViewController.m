//
//  OneViewController.m
//  ModalPresentationDEmo
//
//  Created by 杨晴贺 on 18/12/2016.
//  Copyright © 2016 silence. All rights reserved.
//

#import "OneViewController.h"

@interface OneViewController ()

@end

@implementation OneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIBarButtonItem *dismissBtn = [[UIBarButtonItem alloc]initWithTitle:@"dismiss" style:UIBarButtonItemStylePlain target:self action:@selector(dismiss)] ;
    self.navigationItem.leftBarButtonItem = dismissBtn ;
    
    UIBarButtonItem *otherBtn = [[UIBarButtonItem alloc]initWithTitle:@"other" style:UIBarButtonItemStylePlain target:self action:@selector(other)] ;
    self.navigationItem.rightBarButtonItem = otherBtn ;
    
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:self.view.bounds] ;
    imageView.image = [UIImage imageNamed:@"2"] ;
    imageView.contentMode = UIViewContentModeScaleAspectFill ;
    [self.view addSubview:imageView] ;
    
    self.title = @"PresentView" ;
    self.view.backgroundColor = [UIColor redColor] ;
}

- (void)dismiss{
    [self dismissViewControllerAnimated:YES completion:nil] ;
}

- (void)other{
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:[OneViewController new]] ;
    [self presentViewController:nav animated:YES completion:nil] ;
}

@end
