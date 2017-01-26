//
//  ViewController.m
//  XCTestDemo
//
//  Created by 杨晴贺 on 26/01/2017.
//  Copyright © 2017 Silence. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UITextField *userName;
@property (weak, nonatomic) IBOutlet UITextField *userPassword;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (IBAction)loginAction:(id)sender {
    if ([self.userName.text isEqualToString:@"Silence"] &&[self.userPassword.text isEqualToString:@"1234"]) {
        NSLog(@"😁success😁");
    } else {
        NSLog(@"☹failed☹");
    }
}




@end
