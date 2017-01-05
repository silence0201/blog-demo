//
//  LVAudioPlayer.m
//  LVSDK
//
//  Created by dongxicheng on 4/14/15.
//  Copyright (c) 2015 dongxicheng. All rights reserved.
//

#import "LVAudioPlayer.h"
#import <AVFoundation/AVFoundation.h>
#import "LView.h"
#import "lV.h"
#import "lVauxlib.h"
#import "lVlib.h"
#import "lVstate.h"
#import "lVgc.h"

@interface LVAudioPlayer ()
@property(nonatomic,assign) BOOL playing;
@end

@implementation LVAudioPlayer{
    AVAudioPlayer* audioPlayer;
}

static void releaseUserDataAudioPlayer(LVUserDataInfo* user){
    if( user && user->object ){
        LVAudioPlayer* palyer = CFBridgingRelease(user->object);
        user->object = NULL;
        if( palyer ){
            [palyer stop];
            palyer.lv_userData = NULL;
            palyer.lv_lview = nil;
        }
    }
}

-(void) dealloc{
    releaseUserDataAudioPlayer(_lv_userData);
}

-(id) init:(lv_State*) l{
    self = [super init];
    if( self ){
        self.lv_lview = (__bridge LView *)(l->lView);
    }
    return self;
}

-(void) setPlayFileName0:(NSString*) fileName bundle:(LVBundle*) bundle{
    NSString* path = [bundle resourcePathWithName:fileName];
    if( path ) {
        NSURL* url = [[NSURL alloc] initWithString:path];
        NSError* error = nil;
        audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:&error];//使用本地URL创建
        if( error ) {
            NSLog(@"[LuaView][error]%@",error);
        }
    }
    if( self.playing ) {
        [self play];
    }
}

-(void) setPlayFileName:(NSString*) fileName bundle:(LVBundle*) bundle{
    if( fileName ==nil )
        return;
    if( [LVUtil isExternalUrl:fileName] ){
        [LVUtil download:fileName callback:^(NSData *fileData) {
            NSString* suffix = [fileName componentsSeparatedByString:@"."].lastObject;
            NSData* theFileNameData = [fileName dataUsingEncoding:NSUTF8StringEncoding];
            NSString* md5Path = [LVUtil MD5HashFromData:theFileNameData];
            md5Path = [NSString stringWithFormat:@"%@.%@",md5Path,suffix];//Mp3文件一定要加后缀，否则无法播放
            if( [LVUtil saveData:fileData toFile:[LVUtil PathForCachesResource:md5Path]] ) {
                [self setPlayFileName0:md5Path bundle:bundle];
            }
        }];
    } else {
        [self setPlayFileName0:fileName bundle:bundle];
    }
}

-(void) play {
    [audioPlayer play];
    self.playing = YES;
}

-(void) stop {
    [audioPlayer stop];
    self.playing = NO;
}

- (id) lv_nativeObject{
    return audioPlayer;
}


#pragma -mark AudioPlayer

static int lvNewAudioPlayer (lv_State *L) {
    if( lv_gettop(L)>=1 ) {
        Class c = [LVUtil upvalueClass:L defaultClass:[LVAudioPlayer class]];
        
        LVAudioPlayer* player = [[c alloc] init:L];
        LView* lview = (__bridge LView *)(L->lView);
        NSString* fileName = lv_paramString(L, 1);
        [player setPlayFileName:fileName bundle:lview.bundle];
        
        {
            NEW_USERDATA(userData, AudioPlayer);
            userData->object = CFBridgingRetain(player);
            player.lv_userData = userData;
            
            lvL_getmetatable(L, META_TABLE_AudioPlayer );
            lv_setmetatable(L, -2);
        }
        return 1;
    }
    return 0;
}

static int play (lv_State *L) {
    LVUserDataInfo * user = (LVUserDataInfo *)lv_touserdata(L, 1);
    
    if( user && LVIsType(user, AudioPlayer) ){
        LVAudioPlayer* player = (__bridge LVAudioPlayer *)(user->object);
        if( player ){
            [player play];
            lv_pushvalue(L,1);
            return 1;
        }
    }
    return 0;
}

static int stop (lv_State *L) {
    LVUserDataInfo * user = (LVUserDataInfo *)lv_touserdata(L, 1);
    if( user ){
        LVAudioPlayer* player = (__bridge LVAudioPlayer *)(user->object);
        if( player ){
            [player stop];
        }
    }
    return 0;
}

static int __gc (lv_State *L) {
    LVUserDataInfo * user = (LVUserDataInfo *)lv_touserdata(L, 1);
    releaseUserDataAudioPlayer(user);
    return 0;
}

static int __tostring (lv_State *L) {
    LVUserDataInfo * user = (LVUserDataInfo *)lv_touserdata(L, 1);
    if( user ){
        LVAudioPlayer* player =  (__bridge LVAudioPlayer *)(user->object);
        NSString* s = [NSString stringWithFormat:@"LVUserDataAudioPlayer: %@", player ];
        lv_pushstring(L, s.UTF8String);
        return 1;
    }
    return 0;
}

+(int) lvClassDefine:(lv_State *)L globalName:(NSString*) globalName{
    [LVUtil reg:L clas:self cfunc:lvNewAudioPlayer globalName:globalName defaultName:@"AudioPlayer"];
    
    const struct lvL_reg memberFunctions [] = {
        {"play", play },
        {"stop", stop },
        
        {"__gc", __gc },
        {"__tostring", __tostring },
        {NULL, NULL}
    };
    lv_createClassMetaTable(L, META_TABLE_AudioPlayer);
    
    lvL_openlib(L, NULL, memberFunctions, 0);
    return 1;
}

@end



