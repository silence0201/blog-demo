//
//  LVLoadingIndicator.h
//  LVSDK
//
//  Created by dongxicheng on 7/27/15.
//  Copyright (c) 2015 dongxicheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LVHeads.h"

@interface LVLoadingIndicator : UIActivityIndicatorView<LVProtocal, LVClassProtocal>

@property(nonatomic,weak) LView* lv_lview;
@property(nonatomic,assign) LVUserDataInfo* lv_userData;
@property(nonatomic,assign) NSUInteger lv_align;
@property(nonatomic,strong) CAShapeLayer* lv_shapeLayer;

-(id) init:(lv_State*) l;

+(int) lvClassDefine:(lv_State *)L globalName:(NSString*) globalName;


@end
