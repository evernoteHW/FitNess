//
//  MotionFriendsController.m
//  FitNess
//
//  Created by liuguoyan on 14-10-12.
//  Copyright (c) 2014年 liuguoyan. All rights reserved.
//

#import "MotionFriendsController.h"
#import "MotionFriendCell.h"

@interface MotionFriendsController ()<UITableViewDataSource,UITableViewDelegate,MotionFriendCellDelegate>
{
    NSMutableArray *_motionFriends;
}
@end

@implementation MotionFriendsController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self createView];
    [self initData];
    [self setListeners];
}


-(void) createView
{
    
    self.navigationController.navigationBar.translucent = NO;
    self.tabBarController.tabBar.translucent = NO;
    self.navigationController.navigationBar.barTintColor = COLOR_NAVIGATIONBAR_UICOLOR ;
    [self.navigationItem setTitle:self.title];
    [self.view setBackgroundColor:R_COLOR_COMMON_BAC];
    [self.navigationItem setTitle:@"心情盟友"];
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(_DIME_LEFT, _px(20), _DIME_CONT_SIZE, DIME_SCREEN_H - TITLE_HEI)];
    [_tableView setDataSource:self];
    [_tableView setDelegate:self];
    _tableView.tableFooterView = [UIView new];
    _tableView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_tableView];
    
    [_tableView setTableHeaderView:[self generateHeaderView]];
    
}

#pragma mark - 
#pragma mark UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _motionFriends.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifer = @"MotionFriendCell";
    MotionFriendCell *cell = (MotionFriendCell *)[tableView dequeueReusableCellWithIdentifier:identifer];
    if (cell == nil) {
        cell = [[MotionFriendCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer];
    }
    cell.delegate =self;
    cell.user = _motionFriends[indexPath.row];
    [cell refreshUI];
    
    return cell;
}

#pragma mark -
#pragma mark UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return _px(310);
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark -
#pragma mark MotionFriendCellDelegate
-(void) onAttentionButtonWithUser:(UserModel *)user
{
    //添加关注
    if (user.remark.intValue != 1) {
        
        [self.senceDataManager.params removeAllObjects];
        [self.senceDataManager.params setObject:[[FNDataKeeper sharedInstance] getUserId] forKey:URL_DATA_K_USER_ID];
        [self.senceDataManager.params setObject:user.uid forKey:URL_DATA_K_RELATIONUSERIDS];
        [self.senceDataManager fetchDataWithModule:MODELS_MODEL_USERREGISTRY method:MODELS_METHOD_SAVEUSERRELATION params:self.senceDataManager.params successListener:^(NSDictionary *result,NSString *msg){
            [[TKAlertCenter defaultCenter]postAlertWithMessage:@"关注成功！"];
            user.remark = @"1";
            [_tableView reloadData];
        } failedListener:^(NSString *msg){
            
        } timeOutListener:^{
            
        }];
    }
    //取消关注
    else{
        
        [self.senceDataManager.params removeAllObjects];
        [self.senceDataManager.params setObject:[[FNDataKeeper sharedInstance] getUserId] forKey:URL_DATA_K_USER_ID];
        [self.senceDataManager.params setObject:user.uid forKey:URL_DATA_K_MUSERID];
        [self.senceDataManager fetchDataWithModule:MODELS_MODEL_USERREGISTRY method:MODELS_METHOD_DELFRIENDSBYUSERIDANDMUSERID params:self.senceDataManager.params successListener:^(NSDictionary *result,NSString *msg){
            [[TKAlertCenter defaultCenter]postAlertWithMessage:@"取消关注！"];
            user.remark = @"0";
            [_tableView reloadData];
        } failedListener:^(NSString *msg){
            
        } timeOutListener:^{
            
        }];
        
    }
}

-(void)queryMotionFriends
{
    
    [self.senceDataManager.params removeAllObjects];
    [self.senceDataManager.params setObject:[[FNDataKeeper sharedInstance] getUserId] forKey:URL_DATA_K_USER_ID];
    [self.senceDataManager fetchDataWithModule:MODELS_MODEL_USERINFOMANGER method:MODELS_METHOD_QRYHEARTSAMEUSER params:self.senceDataManager.params successListener:^(NSDictionary *result,NSString *msg){
        if (!_motionFriends) {
            _motionFriends =[NSMutableArray array];
        }
        NSArray *arr = [self.senceDataManager spliteResultArrayWithResult:result ];
        for (int i = 0 ; i<arr.count; i++) {
            UserModel *user = [UserModel modelWithDictionary:arr[i]];
            [_motionFriends addObject:user];
        }
        [_tableView reloadData];
    } failedListener:^(NSString *msg){
        
    } timeOutListener:^{
        
    }];
}


-(id)generateHeaderView
{
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(_px(20), 0, DIME_SCREEN_W, _px(530))];
    view.backgroundColor = [UIColor whiteColor];
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(_px(15), _px(10), _px(563), _px(383))];
    [imageView setImage:[UIImage imageNamed:@"friend_run_img"]];
    [view addSubview:imageView];
    UILabel *lable = [[UILabel alloc]initWithFrame:CGRectMake(_px(15), _px(400), imageView.frame.size.width, _px(130))];
    lable.textColor = [UIColor blackColor];
    lable.numberOfLines = 3;
    lable.text = @"当你面对美好的身材渴望远远大于你对食物的渴望,你就可以成功减肥.减不下来是因为你对美好的渴望还不够强烈!";
    lable.font = FONT_SIZE(14);
    [view addSubview:lable];
    
    return view;
}

-(void) initData
{
    [self queryMotionFriends];
}

-(void) setListeners
{
    
}


@end
