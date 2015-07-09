//
//  CommonEditController.h
//  FitNess
//
//  Created by liuguoyan on 14-10-8.
//  Copyright (c) 2014年 liuguoyan. All rights reserved.
//

#import "FNStepViewController.h"

@protocol CommonEditControllerDelegate <NSObject>

-(void) onCommonEditConfirmWithFlag:(int) flag andContent:(NSString *)content;

@end

@interface CommonEditController : FNStepViewController
{
    UITextField *_inputer;
    UIButton *_confirmbtn;
}

@property (nonatomic,assign) id<CommonEditControllerDelegate> delegate;

//输入框
@property (nonatomic,copy) NSString *placeholder;
//编辑内容
@property (nonatomic,copy) NSString *value;
//flag
@property (nonatomic,assign)int flag;
//键盘类型
@property(nonatomic,assign) UIKeyboardType keyboardType;



@end
