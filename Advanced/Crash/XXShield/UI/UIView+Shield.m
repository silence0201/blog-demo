//
//  UIView+Shield.m
//  Crash
//
//  Created by Silence on 2018/3/8.
//  Copyright © 2018年 Silence. All rights reserved.
//

#import <objc/runtime.h>
#import <UIKit/UIKit.h>
#import "XXRecord.h"
#import "XXShieldSwizzling.h"

XXStaticHookClass(UIView, ProtectUI, void, @selector(setNeedsDisplay)) {
    if (strcmp(dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL), dispatch_queue_get_label(dispatch_get_main_queue())) == 0) {
        XXHookOrgin();
    } else {
        dispatch_async(dispatch_get_main_queue(), ^{
            XXHookOrgin();
        });
    }
}
XXStaticHookEnd

XXStaticHookClass(UIView, ProtectUI, void, @selector(layoutSubviews)) {
    if (strcmp(dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL), dispatch_queue_get_label(dispatch_get_main_queue())) == 0) {
        XXHookOrgin();
    } else {
        dispatch_async(dispatch_get_main_queue(), ^{
            XXHookOrgin();
        });
    }
}
XXStaticHookEnd

XXStaticHookClass(UIView, ProtectUI, void, @selector(setNeedsUpdateConstraints)) {
    if (strcmp(dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL), dispatch_queue_get_label(dispatch_get_main_queue())) == 0) {
        XXHookOrgin();
    } else {
        dispatch_async(dispatch_get_main_queue(), ^{
            XXHookOrgin();
        });
    }
}
XXStaticHookEnd
