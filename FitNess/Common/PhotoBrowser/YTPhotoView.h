//
//  MJZoomingScrollView.h
//
//  Created by mj on 13-3-4.
//  Copyright (c) 2014年 yintai. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YTPhotoBrowserController, YTPhoto, YTPhotoView;

@protocol YTPhotoViewDelegate <NSObject>
//- (void)photoViewImageFinishLoad:(YTPhotoView *)photoView;
- (void)photoViewSingleTap:(YTPhotoView *)photoView;
- (void)photoViewDidEndZoom:(YTPhotoView *)photoView;
@end

@interface YTPhotoView : UIScrollView <UIScrollViewDelegate>
// 图片
@property (nonatomic, strong) YTPhoto *photo;
// 代理
@property (nonatomic, weak) id<YTPhotoViewDelegate> photoViewDelegate;
@end