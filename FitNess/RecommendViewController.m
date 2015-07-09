//
//  RecommendViewController.m
//  FitNess
//
//  Created by WeiHu on 14/11/24.
//  Copyright (c) 2014年 WeiHu. All rights reserved.
//

#import "RecommendViewController.h"
#import "FNLoginController.h"
#import "FNNavigationViewController.h"
#import "YDAppDelegate.h"
#import "FNHomeTabBarController.h"

@interface RecommendViewController ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>
{
    NSMutableArray *seletedArr;
}
@property (nonatomic, strong) UITableView *addFriendsTablView;
@property (nonatomic, strong) NSMutableArray *addFriendsArray;
@property (nonatomic, strong) NSMutableArray *selectedFriArray;

@end

@implementation RecommendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"为你推荐";
    self.view.backgroundColor = [UIColor whiteColor];
    //    [[[self navigationController] navigationBar ]setHidden:NO];
    // Do any additional setup after loading the view.
    UIView *customNavBar = [[UIView alloc] initWithFrame:CGRectMake(0, 0, DIME_SCREEN_W, 64)];
    customNavBar.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bac_long_btn"]];
    [self.view addSubview:customNavBar];

    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(60, 24, 200, 30)];
    titleLabel.text = @"为你推荐";
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.font = [UIFont boldSystemFontOfSize:16.0f];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.textColor = [UIColor whiteColor];
    [customNavBar addSubview:titleLabel];
    
    //
    UIButton *leftBtn =[[UIButton alloc]initWithFrame:CGRectMake(16, 34,70, 16)];
    [leftBtn addTarget:self action:@selector(popToViewController) forControlEvents:UIControlEventTouchUpInside];
    [leftBtn setTitle:@"<< 上一步" forState:UIControlStateNormal];
    leftBtn.titleLabel.font = [UIFont boldSystemFontOfSize:13.0f];
    [leftBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [leftBtn setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    [customNavBar addSubview:leftBtn];
    
    UIButton *rightBtn =[[UIButton alloc]initWithFrame:CGRectMake(DIME_SCREEN_W - 16 - 70, 34, _px(140), _px(32))];
    [rightBtn setTitle:@"跳过 >>" forState:UIControlStateNormal];
    rightBtn.titleLabel.font = [UIFont boldSystemFontOfSize:13.0f];
    [rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [rightBtn setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    [rightBtn addTarget:self action:@selector(rightButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [customNavBar addSubview:rightBtn];

    [self.view addSubview:self.addFriendsTablView];
    
    UIButton *saveUserInfoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    saveUserInfoBtn.frame = CGRectMake(60, self.view.height - 60, 200, 40);
    [saveUserInfoBtn setTitle:@"+关注" forState:UIControlStateNormal];
    saveUserInfoBtn.titleLabel.font = [UIFont boldSystemFontOfSize:16.0f];
    saveUserInfoBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    [saveUserInfoBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [saveUserInfoBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    [saveUserInfoBtn addTarget:self action:@selector(changeUserInfo) forControlEvents:UIControlEventTouchUpInside];
    [saveUserInfoBtn setBackgroundImage:[UIImage imageNamed:@"bmi_btn"] forState:UIControlStateNormal];
    [self.view addSubview:saveUserInfoBtn];

    seletedArr = [NSMutableArray array];
    _addFriendsArray = [NSMutableArray array];
    [self requestRecommendFriData];
}

- (UITableView *)addFriendsTablView
{
    if (_addFriendsTablView == nil) {
        _addFriendsTablView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, DIME_SCREEN_W, DIME_SCREEN_H - 64 - 80) style:UITableViewStylePlain];
        _addFriendsTablView.rowHeight = 70;
        _addFriendsTablView.backgroundColor = [UIColor clearColor];
        _addFriendsTablView.dataSource = self;
        _addFriendsTablView.delegate = self;
        _addFriendsTablView.tableFooterView = [UIView new];
    }
    return _addFriendsTablView;
}

#pragma mark UITableViewDataSource


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _addFriendsArray.count;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *identifier = @"AltFriendsCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        
        
        UIImageView *colFoodIcon =[[UIImageView alloc]initWithFrame:CGRectMake(_DIME_LEFT+_px(16), 5 , _px(130), _px(120))];
        colFoodIcon.tag = 100;
        colFoodIcon.backgroundColor = [UIColor clearColor];
        [cell.contentView  addSubview:colFoodIcon];
        //
        UILabel *title_v =[[UILabel alloc]initWithFrame:CGRectMake(_DIME_LEFT + _px(172),10, _px(360), _px(80))];
        [title_v setFont:[UIFont systemFontOfSize:15.0f]];
        title_v.textColor = [UIColor blackColor];
        title_v.tag = 101;
        [cell.contentView  addSubview:title_v];
        
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(DIME_SCREEN_W-_DIME_LEFT - _px(60), _px(50), 20, 20)];
        imageView.tag = 102;
        [imageView setImage:[UIImage imageNamed:@"motion_img_02"]];
        [imageView setHighlightedImage:[UIImage imageNamed:@"motion_img_03"]];
        imageView.userInteractionEnabled = YES;
        [cell.contentView  addSubview:imageView];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(chooseAttention:)];
        [imageView addGestureRecognizer:tap];

        
        UILabel *title_v2 =[[UILabel alloc]initWithFrame:CGRectMake(_DIME_LEFT + _px(172),38, _px(360), 20)];
        [title_v2 setFont:[UIFont systemFontOfSize:14.0f]];
        title_v2.textColor = [UIColor lightGrayColor];
        title_v2.tag = 103;
        [cell.contentView  addSubview:title_v2];
    
    }

    UserModel *model = _addFriendsArray[indexPath.row];
    
    UIImageView *colFoodIcon = (UIImageView *)[cell.contentView viewWithTag:100];
    [colFoodIcon sd_setImageWithURL:[NSURL URLWithString:model.userImgPath] placeholderImage:[UIImage imageNamed:@"me_default_head_icon"]];
    
    UILabel *title_v = (UILabel *)[cell.contentView viewWithTag:101];
    title_v.text = model.userName;
    
    UILabel *title_v2 = (UILabel *)[cell.contentView viewWithTag:103];
    title_v2.text = [NSString stringWithFormat:@"BMI: %@",model.registyWeight];
   
    
    UIImageView *imageView = (UIImageView *)[cell.contentView viewWithTag:102];
    if([seletedArr containsObject:indexPath]){
        imageView.highlighted = YES;
    }else{
        imageView.highlighted = NO;
    };
    return cell;
    
}

- (void)changeUserInfo
{
    
    if (seletedArr.count > 0) {
        
    }else{
        [[TKAlertCenter defaultCenter] postAlertWithMessage:@"请选择好友"];
        return;
    }
    NSMutableDictionary *parametersDic = [NSMutableDictionary dictionary];
    [parametersDic setObject:[[FNDataKeeper sharedInstance] getUserId] forKey:@"rUserid"];
    [self showHud];
    NSMutableArray *tempArr = [NSMutableArray array];
    for (NSIndexPath *indexPath in seletedArr) {
        UserModel *model = _addFriendsArray[indexPath.row];
        [tempArr addObject:model.uid];
    }
    
    
    [parametersDic setObject:[tempArr componentsJoinedByString:@","] forKey:@"mUserIds"];
    __unsafe_unretained RecommendViewController *weakSelf = self;
    [[NetworkManager shareManager] requestParams:parametersDic withModule:MODELS_MODEL_USERREGISTRY method:MODELS_METHOD_SAVEUSERRELATION finishBlock:^(DataServies *request, id result) {
        
        NSString *msg = [result objectForKey:@"msg"];
        if ([[result objectForKey:@"flag"] integerValue] == 1) {
            
            FNHomeTabBarController *controler = [[FNHomeTabBarController alloc]init];
            [self.navigationController pushViewController:controler animated:YES];
            
        }else{
            NSLog(@"%@",msg);
        }
        [weakSelf hideHud];
        
    } failBlock:^(DataServies *request, NSError *error) {
        
        [weakSelf hideHud];
    }];
}

- (void)rightButtonAction
{
    FNHomeTabBarController *controler = [[FNHomeTabBarController alloc]init];
    [self.navigationController pushViewController:controler animated:YES];
}

- (void)chooseAttention:(UITapGestureRecognizer *)tap
{
    UITableViewCell *cell = (UITableViewCell *)tap.view.superview.superview;
    NSIndexPath *indexpath = [self.addFriendsTablView indexPathForCell:cell];
    UIImageView *imageView = (UIImageView *)[cell.contentView viewWithTag:102];
    if([seletedArr containsObject:indexpath]){
        [seletedArr removeObject:indexpath];
        imageView.highlighted = NO;
    }else{
        [seletedArr addObject:indexpath];
        imageView.highlighted = YES;
    };
    [self.addFriendsTablView reloadData];
}

- (void)requestRecommendFriData
{
    [self showHud];
    NSMutableDictionary *parametersDic = [NSMutableDictionary dictionary];
    [parametersDic setObject:[[FNDataKeeper sharedInstance] getUserId] forKey:URL_DATA_K_USER_ID];
    if (self.arr && self.arr.count > 0) {
        [parametersDic setObject:[self.arr componentsJoinedByString:@","] forKey:@"userTargets"];
    }else{
        [parametersDic setObject:@"1,2,3,4,5,6" forKey:@"userTargets"];
    }
    __unsafe_unretained RecommendViewController *weakSelf = self;
    [[NetworkManager shareManager] requestParams:parametersDic withModule:MODELS_MODEL_USERREGISTRY method:@"getFirendsByuserTarget" finishBlock:^(DataServies *request, id result) {
        
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
