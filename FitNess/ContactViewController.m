//
//  ContactViewController.m
//  FitNess
//
//  Created by WeiHu on 14/12/4.
//  Copyright (c) 2014年 WeiHu. All rights reserved.
//

#import "ContactViewController.h"

@interface ContactViewController ()<UITextViewDelegate>
{
    UILabel *uilabel;
    UITextView *statusInputer ;
}
@end

@implementation ContactViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //UITextView * _statusInputer;
    [self.navigationItem setTitle:@"填写联系信息"];
   statusInputer = [[UITextView alloc] initWithFrame:CGRectMake(10,20, DIME_SCREEN_W-20, 200)];
    [statusInputer setFont:FONT_SIZE(14)];
    [statusInputer setBackgroundColor:[UIColor clearColor]];
    statusInputer.textColor = [UIColor blackColor];
    [statusInputer setDelegate:self];
    //    [_statusInputer becomeFirstResponder];
    [self.view addSubview:statusInputer];
    uilabel = [[UILabel alloc] init];
    uilabel.frame =CGRectMake(5, 5, statusInputer.width, 20);
    uilabel.text = @"QQ，电话等我们能联系您的联系方式";
    uilabel.enabled = NO;//lable必须设置为不可用
    uilabel.font = FONT_SIZE(14);
    uilabel.backgroundColor = [UIColor clearColor];
    [statusInputer addSubview:uilabel];
    
    UIBarButtonItem *frendar = [[UIBarButtonItem alloc]initWithCustomView:self.rightButton];
    [self.rightButton addTarget:self action:@selector(rightBtnAction) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = frendar;
    self.rightButton.titleLabel.font = [UIFont systemFontOfSize:20.0f];
    [self.rightButton setTitle:@"√" forState:UIControlStateNormal];
    
    // Do any additional setup after loading the view.
}
- (void)rightBtnAction
{
    [[NSUserDefaults standardUserDefaults] setObject:statusInputer.text forKey:@"ContactViewController_Infomation"];
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)textViewDidChange:(UITextView *)textView
{
//    self.examineText =  textView.text;
    if (textView.text.length == 0) {
        uilabel.text = @"QQ，电话等我们能联系您的联系方";
    }else{
        uilabel.text = @"";
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
