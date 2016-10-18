//
//  POIPreviewViewController.m
//  officialDemo2D
//
//  Created by KuangYe on 15/11/18.
//  Copyright © 2015年 AutoNavi. All rights reserved.
//

#import <AMapSearchKit/AMapSearchKit.h>
#import "POIPreviewViewController.h"
#import "PureLayout.h"
#import "RouteTableViewCell.h"
#import "RouteViewController.h"

@interface POIPreviewViewController () <UITableViewDataSource, UITableViewDelegate, RouteTableViewCellDelegate, MAMapViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSURLConnection *connection;

@property (nonatomic, assign) CLLocationCoordinate2D startCoor;
@property (nonatomic, strong) AMapPOI *selectedPOI;

@property (nonatomic, strong) MAMapView *mapView;
@end

@implementation POIPreviewViewController


#pragma mark - MAMapview Delegate

- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id<MAAnnotation>)annotation
{
    if ([annotation isKindOfClass:[MAPointAnnotation class]])
    {
        static NSString *routePlanningCellIdentifier = @"RoutePlanningCellIdentifier";
        
        MAAnnotationView *poiAnnotationView = (MAAnnotationView*)[self.mapView dequeueReusableAnnotationViewWithIdentifier:routePlanningCellIdentifier];
        if (poiAnnotationView == nil)
        {
            poiAnnotationView = [[MAAnnotationView alloc] initWithAnnotation:annotation
                                                             reuseIdentifier:routePlanningCellIdentifier];
        }
        
        poiAnnotationView.canShowCallout = YES;
        
        /* 起点. */
        if ([[annotation title] isEqualToString:@"起点"])
        {
            poiAnnotationView.image = [UIImage imageNamed:@"startPoint"];
        }
        /* 终点. */
        else if([[annotation title] isEqualToString:@"终点"])
        {
            poiAnnotationView.image = [UIImage imageNamed:@"endPoint"];
        }
        
        return poiAnnotationView;
    }
    
    return nil;
}

#pragma mark - tabelView datasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *id = @"id";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:id];
    if (cell == nil)
    {
        if (indexPath.row == 0)
        {
            RouteTableViewCell *routeCell = ([[RouteTableViewCell alloc] init]);
            routeCell.delegate = self;
            cell = routeCell;
        }
        else
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:id];
        }
    }

    if (indexPath.row == 0)
    {
        
    }
    else if (indexPath.row == 1)
    {
        cell.textLabel.text = @"地址";
        cell.detailTextLabel.text = self.selectedPOI.address;
    }
    else
    {
        cell.textLabel.text = @"类型";
        cell.detailTextLabel.text = self.selectedPOI.type;
    }
        
    return cell;
}

#pragma mark - RouteTableViewCell Delegate

- (void)cellButtonDidTapped:(UIButton *)button
{
    CLLocationCoordinate2D startCoor = self.startCoor;
    
    RouteViewController *controller = nil;
    switch (button.tag)
    {
        case kDriveBtnTag:
           controller = [[RouteViewController alloc] initWtihStartCoor:startCoor desPOI:self.selectedPOI routeType:AMapRoutePlanningTypeDrive];
            break;
        case kBusBtnTag:
            controller = [[RouteViewController alloc] initWtihStartCoor:startCoor desPOI:self.selectedPOI routeType:AMapRoutePlanningTypeBus];
            break;
        case kWalkBtnTag:
            controller = [[RouteViewController alloc] initWtihStartCoor:startCoor desPOI:self.selectedPOI routeType:AMapRoutePlanningTypeWalk];
            break;
        default:
            break;
    }
    
    if (controller)
    {
        [self showViewController:controller sender:self];
    }
}

#pragma mark - Preview Actions

