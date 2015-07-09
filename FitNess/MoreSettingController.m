//
//  MoreSettingController.m
//  FitNess
//
//  Created by liuguoyan on 14-10-5.
//  Copyright (c) 2014年 liuguoyan. All rights reserved.
//

#import "MoreSettingController.h"
#import "MoreFeedBackViewController.h"
#import "MoreAboutViewController.h"
#import "FNHomeTabBarController.h"
#import "FNNavigationViewController.h"
#import "UserInfoViewController.h"
#import "FNRegistViewController.h"


@interface Set_ViewController : UITableViewCell
@end
@interface MoreSettingController ()<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>
{
    NSArray *_itemIcons;
    NSArray *_itemTitles;
}
@end

@implementation MoreSettingController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.navigationItem setTitle:@"设置"];
    [self createView];
    [self initData];
    [self setListeners];
}

-(void) initData
{
    
}

-(void) setListeners
{
    
}

-(void) initParams
{
    _itemIcons = @[@"more_set_myaccount",@"more_version",@"more_fen",@"more_suggest",@"more_about",@"more_set_exit"];
    _itemTitles = @[@"我的帐号",@"版本更新",@"给我评分",@"意见反馈",@"关于云朵朵",@"退出云朵朵"];
}

#pragma UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _itemIcons.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[Set_ViewController alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    
    cell.imageView.image = [UIImage imageNamed:_itemIcons[indexPath.row]];
    [cell.imageView setContentMode:UIViewContentModeScaleAspectFit];
    cell.textLabel.text = _itemTitles[indexPath.row];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}

#pragma UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return _px(122);
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //当手指离开某行时，就让某行的选中状态消失
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    switch (indexPath.row) {
            //我的帐号
        case 0:
        {
            UserInfoViewController *controller = [[UserInfoViewController alloc]init];
            [self.navigationController pushViewController:controller animated:YES];
        }
            break;
             //版本更新
        case 1:
            [[TKAlertCenter defaultCenter] postAlertWithMessage:@"已经是最新版本"];
            break;
             //给我评分
        case 2:
            [[TKAlertCenter defaultCenter] postAlertWithMessage:@"功能暂时关闭"];
            break;
            //意见反馈
        case 3:
        {
            MoreFeedBackViewController *controller = [[MoreFeedBackViewController alloc]init];
            [self.navigationController pushViewController:controller animated:YES];
        }
            break;
            //关于云朵朵
        case 4:
        {
            MoreAboutViewController *controller = [[MoreAboutViewController alloc]init];
            [self.navigationController pushViewController:controller animated:YES];
        }
            break;
            //退出云朵朵
        case 5:
        {
            UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:@"您要退出云朵朵吗？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
            [alertView show];
        }
            break;
    }
    
}

#pragma mark UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    //确定
    if (buttonIndex == 1) {
    }
}
- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex{
    //确定
    if (buttonIndex == 1) {
//        NSUserDefaults *userDef = [NSUserDefaults standardUserDefaults];
//        NSMutableDictionary *user = [userDef objectForKey:@"user"];
//        if (user) {
//            [userDef removeObjectForKey:@"user"];
//            [userDef synchronize];
//        }
        [(FNNavigationViewController *)[UIApplication sharedApplication].keyWindow.rootViewController popToRootViewControllerAnimated:YES];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return _px(20);
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *_headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, _px(20))];
    [_headView setBackgroundColor:[UIColor whiteColor]];
    return _headView;
}



- (void)setExtraCellLineHidden: (UITableView *)tableView

{
    
    UIView *view = [UIView new];
    
    view.backgroundColor = [UIColor clearColor];
    
    [tableView setTableFooterView:view];
    
}


-(void) createView
{
    
    [self initParams];

    _backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, DIME_SCREEN_W, DIME_SCREEN_H-TITLE_HEI)];
    [_backView setBackgroundColor:R_COLOR_COMMON_BAC];
    [self.view addSubview:_backView];
    
    _tableView =[[UITableView alloc]initWithFrame:CGRectMake(_DIME_LEFT, _px(20), DIME_SCREEN_W-2*_DIME_LEFT, DIME_SCREEN_H-TITLE_HEI)];
    [self.view addSubview:_tableView];
    
    [_tableView setDataSource:self];
    [_tableView setDelegate:self];
    [self setExtraCellLineHidden:_tableView];
    
}

@end

@implementation Set_ViewController
- (void)layoutSubviews {
    [super layoutSubviews];
    self.imageView.frame = CGRectMake(_px(10),_px(10),_px(100),_px(100));
}
@end