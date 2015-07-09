//
//  CircleMainViewController.m
//  FitNess
//
//  Created by liuguoyan on 14-10-6.
//  Copyright (c) 2014年 liuguoyan. All rights reserved.
//

#import "CircleMainViewController.h"
#import "SendStatusViewController.h"
#import "FriendActivityCell.h"
#import "YTPhotoBrowserController.h"
#import "YTPhoto.h"
#import "UIButton+WebCache.h"
#import "AddFriendViewController.h"
#import "PopoverView.h"
#import "UMSocial.h"
#import "StatusCommentViewController.h"
#import "FeedbackViewController.h"


@interface CircleMainViewController ()<FriendActivityCellDelegate,PopoverViewDelegate,UMSocialUIDelegate>
{
    NSInteger init_num;
    NSMutableArray * friend_activity_list;
    UIButton *funcBgBtn;                  ///功能健背景
    UIView *funcWhitBgView;               ///分享和转发
}
@end

@implementation CircleMainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.userId = [[FNDataKeeper sharedInstance] getUserId];
        UserModel *user = [[FNDataKeeper sharedInstance] getUser];
        self.userImgPath = user.userImgPath;
        self.userName = user.userName;
        self.increamFatTip = user.increamFatTip;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    if (self.isLookOther) {
        [self.navigationItem setTitle:@"个人主页"];
    }else{
        [self.navigationItem setTitle:@"圈圈"];
    }
    
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"quan_bg"]]];
    [self createCircleMainView];
    [self initData];
    self.leftButton.hidden = YES;
}


-(void) createCircleMainView
{
    [self adTitleMenu];
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, DIME_SCREEN_W, DIME_SCREEN_H-(TITLE_HEI+TABBAR_HEI))];
    if (self.isLookOther) {
        _tableView.height = self.view.height - 64;
    }
    [self.view addSubview:_tableView];
    [_tableView setDataSource:self];
    [_tableView setDelegate:self];
    [_tableView setTableHeaderView:[self headerViewForTableView ]];
    [_tableView setTableFooterView:[self footerViewForTableView]];
    _tableView.backgroundColor = [UIColor clearColor];
	if (_refreshHeaderView == nil) {
		
		EGORefreshTableHeaderView *view = [[EGORefreshTableHeaderView alloc] initWithFrame:CGRectMake(0.0f, 0.0f - _tableView.bounds.size.height, self.view.frame.size.width, _tableView.bounds.size.height)];
		view.delegate = self;
		[_tableView addSubview:view];
		_refreshHeaderView = view;
	}
	//  update the last update date
	[_refreshHeaderView refreshLastUpdatedDate];

}

-(void) initData
{
    init_num = 0;
    [self queryFriendsStatus];
    friend_activity_list = [NSMutableArray array];

    if (self.userImgPath.length>0) {
        [_headIcon sd_setImageWithURL:[NSURL URLWithString:self.userImgPath] forState:UIControlStateNormal placeholderImage:nil];
    }
    _nickName.text = self.userName;
    _announceView.text = self.increamFatTip;
}

#pragma mark - 获取好友圈信息

