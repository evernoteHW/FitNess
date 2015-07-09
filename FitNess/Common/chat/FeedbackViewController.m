//
//  FeedbackViewController.m
//  UMeng Analysis
//
//  Created by liu yu on 7/12/12.
//  Copyright (c) 2012 Realcent. All rights reserved.
//

#import "FeedbackViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "L_FeedbackTableViewCell.h"
#import "R_FeedbackTableViewCell.h"


@implementation FeedbackViewController

@synthesize mTextField = _mTextField, mTableView = _mTableView, mToolBar = _mToolBar, mFeedbackDatas = _mFeedbackDatas;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}



- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    feedbackClient = [UMFeedback sharedInstance];
    feedbackClient.delegate = self ;
    [feedbackClient get];
    
    
//    UIButton *lbutton =[[UIButton alloc]initWithFrame:CGRectMake(0, 0, _px(100), _px(32))];
//    [lbutton addTarget:self action:@selector(onAddFrends) forControlEvents:UIControlEventTouchUpInside];
//    [lbutton setTitle:@"《返回" forState:UIControlStateNormal];
//    lbutton.titleLabel.font = FONT_SIZE(15);
//    lbutton.backgroundColor = [UIColor redColor];
//    [lbutton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    [lbutton setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
//    UIBarButtonItem *frendar = [[UIBarButtonItem alloc]initWithCustomView:lbutton];
////    [self.navigationItem setLeftBarButtonItem:frendar];
//    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:lbutton];
    
    //设置iOS7系统下(0,0)点的位置
    float systemVersion = [[[UIDevice currentDevice] systemVersion] floatValue];
    float limitVersion = 100;
    if ((systemVersion >= 7.0) && (systemVersion < limitVersion)) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    self.mToolBar.frame = CGRectMake(0, 568-64-44, 320, 44);

   
    //设置navigationbar颜色

    
    self.title = @"举报";
    
    [_mTableView setBackgroundColor:[UIColor whiteColor]];

    _mFeedbackDatas = [[NSArray alloc] init];

//    从缓存取topicAndReplies
    self.mFeedbackDatas = feedbackClient.topicAndReplies;
    [self updateTableView:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];

}
- (void)onAddFrends
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark keyboard notification

- (void)keyboardWillShow:(NSNotification *) notification {
    float animationDuration = [[[notification userInfo] valueForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue];
    CGFloat height = [[[notification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size.height;
    
    CGRect bottomBarFrame = self.mToolBar.frame;
    {
        [UIView beginAnimations:@"bottomBarUp" context:nil];
        [UIView setAnimationDuration: animationDuration];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        bottomBarFrame.origin.y = self.view.bounds.size.height - 44 - height;
        self.mToolBar.frame = bottomBarFrame;
        [self.mTextField becomeFirstResponder];
        [UIView commitAnimations];
    }
}

- (void)keyboardWillHide:(NSNotification *) notification {
    float animationDuration = [[[notification userInfo] valueForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue];
    CGFloat height = [[[notification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size.height;
    
    CGRect bottomBarFrame = self.mToolBar.frame;
    if (bottomBarFrame.origin.y < 300)
    {
        [UIView beginAnimations:@"bottomBarDown" context:nil];
        [UIView setAnimationDuration: animationDuration];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        bottomBarFrame.origin.y += height;
        self.mToolBar.frame = bottomBarFrame;
        [UIView commitAnimations];
    }
}



- (void)popView {
    if ([self.mTextField isFirstResponder]) {
        [self.mTextField resignFirstResponder];
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark tableview delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_mFeedbackDatas count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *content = [[self.mFeedbackDatas objectAtIndex:indexPath.row] objectForKey:@"content"];
    CGSize labelSize =[content sizeWithFont:[UIFont systemFontOfSize:14.0f] constrainedToSize:CGSizeMake(250.0f, MAXFLOAT)
                               lineBreakMode:NSLineBreakByWordWrapping];


    return labelSize.height + 30;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *L_CellIdentifier = @"L_UMFBTableViewCell";
    static NSString *R_CellIdentifier = @"R_UMFBTableViewCell";
    
    NSDictionary *data = [self.mFeedbackDatas objectAtIndex:indexPath.row];
    
    if ([[data valueForKey:@"type"] isEqualToString:@"dev_reply"]) {
        L_FeedbackTableViewCell *cell = (L_FeedbackTableViewCell *) [tableView dequeueReusableCellWithIdentifier:L_CellIdentifier];
        if (cell == nil) {
            cell = [[L_FeedbackTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:L_CellIdentifier];
        }
        
        cell.textLabel.text = [data valueForKey:@"content"];
        cell.backgroundColor = [UIColor clearColor];
        
        return cell;
    }
    else {
        
        R_FeedbackTableViewCell *cell = (R_FeedbackTableViewCell *) [tableView dequeueReusableCellWithIdentifier:R_CellIdentifier];
        if (cell == nil) {
            cell = [[R_FeedbackTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:R_CellIdentifier];
        }
        
        cell.textLabel.text = [data valueForKey:@"content"];
         cell.backgroundColor = [UIColor clearColor];
        
        return cell;
        
    }
}

#pragma mark Umeng Feedback delegate

- (void)updateTableView:(NSError *)error
{
    if ([self.mFeedbackDatas count])
    {
        [self.mTableView reloadData];
        
        NSInteger lastRowNumber = [self.mTableView numberOfRowsInSection:0] - 1;
        NSIndexPath *ip = [NSIndexPath indexPathForRow:lastRowNumber inSection:0];
        [self.mTableView scrollToRowAtIndexPath:ip atScrollPosition:UITableViewScrollPositionTop animated:NO];
        
        
        
    }
    else
    {

    }
}

- (void)updateTextField:(NSError *)error
{
    self.mTextField.text = @"";
    [feedbackClient get];
}

- (void)getFinishedWithError:(NSError *)error
{
    if (!error)
    {
    
         NSLog(@"%@", feedbackClient.topicAndReplies);
        [self updateTableView:error];
    }
    else
    {
           NSLog(@"%@",error);
    }
}



- (void)postFinishedWithError:(NSError *)error
{
    if (!error) {
         NSLog(@"发送成功");
        [[TKAlertCenter defaultCenter] postAlertWithMessage:@"举报成功"];
    } else{
        NSLog(@"发送失败");
        [[TKAlertCenter defaultCenter] postAlertWithMessage:@"举报失败"];
    }

    [self updateTextField:error];
}

#pragma mark scrollow delegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    [self.mTextField resignFirstResponder];
}



- (IBAction)sendFeedback:(id)sender {
    if ([self.mTextField.text length])
    {
        
        
        NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
        
        [dictionary setObject:self.mTextField.text forKey:@"content"];
        
        [feedbackClient post:dictionary];
        [self.mTextField resignFirstResponder];
    }
}
@end
