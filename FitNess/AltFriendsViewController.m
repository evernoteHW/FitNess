//
//  AltFriendsViewController.m
//  FitNess
//
//  Created by WeiHu on 14/10/19.
//  Copyright (c) 2014年 WeiHu. All rights reserved.
//

#import "AltFriendsViewController.h"

@implementation AltFriendsCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.altFriHeadImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bac_long_btn"]];
        self.altFriHeadImageView.frame = CGRectMake(5, 5, 60, 60);
        self.altFriHeadImageView.tag = 99;
        self.altFriHeadImageView.backgroundColor = [UIColor clearColor];
        //        [CommonUtils generateRoundButton:altFriHeadImageView];
        [self.contentView addSubview:self.altFriHeadImageView];
        self.separatorInset = UIEdgeInsetsZero;
        
        self.altFriLabel= [[UILabel alloc]initWithFrame:CGRectMake(self.altFriHeadImageView.right + 5, 15, 160,40)];
        self.altFriLabel.text = @"名字";
        self.altFriLabel.backgroundColor = [UIColor clearColor];
        self.altFriLabel.font = [UIFont systemFontOfSize:14.0f];
        self.altFriLabel.tag = 100;
        [self.contentView addSubview:self.altFriLabel];
        
        self.boxImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"motion_img_02"]];
        self.boxImageView.frame = CGRectMake(self.right - 65, 15, 40, 40);
        self.boxImageView.tag = 101;
        self.boxImageView.backgroundColor = [UIColor clearColor];
        self.boxImageView.userInteractionEnabled = YES;
        [self.contentView addSubview:self.boxImageView];
        
        
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectFriArray)];
        tapGesture.numberOfTapsRequired = 1;
        [self.boxImageView addGestureRecognizer:tapGesture];
        
        self.tickOffImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"motion_img_03"]];
        self.tickOffImageView .frame = self.boxImageView.bounds;
        self.tickOffImageView .hidden = YES;
        self.tickOffImageView .backgroundColor = [UIColor clearColor];
        [self.boxImageView addSubview:self.tickOffImageView ];

    }
    return self;
}
- (void)selectFriArray
{
    if (self.altFriendBlock) {
        self.altFriendBlock(self);
    }
}

- (void)setModel:(UserModel *)model
{
    if (_model != model) {
        _model = model;
        [self.altFriHeadImageView sd_setImageWithURL:[NSURL URLWithString:model.userImgPath] placeholderImage:[UIImage imageNamed:@"quan_icon_default"]];
        self.altFriLabel.text = model.userName;
    }
}


@end

@interface AltFriendsViewController ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>
{
    UITextField *searcTF;
    
}
@property (nonatomic, strong) UITableView *altFriendsTablView;
@property (nonatomic, strong) NSMutableArray *altFriendsArray;
@property (nonatomic, strong) NSMutableArray *selectedFriArray;
@end

@implementation AltFriendsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _altFriendsArray = [NSMutableArray array];
        _selectedFriArray = [NSMutableArray array];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"quan_bg"]]];
    [self adTitleMenu];
    [self.view addSubview:self.altFriendsTablView];

    UIButton *tableFootView = [UIButton buttonWithType:UIButtonTypeCustom];
    tableFootView.frame = CGRectMake(40, DIME_SCREEN_H - 49 - 20 - 64, 240, 40);
    [tableFootView setTitle:@"确定" forState:UIControlStateNormal];
    [tableFootView setBackgroundImage:[UIImage imageNamed:@"bmi_btn"] forState:UIControlStateNormal];
    [tableFootView addTarget:self action:@selector(tableFootViewAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:tableFootView];
    
    [self queryMoreFriendsStatus];
}


