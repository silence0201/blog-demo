//
//  ViewController.m
//  ModalPresentationDEmo
//
//  Created by 杨晴贺 on 18/12/2016.
//  Copyright © 2016 silence. All rights reserved.
//

#import "ViewController.h"
#import "OneViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (IBAction)fullScreen:(id)sender {
    OneViewController *one = [OneViewController new] ;
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:one] ;
    nav.modalPresentationStyle = UIModalPresentationFullScreen ;
    nav.modalTransitionStyle = UIModalTransitionStylePartialCurl ;
    [self presentViewController:nav animated:YES completion:nil] ;
}
- (IBAction)pageSheet:(id)sender {
    OneViewController *one = [OneViewController new] ;
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:one] ;
    nav.modalPresentationStyle = UIModalPresentationPageSheet ;
    nav.modalTransitionStyle =  UIModalTransitionStyleCrossDissolve;
    [self presentViewController:nav animated:YES completion:nil] ;
}
- (IBAction)formSheet:(id)sender {
    OneViewController *one = [OneViewController new] ;
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:one] ;
    nav.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal ;
    nav.modalPresentationStyle = UIModalPresentationFormSheet ;
    [self presentViewController:nav animated:YES completion:nil] ;
}
- (IBAction)currentContext:(id)sender {
    OneViewController *one = [OneViewController new] ;
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:one] ;
    nav.modalPresentationStyle = UIModalPresentationCurrentContext ;
    [self presentViewController:nav animated:YES completion:nil] ;
}

- (IBAction)custom:(id)sender {
    OneViewController *one = [OneViewController new] ;
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:one] ;
    nav.modalPresentationStyle = UIModalPresentationCustom ;
    [self presentViewController:nav animated:YES completion:nil] ;
}

- (IBAction)overFullSCreen:(id)sender {
    OneViewController *one = [OneViewController new] ;
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:one] ;
    nav.modalPresentationStyle = UIModalPresentationOverFullScreen ;
    [self presentViewController:nav animated:YES completion:nil] ;
}
- (IBAction)overCurrentContext:(id)sender {
    OneViewController *one = [OneViewController new] ;
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:one] ;
    nav.modalPresentationStyle = UIModalPresentationOverCurrentContext ;
    [self presentViewController:nav animated:YES completion:nil] ;
}
- (IBAction)popover:(UIButton *)sender {
    OneViewController *one = [OneViewController new] ;
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:one] ;
    
    nav.modalPresentationStyle = UIModalPresentationPopover ;
    nav.preferredContentSize = CGSizeMake(600, 600) ;
    nav.popoverPresentationController.sourceView = sender;
    nav.popoverPresentationController.sourceRect = sender.bounds;
    [self presentViewController:nav animated:YES completion:nil] ;
    
}


@end
