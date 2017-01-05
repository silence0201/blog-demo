//
//  LVSwipeGestureRecognizer.m
//  LVSDK
//
//  Created by 城西 on 15/3/9.
//  Copyright (c) 2015年 dongxicheng. All rights reserved.
//

#import "LVSwipeGesture.h"
#import "LVGesture.h"
#import "LView.h"
#import "lV.h"
#import "lVauxlib.h"
#import "lVlib.h"
#import "lVstate.h"
#import "lVgc.h"

@implementation LVSwipeGesture


-(void) dealloc{
    LVLog(@"LVSwipeGesture.dealloc");
    [LVGesture releaseUD:_lv_userData];
}

-(id) init:(lv_State*) l{
    self = [super initWithTarget:self action:@selector(handleGesture:)];
    if( self ){
        self.lv_lview = (__bridge LView *)(l->lView);
    }
    return self;
}

-(void) handleGesture:(LVSwipeGesture*)sender {
    lv_State* l = self.lv_lview.l;
    if ( l ){
        lv_checkStack32(l);
        lv_pushUserdata(l,self.lv_userData);
        [LVUtil call:l lightUserData:self key1:"callback" key2:NULL nargs:1];
    }
}

static int lvSwipeGestureRecognizer (lv_State *L) {
    Class c = [LVUtil upvalueClass:L defaultClass:[LVSwipeGesture class]];
    {
        LVSwipeGesture* gesture = [[c alloc] init:L];
        
        if( lv_type(L, 1) == LV_TFUNCTION ) {
            [LVUtil registryValue:L key:gesture stack:1];
        }
        
        {
            NEW_USERDATA(userData, Gesture);
            gesture.lv_userData = userData;
            userData->object = CFBridgingRetain(gesture);
            
            lvL_getmetatable(L, META_TABLE_SwipeGesture );
            lv_setmetatable(L, -2);
        }
    }
    return 1; /* new userdatum is already on the stack */
}

static int touchCount (lv_State *L) {
    LVUserDataInfo * user = (LVUserDataInfo *)lv_touserdata(L, 1);
    if( LVIsType(user, Gesture) ){
        LVSwipeGesture* gesture =  (__bridge LVSwipeGesture *)(user->object);
        if( lv_gettop(L)>=2 ) {
            float num = lv_tonumber(L, 2);
            gesture.numberOfTouchesRequired = num;
            return 0;
        } else {
            float num = gesture.numberOfTouchesRequired;
            lv_pushnumber(L, num);
            return 1;
        }
    }
    return 0;
}

static int direction (lv_State *L) {
    LVUserDataInfo * user = (LVUserDataInfo *)lv_touserdata(L, 1);
    if( LVIsType(user, Gesture) ){
        LVSwipeGesture* gesture =  (__bridge LVSwipeGesture *)(user->object);
        if ( lv_gettop(L)>=2 ) {
            float num = lv_tonumber(L, 2);
            gesture.direction = num;
            return 0;
        } else {
            float direction = gesture.direction;
            lv_pushnumber(L, direction);
            return 1;
        }
    }
    return 0;
}

+(int) lvClassDefine:(lv_State *)L globalName:(NSString*) globalName{
    {
        lv_settop(L, 0);
        NSDictionary* v = nil;
        v = @{
              @"LEFT":@(UISwipeGestureRecognizerDirectionLeft),
              @"RIGHT":@(UISwipeGestureRecognizerDirectionRight),
              @"UP":@(UISwipeGestureRecognizerDirectionUp),
              @"DOWN":@(UISwipeGestureRecognizerDirectionDown),
              };
        [LVUtil defineGlobal:@"GestureDirection" value:v L:L];
    }
    
    [LVUtil reg:L clas:self cfunc:lvSwipeGestureRecognizer globalName:globalName defaultName:@"SwipeGesture"];
    
    lv_createClassMetaTable(L ,META_TABLE_SwipeGesture);
    lvL_openlib(L, NULL, [LVGesture baseMemberFunctions], 0);
    {
        const struct lvL_reg memberFunctions [] = {
            {"touchCount", touchCount},
            {"direction", direction},
            {NULL, NULL}
        };
        lvL_openlib(L, NULL, memberFunctions, 0);
    }
    return 1;
}



@end