-(void)queryFriendsStatus
{
    [self showHud];
    init_num = 0;
//
    NSMutableDictionary *parametersDic = [NSMutableDictionary dictionary];
    NSString *mothod  = @"";
    if (self.isLookOther) {
        mothod = MODELS_METHOD_QRY_MY_ACTIVITYLIST;
        [parametersDic setObject:self.userId forKey:URL_DATA_K_USER_ID];
    }else{
        mothod = MODELS_METHOD_QRY_FRIEND_ACTIVITYLIST;
        [parametersDic setObject:[[FNDataKeeper sharedInstance] getUserId] forKey:URL_DATA_K_USER_ID];
    }
    [parametersDic setObject:[NSString stringWithFormat:@"%d",0] forKey:URL_DATA_K_OFFSET];
    [parametersDic setObject:[NSString stringWithFormat:@"20"] forKey:URL_DATA_K_NUM];
    
    __unsafe_unretained CircleMainViewController *weakSelf = self;
    [[NetworkManager shareManager] requestParams:parametersDic withModule:MODELS_MODEL_PARTYMANAGER method:mothod finishBlock:^(DataServies *request, id result) {
    
        NSString *msg = [result objectForKey:@"msg"];
        if ([[result objectForKey:@"flag"] integerValue] == 1) {
            NSArray *arr = [result objectForKey:@"retDataArray"];
            [friend_activity_list removeAllObjects];
            for (int i = 0 ; i<arr.count ; i++) {
                FriendActivityModel * fActivity = [FriendActivityModel modelWithDictionary:[arr objectAtIndex:i]];
                [friend_activity_list addObject:fActivity];
            }
            [weakSelf.tableView reloadData];
            [weakSelf.footerButton setHidden:NO];

        }else{
            NSLog(@"%@",msg);
        }
            [weakSelf doneLoadingTableViewData];
            [weakSelf hideHud];
        
    } failBlock:^(DataServies *request, NSError *error) {
       
         [weakSelf hideHud];
    }];
    
    
}


#pragma mark - 获取更多好友圈信息

-(void)queryMoreFriendsStatus
{

//    init_num += 1 ;
    NSMutableDictionary *parametersDic = [NSMutableDictionary dictionary];
    NSString * mothod = @"";
    if (self.isLookOther) {
        mothod = MODELS_METHOD_QRY_MY_ACTIVITYLIST;
        [parametersDic setObject:self.userId forKey:URL_DATA_K_USER_ID];
    }else{
         mothod = MODELS_METHOD_QRY_FRIEND_ACTIVITYLIST;
        [parametersDic setObject:[[FNDataKeeper sharedInstance] getUserId] forKey:URL_DATA_K_USER_ID];
    }
    [parametersDic setObject:[NSString stringWithFormat:@"%d",friend_activity_list.count] forKey:URL_DATA_K_OFFSET];
    [parametersDic setObject:[NSString stringWithFormat:@"20"] forKey:URL_DATA_K_NUM];
    
    __unsafe_unretained CircleMainViewController *weakSelf = self;
    [[NetworkManager shareManager] requestParams:parametersDic withModule:MODELS_MODEL_PARTYMANAGER method:mothod finishBlock:^(DataServies *request, id result) {
        
        NSString *msg = [result objectForKey:@"msg"];
        if ([[result objectForKey:@"flag"] integerValue] == 1) {
            NSArray *arr = [result objectForKey:@"retDataArray"];
            for (int i = 0 ; i<arr.count ; i++) {
                FriendActivityModel * fActivity = [FriendActivityModel modelWithDictionary:[arr objectAtIndex:i]];
                [friend_activity_list addObject:fActivity];
            }
            [weakSelf.tableView reloadData];
            [weakSelf.footerButton setHidden:NO];
            [weakSelf.footerButton setTitle:@"点击加载更多" forState:UIControlStateNormal];
            
        }else{
            NSLog(@"%@",msg);
        }
        
        
    } failBlock:^(DataServies *request, NSError *error) {
        
        
    }];
    
}

//////////////////点赞

#pragma mark 点赞

-(void)addPraiseStatues
{

    NSMutableDictionary *parametersDic = [NSMutableDictionary dictionary];
    if (self.isLookOther) {
        [parametersDic setObject:self.userId forKey:URL_DATA_K_USER_ID];
    }else{
        [parametersDic setObject:[[FNDataKeeper sharedInstance] getUserId] forKey:URL_DATA_K_USER_ID];
    }
    [parametersDic setObject:self.selectedFriModel.userMessageVO.uid forKey:URL_DATA_K_USER_MSGID];
    
    __unsafe_unretained CircleMainViewController *weakSelf = self;
    [[NetworkManager shareManager] requestParams:parametersDic withModule:MODELS_MODEL_PARTYMANAGER method:MODELS_METHOD_ADD_USER_PAIRSE finishBlock:^(DataServies *request, id result) {
        
        NSString *msg = [result objectForKey:@"msg"];
        if ([[result objectForKey:@"flag"] integerValue] == 1) {
            NSLog(@"%@",weakSelf.selectedFriModel.userMessageVO.pairseNum);
            weakSelf.selectedFriModel.userMessageVO.pairseNum = [NSString stringWithFormat:@"%d",[weakSelf.selectedFriModel.userMessageVO.pairseNum integerValue] + 1];
            NSLog(@"%@",weakSelf.selectedFriModel.userMessageVO.pairseNum);
            [weakSelf.tableView reloadData];

            
        }else{
            NSLog(@"%@",msg);
        }
        
        
    } failBlock:^(DataServies *request, NSError *error) {
        
        
    }];
    
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	return YES;
}

