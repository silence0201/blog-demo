//
//  LVPinchGestureRecognizer.m
//  LVSDK
//
//  Created by 董希成 on 15/3/9.
//  Copyright (c) 2015年 dongxicheng. All rights reserved.
//

#import "LVPinchGesture.h"
#import "LVGesture.h"
#import "LView.h"
#import "lV.h"
#import "lVauxlib.h"
#import "lVlib.h"
#import "lVstate.h"
#import "lVgc.h"

@implementation LVPinchGesture

-(void) dealloc{
    LVLog(@"LVPinchGesture.dealloc");
    [LVGesture releaseUD:_lv_userData];
}

-(id) init:(lv_State*) l{
    self = [super initWithTarget:self action:@selector(handleGesture:)];
    if( self ){
        self.lv_lview = (__bridge LView *)(l->lView);
    }
    return self;
}

-(void) handleGesture:(LVPinchGesture*)sender {
    lv_State* l = self.lv_lview.l;
    if ( l ){
        lv_checkStack32(l);
        lv_pushUserdata(l,self.lv_userData);
        [LVUtil call:l lightUserData:self key1:"callback" key2:NULL nargs:1];
    }
}

static int lvNewPinchGestureRecognizer (lv_State *L) {
    Class c = [LVUtil upvalueClass:L defaultClass:[LVPinchGesture class]];
    {
        LVPinchGesture* gesture = [[c alloc] init:L];
        
        if( lv_type(L, 1) != LV_TFUNCTION ) {
            [LVUtil registryValue:L key:gesture stack:1];
        }
        
        {
            NEW_USERDATA(userData, Gesture);
            gesture.lv_userData = userData;
            userData->object = CFBridgingRetain(gesture);
            
            lvL_getmetatable(L, META_TABLE_PinchGesture );
            lv_setmetatable(L, -2);
        }
    }
    return 1; /* new userdatum is already on the stack */
}

static int scale (lv_State *L) {
    LVUserDataInfo * user = (LVUserDataInfo *)lv_touserdata(L, 1);
    if( LVIsType(user, Gesture) ){
        LVPinchGesture* gesture =  (__bridge LVPinchGesture *)(user->object);
        float s = gesture.scale;
        lv_pushnumber(L, s);
        return 1;
    }
    return 0;
}

+(int) lvClassDefine:(lv_State *)L globalName:(NSString*) globalName{
    [LVUtil reg:L clas:self cfunc:lvNewPinchGestureRecognizer globalName:globalName defaultName:@"PinchGesture"];
    
    lv_createClassMetaTable(L ,META_TABLE_PinchGesture);
    
    lvL_openlib(L, NULL, [LVGesture baseMemberFunctions], 0);
    
    {
        const struct lvL_reg memberFunctions [] = {
            {"scale", scale},
            {NULL, NULL}
        };
        lvL_openlib(L, NULL, memberFunctions, 0);
    }
    return 1;
}

@end