//添加左上和右上的按钮
-(void) adTitleMenu
{
    searcTF = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, 220, 40)];
    searcTF.delegate = self;
    searcTF.returnKeyType = UIReturnKeySearch;
    searcTF.placeholder = @"输入昵称查找小伙伴";
    searcTF.backgroundColor=[UIColor clearColor];
    searcTF.font = [UIFont systemFontOfSize:15.0f];
    searcTF.textColor = [UIColor whiteColor];
    self.navigationItem.titleView = searcTF;
   
    
    UIButton *lbutton =[[UIButton alloc]initWithFrame:CGRectMake(0, 0, _px(100), _px(32))];
    [lbutton addTarget:self action:@selector(cancelSearch) forControlEvents:UIControlEventTouchUpInside];
    [lbutton setTitle:@"取消" forState:UIControlStateNormal];
    lbutton.titleLabel.font = [UIFont boldSystemFontOfSize:15.0f];
    [lbutton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [lbutton setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    UIBarButtonItem *frendar = [[UIBarButtonItem alloc]initWithCustomView:lbutton];
    [self.navigationItem setLeftBarButtonItem:frendar];
    
    
    UIButton *rbutton =[[UIButton alloc]initWithFrame:CGRectMake(0, 0,_px(100), _px(32))];
    [rbutton addTarget:self action:@selector(clickToSearch) forControlEvents:UIControlEventTouchUpInside];
    [rbutton setTitle:@"搜索" forState:UIControlStateNormal];
    rbutton.titleLabel.font = [UIFont boldSystemFontOfSize:15.0f];
    [rbutton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [rbutton setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    UIBarButtonItem *msgar = [[UIBarButtonItem alloc]initWithCustomView:rbutton];
    [self.navigationItem setRightBarButtonItem:msgar];

}

- (void)tableFootViewAction{
    //回传值
    if (self.sendStatusBlock ) {
        //所有的名字加上@
        NSMutableArray *strArr = [NSMutableArray array];
        for (UserModel *model in _selectedFriArray) {
            NSString *str = [NSString stringWithFormat:@"@%@",model.userName];
            [strArr addObject:str];
        }
        self.sendStatusBlock (strArr);
    }
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)cancelSearch
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)clickToSearch
{
    NSLog(@"搜索");
    
    [self.senceDataManager.params removeAllObjects];
    [self.senceDataManager.params setObject:[[FNDataKeeper sharedInstance] getUserId] forKey:URL_DATA_K_USER_ID];
    [self.senceDataManager.params setObject:@"admin" forKey:URL_DATA_K_USERNAME];
    __unsafe_unretained AltFriendsViewController *weakSelf = self;
    [self.senceDataManager fetchDataWithModule:MODELS_MODEL_USERREGISTRY method:MODELS_METHOD_QRY_FRIEND_LIST params:self.senceDataManager.params successListener:^(NSDictionary *result,NSString *msg){
        
        NSArray *arr = [result objectForKey:@"data"];
        for (int i = 0 ; i<arr.count ; i++) {
            UserModel * fActivity = [[UserModel alloc] initWithDictionary:[arr objectAtIndex:i]];
            
            [weakSelf.altFriendsArray addObject:fActivity];
        }
        [weakSelf.altFriendsTablView reloadData];
        
        
    } failedListener:^(NSString *msg){
        
    } timeOutListener:^{
        
    }];

    
    [searcTF resignFirstResponder];
}

#pragma mark UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self clickToSearch];
    
    return YES;
}

- (UITableView *)altFriendsTablView
{
    if (_altFriendsTablView == nil) {
        _altFriendsTablView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, DIME_SCREEN_W, DIME_SCREEN_H - 49 - 64) style:UITableViewStylePlain];
        _altFriendsTablView.rowHeight = 70;
        _altFriendsTablView.backgroundColor = [UIColor clearColor];
        _altFriendsTablView.dataSource = self;
        _altFriendsTablView.delegate = self;
        _altFriendsTablView.tableFooterView = [UIView new];
    }
    return _altFriendsTablView;
}

#pragma mark UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _altFriendsArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *identifier = @"AltFriendsCell";
    AltFriendsCell *cell = (AltFriendsCell *)[tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[AltFriendsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        if (!cell.altFriendBlock) {
            __unsafe_unretained AltFriendsViewController *weakSelf = self;
            cell.altFriendBlock = ^(AltFriendsCell *cell){
                if ([weakSelf.selectedFriArray containsObject:cell.model]) {
                    [weakSelf.selectedFriArray removeObject:cell.model];
                }else{
                    [weakSelf.selectedFriArray addObject:cell.model];
                }
                [weakSelf.altFriendsTablView reloadData];
            };
        }
    }
    
    cell.model = _altFriendsArray[indexPath.row];
    if ([_selectedFriArray containsObject:cell.model]) {
        cell.tickOffImageView.hidden = NO;
    }else{
        cell.tickOffImageView.hidden = YES;
    }
    return cell;
    
}


#pragma mark  获取好友列表

-(void)queryMoreFriendsStatus
{
    [self.senceDataManager.params removeAllObjects];
    [self.senceDataManager.params setObject:[[FNDataKeeper sharedInstance] getUserId] forKey:URL_DATA_K_USER_ID];
    __unsafe_unretained AltFriendsViewController *weakSelf = self;
    [self.senceDataManager fetchDataWithModule:MODELS_MODEL_CHECK_MODULE2 method:MODELS_METHOD_QRY_FRIEND_LIST params:self.senceDataManager.params successListener:^(NSDictionary *result,NSString *msg){
        
        NSArray *arr = [result objectForKey:@"data"];
        for (int i = 0 ; i<arr.count ; i++) {
            UserModel * fActivity = [[UserModel alloc] initWithDictionary:[arr objectAtIndex:i]];

            [weakSelf.altFriendsArray addObject:fActivity];
        }
        [weakSelf.altFriendsTablView reloadData];

        
    } failedListener:^(NSString *msg){
        
    } timeOutListener:^{

    }];
}
- (void)dealloc
{
    NSLog(@"%s",__FUNCTION__);
}


@end
