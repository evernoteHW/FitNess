//
//  FNMacro.h
//  FitNess
//
//  Created by liuguoyan on 14-10-2.
//  Copyright (c) 2014年 liuguoyan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DataServies.h"
#import "NetworkManager.h"
#import "RequestDefine.h"
#import "TKAlertCenter.h"
#import "UIViewExt.h"
#import "UIColor+RGBColor.h"
#import "CommonUtils.h"
#import "UIImageView+WebCache.h"
#import "ModelDef.h"
#import "FNSenceDataManager.h"
#import "FNDataKeeper.h"
#import "CommonSenceDataManager.h"
#import "UIImageView+WebCache.h"
#import "UIButton+WebCache.h"
#import "CellDef.h"

///////////////////////// 颜色 COLOR_
//标题栏背景色
#define COLOR_NAVIGATIONBAR_UICOLOR [UIColor colorWithHexString:@"FF6794"]

//////////////////////// 屏幕尺寸相关 DIME_
//屏幕宽
#define DIME_SCREEN_W  [[UIScreen mainScreen] bounds].size.width
//屏幕高
#define DIME_SCREEN_H  [[UIScreen mainScreen] bounds].size.height
//屏幕CGRect
#define DIME_SCREEN_RECT [[UIScreen mainScreen] bounds]

//////////////////////// 尺寸换算 _px
//尺寸换算
#define _px(x) (x/2.0)

//////////////////////// 字体相关 FONT
#define FONT_SIZE(x)   [UIFont fontWithName:@"Verdana" size:x]


///////////////////////// 系统相关
//判断ios系统版本
#define IOS_VERSION [[[UIDevice currentDevice] systemVersion] floatValue]
//Navigation Bar高度
#define NAVIGATION_HEI 44
//总标题高度
#define TITLE_HEI 64
//状态栏高度
#define STATAS_HEI 20
//TabBar高度
#define TABBAR_HEI 49

///////////////////////// 通用颜色资源 R_COLOR_
//通用灰色文字
#define R_COLOR_NOMARL_GREY [UIColor grayColor]
//界面背景的粉红色
#define R_COLOR_COMMON_BAC [UIColor colorWithHexString:@"FFEAF1"]
//分界线颜色
#define R_COLOR_LINE [UIColor colorWithHexString:@"AAAAAA"]
///////////////////////// 通用尺寸资源 R_DIME_
//标题通用大小
#define R_DIME_NOMARL_TITLE_SIZE 20

//RGB色值
#define RGB(r,g,b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1]

#define UmengAppkey @"5211818556240bc9ee01db2f"