#pragma mark -
#pragma mark FriendActivityCellDelegate (好友列表代理方法)

-(void) onHeadtButtonClicked :(FriendActivityModel *)activity
{
    NSLog(@"点击%@的头像",activity.user.uid);
    CircleMainViewController *controller = [[CircleMainViewController alloc] init];
    controller.userId = [NSString stringWithFormat:@"%@",activity.user.uid];
    controller.hidesBottomBarWhenPushed = YES;
    controller.isLookOther = YES;
    
    controller.userImgPath = activity.user.userImgPath;
    controller.userName = activity.user.userName;
    controller.increamFatTip = activity.user.increamFatTip;
    
    [self.navigationController pushViewController:controller animated:YES];
}
-(void) onHeartButtonClicked :(FriendActivityModel *)activity
{
    self.selectedFriModel = activity;
    [self addPraiseStatues];
     NSLog(@"点击%@的爱心",activity.user.userName);
}
-(void) onCommontButtonClicked:(FriendActivityModel *)activity
{
    StatusCommentViewController *statusCommentCtrl = [[StatusCommentViewController alloc] init];
    statusCommentCtrl.hidesBottomBarWhenPushed = YES;
    statusCommentCtrl.selectedModel =  activity;
    __unsafe_unretained CircleMainViewController *weakSelf = self;
    statusCommentCtrl.statusCommentBlock = ^(NSString *commentNum){
        weakSelf.selectedFriModel.userMessageVO.commentNum = commentNum;
        NSLog(@"%@",weakSelf.tableView.dataSource);
        [weakSelf.tableView reloadData];
        
//        [weakSelf queryFriendsStatus];
    };
    [self.navigationController pushViewController:statusCommentCtrl animated:YES];
     NSLog(@"点击%@的评论",activity.user.userName);
}
-(void) onImageViewClicked:(FriendActivityModel *)activity friendActivityCell:(FriendActivityCell *)cell
{
    NSLog(@"点击%@的图片",activity.user.userName);
    // 1.封装图片数据
    // 替换为中等尺寸图片
    NSString *url = cell.activity.userMessageVO.msgImg;
    YTPhoto *photo = [[YTPhoto alloc] init];
    photo.url = [NSURL URLWithString:url]; // 图片路径
    photo.srcImageView = cell.imgContView; // 来源于哪个UIImageView
    
    // 2.显示相册
    YTPhotoBrowserController *browserCtrl = [[YTPhotoBrowserController alloc] init];
    browserCtrl.currentPhotoIndex = 0; // 弹出相册时显示的第一张图片是？
    browserCtrl.photos = @[photo]; // 设置所有的图片
    [browserCtrl show];

    
}
-(void) onActionButtonClicked:(FriendActivityModel *)activity friendActivityCell:(FriendActivityCell *)cell
{
    self.selectedFriModel = activity;
    CGPoint point = [cell.actionButton convertPoint:cell.actionButton.bounds.origin toView:[UIApplication sharedApplication].keyWindow] ;
    [self showFunctionView:point];
//     NSLog(@"点击%@的功能键",activity.user.userName);
}

////////////////////出现分享和点击

