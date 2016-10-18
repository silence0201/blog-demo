//
//  ViewController.m
//  baiduMapDemo
//
//  Created by 杨晴贺 on 27/09/2016.
//  Copyright © 2016 silence. All rights reserved.
//

#import "ViewController.h"
#import <BaiduMapAPI_Base/BMKBaseComponent.h>//引入base相关所有的头文件
#import <BaiduMapAPI_Map/BMKMapComponent.h>//引入地图功能所有的头文件
#import <BaiduMapAPI_Search/BMKSearchComponent.h>//引入检索功能所有的头文件
#import <BaiduMapAPI_Location/BMKLocationComponent.h>//引入定位功能所有的头文件

@interface ViewController ()<BMKMapViewDelegate,BMKPoiSearchDelegate,BMKBusLineSearchDelegate,BMKGeoCodeSearchDelegate,BMKShareURLSearchDelegate,BMKLocationServiceDelegate>

@property (nonatomic,strong) BMKMapView *mapView ;
@property (nonatomic,strong) BMKPoiSearch *search ;
@property (nonatomic,strong) BMKBusLineSearch *busSearch ;
@property (nonatomic,strong) BMKGeoCodeSearch *genSearch ;
@property (nonatomic,strong) BMKShareURLSearch *shareurlsearch ;
@property (nonatomic,strong) BMKLocationService *locService ;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.mapView.frame = [UIScreen mainScreen].bounds ;
    
    //启动LocationService
    [_locService startUserLocationService];
    
    [self addAnnotation] ;
    
    [self addOverlay] ;
    
    [self poiSearch] ;
    
    [self busLineSearch] ;
    
    [self geo] ;
    
    [self urlSearch] ;
    
    [self.view addSubview:_mapView] ;
   
}

- (void)viewWillAppear:(BOOL)animated
{
    [_mapView viewWillAppear];
    _mapView.delegate = self; // 此处记得不用的时候需要置nil，否则影响内存的释放
}
- (void)viewWillDisappear:(BOOL)animated
{
    [_mapView viewWillDisappear];
    _mapView.delegate = nil; // 不用时，置nil
}

#pragma mark - Lazy Load
- (BMKMapView *)mapView{
    if(_mapView == nil){
        _mapView = [[BMKMapView alloc]init] ;
        _mapView.mapType = BMKMapTypeStandard ;
        
        // 设置logo的位置
        [_mapView setLogoPosition:BMKLogoPositionRightBottom] ;
        
        // 设置显示路况信息
        // [_mapView setTrafficEnabled:YES];
        
        // 设置热力图
        // [_mapView setBaiduHeatMapEnabled:YES];
        
        // 设置地图显示的比例尺等级
        [_mapView setZoomLevel:15.0 ];
        
        //设置隐藏地图标注
        // [_mapView setShowMapPoi:NO];
        
        //普通态
        //以下_mapView为BMKMapView对象
        _mapView.showsUserLocation = YES;//显示定位图层
                
    }
    return _mapView ;
}

- (BMKLocationService *)locService{
    if (_locService == nil) {
        //初始化BMKLocationService
        _locService = [[BMKLocationService alloc]init];
        _locService.delegate = self;
    }
    return _locService ;
}

#pragma mark - Test Method
- (void)addAnnotation{
    BMKPointAnnotation *annotation = [[BMKPointAnnotation alloc]init] ;
    CLLocationCoordinate2D coor ;
    coor.latitude = 39.915 ;
    coor.longitude = 116.404 ;
    annotation.coordinate = coor ;
    annotation.title = @"这里是北京" ;
    annotation.subtitle = @"欢迎来北京" ;
    [_mapView addAnnotation:annotation] ;
}

- (void)removeAnnotation{
    [_mapView removeAnnotations:_mapView.annotations] ;
}

- (void)addOverlay{
    // 添加多边形覆盖物
    CLLocationCoordinate2D coords[3] = {0};
    coords[0].latitude = 39;
    coords[0].longitude = 116;
    coords[1].latitude = 38;
    coords[1].longitude = 115;
    coords[2].latitude = 38;
    coords[2].longitude = 117;
    BMKPolygon* polygon = [BMKPolygon polygonWithCoordinates:coords count:3];
    
    [_mapView addOverlay:polygon];
}

