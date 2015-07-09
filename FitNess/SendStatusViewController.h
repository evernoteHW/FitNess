//
//  SendStatusViewController.h
//  FitNess
//
//  Created by liuguoyan on 14-10-6.
//  Copyright (c) 2014年 liuguoyan. All rights reserved.
//

#import "FNStepViewController.h"
#import "UIKeyboardCoView.h"
typedef void(^SendMsgSuccessBlock)();

@interface SendStatusViewController : FNStepViewController
{
    UILabel *placeholder;       //placeholder
    UITextView * _statusInputer;
    UIKeyboardCoView * _bottomContainer;
    UIImageView *_checkBox;
    UILabel *_checkBoxLabel;
    UILabel *_inputCounter;
    UIButton *_cameraBtn;
    UIButton *_picBtn;
    UIButton *_msgFrendsBtn;
    UIImageView *selectedPhotiImageView;
    
}
@property (nonatomic, strong) UITextView *statusInputer;
@property (nonatomic, strong) NSArray *altFriArr;

@property (nonatomic, copy) SendMsgSuccessBlock sendMsgSuccessBlock;


@end
