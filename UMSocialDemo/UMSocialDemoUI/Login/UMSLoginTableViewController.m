//
//  UMSLoginTableViewController.m
//  SocialSDK
//
//  Created by umeng on 16/4/25.
//  Copyright © 2016年 dongjianxiong. All rights reserved.
//

#import "UMSLoginTableViewController.h"

#define UMSAuthPlatformTypeKey @"UMSAuthPlatformTypeKey"
#define UMSAuthPlatformNameKey @"UMSAuthPlatformNameKey"
#define UMSAuthPlatformIconNameKey @"UMSAuthPlatformImageNameKey"


@interface UMSLoginTableViewController ()

@property (nonatomic, strong) NSMutableArray *platformInfoArray;

@end

@implementation UMSLoginTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.platformInfoArray = [NSMutableArray arrayWithCapacity:10];
    
    NSArray *paltformTypeArray = [NSArray arrayWithObjects:@(UMSocialPlatformType_Sina),@(UMSocialPlatformType_WechatSession),@(UMSocialPlatformType_QQ),@(UMSocialPlatformType_TencentWb),@(UMSocialPlatformType_Renren),@(UMSocialPlatformType_Douban),@(UMSocialPlatformType_Facebook),@(UMSocialPlatformType_Twitter),@(UMSocialPlatformType_Linkedin), nil];
    
    for (NSNumber *platformType in paltformTypeArray) {
        NSMutableDictionary *dict = [self dictWithPlatformName:platformType];
        [dict setValue:platformType forKey:UMSAuthPlatformTypeKey];
        if (dict) {
            [self.platformInfoArray addObject:dict];
        }
    }
    
    [self.tableView registerClass:[UMSocialAthoTableViewCell class] forCellReuseIdentifier:@"cellID"];

}

- (NSMutableDictionary *)dictWithPlatformName:(NSNumber *)platformType
{
    UMSocialPlatformType platformType_int = [platformType integerValue];
    NSString *imageName = nil;
    NSString *paltFormName = nil;
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] initWithCapacity:1];
    switch (platformType_int) {
        case UMSocialPlatformType_Sina:
            imageName = @"UMS_sina_icon";
            paltFormName = @"新浪";
            break;
        case UMSocialPlatformType_WechatSession:
            imageName = @"UMS_wechat_icon";
            paltFormName = @"微信";
            break;
        case UMSocialPlatformType_QQ:
            imageName = @"UMS_qq_icon";
            paltFormName = @"QQ";
            break;
        case UMSocialPlatformType_TencentWb:
            imageName = @"UMS_tencent_icon";
            paltFormName = @"腾讯微博";
            break;
        case UMSocialPlatformType_Douban:
            imageName = @"UMS_douban_icon";
            paltFormName = @"豆瓣";
            break;
        case UMSocialPlatformType_Renren:
            imageName = @"UMS_renren_icon";
            paltFormName = @"人人";
            break;
        case UMSocialPlatformType_Email:
            imageName = @"UMS_email_icon";
            paltFormName = @"邮件";
            break;
        case UMSocialPlatformType_Sms:
            imageName = @"UMS_sms_icon";
            paltFormName = @"短信";
            break;
        case UMSocialPlatformType_Facebook:
            imageName = @"UMS_facebook_icon";
            paltFormName = @"Facebook";
            break;
        case UMSocialPlatformType_Twitter:
            imageName = @"UMS_twitter_icon";
            paltFormName = @"Twitter";
            break;
        case UMSocialPlatformType_Linkedin:
            imageName = @"UMS_linkedin_icon";
            paltFormName = @"Linkedin";
            break;
        default:
            break;
    }
    [dict setValue:UMSocialPlatformIconWithName(imageName) forKey:UMSAuthPlatformIconNameKey];
    [dict setValue:paltFormName forKey:UMSAuthPlatformNameKey];
    return dict;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.platformInfoArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellId = @"cellID";
    UMSocialAthoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[UMSocialAthoTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    NSDictionary *dict = self.platformInfoArray[indexPath.row];
    NSNumber *number = [dict objectForKey:UMSAuthPlatformTypeKey];
    UMSocialPlatformType platformType = [number integerValue];
    cell.platformType = platformType;
    cell.platformSwitch.on = [self checkIsLogin:platformType];
    cell.textLabel.text = [dict objectForKey:UMSAuthPlatformNameKey];
    __weak typeof(self) weakSelf = self;
    cell.switchAction = ^(UISwitch *platformSwitch, UMSocialPlatformType platformType){
        
        [weakSelf switchActionWith:platformSwitch platformType:platformType];
    };
    return cell;
}

-(BOOL)checkIsLogin:(UMSocialPlatformType)platformType{

    if ([[UMSocialDataManager defaultManager] isAuth:platformType]) {
        return YES;
    }else{
        return NO;
    }
}

-(void)switchActionWith:(UISwitch *)platformSwitch platformType:(UMSocialPlatformType)platformType
{
    if (platformSwitch.isOn) {
        [[UMSocialManager defaultManager]  authWithPlatform:platformType currentViewController:self completion:^(id result, NSError *error) {
            [self.tableView reloadData];
            UMSocialAuthResponse *authresponse = result;
            NSString *message = [NSString stringWithFormat:@"result: %d\n uid: %@\n accessToken: %@\n",(int)error.code,authresponse.uid,authresponse.accessToken];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Login"
                                                            message:message
                                                           delegate:nil
                                                  cancelButtonTitle:NSLocalizedString(@"确定", nil)
                                                  otherButtonTitles:nil];
            [alert show];
        }];
    }else{
        [[UMSocialManager defaultManager] cancelAuthWithPlatform:platformType completion:^(id result, NSError *error) {
            if (!error) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"取消授权"
                                                                message:@"取消授权成功"
                                                               delegate:nil
                                                      cancelButtonTitle:NSLocalizedString(@"确定", nil)
                                                      otherButtonTitles:nil];
                [alert show];
            }
            [self.tableView reloadData];
        }];
    }

    
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

@implementation UMSocialAthoTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UISwitch *platformSwitch = [[UISwitch alloc]init];
        platformSwitch.frame = CGRectMake(200, 5, 80, 20);
        [platformSwitch addTarget:self action:@selector(switchAction:) forControlEvents:UIControlEventValueChanged];
        self.accessoryView = platformSwitch;
        self.platformSwitch = platformSwitch;
    }
    return self;
}

- (void)switchAction:(UISwitch *)sender
{
    if (self.switchAction) {
        self.switchAction(self.platformSwitch, self.platformType);
    }
}

@end
