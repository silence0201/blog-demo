//
//  LVButton.h
//  lv5.1.4
//
//  Created by dongxicheng on 12/17/14.
//  Copyright (c) 2014 dongxicheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LVHeads.h"
#import "LView.h"


@interface LVButton : UIButton<LVProtocal, LVClassProtocal>

@property(nonatomic,weak) LView* lv_lview;
@property(nonatomic,assign) LVUserDataInfo* lv_userData;
@property(nonatomic,assign) NSUInteger lv_align;
@property(nonatomic,strong) CAShapeLayer* lv_shapeLayer;

-(id) init:(lv_State*) l;
-(void) setWebImageUrl:(NSString*)url forState:(UIControlState) state finished:(LVLoadFinished) finished;

+(int) lvClassDefine:(lv_State *)L globalName:(NSString*) globalName;

-(void) lvButtonCallBack;

@end
