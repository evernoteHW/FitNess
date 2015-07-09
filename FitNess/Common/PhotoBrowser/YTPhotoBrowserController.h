//
//  MJPhotoBrowser.h
//
//  Created by mj on 13-3-4.
//  Copyright (c) 2014年 yintai. All rights reserved.

#import <UIKit/UIKit.h>

//@protocol MJPhotoBrowserDelegate;
//改变图片偏移量
static NSString *SETUP_CONTENT_OFFSET = @"SETUP_CONTENT_OFFSET";

@interface YTPhotoBrowserController : UIViewController <UIScrollViewDelegate>


@property (nonatomic, strong) NSArray *photos;
// 当前展示的图片索引
@property (nonatomic, assign) NSUInteger currentPhotoIndex;

// 显示
- (void)show;
@end
