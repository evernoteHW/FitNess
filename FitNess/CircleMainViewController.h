//
//  CircleMainViewController.h
//  FitNess
//
//  Created by liuguoyan on 14-10-6.
//  Copyright (c) 2014年 liuguoyan. All rights reserved.
//

#import "FNStepViewController.h"
#import "EGORefreshTableHeaderView.h"

@interface CircleMainViewController : FNStepViewController<EGORefreshTableHeaderDelegate, UITableViewDelegate, UITableViewDataSource>
{
	EGORefreshTableHeaderView *_refreshHeaderView;
	BOOL _reloading;
    UITableView *_tableView;
    
    
    UIButton * _headIcon;
    UILabel *_nickName;
    UILabel *_announceView;
    
    UIButton *_footerButton;
    
}
@property (nonatomic, strong) FriendActivityModel *selectedFriModel;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIButton *footerButton;

@property (nonatomic, assign) BOOL isLookOther;
@property (nonatomic, strong) NSString *userId;

@property (nonatomic, strong) NSString *userImgPath;
@property (nonatomic, strong) NSString *userName;
@property (nonatomic, strong) NSString *increamFatTip;

- (void)reloadTableViewDataSource;

- (void)doneLoadingTableViewData;

@end
