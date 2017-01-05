//
//  LVTapGestureRecognizer.m
//  LVSDK
//
//  Created by dongxicheng on 1/21/15.
//  Copyright (c) 2015 dongxicheng. All rights reserved.
//

#import "LVTapGesture.h"
#import "LVGesture.h"
#import "LView.h"
#import "lV.h"
#import "lVauxlib.h"
#import "lVlib.h"
#import "lVstate.h"
#import "lVgc.h"

@implementation LVTapGesture


-(void) dealloc{
    LVLog(@"LVTapGesture.dealloc");
    [LVGesture releaseUD:_lv_userData];
}

-(id) init:(lv_State*) l{
    self = [super initWithTarget:self action:@selector(handleGesture:)];
    if( self ){
        self.lv_lview = (__bridge LView *)(l->lView);
    }
    return self;
}



-(void) handleGesture:(LVTapGesture*)sender {
    lv_State* l = self.lv_lview.l;
    if ( l ){
        lv_checkStack32(l);
        lv_pushUserdata(l, self.lv_userData);
        [LVUtil call:l lightUserData:self key1:"callback" key2:NULL nargs:1];
    }
}

static int lvNewTapGestureRecognizer (lv_State *L) {
    Class c = [LVUtil upvalueClass:L defaultClass:[LVTapGesture class]];
    {
        LVTapGesture* gesture = [[c alloc] init:L];
        
        if( lv_type(L, 1) == LV_TFUNCTION ) {
            [LVUtil registryValue:L key:gesture stack:1];
        }
        
        {
            NEW_USERDATA(userData, Gesture);
            gesture.lv_userData = userData;
            userData->object = CFBridgingRetain(gesture);
            
            lvL_getmetatable(L, META_TABLE_TapGesture );
            lv_setmetatable(L, -2);
        }
    }
    return 1; /* new userdatum is already on the stack */
}

+(int) lvClassDefine:(lv_State *)L globalName:(NSString*) globalName{
    [LVUtil reg:L clas:self cfunc:lvNewTapGestureRecognizer globalName:globalName defaultName:@"TapGesture"];
    
    const struct lvL_reg memberFunctions [] = {
        {NULL, NULL}
    };
    
    lv_createClassMetaTable(L ,META_TABLE_TapGesture);
    
    lvL_openlib(L, NULL, [LVGesture baseMemberFunctions], 0);
    lvL_openlib(L, NULL, memberFunctions, 0);
    return 1;
}


@end
