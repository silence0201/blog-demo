//
//  LVAnimator.m
//  LuaViewSDK
//
//  Created by lamo on 15/12/28.
//  Copyright © 2015年 dongxicheng. All rights reserved.
//

#import "LVAnimator.h"
#import "lV.h"
#import "lVstate.h"
#import "lVauxlib.h"
#import "LVHeads.h"
#import "LVUtil.h"
#import "LView.h"
#import "LVTransform3D.h"
#import <QuartzCore/CoreAnimation.h>

typedef NS_ENUM(int, LVAnimatorCallback) {
    kLVAnimatorCallbackOnStart = 1,
    kLVAnimatorCallbackOnEnd,
    kLVAnimatorCallbackOnCancel,
    kLVAnimatorCallbackOnPause,
    kLVAnimatorCallbackOnResume,
};

static char *callbackKeys[] = { "", "onStart", "onEnd", "onCancel", "onPause", "onResume" };

@implementation LVAnimator {
    NSString *_animationKey;
    CABasicAnimation *_pausedAnimation;
    NSTimeInterval _timeOffset;
}

@dynamic running, paused;

-(id) lv_nativeObject{
    return self;
}

static int lvNewAnimator(lv_State *L) {
    Class c = [LVUtil upvalueClass:L defaultClass:[LVAnimator class]];
    
    LVAnimator *animator = [c new];

    NEW_USERDATA(userData, Animator);
    userData->object = CFBridgingRetain(animator);
    
    animator.lv_userData = userData;
    animator.lv_lview = (__bridge LView * _Nullable)(L->lView);
    
    lvL_getmetatable(L, META_TABLE_Animator);
    lv_setmetatable(L, -2);
    
    return 1;
}

static int __gc(lv_State *L) {
    LVUserDataInfo *data = (LVUserDataInfo *)lv_touserdata(L, 1);
    if (LVIsType(data, Animator) && data->object) {
        LVAnimator *animator = (__bridge LVAnimator *)data->object;

        CFBridgingRelease((__bridge CFTypeRef)(animator));
        data->object = nil;
        
        animator.lv_userData = NULL;
    }
    
    return 0;
}

static int __tostring(lv_State *L) {
    LVUserDataInfo *data = (LVUserDataInfo *)lv_touserdata(L, 1);
    if (LVIsType(data, Animator)) {
        LVAnimator *animator = (__bridge LVAnimator *)data->object;
        NSString *s = [NSString stringWithFormat:@"Animator<%@>: %@", animator.keyPath, animator.toValue];
        lv_pushstring(L, s.UTF8String);
        
        return 1;
    }
    
    return 0;
}

static int __eq(lv_State *L) {
    LVUserDataInfo *data1 = (LVUserDataInfo *)lv_touserdata(L, 1);
    LVUserDataInfo *data2 = (LVUserDataInfo *)lv_touserdata(L, 2);
    
    if (LVIsType(data1, Animator) && LVIsType(data2, Animator)) {
        LVAnimator *a1 = (__bridge LVAnimator *)data1->object;
        LVAnimator *a2 = (__bridge LVAnimator *)data2->object;
        
        BOOL eq = [a1 isEqual:a2];
        lv_pushboolean(L, eq);
        
        return 1;
    }
    
    return 0;
}

static int clone(lv_State *L) {
    LVUserDataInfo *data = (LVUserDataInfo *)lv_touserdata(L, 1);
    if (LVIsType(data, Animator)) {
        LVAnimator *animator = [(__bridge LVAnimator *)data->object copy];
        
        NEW_USERDATA(userData, Animator);
        userData->object = CFBridgingRetain(animator);
        
        animator.lv_userData = userData;
        animator.lv_lview = (__bridge LView * _Nullable)(L->lView);
        
        lvL_getmetatable(L, META_TABLE_Animator);
        lv_setmetatable(L, -2);
        
        return 1;
    }
    
    return 0;
}