- (void)showFunctionView:(CGPoint)point
{
    if (funcBgBtn == nil) {
        funcBgBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        funcBgBtn.frame = [UIApplication sharedApplication].keyWindow.bounds;
        [funcBgBtn addTarget:self action:@selector(dismissBtn) forControlEvents:UIControlEventTouchDown];
        funcBgBtn.backgroundColor = [UIColor clearColor];
    }
    if (funcWhitBgView == nil) {
        funcWhitBgView = [[UIView alloc] init];
        funcWhitBgView.backgroundColor = [UIColor clearColor];
        funcWhitBgView.size = CGSizeMake(240, 40);
        
        
//        UIView *lineViewTop = [[UIView alloc] initWithFrame:CGRectMake(0, 0, funcWhitBgView.width, 0.5)];
//        lineViewTop.backgroundColor = [UIColor lightGrayColor];
//        [funcWhitBgView addSubview:lineViewTop];
        
        //转发
        UIButton *forwardBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        forwardBtn.frame = CGRectMake(0, 0, funcWhitBgView.width / 3.0, funcWhitBgView.height);
        [forwardBtn addTarget:self action:@selector(forwardBtnAction) forControlEvents:UIControlEventTouchUpInside];
        forwardBtn.backgroundColor = [UIColor clearColor];
        [forwardBtn setTitle:@"转发" forState:UIControlStateNormal];
        forwardBtn.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"forward_share_Bg"]];
        forwardBtn.titleLabel.font = [UIFont systemFontOfSize:12.0f];
        [forwardBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [forwardBtn setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
        [funcWhitBgView addSubview:forwardBtn];
        
        UIImageView *forwordImageView = [[UIImageView alloc] initWithFrame:CGRectMake(5, 13, 19, 14)];
        forwordImageView.image = [UIImage imageNamed:@"forwardBtn"];
        [forwardBtn addSubview:forwordImageView];
        
//        UIView *lineViewCenter = [[UIView alloc] initWithFrame:CGRectMake(funcWhitBgView.width / 2.0, 0, 0.5, funcWhitBgView.height)];
//        lineViewCenter.backgroundColor = [UIColor lightGrayColor];
//        [funcWhitBgView addSubview:lineViewCenter];
        
        //分享
        UIButton *shareBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        shareBtn.frame = CGRectMake(funcWhitBgView.width / 3.0, 0, funcWhitBgView.width / 3.0, funcWhitBgView.height);
        [shareBtn addTarget:self action:@selector(shareBtnAction) forControlEvents:UIControlEventTouchUpInside];
        shareBtn.backgroundColor = [UIColor clearColor];
        [shareBtn setTitle:@"分享" forState:UIControlStateNormal];
        shareBtn.titleLabel.font = [UIFont systemFontOfSize:12.0f];
        [shareBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [shareBtn setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
        shareBtn.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"forward_share_Bg"]];
        [funcWhitBgView addSubview:shareBtn];
       
        UIImageView *shareImageView = [[UIImageView alloc] initWithFrame:CGRectMake(5, 13, 14, 14)];
        shareImageView.image = [UIImage imageNamed:@"shareBtn"];
        [shareBtn addSubview:shareImageView];
        
//        UIView *lineViewBottom = [[UIView alloc] initWithFrame:CGRectMake(0, funcWhitBgView.height - 0.5, funcWhitBgView.width, 0.5)];
//        lineViewBottom.backgroundColor = [UIColor lightGrayColor];
//        [funcWhitBgView addSubview:lineViewBottom];
        
        //分享
        
        //转发
        UIButton *feedBackBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        feedBackBtn.frame = CGRectMake(funcWhitBgView.width / 3.0 * 2, 0, funcWhitBgView.width / 3.0, funcWhitBgView.height);
        [feedBackBtn addTarget:self action:@selector(feedBackBtnAction) forControlEvents:UIControlEventTouchUpInside];
        feedBackBtn.backgroundColor = [UIColor whiteColor];
        [feedBackBtn setTitle:@"举报" forState:UIControlStateNormal];
        feedBackBtn.titleLabel.font = [UIFont systemFontOfSize:12.0f];
        [feedBackBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [feedBackBtn setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
         feedBackBtn.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"forward_share_Bg"]];
        
        [funcWhitBgView addSubview:feedBackBtn];

            if ([[NSString stringWithFormat:@"%@",[[FNDataKeeper sharedInstance] getUserId]] isEqualToString:self.userId]) {
                UIButton *deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
                deleteBtn.frame = CGRectMake(funcWhitBgView.width / 3.0 * 2, 0, funcWhitBgView.width / 3.0, funcWhitBgView.height);
                [deleteBtn addTarget:self action:@selector(delBtnAction) forControlEvents:UIControlEventTouchUpInside];
                deleteBtn.backgroundColor = [UIColor clearColor];
                [deleteBtn setTitle:@"删除" forState:UIControlStateNormal];
                deleteBtn.titleLabel.font = [UIFont systemFontOfSize:12.0f];
                [deleteBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
                [deleteBtn setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
                deleteBtn.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"forward_share_Bg"]];
                [funcWhitBgView addSubview:deleteBtn];
                
                UIImageView *deleteImageView = [[UIImageView alloc] initWithFrame:CGRectMake(5, 13, 37/2.0, 27/2.0)];
                deleteImageView.image = [UIImage imageNamed:@"deleteBg"];
                [deleteBtn addSubview:deleteImageView];
            }else{
                funcWhitBgView.size = CGSizeMake(240, 40);
                forwardBtn.width = funcWhitBgView.width / 3.0;
                shareBtn.left = funcWhitBgView.width / 3.0;
                shareBtn.width = funcWhitBgView.width / 3.0;
            }

//
    }
     if ([[NSString stringWithFormat:@"%@",[[FNDataKeeper sharedInstance] getUserId]] isEqualToString:self.userId]) {
         funcWhitBgView.origin = CGPointMake(point.x - 280, point.y + 12);
     }else{
         funcWhitBgView.origin = CGPointMake(point.x - 200, point.y + 12);
     }
    [funcBgBtn addSubview:funcWhitBgView];
    [[UIApplication sharedApplication].keyWindow addSubview:funcBgBtn];
    
}

