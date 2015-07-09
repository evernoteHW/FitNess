//
//  AddFriendViewController.m
//  FitNess
//
//  Created by WeiHu on 14/10/19.
//  Copyright (c) 2014年 WeiHu. All rights reserved.
//

#import "AddFriendViewController.h"

@implementation AddFriendsCell

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
        
        self.addAttentionBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.addAttentionBtn setBackgroundImage:[UIImage imageNamed:@"bmi_btn"] forState:UIControlStateNormal];
        self.addAttentionBtn.frame = CGRectMake(self.right - 105, 15, 100, 40);
        self.addAttentionBtn.tag = 101;
        self.addAttentionBtn.backgroundColor = [UIColor clearColor];
        self.addAttentionBtn.userInteractionEnabled = YES;
        [self.addAttentionBtn addTarget:self action:@selector(selectFriArray) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:self.addAttentionBtn];
        
        
    }
    return self;
}
- (void)selectFriArray
{
    if (self.addFriendBlock) {
        self.addFriendBlock(self);
    }
}

- (void)setModel:(UserModel *)model
{
        _model = model;
    if (self.addFriend) {
        if ([model.remark integerValue] == 1) {
            [self.addAttentionBtn setTitle:@"取消关注" forState:UIControlStateNormal];
        }else{
            [self.addAttentionBtn setTitle:@"加关注" forState:UIControlStateNormal];
        }
    }else{
            [self.addAttentionBtn setTitle:@"删除好友" forState:UIControlStateNormal];
    }
    [self.altFriHeadImageView sd_setImageWithURL:[NSURL URLWithString:model.userImgPath] placeholderImage:[UIImage imageNamed:@"quan_icon_default"]];
    self.altFriLabel.text = model.userName;
}
@end

@interface AddFriendViewController ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>
{
    UITextField *searcTF;
    
}

@property (nonatomic, strong) UITableView *addFriendsTablView;
@property (nonatomic, strong) NSMutableArray *addFriendsArray;
@property (nonatomic, strong) NSMutableArray *selectedFriArray;

@end

@implementation AddFriendViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _addFriendsArray = [NSMutableArray array];
        _selectedFriArray = [NSMutableArray array];


    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"quan_bg"]]];
    [self adTitleMenu];
    [self.view addSubview:self.addFriendsTablView];
    [self setUpForDismissKeyboard];
    if (self.addFriend) {
        [self queryAddFriendsStatus:@""];
    }else{
        [self queryAttentionFriends];
    }
    
//    self.view.userInteractionEnabled = YES;
}


- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

//添加左上和右上的按钮
-(void) adTitleMenu
{
    if (self.addFriend) {
        searcTF = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, 220, 40)];
        searcTF.delegate = self;
        searcTF.returnKeyType = UIReturnKeySearch;
        searcTF.placeholder = @"输入昵称查找小伙伴";
        searcTF.backgroundColor=[UIColor clearColor];
        searcTF.font = [UIFont systemFontOfSize:15.0f];
        searcTF.textColor = [UIColor whiteColor];
        self.navigationItem.titleView = searcTF;
        
        UIButton *rbutton =[[UIButton alloc]initWithFrame:CGRectMake(0, 0,_px(100), _px(32))];
        [rbutton addTarget:self action:@selector(clickToSearch) forControlEvents:UIControlEventTouchUpInside];
        [rbutton setTitle:@"搜索" forState:UIControlStateNormal];
        rbutton.titleLabel.font = [UIFont boldSystemFontOfSize:15.0f];
        [rbutton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [rbutton setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
        UIBarButtonItem *msgar = [[UIBarButtonItem alloc]initWithCustomView:rbutton];
        [self.navigationItem setRightBarButtonItem:msgar];
    }
    UIButton *lbutton =[[UIButton alloc]initWithFrame:CGRectMake(0, 0, _px(100), _px(32))];
    [lbutton addTarget:self action:@selector(cancelSearch) forControlEvents:UIControlEventTouchUpInside];
    [lbutton setTitle:@"取消" forState:UIControlStateNormal];
    lbutton.titleLabel.font = [UIFont boldSystemFontOfSize:15.0f];
    [lbutton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [lbutton setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    UIBarButtonItem *frendar = [[UIBarButtonItem alloc]initWithCustomView:lbutton];
    [self.navigationItem setLeftBarButtonItem:frendar];
 
    
}

- (void)cancelSearch
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)clickToSearch
{
    NSLog(@"搜索");
    [self queryAddFriendsStatus:searcTF.text];
    [searcTF resignFirstResponder];
}

#pragma mark UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self clickToSearch];
    
    return YES;
}



