//
//  LvTimer.h
//  lv5.1.4
//
//  Created by dongxicheng on 12/18/14.
//  Copyright (c) 2014 dongxicheng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LVHeads.h"


@interface LVTimer : NSObject<LVProtocal, LVClassProtocal>

@property(nonatomic,weak) LView* lv_lview;
@property(nonatomic,assign) LVUserDataInfo* lv_userData;

-(id) init:(lv_State*) l;

-(void) startTimer;
-(void) cancel;


+(int) lvClassDefine:(lv_State *)L globalName:(NSString*) globalName;


@end
