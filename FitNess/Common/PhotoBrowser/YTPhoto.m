//
//  MJPhoto.m
//
//  Created by mj on 13-3-4.
//  Copyright (c) 2014年 yintai. All rights reserved.

#import <QuartzCore/QuartzCore.h>
#import "YTPhoto.h"

@implementation YTPhoto

#pragma mark 截图
- (UIImage *)capture:(UIView *)view
{
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, YES, 0.0);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}

- (void)setSrcImageView:(UIImageView *)srcImageView
{
    if (_srcImageView != srcImageView) {
        _srcImageView = srcImageView;
        _placeholder = srcImageView.image;
        if (srcImageView.clipsToBounds) {
//            _capture = [self capture:srcImageView];
        }
    }
}

@end