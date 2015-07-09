//
//  MoreFeedBackViewController.m
//  FitNess
//
//  Created by liuguoyan on 14-10-5.
//  Copyright (c) 2014年 liuguoyan. All rights reserved.
//

#import "MoreFeedBackViewController.h"
#import "RTLabel.h"
#import "ContactViewController.h"

@interface MoreFeedBackViewController ()<UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource>
{
    UITapGestureRecognizer *singleTapGR;
}
@property (nonatomic, strong) UIButton *sendMsgBtn;
@property (nonatomic, strong) UITextField *commentTextField;
@property (nonatomic, strong) UIView *customKeybordView;    //自定义输入框

@property (nonatomic, strong) UITableView *feedBackTableView;
@property (nonatomic, strong) NSMutableArray *feedBackDataArray;


@end

@implementation MoreFeedBackViewController

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
        
        
        //得到完整的文件名
        NSString *filename = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/FeedBack.plist"];
        _feedBackDataArray = [[NSMutableArray alloc] initWithContentsOfFile:filename];

        

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.navigationItem setTitle:@"意见反馈"];
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"quan_bg"]]];
    [self.view addSubview:self.feedBackTableView];
    [self.view addSubview:self.customKeybordView];
    

}



//Code from Brett Schumann
-(void) keyboardWillShow:(NSNotification *)note{
    // get keyboard size and loctaion
    CGRect keyboardBounds;
    [[note.userInfo valueForKey:UIKeyboardFrameEndUserInfoKey] getValue: &keyboardBounds];
    NSNumber *duration = [note.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSNumber *curve = [note.userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey];
    
    // Need to translate the bounds to account for rotation.
    keyboardBounds = [self.view convertRect:keyboardBounds toView:nil];
    
    // get a rect for the textView frame
    CGRect containerFrame = self.customKeybordView.frame;
    containerFrame.origin.y = self.view.bounds.size.height - (keyboardBounds.size.height + containerFrame.size.height);
    // animations settings
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:[duration doubleValue]];
    [UIView setAnimationCurve:[curve intValue]];
    
    // set views with new info
    self.customKeybordView.frame = containerFrame;
    
    // commit animations
    [UIView commitAnimations];
    if (singleTapGR == nil) {
        singleTapGR  =  [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAnywhereToDismissKeyboard:)];
    }
    [self.view addGestureRecognizer:singleTapGR];
    
    
    //
//    CGSize kbSize = [[note.userInfo objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
////
//    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, kbSize.height + 50, 0.0);
//    _feedBackTableView.contentInset = contentInsets;
//    _feedBackTableView.scrollIndicatorInsets = contentInsets;
//    CGFloat y = self.feedBackTableView.contentSize.height - self.feedBackTableView.height + 216;
//    [self.feedBackTableView setContentOffset:CGPointMake(0, y) animated:YES];
//
    
}

- (void) keyboardWillHide:(NSNotification *)note{
    NSNumber *duration = [note.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSNumber *curve = [note.userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey];
    
    // get a rect for the textView frame
    CGRect containerFrame = self.customKeybordView.frame;
    containerFrame.origin.y = self.view.height  - 50;
    
    // animations settings
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:[duration doubleValue]];
    [UIView setAnimationCurve:[curve intValue]];
    
    // set views with new info
    self.customKeybordView.frame = containerFrame;
    
    // commit animations
    [UIView commitAnimations];
    
    [self.view removeGestureRecognizer:singleTapGR];
    
    UIEdgeInsets contentInsets = UIEdgeInsetsZero;
    _feedBackTableView.contentInset = contentInsets;
    _feedBackTableView.scrollIndicatorInsets = contentInsets;
    
}

- (void)tapAnywhereToDismissKeyboard:(UIGestureRecognizer *)gestureRecognizer {
    //此method会将self.view里所有的subview的first responder都resign掉
    [self.view endEditing:YES];
}

- (UITableView *)feedBackTableView
{
    if (_feedBackTableView == nil) {
        _feedBackTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, DIME_SCREEN_W, DIME_SCREEN_H - 64 - 50) style:UITableViewStylePlain];
        _feedBackTableView.backgroundColor = [UIColor clearColor];
        _feedBackTableView.dataSource = self;
        _feedBackTableView.delegate = self;
        
//        if (![[NSUserDefaults standardUserDefaults] boolForKey:@"FirstStart"]) {
//            [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"FirstStart"];
//            [[NSUserDefaults standardUserDefaults] setObject:[NSDate date] forKey:@"LocalDate"];
//            FNGuideViewController *navController = [[FNGuideViewController alloc]init];
//            self.window.rootViewController = navController;
//        }
        NSString *str =  [[NSUserDefaults standardUserDefaults] objectForKey:@"ContactViewController_Infomation"];
        if (str && ![str isEqualToString:@""]) {
            
        }else
        {
        UIButton *qqAndTelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        qqAndTelBtn.frame = CGRectMake(0, 0, DIME_SCREEN_W, 40);
        [qqAndTelBtn addTarget:self action:@selector(qqAndTelBtnAction) forControlEvents:UIControlEventTouchUpInside];
        qqAndTelBtn.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"me_body_xuyundong_bg"]];
        _feedBackTableView.tableHeaderView = qqAndTelBtn;
        
        UIImageView *arr = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0,qqAndTelBtn.width, 6)];
        [arr setImage:[UIImage imageNamed:@"head_banner"]];
        [qqAndTelBtn  addSubview:arr];
        
        UILabel *dataLabel = [[UILabel alloc] initWithFrame:qqAndTelBtn.bounds];
        dataLabel.textColor = [UIColor whiteColor];
        dataLabel.backgroundColor = [UIColor clearColor];
        dataLabel.font = [UIFont boldSystemFontOfSize:16.0f];
        dataLabel.text = @"  联系方式                                                   >";
        [qqAndTelBtn addSubview: dataLabel];
        }
        _feedBackTableView.tableFooterView = [UIView new];