static int with(lv_State *L) {
    LVUserDataInfo *adata = (LVUserDataInfo *)lv_touserdata(L, 1);
    LVUserDataInfo *vdata = (LVUserDataInfo *)lv_touserdata(L, 2);

    if (LVIsType(adata, Animator) && LVIsType(vdata, View)) {
        LVAnimator *animator = (__bridge LVAnimator *)adata->object;
        animator.target = (__bridge UIView *)vdata->object;
    }
    
    lv_pushUserdata(L, adata);
    
    return 1;
}

static int start(lv_State *L) {
    LVUserDataInfo *data = (LVUserDataInfo *)lv_touserdata(L, 1);
    
    if (LVIsType(data, Animator)) {
        LVAnimator *animator = (__bridge LVAnimator *)data->object;
        if (animator.running) {
            LVLog(@"Animation of key:%@ is running!", animator.keyPath);
        } else {
            [animator start];
        }
    }
    
    lv_pushUserdata(L, data);
    
    return 1;
}

static int cancel(lv_State *L) {
    LVUserDataInfo *data = (LVUserDataInfo *)lv_touserdata(L, 1);
    
    if (LVIsType(data, Animator)) {
        LVAnimator *animator = (__bridge LVAnimator *)data->object;
        [animator cancel];
    }
    
    lv_pushUserdata(L, data);
    
    return 1;
}

static int isRunning(lv_State *L) {
    LVUserDataInfo *data = (LVUserDataInfo *)lv_touserdata(L, 1);
    
    if (LVIsType(data, Animator)) {
        LVAnimator *animator = (__bridge LVAnimator *)data->object;
        lv_pushboolean(L, animator.running);
    } else {
        lv_pushboolean(L, 0);
    }
    
    return 1;
}

static int pauseAnimator(lv_State *L) {
    LVUserDataInfo *data = (LVUserDataInfo *)lv_touserdata(L, 1);
    
    if (LVIsType(data, Animator)) {
        LVAnimator *animator = (__bridge LVAnimator *)data->object;
        [animator pause];
    }
    
    lv_pushUserdata(L, data);
    
    return 1;
}

static int resumeAnimator(lv_State *L) {
    LVUserDataInfo *data = (LVUserDataInfo *)lv_touserdata(L, 1);
    
    if (LVIsType(data, Animator)) {
        LVAnimator *animator = (__bridge LVAnimator *)data->object;
        [animator resume];
    }
    
    lv_pushUserdata(L, data);
    
    return 1;
}

static int isPaused(lv_State *L) {
    LVUserDataInfo *data = (LVUserDataInfo *)lv_touserdata(L, 1);
    
    if (LVIsType(data, Animator)) {
        LVAnimator *animator = (__bridge LVAnimator *)data->object;
        lv_pushboolean(L, animator.paused);
    } else {
        lv_pushboolean(L, 0);
    }
    
    return 1;
}

static int duration(lv_State *L) {
    LVUserDataInfo *data = (LVUserDataInfo *)lv_touserdata(L, 1);
    float value = lv_tonumber(L, 2);
    
    if (LVIsType(data, Animator)) {
        LVAnimator *animator = (__bridge LVAnimator *)data->object;
        
        animator.duration = value;
    }
    
    lv_pushUserdata(L, data);
    
    return 1;
}

static int delay(lv_State *L) {
    LVUserDataInfo *data = (LVUserDataInfo *)lv_touserdata(L, 1);
    float value = lv_tonumber(L, 2);
    
    if (LVIsType(data, Animator)) {
        LVAnimator *animator = (__bridge LVAnimator *)data->object;
        
        animator.delay = value;
    }
    
    lv_pushUserdata(L, data);
    
    return 1;
}

static int repeatCount(lv_State *L) {
    LVUserDataInfo *data = (LVUserDataInfo *)lv_touserdata(L, 1);
    int value = (int)lv_tointeger(L, 2);
    
    if (LVIsType(data, Animator)) {
        LVAnimator *animator = (__bridge LVAnimator *)data->object;
        
        animator.repeatCount = value;
    }
    
    lv_pushUserdata(L, data);
    
    return 1;
}

