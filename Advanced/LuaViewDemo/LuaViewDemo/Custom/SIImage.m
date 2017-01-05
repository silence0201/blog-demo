//
//  SIImage.m
//  LuaViewDemo
//
//  Created by 杨晴贺 on 05/01/2017.
//  Copyright © 2017 silence. All rights reserved.
//

#import "SIImage.h"
#import <SDWebImage/UIImageView+WebCache.h>

@implementation SIImage

- (void)setWebImageUrl:(NSURL *)url finished:(LVLoadFinished)finished {
    __weak SIImage *weakImageView = self;
    [self sd_setImageWithURL:url placeholderImage:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        double duration = (cacheType == SDImageCacheTypeNone && !error) ? .4f: .0f;
        if (duration > 0) {
            weakImageView.alpha = 1.0f;
            [UIView animateWithDuration:duration animations:^{
                weakImageView.alpha = 1.0f;
            }];
        }else {
            weakImageView.alpha = 1.0f;
        }
        if (finished) {
            finished(error);
        }
    }];
}


@end