- (UITableView *)addFriendsTablView
{
    if (_addFriendsTablView == nil) {
        _addFriendsTablView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, DIME_SCREEN_W, DIME_SCREEN_H - 64) style:UITableViewStylePlain];
        _addFriendsTablView.rowHeight = 70;
        _addFriendsTablView.backgroundColor = [UIColor clearColor];
        _addFriendsTablView.dataSource = self;
        _addFriendsTablView.delegate = self;
        _addFriendsTablView.tableFooterView = [UIView new];
    }
    return _addFriendsTablView;
}

//////////////////////////

#pragma mark  查询好友列表数据

- (void)queryAddFriendsStatus:(NSString *)keyword
{
    [self showHud];
    NSMutableDictionary *parametersDic = [NSMutableDictionary dictionary];
    [parametersDic setObject:[[FNDataKeeper sharedInstance] getUserId] forKey:URL_DATA_K_USER_ID];
    [parametersDic setObject:keyword forKey:URL_DATA_K_USERNAME];    
    __unsafe_unretained AddFriendViewController *weakSelf = self;
    [[NetworkManager shareManager] requestParams:parametersDic withModule:MODELS_MODEL_USERREGISTRY method:MODELS_METHOD_GETUSERBYNAME finishBlock:^(DataServies *request, id result) {
        
        NSString *msg = [result objectForKey:@"msg"];
        if ([[result objectForKey:@"flag"] integerValue] == 1) {
            [weakSelf.addFriendsArray removeAllObjects];
            NSArray *arr = [result objectForKey:@"retDataArray"];
            for (int i = 0 ; i < arr.count ; i++) {
                UserModel * fActivity = [[UserModel alloc] initWithDictionary:[arr objectAtIndex:i]];
                [weakSelf.addFriendsArray addObject:fActivity];
            }
            [weakSelf.addFriendsTablView reloadData];
            
        }else{
            NSLog(@"%@",msg);
        }
        [weakSelf hideHud];
        
    } failBlock:^(DataServies *request, NSError *error) {
        
        [weakSelf hideHud];
    }];

}

//////////////////////////

#pragma mark  查询关注好友列表数据

- (void)queryAttentionFriends
{
    [self showHud];
    NSMutableDictionary *parametersDic = [NSMutableDictionary dictionary];
    [parametersDic setObject:[[FNDataKeeper sharedInstance] getUserId] forKey:URL_DATA_K_USER_ID];

    __unsafe_unretained AddFriendViewController *weakSelf = self;
    [[NetworkManager shareManager] requestParams:parametersDic withModule:MODELS_MODEL_MOREINFOMANAGER method:MODELS_METHOD_QRY_FRIEND_LIST finishBlock:^(DataServies *request, id result) {
        
        NSString *msg = [result objectForKey:@"msg"];
        if ([[result objectForKey:@"flag"] integerValue] == 1) {
            [weakSelf.addFriendsArray removeAllObjects];
            NSArray *arr = [result objectForKey:@"retDataArray"];
            for (int i = 0 ; i < arr.count ; i++) {
                UserModel * fActivity = [[UserModel alloc] initWithDictionary:[arr objectAtIndex:i]];
                [weakSelf.addFriendsArray addObject:fActivity];
            }
            [weakSelf.addFriendsTablView reloadData];
            
        }else{
            NSLog(@"%@",msg);
        }
        [weakSelf hideHud];
        
    } failBlock:^(DataServies *request, NSError *error) {
        
        [weakSelf hideHud];
    }];
    
}