- (void)poiSearch{
    // 初始化检索对象
    _search = [[BMKPoiSearch alloc]init] ;
    _search.delegate = self ;
    // 发起检索
    BMKNearbySearchOption *option = [[BMKNearbySearchOption alloc]init];
    option.pageIndex = 1 ;
    option.pageCapacity = 10;
    option.location = CLLocationCoordinate2DMake(39.915, 116.404);
    option.keyword = @"设施";
    option.radius = 1000 ;
    
    BOOL flag = [_search poiSearchNearBy:option] ;
    if (flag) {
        NSLog(@"周边检索发送成功") ;
    }else{
        NSLog(@"周边检索失败") ;
    }
}

// 公交详情信息检索
- (void)busLineSearch{
    self.busSearch = [[BMKBusLineSearch alloc]init] ;
    self.busSearch.delegate = self ;
    
    // 发起索引
    BMKBusLineSearchOption *buslineSearchOption = [[BMKBusLineSearchOption alloc]init];
    buslineSearchOption.city= @"杭州";
    buslineSearchOption.busLineUid= @"315";
    BOOL flag = [self.busSearch busLineSearch:buslineSearchOption];
    if(flag){
        NSLog(@"busline检索发送成功");
    }
    else{
        NSLog(@"busline检索发送失败");
    }
}

// 地址编码
- (void)geo{
    //初始化检索对象
    self.genSearch=[[BMKGeoCodeSearch alloc]init];
    self.genSearch.delegate = self;
    BMKGeoCodeSearchOption *geoCodeSearchOption = [[BMKGeoCodeSearchOption alloc]init];
    geoCodeSearchOption.city= @"北京市";
    geoCodeSearchOption.address = @"海淀区上地10街10号";
    BOOL flag = [self.genSearch geoCode:geoCodeSearchOption];
    if(flag){
        NSLog(@"geo检索发送成功");
    }else{
        NSLog(@"geo检索发送失败");
    }
    
    //发起反向地理编码检索
    CLLocationCoordinate2D pt = (CLLocationCoordinate2D){39.915, 116.404};
    BMKReverseGeoCodeOption *reverseGeoCodeSearchOption = [[
    BMKReverseGeoCodeOption alloc]init];
    reverseGeoCodeSearchOption.reverseGeoPoint = pt;
    flag = [_genSearch reverseGeoCode:reverseGeoCodeSearchOption];
    if(flag){
      NSLog(@"反geo检索发送成功");
    }else{
      NSLog(@"反geo检索发送失败");
    }
}

//
- (void)urlSearch{
    //初始化检索服务
    _shareurlsearch = [[BMKShareURLSearch alloc]init];
    //设置delegate
    _shareurlsearch.delegate = self;
    
    //构建路线规划短串分享检索信息类
    BMKRoutePlanShareURLOption *option = [[BMKRoutePlanShareURLOption alloc] init];
    
    //起点
    BMKPlanNode *fromNode = [[BMKPlanNode alloc] init];
    fromNode.name = @"百度大厦";
    fromNode.cityID = 131;
    option.from = fromNode;
    
    //终点
    BMKPlanNode *toNode = [[BMKPlanNode alloc] init];
    toNode.name = @"天安门";
    toNode.cityID = 131;
    option.to = toNode;
    
    //    option.routePlanType = BMK_ROUTE_PLAN_SHARE_URL_TYPE_DRIVE;//驾车
    //    option.routePlanType = BMK_ROUTE_PLAN_SHARE_URL_TYPE_WALK;//步行
    //    option.routePlanType = BMK_ROUTE_PLAN_SHARE_URL_TYPE_RIDE;//骑行
    option.routePlanType = BMK_ROUTE_PLAN_SHARE_URL_TYPE_TRANSIT;//公交
    option.cityID = 131;//当进行公交路线规划短串分享且起终点通过关键字指定时，必须指定
    option.routeIndex = 0;//公交路线规划短串分享时使用，分享的是第几条线路
    
    //发起检索
    BOOL flag = [_shareurlsearch requestRoutePlanShareURL:option];
    if (flag) {
        NSLog(@"routePlanShortUrlShare检索发送成功");
    } else {
        NSLog(@"routePlanShortUrlShare检索发送失败");
    }
}