//        CGFloat y = _feedBackTableView.contentSize.height - _feedBackTableView.height ;
//        [_feedBackTableView setContentOffset:CGPointMake(0, y) animated:YES];
    }
    return _feedBackTableView;
}

- (UIView *)customKeybordView
{
    if (_customKeybordView == nil) {
        _customKeybordView = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.height - 64 - 50, DIME_SCREEN_W, 50)];
        _customKeybordView.backgroundColor = [UIColor colorWithHexString:@"CF004F"];
        
        self.commentTextField = [[UITextField alloc] initWithFrame:CGRectMake(10 , 10, 180, 30)];
        self.commentTextField.delegate = self;
        self.commentTextField.returnKeyType = UIReturnKeySearch;
        self.commentTextField.placeholder = @"我想说";
        self.commentTextField.backgroundColor=[UIColor whiteColor];
        self.commentTextField.font = [UIFont systemFontOfSize:15.0f];
        self.commentTextField.textColor = [UIColor blackColor];
        self.commentTextField.delegate = self;
        self.commentTextField.returnKeyType = UIReturnKeySend;
        self.commentTextField.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 0)];
        self.commentTextField.leftViewMode = UITextFieldViewModeAlways;
        [_customKeybordView addSubview:self.commentTextField];
        
        self.sendMsgBtn =[[UIButton alloc]initWithFrame:CGRectMake(self.commentTextField.right + 10, 5, 80,40)];
        [self.sendMsgBtn addTarget:self action:@selector(onFeedBack) forControlEvents:UIControlEventTouchUpInside];
        [self.sendMsgBtn setTitle:@"发送" forState:UIControlStateNormal];
        self.sendMsgBtn.titleLabel.font = [UIFont boldSystemFontOfSize:15.0f];
        self.sendMsgBtn.backgroundColor = [UIColor clearColor];
        [self.sendMsgBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.sendMsgBtn setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
        [_customKeybordView addSubview:self.sendMsgBtn];
    }
    return _customKeybordView;
}

- (void)qqAndTelBtnAction
{
    ContactViewController *controller = [[ContactViewController alloc] init];
    [self.navigationController pushViewController:controller animated:YES];
}

#pragma mark UITableViewDataSource

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    RTLabel *contentLabel = [[RTLabel alloc] initWithFrame:CGRectMake(10, 40, 300, 40)];
    NSDictionary *dic = _feedBackDataArray[indexPath.row];
    contentLabel.text = dic[@"Content"];
    return contentLabel.optimumSize.height + 20 + 20;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _feedBackDataArray.count;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *identifier = @"FeedBackCell";
    UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.separatorInset = UIEdgeInsetsZero;
        
        UILabel *dataLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 300, 20)];
        dataLabel.textColor = [UIColor blackColor];
        dataLabel.backgroundColor = [UIColor whiteColor];
        dataLabel.font = [UIFont systemFontOfSize:14.0f];
        dataLabel.tag = 89;
        [cell.contentView addSubview:dataLabel];
        
        RTLabel *contentLabel = [[RTLabel alloc] initWithFrame:CGRectMake(10, dataLabel.bottom, 300, 40)];
        contentLabel.textColor = [UIColor blackColor];
        contentLabel.backgroundColor = [UIColor whiteColor];
        contentLabel.tag = 88;
        [cell.contentView addSubview:contentLabel];
        
    }
    RTLabel *contentLabel = (RTLabel *)[cell.contentView viewWithTag:88];
    NSDictionary *dic = _feedBackDataArray[indexPath.row];
    contentLabel.text = dic[@"Content"];
    contentLabel.height = contentLabel.optimumSize.height;
    
    UILabel *dataLabel = (UILabel *)[cell.contentView viewWithTag:89];
    dataLabel.text = dic[@"DateTime"];
    
    return cell;
    
}

- (void)dealloc
{
    NSLog(@"%s",__FUNCTION__);
}

//意见反馈
-(void) onFeedBack
{
    if (_feedBackDataArray == nil) {
        _feedBackDataArray = [NSMutableArray array];
    }
    if (self.commentTextField.text.length > 0) {
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateStyle:NSDateFormatterMediumStyle];
        [formatter setTimeStyle:NSDateFormatterShortStyle];
        [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
        NSString *nowtimeStr = [formatter stringFromDate:[NSDate date]];
        [_feedBackDataArray addObject:@{@"Content":self.commentTextField.text,@"DateTime":nowtimeStr}];
    }
    //获取应用程序沙盒的Documents目录
    NSString *filename = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/FeedBack.plist"];
    [_feedBackDataArray writeToFile:filename atomically:YES];

//    self.feedBackTableView.contentOffset
//    self.feedBackTableView.height
//    self.feedBackTableView.contentSize.height
//    CGFloat y = self.feedBackTableView.contentSize.height - self.feedBackTableView.height + 216 + 50;
//    [self.feedBackTableView setContentOffset:CGPointMake(0, y) animated:YES];
    
    [self.feedBackTableView reloadData];
    
    self.commentTextField.text = @"";

}




@end