//
//  UMSShareMainViewController.m
//  SocialSDK
//
//  Created by umeng on 16/4/24.
//  Copyright © 2016年 dongjianxiong. All rights reserved.
//

#import "UMSShareMainViewController.h"
#import "UMSocialUIManager.h"
#import "UMShareContentViewController.h"

@interface UMSShareMainViewController ()

@property (nonatomic, strong) UIBarButtonItem *leftItem;

@end

@implementation UMSShareMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    self.view.backgroundColor = [UIColor whiteColor];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithTitle:@" " style:UIBarButtonItemStylePlain target:self action:@selector(disMissShareMenuView)];
    self.navigationItem.leftBarButtonItem = leftItem;
    self.leftItem = leftItem;
    
    // Do any additional setup after loading the view from its nib.
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

- (void)disMissShareMenuView
{
     self.leftItem.title = nil;
    [UMSocialUIManager dismissShareMenuView];
    [self dismissViewControllerAnimated:YES completion:nil];
    
}


- (IBAction)showShareSelectionView:(UIButton *)sender {

     self.leftItem.title = @"取消";
    __weak typeof(self) weakSelf = self;
    [UMSocialUIManager showShareMenuViewInView:self.view sharePlatformSelectionBlock:^(UMSocialShareSelectionView *shareSelectionView, NSIndexPath *indexPath, UMSocialPlatformType platformType) {
        [UMSocialUIManager dismissShareMenuView];
        UMShareContentViewController *contentView = [[UMShareContentViewController alloc] initWithNibName:@"UMShareContentViewController" bundle:nil];
        contentView.socialType = platformType;
        UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController:contentView];
        [weakSelf.navigationController presentViewController:navi animated:YES completion:nil];
    }];
}

- (IBAction)showShareDemoView:(UIButton *)sender {
//    
//    UMSSharePlatformTableViewController *sharePlatformVc = [[UMSSharePlatformTableViewController alloc] init];
//    UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController:sharePlatformVc];
//    [self presentViewController:navi animated:YES completion:nil];
//
//    NSDictionary* paramDic = @{@"dc": @"UMSocialDefault",
//                      @"ni":@"1",
//                      @"opid":@"1",};
//    NSDictionary* paramDic = @{
//                               @"ni":@"1",
//                               @"opid":@"1",};
//    [UMSocialHttpManager actionBarRequestWithParamDic:paramDic completion:^(id result, NSError *error) {
//        
//    }];
//
//    NSDictionary* paramDic = @{@"to":@"sina",
//                      @"usid":@"3228796143",
//                      @"access_token":@"2.00J4hVWDMZD6RE522c07de4fZtiWID",
//                      @"refresh_token":@"2.00J4hVWDMZD6RE9a369d63410wC8nc",
//                      @"expires_in":@"2625021",
//                      @"app_id":@"3921700954",//3921700954
//                      @"app_secret":@"04b48b094faeb16683c32669824ebdad",//04b48b094faeb16683c32669824ebdad
//                      };
//    [UMSocialHttpManager platformTokenUploadReqWithParamDic:paramDic completion:^(id result, NSError *error) {
//        
//    }];
    
}


@end
