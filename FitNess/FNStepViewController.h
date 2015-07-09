//
//  YDStepViewController.h
//  FitNess
//
//  Created by liuguoyan on 14-10-2.
//  Copyright (c) 2014年 liuguoyan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FNMacro.h"

@interface FNStepViewController : UIViewController

{
    //内容左边距，为了适配大屏
    //通用左边距
    int _DIME_LEFT;
    //通用内容区宽度
    int _DIME_CONT_SIZE;
    //屏幕横向中心
    int _DIME_CONT_CENTER;
}

@property (nonatomic , strong) CommonSenceDataManager * senceDataManager;
@property (nonatomic, strong) UIButton *leftButton;
@property (nonatomic, strong) UIButton *rightButton;
///////点击键盘外隐藏键盘
- (void)setUpForDismissKeyboard ;

- (void)tapAnywhereToDismissKeyboard:(UIGestureRecognizer *)gestureRecognizer;

//- (id) getSenceDataManager;
- (void)popToViewController;
- (void)showHud;
- (void)hideHud;

@end