- (NSArray<id<UIPreviewActionItem>> *)previewActionItems
{
    // setup a list of preview actions
    UIPreviewAction *drive = [UIPreviewAction actionWithTitle:@"驾车" style:UIPreviewActionStyleDefault handler:^(UIPreviewAction * _Nonnull action, UIViewController * _Nonnull previewViewController)
    {
        CLLocationCoordinate2D startCoor = self.startCoor;

        RouteViewController *controller = [[RouteViewController alloc] initWtihStartCoor:startCoor desPOI:self.selectedPOI routeType:AMapRoutePlanningTypeDrive];
        
        [self.delegate presentViewContrller:controller];
    }];
    
    UIPreviewAction *bus = [UIPreviewAction actionWithTitle:@"公交" style:UIPreviewActionStyleDefault handler:^(UIPreviewAction * _Nonnull action, UIViewController * _Nonnull previewViewController)
    {
        CLLocationCoordinate2D startCoor = self.startCoor;
        
        RouteViewController *controller = [[RouteViewController alloc] initWtihStartCoor:startCoor desPOI:self.selectedPOI routeType:AMapRoutePlanningTypeBus];
        
        [self.delegate presentViewContrller:controller];
        
    }];
    
    UIPreviewAction *walk = [UIPreviewAction actionWithTitle:@"步行" style:UIPreviewActionStyleDefault handler:^(UIPreviewAction * _Nonnull action, UIViewController * _Nonnull previewViewController)
    {
        CLLocationCoordinate2D startCoor = self.startCoor;
        
        RouteViewController *controller = [[RouteViewController alloc] initWtihStartCoor:startCoor desPOI:self.selectedPOI routeType:AMapRoutePlanningTypeWalk];
        
        [self.delegate presentViewContrller:controller];
    }];
    
    // add them to an arrary
    NSArray *actions = @[drive, bus, walk];
    
    return actions;
}

#pragma mark - Private Method

// 添加起始点、终点标注
- (void)addAnnotations
{
    MAPointAnnotation *startAnnotation = [[MAPointAnnotation alloc] init];
    startAnnotation.coordinate = self.startCoor;
    startAnnotation.title      = @"起点";
    startAnnotation.subtitle   = [NSString stringWithFormat:@"{%f, %f}", self.startCoor.latitude, self.startCoor.longitude];
    
    MAPointAnnotation *destinationAnnotation = [[MAPointAnnotation alloc] init];
    destinationAnnotation.coordinate = CLLocationCoordinate2DMake(self.selectedPOI.location.latitude,self.selectedPOI.location.longitude);
    destinationAnnotation.title      = @"终点";
    destinationAnnotation.subtitle   = [NSString stringWithFormat:@"{%f, %f}", self.selectedPOI.location.latitude, self.selectedPOI.location.longitude];
    
    [self.mapView addAnnotation:startAnnotation];
    [self.mapView addAnnotation:destinationAnnotation];
    
    [self.mapView showAnnotations:@[startAnnotation,destinationAnnotation] animated:YES];
}

#pragma mark - Initialization

- (void)initTableView
{
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tableView.allowsSelection = NO;
    [self.view addSubview:self.tableView];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView autoPinEdgesToSuperviewEdges];
    
    UIView *tableHeader = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height*0.36)];
    self.mapView = [[MAMapView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height*0.36)];
    self.mapView.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.5];
    self.mapView.mapType = MAMapTypeSatellite;
    self.mapView.scrollEnabled = NO;
    self.mapView.zoomEnabled = NO;
    self.mapView.showsCompass = NO;
    self.mapView.showsScale = NO;
    self.mapView.delegate = self;
    [tableHeader addSubview:self.mapView];
    self.tableView.tableHeaderView = tableHeader;
    [self.mapView autoPinEdgesToSuperviewEdges];
    
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.text = self.selectedPOI.name;
    [self.mapView addSubview:titleLabel];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = [UIFont boldSystemFontOfSize:30];
    titleLabel.textColor = [UIColor whiteColor];
    
    [titleLabel autoAlignAxisToSuperviewAxis:ALAxisVertical];
    [titleLabel autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:self.view.bounds.size.height*0.36*0.3];
    [titleLabel autoSetDimensionsToSize:CGSizeMake(self.view.bounds.size.width, 50)];
    
    UILabel *typeLabel = [[UILabel alloc] init];
    typeLabel.text = self.selectedPOI.type;
    typeLabel.textAlignment = NSTextAlignmentCenter;
    typeLabel.font = [UIFont systemFontOfSize:20];
    typeLabel.textColor = [UIColor whiteColor];
    [self.mapView addSubview:typeLabel];
    
    [typeLabel autoAlignAxisToSuperviewAxis:ALAxisVertical];
    [typeLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:titleLabel withOffset:0];
    [typeLabel autoSetDimensionsToSize:CGSizeMake(self.view.bounds.size.width, 35)];

    self.tableView.tableFooterView = [[UIView alloc] init];
}

#pragma mark - Life cycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self initTableView];
    
    [self addAnnotations];
}

- (instancetype)initWithUserPoint:(CLLocationCoordinate2D)userCoor selectedPOI:(AMapPOI *)poi
{
    self = [super init];
    if (self)
    {
        self.selectedPOI = poi;
        self.startCoor = userCoor;
    }
    return self;
}

@end