#pragma mark - Delegate
// 自定义大头针
- (BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id<BMKAnnotation>)annotation{
    if ([annotation isKindOfClass:[BMKPointAnnotation class]]) {
        BMKPinAnnotationView *newAnnotationView = [[BMKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"myAnnotation"];
        newAnnotationView.pinColor = BMKPinAnnotationColorGreen;
        newAnnotationView.animatesDrop = YES;// 设置该标注点动画显示
        return newAnnotationView;
    }
    return nil ;
}

// 自定义遮罩
- (BMKOverlayView *)mapView:(BMKMapView *)mapView viewForOverlay:(id <BMKOverlay>)overlay{
    if ([overlay isKindOfClass:[BMKPolygon class]]){
        BMKPolygonView* polygonView = [[BMKPolygonView alloc] initWithOverlay:overlay];
        polygonView.strokeColor = [[UIColor purpleColor] colorWithAlphaComponent:1];
        polygonView.fillColor = [[UIColor cyanColor] colorWithAlphaComponent:0.2];
        polygonView.lineWidth = 5.0;
        
        return polygonView;
    }
    return nil;
}

// 实现PoiSearchDeleage处理回调结果
- (void)onGetPoiResult:(BMKPoiSearch*)searcher result:(BMKPoiResult*)poiResultList errorCode:(BMKSearchErrorCode)error{
    if (error == BMK_SEARCH_NO_ERROR) {
        NSLog(@"检索成功") ;
        [_mapView removeAnnotations:_mapView.annotations] ;
        //在此处理正常结果
        NSLog(@"%@",poiResultList) ;
        // 遍历所有的结果(都是BMKPoiInfo对象)
        for (BMKPoiInfo *poiInfo in poiResultList.poiInfoList) {
            
            // 将BMKPoiInfo对象的属性转化成大头针对应的属性
            BMKPointAnnotation *anno = [[BMKPointAnnotation alloc] init];
            anno.coordinate = poiInfo.pt;
            anno.title = poiInfo.name;
            anno.subtitle = poiInfo.address;
            
            // 将大头针添加到地图上
            [self.mapView addAnnotation:anno];
        }
    }
    else if (error == BMK_SEARCH_AMBIGUOUS_KEYWORD){
        //当在设置城市未找到结果，但在其他城市找到结果时，回调建议检索城市列表
        // result.cityList;
        NSLog(@"起始点有歧义");
    } else {
        NSLog(@"抱歉，未找到结果");
    }
}

// 实现PoiSearchDeleage处理回调结果
- (void)onGetBusDetailResult:(BMKBusLineSearch*)searcher result:(BMKBusLineResult*)busLineResult errorCode:(BMKSearchErrorCode)error
{
    if (error == BMK_SEARCH_NO_ERROR) {
        //在此处理正常结果
        NSLog(@"%@",busLineResult) ;
    }
    else {
        NSLog(@"抱歉，未找到结果");
    }
}

// 地址编码
- (void)onGetGeoCodeResult:(BMKGeoCodeSearch *)searcher result:(BMKGeoCodeResult *)result errorCode:(BMKSearchErrorCode)error{
    if (error == BMK_SEARCH_NO_ERROR) {
        //在此处理正常结果
        NSLog(@"%@",result) ;
    }
    else {
        NSLog(@"抱歉，未找到结果");
    }
}

//接收反向地理编码结果
-(void) onGetReverseGeoCodeResult:(BMKGeoCodeSearch *)searcher result:(BMKReverseGeoCodeResult *)result errorCode:(BMKSearchErrorCode)error{
  if (error == BMK_SEARCH_NO_ERROR) {
      // 处理正常结果
      NSLog(@"%@",result.address) ;
  }
  else {
      NSLog(@"抱歉，未找到结果");
  }
}

// ShareURLResult:
- (void)onGetRoutePlanShareURLResult:(BMKShareURLSearch *)searcher result:(BMKShareURLResult *)result errorCode:(BMKSearchErrorCode)error {
    NSLog(@"onGetRoutePlanShareURLResult error:%d", (int)error);
    if (error == BMK_SEARCH_NO_ERROR) {
        //share shore url is result.url
        //share code
        NSLog(@"%@",result.url) ;
    }
}

//实现相关delegate 处理位置信息更新
//处理方向变更信息
- (void)didUpdateUserHeading:(BMKUserLocation *)userLocation{
    NSLog(@"heading is %@",userLocation.heading);
}
//处理位置坐标更新
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation{
    NSLog(@"didUpdateUserLocation lat %f,long %f",userLocation.location.coordinate.latitude,userLocation.location.coordinate.longitude);
    [_mapView updateLocationData:userLocation];
}

@end