static int autoreverses(lv_State *L) {
    LVUserDataInfo *data = (LVUserDataInfo *)lv_touserdata(L, 1);
    BOOL autoreverses = !!lv_toboolean(L, 2);
    
    if (LVIsType(data, Animator)) {
        LVAnimator *animator = (__bridge LVAnimator *)data->object;
        
        animator.autoreverses = autoreverses;
    }
    
    lv_pushUserdata(L, data);
    
    return 1;
}

static int interpolator(lv_State *L) {
    LVUserDataInfo *data = (LVUserDataInfo *)lv_touserdata(L, 1);
    LVAniamtorInterpolator interpolator = lv_tonumber(L, 2);
    
    if (LVIsType(data, Animator)) {
        LVAnimator *animator = (__bridge LVAnimator *)data->object;
        
        animator.interpolator = interpolator;
    }
    
    lv_pushUserdata(L, data);
    
    return 1;
}

static int setCallback(lv_State *L, int idx) {
    LVUserDataInfo *data = (LVUserDataInfo *)lv_touserdata(L, 1);
    
    if (LVIsType(data, Animator)) {
        lv_pushvalue(L, 1);
        if (lv_type(L, 2) == LV_TFUNCTION) {
            lv_pushvalue(L, 2);
        } else {
            lv_pushnil(L);
        }
        
        lv_udataRef(L, idx);
    }
    
    lv_pushUserdata(L, data);
    
    return 1;
}

static int onStart(lv_State *L) {
    return setCallback(L, kLVAnimatorCallbackOnStart);
}

static int onEnd(lv_State *L) {
    return setCallback(L, kLVAnimatorCallbackOnEnd);
}

static int onCancel(lv_State *L) {
    return setCallback(L, kLVAnimatorCallbackOnCancel);
}

static int onPause(lv_State *L) {
    return setCallback(L, kLVAnimatorCallbackOnPause);
}

static int onResume(lv_State *L) {
    return setCallback(L, kLVAnimatorCallbackOnResume);
}

static int callback(lv_State *L) {
    LVUserDataInfo *data = (LVUserDataInfo *)lv_touserdata(L, 1);
    if (LVIsType(data, Animator) && lv_type(L, 2) == LV_TTABLE) {
        lv_pushvalue(L, 2);
        lv_pushnil(L);
        
        while (lv_next(L, -2)) {
            if (lv_type(L, -2) != LV_TSTRING) {
                continue;
            }
            const char* key = lv_tostring(L, -2);
            int idx = 0;
            for (int i = 0; i < sizeof(callbackKeys) / sizeof(callbackKeys[0]); ++i) {
                if (strcmp(key, callbackKeys[i]) == 0) {
                    idx = i;
                    break;
                }
            }
            
            if (idx != 0) {
                lv_pushvalue(L, 1);
                if (lv_type(L, -2) == LV_TFUNCTION) {
                    lv_pushvalue(L, -2);
                } else {
                    lv_pushnil(L);
                }
                lv_udataRef(L, idx);
                lv_pop(L, 2);
            } else {
                lv_pop(L, 1);
            }
        }
        lv_pop(L, 1);
    }
    
    lv_pushUserdata(L, data);
    
    return 1;
}

static int updateValue(lv_State *L, NSString *keyPath, id value) {
    LVUserDataInfo *data = (LVUserDataInfo *)lv_touserdata(L, 1);
    if (LVIsType(data, Animator)) {
        LVAnimator *animator = (__bridge LVAnimator *)data->object;
        if (keyPath) {
            animator.keyPath = keyPath;
        }
        
        animator.toValue = value;
    }
    
    lv_settop(L, 1);
    
    return 1;
}

static int updateFloat(lv_State *L, NSString *keyPath) {
    float value = lv_tonumber(L, 2);
    
    return updateValue(L, keyPath, @(value));
}