////////////////// 关注好友

#pragma mark 关注好友

- (void)addFriendAttentionStr:(UserModel *)model
{
    [self showHud];
    NSMutableDictionary *parametersDic = [NSMutableDictionary dictionary];
    [parametersDic setObject:[[FNDataKeeper sharedInstance] getUserId] forKey:URL_DATA_K_USER_ID];
    [parametersDic setObject:model.uid forKey:URL_DATA_K_RELATIONUSERIDS];
    
    __unsafe_unretained AddFriendViewController *weakSelf = self;
    [[NetworkManager shareManager] requestParams:parametersDic withModule:MODELS_MODEL_USERREGISTRY method:MODELS_METHOD_SAVEUSERRELATION finishBlock:^(DataServies *request, id result) {
        
        NSString *msg = [result objectForKey:@"msg"];
        if ([[result objectForKey:@"flag"] integerValue] == 1) {
//            model.remark = @"1";
            [weakSelf.addFriendsArray removeObject:model];
            [weakSelf.addFriendsTablView reloadData];
            [[TKAlertCenter defaultCenter] postAlertWithMessage:@"关注成功"];
//            [weakSelf.navigationController popToRootViewControllerAnimated:YES];
        }else{
            NSLog(@"%@",msg);
        }
        [weakSelf hideHud];
        
    } failBlock:^(DataServies *request, NSError *error) {
        
        [weakSelf hideHud];
    }];

}

////////////////////////////////取消关注好友

#pragma  mark 取消关注好友

- (void)deleteFriendAttentionStr:(UserModel *)model
{
    [self showHud];
    NSMutableDictionary *parametersDic = [NSMutableDictionary dictionary];
    [parametersDic setObject:[[FNDataKeeper sharedInstance] getUserId] forKey:URL_DATA_K_USER_ID];
    [parametersDic setObject:model.uid forKey:URL_DATA_K_MUSERID];
    __unsafe_unretained AddFriendViewController *weakSelf = self;
    [[NetworkManager shareManager] requestParams:parametersDic withModule:MODELS_MODEL_USERREGISTRY method:MODELS_METHOD_DELFRIENDSBYUSERIDANDMUSERID finishBlock:^(DataServies *request, id result) {
        
        NSString *msg = [result objectForKey:@"msg"];
        if ([[result objectForKey:@"flag"] integerValue] == 1) {
//            model.remark = @"0";
            [weakSelf.addFriendsArray removeObject:model];
            [weakSelf.addFriendsTablView reloadData];
            [[TKAlertCenter defaultCenter] postAlertWithMessage:@"删除好友成功"];
//            [weakSelf.navigationController popToRootViewControllerAnimated:YES];
        }else{
            NSLog(@"%@",msg);
        }
        [weakSelf hideHud];
        
    } failBlock:^(DataServies *request, NSError *error) {
        
        [weakSelf hideHud];
    }];
}


#pragma mark UITableViewDataSource


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _addFriendsArray.count;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *identifier = @"AltFriendsCell";
    AddFriendsCell *cell = (AddFriendsCell *)[tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[AddFriendsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        if (!cell.addFriendBlock) {
            __unsafe_unretained AddFriendViewController *weakSelf = self;
            cell.addFriendBlock = ^(AddFriendsCell *cell){
                if (cell.addFriend) {
                    if ([cell.model.remark integerValue] != 1) {
                        [weakSelf addFriendAttentionStr:cell.model];
                    }else{
                        [weakSelf deleteFriendAttentionStr:cell.model];
                    }
                }else{
                    [weakSelf deleteFriendAttentionStr:cell.model];
                }
            };
        }
    }
    cell.addFriend = self.addFriend;
    cell.model = _addFriendsArray[indexPath.row];
    return cell;
    
}


- (void)setUpForDismissKeyboard {
    
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
//    [phoneNumber resignFirstResponder];
    [searcTF resignFirstResponder];
}

- (void)dealloc
{
    NSLog(@"%s",__FUNCTION__);
}


@end
