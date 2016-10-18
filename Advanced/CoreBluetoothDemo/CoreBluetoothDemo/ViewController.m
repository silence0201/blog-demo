//
//  ViewController.m
//  CoreBluetoothDemo
//
//  Created by 杨晴贺 on 7/31/16.
//  Copyright © 2016 silence. All rights reserved.
//

#import "ViewController.h"
#import <CoreBluetooth/CoreBluetooth.h>

@interface ViewController ()<CBCentralManagerDelegate,CBPeripheralDelegate>

// 中央管理者
@property (nonatomic,strong) CBCentralManager *mgr ;

// 外围设备
@property (nonatomic,strong) NSMutableArray *peripherals ;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    // 扫描所有的外围设备
    // serviceUUIDs:可以将你想要扫描的服务的外围设备传入(传nil,扫描所有的外围设备)
    [self.mgr scanForPeripheralsWithServices:nil options:nil] ;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 懒加载
- (CBCentralManager *)mgr{
    if (_mgr == nil) {
        _mgr = [[CBCentralManager alloc]initWithDelegate:self queue:nil] ;
    }
    return _mgr ;
}

- (NSMutableArray *)peripherals{
    if (_peripherals == nil) {
        _peripherals = [NSMutableArray array] ;
    }
    return _peripherals ;
}

#pragma mark - CBCentralManagerDelegate的代理方法
/**
 *  状态发生改变的时候会调用该方法  未开启 -- > 开启
 */
- (void)centralManagerDidUpdateState:(CBCentralManager *)central{
}

/**
 *  当发现外围设备的时候会调用该方法
 *
 *  @param peripheral        返现的外围设备
 *  @param advertisementData 外围设备发出的信号
 *  @param RSSI              信号强度
 */
- (void)centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary<NSString *,id> *)advertisementData RSSI:(NSNumber *)RSSI{
    if (![self.peripherals containsObject:peripheral]) {
        [self.peripherals addObject:peripheral] ;
    }
}

/**
 *  连接上外围设备的时候调用这个方法
 *
 *  @param peripheral 外围设备
 */
- (void)centralManager:(CBCentralManager *)central didConnectPeripheral:(CBPeripheral *)peripheral{
    // 扫描所有的服务
    [peripheral discoverServices:nil];  // 可以限制扫描什么服务,nil代表所有的服务
    
    // 设置外围设备的代理
    peripheral.delegate = self ;
}

#pragma mark - CBPeripheralDelegate的代理方法
/**
 *  发现外围设备会调用这个方法
 *
 *  @param peripheral 外围设备
 */
- (void)peripheral:(CBPeripheral *)peripheral didDiscoverServices:(NSError *)error{
    // 添加到service对象数组中
    for(CBService *servie in peripheral.services){
        if ([servie.UUID.UUIDString isEqualToString:@"123"]) {
            // 查找特征.可以指定要扫描的特征码
            [peripheral discoverCharacteristics:nil forService:servie] ;
        }
    }
}

/**
 *  当扫描到某个特征时进行执行
 *
 */
- (void)peripheral:(CBPeripheral *)peripheral didDiscoverCharacteristicsForService:(CBService *)service error:(NSError *)error{
    for(CBCharacteristic *chara in service.characteristics){
        if ([chara.UUID.UUIDString isEqualToString:@"456"]) {
            // 拿到特征,和外围设备进行交互
            
        }
    }
}

#pragma mark - 连接外围设备
- (void)connect:(CBPeripheral *)peripheral{
    [self.mgr connectPeripheral:peripheral options:nil] ;
}
@end