static int updatePoint(lv_State *L, NSString *keyPath) {
    float x = lv_tonumber(L, 2), y = lv_tonumber(L, 3);
    NSValue *point = [NSValue valueWithCGPoint:CGPointMake(x, y)];
    
    return updateValue(L, keyPath, point);
}

static int alpha(lv_State *L) {
    return updateFloat(L, @"opacity");
}

static int rotation(lv_State *L) {
    return updateFloat(L, @"transform.rotation");
}

static int scale(lv_State *L) {
    // default y = x
    if (lv_gettop(L) == 2) {
        lv_pushnumber(L, lv_tonumber(L, 2));
    }
    return updatePoint(L, @"transform.scale");
}

static int scaleX(lv_State *L) {
    return updateFloat(L, @"transform.scale.x");
}

static int scaleY(lv_State *L) {
    return updateFloat(L, @"transform.scale.y");
}

static int translation(lv_State *L) {
    return updatePoint(L, @"transform.translation");
}

static int translationX(lv_State *L) {
    return updateFloat(L, @"transform.translation.x");
}

static int translationY(lv_State *L) {
    return updateFloat(L, @"transform.translation.y");
}

static int value(lv_State *L) {
    return updateFloat(L, nil);
}

+(int) lvClassDefine:(lv_State *)L globalName:(NSString*) globalName{
    [LVUtil reg:L clas:self cfunc:lvNewAnimator globalName:globalName defaultName:@"Animation"];
    
    const struct lvL_reg memberFunctions[] = {
        { "__gc", __gc },
        { "__tostring", __tostring },
        { "__eq", __eq },
        
        { "clone", clone },
        
        { "with", with },
        { "duration", duration },
        { "delay", delay },
        { "repeatCount", repeatCount },
        { "reverses", autoreverses },
        { "interpolator", interpolator },
        
        { "cancel", cancel },
        { "start", start },
        { "isRunning", isRunning },
        
        { "pause", pauseAnimator },
        { "resume", resumeAnimator },
        { "isPaused", isPaused },
        
        { "callback", callback },
        { callbackKeys[kLVAnimatorCallbackOnStart], onStart },
        { callbackKeys[kLVAnimatorCallbackOnEnd], onEnd },
        { callbackKeys[kLVAnimatorCallbackOnCancel], onCancel },
        { callbackKeys[kLVAnimatorCallbackOnPause], onPause },
        { callbackKeys[kLVAnimatorCallbackOnResume], onResume },

        { "alpha", alpha },
        { "rotation", rotation },
        { "scale", scale },
        { "scaleX", scaleX },
        { "scaleY", scaleY },
        { "translation", translation },
        { "translationX", translationX },
        { "translationY", translationY },
        { "value", value },
        
        { NULL, NULL}
    };
    
    lv_createClassMetaTable(L, META_TABLE_Animator);
    lvL_openlib(L, NULL, memberFunctions, 0);
    
    return 1;
}

- (instancetype)init {
    if (self = [super init]) {
        _autoreverses = YES;
    }
    
    return self;
}

- (instancetype)copyWithZone:(NSZone *)zone {
    LVAnimator *animator = [[[self class] allocWithZone:zone] init];
    animator.keyPath = [self.keyPath copy];
    animator.toValue = [self.toValue copy];

    animator.duration = self.duration;
    animator.delay = self.delay;
    animator.repeatCount = self.repeatCount;
    animator.autoreverses = self.autoreverses;

    animator.target = self.target;
    
    return animator;
}

- (instancetype)mutableCopyWithZone:(NSZone *)zone {
    return [self copyWithZone:zone];
}

- (NSUInteger)hash {
    return self.keyPath.hash;
}

- (BOOL)isEqual:(id)object {
    if (object == nil) {
        return NO;
    }
    if (![object isKindOfClass:[self class]]) {
        return NO;
    }
    
    LVAnimator *a1 = (LVAnimator *)object;
    return lv_objcEqual(self.keyPath, a1.keyPath) &&
        lv_objcEqual(self.toValue, a1.toValue) &&
        self.duration == a1.duration &&
        self.delay == a1.delay &&
        self.repeatCount == a1.repeatCount &&
        self.autoreverses == a1.autoreverses;
}

