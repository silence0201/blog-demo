//
//  ViewController.m
//  GroupChatClient
//
//  Created by 杨晴贺 on 25/09/2016.
//  Copyright © 2016 silence. All rights reserved.
//

#import "ViewController.h"
#import "GCDAsyncSocket.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource,GCDAsyncSocketDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (weak, nonatomic) IBOutlet UITextField *inputText;


@property (nonatomic,strong) GCDAsyncSocket *clientStock ;

@property (nonatomic,strong) NSMutableArray *dataSource ; // 数据源
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 实现聊天室
    // 链接到群聊天服务器
    
    // 创建一个客户端Socket对象
    GCDAsyncSocket *clientSocket = [[GCDAsyncSocket alloc]initWithDelegate:self delegateQueue:dispatch_get_global_queue(0, 0) ] ;
    
    // 发送链接请求
    NSError *error = nil ;
    [clientSocket connectToHost:@"127.0.0.1" onPort:10123 error:&error] ;
    
    self.clientStock = clientSocket ;
    
}

- (IBAction)sendAction:(id)sender {
    //发送数据
    NSString *str = self.inputText.text ;
    if(str.length == 0) return ;
    
    
    NSString *string = [NSString stringWithFormat:@"Me,%@",str] ;
    [self.dataSource addObject:string] ;
    [self.tableView reloadData] ;
    self.inputText.text = @"" ;
    
    [self.clientStock writeData:[str dataUsingEncoding:NSUTF8StringEncoding] withTimeout:-1 tag:0] ;
}

#pragma mark - 链接状态
- (void)socket:(GCDAsyncSocket *)sock didConnectToHost:(NSString *)host port:(uint16_t)port{
    NSLog(@"与服务器链接成功") ;
    
    // 监听读取数据
    [sock readDataWithTimeout:-1 tag:0] ;
}

- (void)socketDidDisconnect:(GCDAsyncSocket *)sock withError:(NSError *)err{
    NSLog(@"与服务器断开链接%@",err) ;
}

#pragma mark - 读取数据
- (void)socket:(GCDAsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag{
    NSString *str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding] ;
    
    NSLog(@"%@====%@",sock,self.clientStock) ;
    NSLog(@"收到的数据为%@",str) ;
    
    if(str){
        [self.dataSource addObject:str] ;
        NSLog(@"%@",self.dataSource) ;
        NSLog(@"%@",[NSThread currentThread]) ;
        
        // 必须在主线程中刷新UI
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            [self.tableView reloadData] ;
        }] ;
        
    }
    
    // 再次进行监听
    [sock readDataWithTimeout:-1 tag:0] ;
}


#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;{
    return _dataSource.count ;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"] ;
    
    NSArray *strItem = [_dataSource[indexPath.row] componentsSeparatedByString:@","];
    
    cell.textLabel.text = strItem[0] ;
    cell.detailTextLabel.text = strItem[1] ;
    
    return cell ;
}

#pragma mark - Lazy Load
- (NSMutableArray *)dataSource{
    if (_dataSource == nil) {
        _dataSource = [NSMutableArray array] ;
    }
    return _dataSource ;
}

@end