//举报
- (void)feedBackBtnAction
{
    [self dismissBtn];
    
    FeedbackViewController *controller = [[FeedbackViewController alloc] init];
    controller.userMessageVOModel = self.selectedFriModel.userMessageVO;
    
    controller.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:controller animated:YES];
}

- (void)dismissBtn{
    [funcBgBtn removeFromSuperview];
}
- (void)forwardBtnAction
{
    [self dismissBtn];

    
    NSMutableDictionary *parametersDic = [NSMutableDictionary dictionary];
    if (self.selectedFriModel.userMessageVO.forwardMsgId && ![self.selectedFriModel.userMessageVO.forwardMsgId isEqualToString:@""]) {
        [parametersDic setObject:self.selectedFriModel.userMessageVO.forwardMsgId forKey:URL_DATA_K_F_MSGID];
    }else {
        [parametersDic setObject:self.selectedFriModel.userMessageVO.uid forKey:URL_DATA_K_F_MSGID];
    }
    [parametersDic setObject:self.selectedFriModel.userMessageVO.userIntrestList forKey:URL_DATA_K_USER_INTRESTLIST];
    [parametersDic setObject:@"" forKey:URL_DATA_K_F_COMMENT];
    [parametersDic setObject:self.selectedFriModel.userMessageVO.userIntrestList forKey:URL_DATA_K_F_USENAME];
    [parametersDic setObject:self.selectedFriModel.userMessageVO.forwardUserId forKey:URL_DATA_K_F_USERID];
    [parametersDic setObject:@"1" forKey:URL_DATA_K_MSG_PRIVIGE];
    [parametersDic setObject:[[FNDataKeeper sharedInstance] getUserId] forKey:URL_DATA_K_USER_ID];
    
    __unsafe_unretained CircleMainViewController *weakSelf = self;
    [[NetworkManager shareManager] requestParams:parametersDic withModule:MODELS_MODEL_PARTYMANAGER method:MODELS_METHOD_USER_MSG_FORWARD finishBlock:^(DataServies *request, id result) {
        
        NSString *msg = [result objectForKey:@"msg"];
        if ([[result objectForKey:@"flag"] integerValue] == 1) {
            [[TKAlertCenter defaultCenter] postAlertWithMessage:@"转发成功"];
            [self queryFriendsStatus];
        }else{
            NSLog(@"%@",msg);
        }
        [weakSelf doneLoadingTableViewData];
        [weakSelf hideHud];
        
    } failBlock:^(DataServies *request, NSError *error) {
        
        [weakSelf hideHud];
    }];
    
}
- (void)shareBtnAction
{
    [self dismissBtn];
//    self.selectedFriModel
    UIImage *img  = nil;
    if (self.selectedFriModel.userMessageVO.msgImg.length > 0) {
            img = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:self.selectedFriModel.userMessageVO.msgImg];
    }
    [UMSocialSnsService presentSnsIconSheetView:self
                                         appKey:UmengAppkey
                                      shareText:self.selectedFriModel.userMessageVO.msgContent
                                     shareImage:img
                                shareToSnsNames:@[UMShareToWechatSession,UMShareToWechatTimeline,UMShareToQzone,UMShareToSina] delegate:self];

}
//////删除状态了
- (void)delBtnAction
{
    NSLog(@"删除消息");
    ////////////////////////////////取消关注好友
    
    [self showHud];
    NSMutableDictionary *parametersDic = [NSMutableDictionary dictionary];
    [parametersDic setObject:[[FNDataKeeper sharedInstance] getUserId] forKey:URL_DATA_K_USER_ID];
    [parametersDic setObject:self.selectedFriModel.userMessageVO.uid forKey:URL_DATA_K_MSGID];
    __unsafe_unretained CircleMainViewController *weakSelf = self;
    [[NetworkManager shareManager] requestParams:parametersDic withModule:MODELS_MODEL_PARTYMANAGER method:MODELS_METHOD_DEL_MYACTIVITY finishBlock:^(DataServies *request, id result) {
        
        NSString *msg = [result objectForKey:@"msg"];
        if ([[result objectForKey:@"flag"] integerValue] == 1) {
            for (FriendActivityModel * fActivity in friend_activity_list) {
                if ([[NSString stringWithFormat:@"%@",fActivity.userMessageVO.uid] isEqualToString:[NSString stringWithFormat:@"%@",weakSelf.selectedFriModel.userMessageVO.uid]]) {
                    [friend_activity_list removeObject:fActivity];
                    break;
                }
            }

        }else{
            NSLog(@"%@",msg);
        }
        [self dismissBtn];
        [_tableView reloadData];
        [weakSelf hideHud];
        
    } failBlock:^(DataServies *request, NSError *error) {
        
        [weakSelf hideHud];
    }];
    //    UIGestureRecognizer
    
}

