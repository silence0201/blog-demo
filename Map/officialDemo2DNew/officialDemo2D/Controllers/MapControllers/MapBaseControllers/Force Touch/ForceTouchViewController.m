//
//  3DTouchViewController.m
//  officialDemo2D
//
//  Created by KuangYe on 15/11/18.
//  Copyright © 2015年 AutoNavi. All rights reserved.
//

#import "ForceTouchViewController.h"
#import "POIPreviewViewController.h"
#import "POIAnnotation.h"

@interface ForceTouchViewController ()<PreviewActionDelegate>

@property (nonatomic, strong) CLLocation *userLocation;
@property (nonatomic, assign) BOOL hasSearch;

@property (nonatomic, strong) NSMutableArray *annotationArray;
@property (nonatomic, strong) AMapPOI *selectedPoi;

@end

@implementation ForceTouchViewController

# pragma mark - 3D Touch Delegate

- (UIViewController *)previewingContext:(id<UIViewControllerPreviewing>)previewingContext viewControllerForLocation:(CGPoint)location
{
    __block BOOL touchOnAnnotation = NO;
    __block AMapPOI *poi = nil;
    
    [self.annotationArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[MAPinAnnotationView class]])
        {
            MAPinAnnotationView *view = (MAPinAnnotationView *)obj;
            CGPoint point = [view convertPoint:location fromView:self.mapView];
            
            if (CGRectContainsPoint(view.bounds, point))
            {
                touchOnAnnotation = YES;
                
                if ([view.annotation isKindOfClass:[POIAnnotation class]])
                {
                    POIAnnotation *annotion = (POIAnnotation *)view.annotation;
                    poi = annotion.poi;
                }
                
                *stop = YES;
            }
        }
    }];
    
    if (!touchOnAnnotation)
    {
        return nil;
    }
    
    // check if we're not already displaying a preview controller
    if ([self.presentedViewController isKindOfClass:[POIPreviewViewController class]])
    {
        return nil;
    }
    // shallow press: return the preview controller here (peek)
    self.selectedPoi = poi;
    
    POIPreviewViewController *previewController = [[POIPreviewViewController alloc] initWithUserPoint:self.userLocation.coordinate selectedPOI:self.selectedPoi];
    previewController.delegate = self;
    previewController.preferredContentSize = CGSizeMake(0, 400);
    
    return previewController;
}

- (void)previewingContext:(id<UIViewControllerPreviewing>)previewingContext commitViewController:(UIViewController *)viewControllerToCommit
{
    
    // deep press: bring up the commit view controller (pop)
    UIViewController *commitController = [[POIPreviewViewController alloc] initWithUserPoint:self.userLocation.coordinate selectedPOI:self.selectedPoi];

    [self showViewController:commitController sender:self];
    

    // alternatively, use the view controller that's being provided here (viewControllerToCommit)
}

- (void)presentViewContrller:(UIViewController *)controller
{
    [self showViewController:controller sender:self];
}

#pragma mark - MapView Delegate

- (void)mapView:(MAMapView *)mapView didUpdateUserLocation:(MAUserLocation *)userLocation updatingLocation:(BOOL)updatingLocation
{
    // 位置移动
    if (!updatingLocation)
    {
        // 用户位置移动，更新
        if (userLocation.updating)
        {
            self.userLocation = userLocation.location;
            
            if (!self.hasSearch)
            {
                self.hasSearch = YES;
                [self searchPoiByCenterCoordinate];
                [self check3DTouch];
            }
        }
    }
}

- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id<MAAnnotation>)annotation
{
    if ([annotation isKindOfClass:[POIAnnotation class]])
    {
        static NSString *poiIdentifier = @"poiIdentifier";
        MAPinAnnotationView *poiAnnotationView = (MAPinAnnotationView*)[self.mapView dequeueReusableAnnotationViewWithIdentifier:poiIdentifier];
        if (poiAnnotationView == nil)
        {
            poiAnnotationView = [[MAPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:poiIdentifier];
            [self.annotationArray addObject:poiAnnotationView];
        }
        
        poiAnnotationView.canShowCallout = YES;
        poiAnnotationView.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
        
        return poiAnnotationView;
    }
    
    return nil;
}

#pragma mark - AMapSearchDelegate

/* POI 搜索回调. */
- (void)onPOISearchDone:(AMapPOISearchBaseRequest *)request response:(AMapPOISearchResponse *)response
{
    if (response.pois.count == 0)
    {
        return;
    }
    
    NSMutableArray *poiAnnotations = [NSMutableArray arrayWithCapacity:response.pois.count];
    
    [response.pois enumerateObjectsUsingBlock:^(AMapPOI *obj, NSUInteger idx, BOOL *stop) {
        
        [poiAnnotations addObject:[[POIAnnotation alloc] initWithPOI:obj]];
        
    }];
    
    /* 将结果以annotation的形式加载到地图上. */
    [self.mapView addAnnotations:poiAnnotations];
    
    /* 如果只有一个结果，设置其为中心点. */
    if (poiAnnotations.count == 1)
    {
        [self.mapView setCenterCoordinate:[poiAnnotations[0] coordinate]];
    }
    /* 如果有多个结果, 设置地图使所有的annotation都可见. */
    else
    {
        [self.mapView showAnnotations:poiAnnotations animated:YES];
    }
}

#pragma mark - Private Method

- (void)check3DTouch
{
    // register for 3D Touch (if available)
    if (self.traitCollection.forceTouchCapability == UIForceTouchCapabilityAvailable)
    {
        [self registerForPreviewingWithDelegate:(id)self sourceView:self.view];
        NSLog(@"3D Touch is available! Hurra!");
    }
    else
    {
        NSLog(@"3D Touch is not available on this device. Sniff!");
    }
}

/* 根据中心点坐标来搜周边的POI. */
- (void)searchPoiByCenterCoordinate
{
    AMapPOIAroundSearchRequest *request = [[AMapPOIAroundSearchRequest alloc] init];
    
    request.location            = [AMapGeoPoint locationWithLatitude:self.userLocation.coordinate.latitude longitude:self.userLocation.coordinate.longitude];
    request.keywords            = @"火锅";
    /* 按照距离排序. */
    request.sortrule            = 1;
    request.requireExtension    = YES;
    
    [self.search AMapPOIAroundSearch:request];
}

#pragma mark - Life Cycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.annotationArray = [NSMutableArray array];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)hookAction
{
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 9.0)
    {
        self.mapView.showsUserLocation = YES;
        self.mapView.userTrackingMode = MAUserTrackingModeFollow;
    }
    else
    {
        NSLog(@"your iPhone is not iOS9.0 or later, not support force touch");
    }
}

@end
