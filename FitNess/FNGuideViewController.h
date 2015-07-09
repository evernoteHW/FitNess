//
//  FNGuideViewController.h
//  FitNess
//
//  Created by WeiHu on 14/11/18.
//  Copyright (c) 2014年 WeiHu. All rights reserved.
//

#import "FNStepViewController.h"

@interface FNGuideViewController : FNStepViewController<UIScrollViewDelegate>

@property (nonatomic ,strong) UIScrollView *homeScrollView;
@property (nonatomic ,strong) UIPageControl *homePageCtrl;

@end