- (BOOL)closeOauthWebViewController:(UINavigationController *)navigationCtroller socialControllerService:(UMSocialControllerService *)socialControllerService
{
    NSLog(@"%@",navigationCtroller);
    return YES;
}
- (void)didCloseUIViewController:(UMSViewControllerType)fromViewControllerType
{
    NSLog(@"%d",fromViewControllerType);
}

- (void)didFinishGetUMSocialDataInViewController:(UMSocialResponseEntity *)response
{
    if(response.responseCode == UMSResponseCodeSuccess)
    {
        //得到分享到的微博平台名
        NSLog(@"share to sns name is %@",[[response.data allKeys] objectAtIndex:0]);
    }
//    NSLog(@"%@",response);
}

- (void)didSelectSocialPlatform:(NSString *)platformName withSocialData:(UMSocialData *)socialData
{
    NSLog(@"%@...%@",socialData,platformName);
}

- (BOOL)isDirectShareInIconActionSheet
{
    return YES;
}


#pragma mark -
#pragma mark UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return friend_activity_list.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    static NSString *identifier = @"FriendActivityCell";
    FriendActivityCell *cell = (FriendActivityCell *)[tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[FriendActivityCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    cell.delegate =self;
    cell.activity = friend_activity_list[indexPath.row];
//    [cell refreshUI];
    
    return cell;

}

#pragma mark -
#pragma mark UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    FriendActivityModel *model = (FriendActivityModel *)friend_activity_list[indexPath.row];
    return [FriendActivityCell getCellHeightWithModel:model.userMessageVO];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //当手指离开某行时，就让某行的选中状态消失
    StatusCommentViewController *statusCommentCtrl = [[StatusCommentViewController alloc] init];
    statusCommentCtrl.hidesBottomBarWhenPushed = YES;
    statusCommentCtrl.selectedModel =  friend_activity_list[indexPath.row];;
    [self.navigationController pushViewController:statusCommentCtrl animated:YES];

    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark cell的复制功能实现

- (BOOL)tableView:(UITableView *)tableView shouldShowMenuForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (BOOL)tableView:(UITableView *)tableView canPerformAction:(SEL)action forRowAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
    if (action == @selector(copy:)) {
        return YES;
    }
    return NO;
}
- (void)tableView:(UITableView *)tableView performAction:(SEL)action forRowAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
    if (action == @selector(copy:)) {
        FriendActivityModel *model = [friend_activity_list objectAtIndex:indexPath.row];
        [UIPasteboard generalPasteboard].string = model.userMessageVO.msgContent;
    }
}
-(id) headerViewForTableView
{
    UIImageView *headerBac = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, DIME_SCREEN_W, _px(322))];
    [headerBac setImage:[UIImage imageNamed:@"quan_main_bg"]];
    headerBac.userInteractionEnabled = YES;
    
    _headIcon = [[UIButton alloc]initWithFrame:CGRectMake(_px(34), _px(200), _px(92), _px(92))];
    [_headIcon setImage:[UIImage imageNamed:@"quan_icon_default"] forState:UIControlStateNormal];
    [_headIcon addTarget:self action:@selector(_headIconAction) forControlEvents:UIControlEventTouchUpInside];
    [CommonUtils generateRoundButton:_headIcon];
    [headerBac addSubview:_headIcon];
    
    _nickName = [[UILabel alloc]initWithFrame:CGRectMake(_px(144), _px(200), _px(180), _px(30))];
    _nickName.textColor = [UIColor blackColor];
    _nickName.text = @"昵称";
    _nickName.font = FONT_SIZE(14);
    [headerBac addSubview:_nickName];
    
    _announceView = [[UILabel alloc]initWithFrame:CGRectMake(_px(144),_nickName.bottom, _px(200), _px(80))];
    _announceView.textColor = [UIColor grayColor];
    _announceView.backgroundColor = [UIColor clearColor];
    _announceView.text = @"减肥宣言";
    _announceView.numberOfLines = 2;
    _announceView.font = FONT_SIZE(11);
    [headerBac addSubview:_announceView];
    
    return headerBac;
}

