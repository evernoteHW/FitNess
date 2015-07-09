//
//  CommonEditController.m
//  FitNess
//
//  Created by liuguoyan on 14-10-8.
//  Copyright (c) 2014年 liuguoyan. All rights reserved.
//

#import "CommonEditController.h"

@interface CommonEditController ()
{
    UITapGestureRecognizer *singleTapGR;
}
@end

@implementation CommonEditController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        //增加监听，当键盘出现或改变时收出消息
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(keyboardWillShow:)
                                                     name:UIKeyboardWillShowNotification
                                                   object:nil];
        
        //增加监听，当键退出时收出消息
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(keyboardWillHide:)
                                                     name:UIKeyboardWillHideNotification
                                                   object:nil];
        
    }
    return self;
}

#pragma mark
#pragma mark keyboardWillShow 和 keyboardWillHide 监听键盘和键盘一起出动

//Code from Brett Schumann
-(void) keyboardWillShow:(NSNotification *)note{
    if (singleTapGR == nil) {
        singleTapGR  =  [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAnywhereToDismissKeyboard:)];
    }
    [self.view addGestureRecognizer:singleTapGR];
    
}

-(void) keyboardWillHide:(NSNotification *)note{
    [self.view removeGestureRecognizer:singleTapGR];
}

- (void)tapAnywhereToDismissKeyboard:(UIGestureRecognizer *)gestureRecognizer {
    //此method会将self.view里所有的subview的first responder都resign掉
    [self.view endEditing:YES];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
    NSLog(@"%s",__FUNCTION__);
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.navigationItem setTitle:@"编辑减肥宣言"];
    [self createView];
}

-(void) onConfirm
{
    [self.delegate onCommonEditConfirmWithFlag:self.flag andContent:_inputer.text];
    [self.navigationController popViewControllerAnimated:YES];
}

-(void) createView
{
//    [self setUpForDismissKeyboard];

    
    _inputer = [[UITextField alloc]initWithFrame:CGRectMake(_DIME_LEFT, _px(40), _DIME_CONT_SIZE, _px(78))];
    [_inputer setBackgroundColor:[UIColor whiteColor]];
    _inputer.font = FONT_SIZE(15);
    _inputer.textColor = [UIColor blackColor];
    [_inputer setKeyboardType:self.keyboardType];
    [_inputer setPlaceholder:self.placeholder];
    [_inputer setValue:[NSNumber numberWithInt:_px(20)] forKey:@"paddingLeft"];
    [_inputer becomeFirstResponder];
    [self.view addSubview:_inputer];
    
    
    _confirmbtn = [[UIButton alloc] initWithFrame:CGRectMake(_DIME_LEFT, _inputer.frame.origin.y + _inputer.frame.size.height +_px(30),_DIME_CONT_SIZE, _px(78))];
    [_confirmbtn setTitle:@"确定" forState:UIControlStateNormal];
    _confirmbtn.titleLabel.font = FONT_SIZE(16);
    [_confirmbtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_confirmbtn setBackgroundImage:[UIImage imageNamed:@"common_long_btn"] forState:UIControlStateNormal];
    [self.view addSubview:_confirmbtn];
    [_confirmbtn addTarget:self action:@selector(onConfirm) forControlEvents:UIControlEventTouchUpInside];
}
@end
