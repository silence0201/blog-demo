//
//  MARouteViewController.h
//  officialDemo2D
//
//  Created by KuangYe on 15/11/20.
//  Copyright © 2015年 AutoNavi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MAMapKit/MAMapKit.h>
#import <AMapSearchKit/AMapSearchKit.h>

@interface RouteViewController : UIViewController

typedef NS_ENUM(NSInteger, RoutePlanningType)
{
    AMapRoutePlanningTypeDrive = 0,
    AMapRoutePlanningTypeWalk,
    AMapRoutePlanningTypeBus
};

- (instancetype)initWtihStartCoor:(CLLocationCoordinate2D)startCoor desPOI:(AMapPOI *)desPOI routeType:(RoutePlanningType)type;


@end