-(UIView *)footerViewForTableView
{
    _footerButton =[[UIButton alloc]initWithFrame:CGRectMake(0, 0, DIME_SCREEN_W, _px(90))];
    [_footerButton setTitle:@"点击加载更多" forState:UIControlStateNormal];
    _footerButton.titleLabel.font = FONT_SIZE(16);
    [_footerButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [_footerButton setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
    [_footerButton setHidden:YES];
    [_footerButton addTarget:self action:@selector(onFooterViewClicked) forControlEvents:UIControlEventTouchUpInside];
    return _footerButton;
}
- (void)_headIconAction
{
    CircleMainViewController *controller = [[CircleMainViewController alloc] init];
    controller.userId = self.userId;
    controller.hidesBottomBarWhenPushed = YES;
    controller.isLookOther = YES;
    controller.userImgPath = self.userImgPath;
    controller.userName = _nickName.text;
    controller.increamFatTip = _announceView.text;

    [self.navigationController pushViewController:controller animated:YES];
}
//点击加载更多
-(void)onFooterViewClicked
{
    [_footerButton setTitle:@"加载中..." forState:UIControlStateNormal];
    [self queryMoreFriendsStatus];
}

//添加左上和右上的按钮
-(void) adTitleMenu
{
    if(!self.isLookOther){
        UIButton *rbutton =[[UIButton alloc]initWithFrame:CGRectMake(0, 0,_px(100), _px(32))];
        [rbutton addTarget:self action:@selector(onSendMsg) forControlEvents:UIControlEventTouchUpInside];
        [rbutton setTitle:@"发状态" forState:UIControlStateNormal];
        rbutton.titleLabel.font = FONT_SIZE(15);
        [rbutton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [rbutton setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
        UIBarButtonItem *msgar = [[UIBarButtonItem alloc]initWithCustomView:rbutton];
        [self.navigationItem setRightBarButtonItem:msgar];
    }
    UIButton *lbutton =[[UIButton alloc]initWithFrame:CGRectMake(0, 0, _px(100), _px(32))];
    [lbutton addTarget:self action:@selector(onAddFrends:) forControlEvents:UIControlEventTouchUpInside];
    if(!self.isLookOther){
        [lbutton setTitle:@"加好友" forState:UIControlStateNormal];
    }else{
        [lbutton setTitle:@"《返回" forState:UIControlStateNormal];
    }
    lbutton.titleLabel.font = FONT_SIZE(15);
    [lbutton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [lbutton setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    UIBarButtonItem *frendar = [[UIBarButtonItem alloc]initWithCustomView:lbutton];
    [self.navigationItem setLeftBarButtonItem:frendar];
    
    
}
//发状态
-(void) onSendMsg
{
    SendStatusViewController *controller = [[SendStatusViewController alloc]init];
   __unsafe_unretained CircleMainViewController *weakSelf = self;
    controller.sendMsgSuccessBlock = ^(){
        [weakSelf queryFriendsStatus];
    };
    controller.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:controller animated:YES];
}
//添加好友
-(void) onAddFrends:(UIButton *)sender
{
    if ([sender.titleLabel.text isEqualToString:@"加好友"]) {
        AddFriendViewController *controller = [[AddFriendViewController alloc]init];
        controller.addFriend = YES;
        controller.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:controller animated:YES];
    }else{
        [self.navigationController popViewControllerAnimated:YES];
    }
}

#pragma mark -
#pragma mark Data Source Loading / Reloading Methods

- (void)reloadTableViewDataSource{
	
	//  should be calling your tableviews data source model to reload
	//  put here just for demo
    
    [self queryFriendsStatus];
    
	_reloading = YES;
	
}

- (void)doneLoadingTableViewData{
	
	//  model should call this when its done loading
	_reloading = NO;
	[_refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:_tableView];
    
}


#pragma mark -
#pragma mark UIScrollViewDelegate Methods

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
	
	[_refreshHeaderView egoRefreshScrollViewDidScroll:scrollView];
    
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
	
	[_refreshHeaderView egoRefreshScrollViewDidEndDragging:scrollView];
	
}


#pragma mark -
#pragma mark EGORefreshTableHeaderDelegate Methods

- (void)egoRefreshTableHeaderDidTriggerRefresh:(EGORefreshTableHeaderView*)view{
	
	[self reloadTableViewDataSource];
//	[self performSelector:@selector(doneLoadingTableViewData) withObject:nil afterDelay:3.0];
	
}

- (BOOL)egoRefreshTableHeaderDataSourceIsLoading:(EGORefreshTableHeaderView*)view{
	
	return _reloading; // should return if data source model is reloading
	
}

- (NSDate*)egoRefreshTableHeaderDataSourceLastUpdated:(EGORefreshTableHeaderView*)view{
	
	return [NSDate date]; // should return date data source was last changed
	
}



@end
