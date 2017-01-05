//
//  UIView+LuaView.h
//  LVSDK
//
//  Created by dongxicheng on 7/24/15.
//  Copyright (c) 2015 dongxicheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LVHeads.h"

@interface UIView(UIViewLuaView)<LVProtocal>

@property(nonatomic,weak) LView* lv_lview;
@property(nonatomic,assign) LVUserDataInfo* lv_userData;

@property(nonatomic,assign) NSUInteger lv_align;

- (void) lv_callLuaByKey1:(NSString*) key1;
- (void) lv_callLuaByKey1:(NSString*) key1 key2:(NSString*) key2 argN:(int) argN;
-(NSString*) lv_callLua:(NSString*) functionName args:(NSArray*) args;

- (void) lv_buttonCallBack;


- (void) lv_alignSubviews;

- (void) lv_alignSelfWithSuperRect:(CGRect) rect;

@property(nonatomic,assign) BOOL lv_isCallbackAddClickGesture;// 设置Callback时需要注册手势回调,才设置成true

-(void) lv_callbackAddClickGesture;// 回调添加

-(id) lv_getNativeView;

// shapelayer
@property(nonatomic,strong) CAShapeLayer* lv_shapeLayer;
-(CALayer*) lv_layer;
-(void) lv_createShapelayer:(NSArray<NSNumber*>*) arr;

-(void) lv_effectParallax:(CGFloat)dx dy:(CGFloat)dy;
-(void) lv_effectClick:(NSInteger)color alpha:(CGFloat)alpha;

@property(nonatomic,assign) BOOL lv_canvas;

@end
