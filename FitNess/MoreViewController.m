//
//  MoreViewController.m
//  FitNess
//
//  Created by liuguoyan on 14-10-5.
//  Copyright (c) 2014年 liuguoyan. All rights reserved.
//

#import "MoreViewController.h"
#import "MoreSettingController.h"
#import "AddFriendViewController.h"
#import "MoreCollectionController.h"
#import "MessageViewController.h"


@interface More_ViewController : UITableViewCell
@end

@interface MoreViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSArray *_itemIcons;
    NSArray *_itemTitles;
    
}
@end

@implementation MoreViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _itemIcons = @[@"more_message",@"more_store",@"more_active",@"more_friend",@"more_collect"];
        _itemTitles = @[@"消息",@"商店",@"活动",@"好友",@"收藏"];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.navigationItem setTitle:@"更多"];
    [self createMoreView];
    self.leftButton.hidden = YES;
}


#pragma UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _itemIcons.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"More_ViewController";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[More_ViewController alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
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
    //[@"消息",@"商店",@"活动",@"好友",@"收藏"]
    switch (indexPath.row) {
            //消息
        case 0:
        {
            MessageViewController *controller = [[MessageViewController alloc]init];
            controller.hidesBottomBarWhenPushed = YES;
            controller.title = @"消息列表";
            [self.navigationController pushViewController:controller animated:YES];
        }
            break;
            //商店
        case 1:
        {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.plyh.com/index.php"]];
        }
            break;
            //活动
        case 2:
        {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.plyh.com/zxrj/"]];
        }
            break;
            //好友
        case 3:
        {
            AddFriendViewController *controller = [[AddFriendViewController alloc]init];
            controller.addFriend = NO;
            controller.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:controller animated:YES];
        }
            break;
            //收藏
        case 4:
        {
            MoreCollectionController *controller = [[MoreCollectionController alloc]init];
            controller.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:controller animated:YES];
        }
            break;
        default:
            break;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return _px(20);
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, _px(20))];
    [headView setBackgroundColor:[UIColor whiteColor]];
    return headView;
}

- (void)setExtraCellLineHidden: (UITableView *)tableView
{
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor clearColor];
    [tableView setTableFooterView:view];
    
}
-(void)onSetButton
{
    MoreSettingController *contrller = [[MoreSettingController alloc]init];
    [contrller setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:contrller animated:YES];
}



-(void) createMoreView
{
    
    UIButton *button =[[UIButton alloc]initWithFrame:CGRectMake(0, 0, _px(44), _px(44))];
    [button setImage:[UIImage imageNamed:@"more_set_icon"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(onSetButton) forControlEvents:UIControlEventTouchUpInside];

    UIBarButtonItem *settBar = [[UIBarButtonItem alloc]initWithCustomView:button];
    
    [self.navigationItem setRightBarButtonItem:settBar];
    
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

@implementation More_ViewController
- (void)layoutSubviews {
    [super layoutSubviews];
    self.imageView.frame = CGRectMake(_px(10),_px(10),_px(100),_px(100));
}
@end
