//
//  ViewController.m
//  BluetouchDemo
//
//  Created by 杨晴贺 on 7/31/16.
//  Copyright © 2016 silence. All rights reserved.
//

#import "ViewController.h"
#import <GameKit/GameKit.h>

@interface ViewController ()<UINavigationControllerDelegate, UIImagePickerControllerDelegate,GKPeerPickerControllerDelegate>
// 显示照片的View
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

// 保留会话的session
@property (nonatomic,strong) GKSession *session;


@end
/**
 *  利用GameKit进行蓝牙传输,只能用于苹果设备之间进行传输,只能用于同种app之间进行传输
 */
@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - 链接设备
- (IBAction)connectDevice {
    // 创建查找设备的控制器
    GKPeerPickerController *ppc = [[GKPeerPickerController alloc]init] ;
    
    // 设置代理
    ppc.delegate = self ;
    
    // 弹出控制器
    [ppc show] ;
    
}

#pragma mark - GKPeerPickerControllerDelegate的代理方法
/**
 *  设置连接成功后会调用该方法
 *
 *  @param peerID  设备ID
 *  @param session 会话,利用会话来传输数据
 */
- (void)peerPickerController:(GKPeerPickerController *)picker didConnectPeer:(NSString *)peerID toSession:(GKSession *)session{
    NSLog(@"%@",peerID) ;
    // 保存会话session
    self.session = session ;
    // 设置接收者句柄
    [self.session setDataReceiveHandler:self withContext:nil] ;
}

#pragma mark - 选择照片
- (IBAction)pickImage {
    // 判断照片源是否可用
    /*
     UIImagePickerControllerSourceTypePhotoLibrary 手机当中所有的图片
     UIImagePickerControllerSourceTypeCamera 相机
     UIImagePickerControllerSourceTypeSavedPhotosAlbum 相册中的图片
     */
    if(![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) return ;
    
    // 创建照片选择控制器
    UIImagePickerController *ipc = [[UIImagePickerController alloc]init] ;
    
    // 设置照片源
    ipc.sourceType = UIImagePickerControllerSourceTypePhotoLibrary ;
    
    // 设置代理
    ipc.delegate = self ;
    
    // 弹出控制器
    [self presentViewController:ipc animated:YES completion:nil] ;
}

#pragma mark - UIImagePickerController的代理方法
/**
 *  图片选择后会把数据进行传递
 *
 *  @param info   选择图片的详细信息
 */
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    // 取出照片
    self.imageView.image = info[UIImagePickerControllerOriginalImage] ;
    NSLog(@"%@",info) ;
    
    // 退出控制器
    [self dismissViewControllerAnimated:YES completion:nil] ;
}
#pragma mark - 发送照片
- (IBAction)sendImage {
    if(!self.imageView.image) return;
    // 将图片转换为Data
    NSData *imageData = UIImageJPEGRepresentation(self.imageView.image, 0.5) ;  // 可以对图片进行压缩
    /*
     GKSendDataReliable, 可靠传输,数据一定会被传达 --> TCP
     GKSendDataUnreliable, 不可靠传输         -->UDP
     */
    [self.session sendDataToAllPeers:imageData withDataMode:GKSendDataReliable error:NULL] ;
}

#pragma mark - 接收数据
/**
 *  接收到数据后,执行该方法
 *
 *  @param data    收到的数据
 */
- (void) receiveData:(NSData *)data fromPeer:(NSString *)peer inSession: (GKSession *)session context:(void *)context{
    // 将data转换为image
    UIImage *receiveImage = [UIImage imageWithData:data] ;
    
    //设置到imageView
    self.imageView.image = receiveImage ;
    
    // 将图片保存到相册中
    UIImageWriteToSavedPhotosAlbum(receiveImage, nil, nil, nil) ;
}

@end