- (CAMediaTimingFunction *)buildTimingFunction:(LVAniamtorInterpolator)interpolator {
    switch (interpolator) {
        case LVAnticipateInterpolator:
            return [CAMediaTimingFunction functionWithControlPoints:0.5 :-0.6 :0.75 :0.5];
        case LVAnticipateOvershootInterpolator:
            return [CAMediaTimingFunction functionWithControlPoints:0.5 :-0.55 :0.5 :1.55];
        case LVOvershootInterpolator:
            return [CAMediaTimingFunction functionWithControlPoints:0.3 :0.9 :0.75 :1.3];
        case LVAccelerateDecelerateInterpolator:
            return [CAMediaTimingFunction functionWithName:@"easeInEaseOut"];
        case LVAccelerateInterpolator:
            return [CAMediaTimingFunction functionWithName:@"easeIn"];
        case LVDecelerateInterpolator:
            return [CAMediaTimingFunction functionWithName:@"easeOut"];
        case LVLinearInterpolator:
        default:
            return [CAMediaTimingFunction functionWithName:@"linear"];
    }
}

- (CAAnimation *)buildAnimation {
    CAAnimation *animation = nil;
    CALayer *layer = self.target.layer.presentationLayer ?: self.target.layer;
    
    if ([self.keyPath isEqualToString:@"transform.scale"]) {
        CGPoint point = [self.toValue CGPointValue];
        
        NSString *kx = @"transform.scale.x";
        CABasicAnimation *ax = [CABasicAnimation animationWithKeyPath:kx];
        ax.fromValue = [layer valueForKeyPath:kx];
        ax.toValue = @(point.x);
        
        NSString *ky = @"transform.scale.y";
        CABasicAnimation *ay = [CABasicAnimation animationWithKeyPath:ky];
        ay.fromValue = [layer valueForKeyPath:ky];
        ay.toValue = @(point.y);
        
        CAAnimationGroup *group = [CAAnimationGroup animation];
        group.animations = @[ax, ay];
        
        animation = group;
    } else if ([self.keyPath isEqualToString:@"transform.rotation"]) {
        CABasicAnimation *a = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
        a.fromValue = [layer valueForKeyPath:@"transform.rotation"];
        a.toValue = @(((NSNumber *)self.toValue).floatValue * M_PI / 180.0);
        
        animation = a;
    } else {
        CABasicAnimation *a = [CABasicAnimation animationWithKeyPath:self.keyPath];
        a.fromValue = [layer valueForKeyPath:self.keyPath];
        a.toValue = self.toValue;
        
        animation = a;
    }
    
    animation.delegate = (id)self;
    animation.duration = self.duration;
    animation.fillMode = @"both";
    
    if (self.repeatCount > 0) {
        animation.repeatCount = self.repeatCount;
        if (animation.autoreverses) {
            animation.repeatCount += 0.5;
        }
        animation.autoreverses = self.autoreverses;
    } else if (self.repeatCount < 0) {
        animation.repeatCount = HUGE_VALF;
        animation.autoreverses = self.autoreverses;
    }
    
    animation.timingFunction = [self buildTimingFunction:self.interpolator];
    animation.beginTime = CACurrentMediaTime() + self.delay;
    
    return animation;
}

static void syncValue(CAAnimation *animation, CALayer *layer) {
    if (!animation || !layer) {
        return;
    }
    
    if ([animation isKindOfClass:[CAAnimationGroup class]]) {
        for (CAAnimation *a in ((CAAnimationGroup *)animation).animations) {
            syncValue(a, layer);
        }
    } else if ([animation isKindOfClass:[CABasicAnimation class]]) {
        CABasicAnimation *a = (CABasicAnimation *)animation;
        [layer setValue:a.toValue forKeyPath:a.keyPath];
    }
}

- (void)syncAnimatingValue:(CALayer *)layer {
    if (!layer.presentationLayer) {
        return;
    }
    
    NSString *keyPath = nil;
    if ([self.keyPath isEqualToString:@"opacity"]) {
        keyPath = @"opacity";
    } else {
        keyPath = @"transform";
    }
    NSValue *current = [layer.presentationLayer valueForKeyPath:keyPath];
    [layer setValue:current forKeyPath:keyPath];
}

- (void)start {
    if (self.running) {
        LVLog(@"Animator(%p keyPath:%@) is running!", self.lv_userData, self.keyPath);
        return;
    }
    if (self.keyPath.length == 0 || self.toValue == nil) {
        LVLog(@"Animator keyPath and value cannot be nil!");
        return;
    }
    
    CAAnimation *animation = nil;
    if (self.target != nil && (animation = [self buildAnimation])) {
        _animationKey = [NSString stringWithFormat:@"LVAnimator:%@", self.keyPath];
        
        CALayer *layer = self.target.layer;
        if ([layer animationForKey:_animationKey]) {
            LVLog(@"warning: Animation of keyPath:%@ is running", self.keyPath);
        }
        
        syncValue(animation, layer);
        [layer addAnimation:animation forKey:_animationKey];
        [self callback:kLVAnimatorCallbackOnStart];
    }
}

- (void)cancel {
    if (!self.running) {
        LVLog(@"warning: Animation of keyPath:%@ is not running", self.keyPath);
        return;
    }
    
    if (self.paused) {
        _animationKey = nil;
        _pausedAnimation = nil;
        _timeOffset = 0.0;
        [self callback:kLVAnimatorCallbackOnCancel];
        
        // call onEnd, same as Android SDK
        [self callback:kLVAnimatorCallbackOnEnd];
    } else {
        CALayer *layer = self.target.layer;
        [self syncAnimatingValue:layer];
        [layer removeAnimationForKey:_animationKey];
    }
}

- (BOOL)isRunning {
    return _animationKey != nil;
}

- (void)pause {
    if (!self.running) {
        LVLog(@"Animator(%p) is not running!", self.lv_userData);
        return;
    }
    if (self.paused) {
        LVLog(@"Animator(%p) is already paused!", self.lv_userData);
        return;
    }
    
    CALayer *layer = self.target.layer;
    [self syncAnimatingValue:layer];
    
    _pausedAnimation = [[layer animationForKey:_animationKey] copy];
    _timeOffset = CACurrentMediaTime() - _pausedAnimation.beginTime;
    
    [layer removeAnimationForKey:_animationKey];
}

- (void)resume {
    CALayer *layer = self.target.layer;
    
    _pausedAnimation.beginTime = CACurrentMediaTime() - _timeOffset;
    
    syncValue(_pausedAnimation, layer);
    [layer addAnimation:_pausedAnimation forKey:_animationKey];
    
    _timeOffset = 0.0;
    _pausedAnimation = nil;
    
    [self callback:kLVAnimatorCallbackOnResume];
}

- (BOOL)isPaused {
    return _pausedAnimation != nil;
}

#pragma mark - animation delegate

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    if (self.paused) {
        [self callback:kLVAnimatorCallbackOnPause];
    } else {
        _animationKey = nil;
        _pausedAnimation = nil;
        _timeOffset = 0.0;
        
        if (!flag) {
            [self callback:kLVAnimatorCallbackOnCancel];
        }
        
        // call onEnd, same as Android SDK
        [self callback:kLVAnimatorCallbackOnEnd];
    }
}

- (void)callback:(LVAnimatorCallback)idx {
    lv_State* l = self.lv_lview.l;
    if (l && self.lv_userData) {
        int stackIndex = lv_gettop(l);

        lv_pushUserdata(l, self.lv_userData);
        lv_pushUDataRef(l, idx);
        lv_runFunction(l);
        
        if (lv_gettop(l) > stackIndex) {
            lv_settop(l, stackIndex);
        }
    }
}

@end
