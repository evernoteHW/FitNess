//
//  FoodListViewController.m
//  FitNess
//
//  Created by WeiHu on 14/10/23.
//  Copyright (c) 2014年 WeiHu. All rights reserved.
//

#import "FoodListViewController.h"
#import "FoodInfoModel.h"
#import "SportCommonModel.h"
#import "FoodDetailViewController.h"
#import "FoodMenuModel.h"
#import "FoodPubSearch.h"

@interface FoodListViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITextField *searcTF;
    
}

@property (nonatomic, strong) UITableView *foodListTableView;
@property (nonatomic, strong) NSMutableArray *foodListArray;


@end

@implementation FoodListViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.sportType = @"";
        _foodListArray = [NSMutableArray array];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"食物库";
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"quan_bg"]]];
    [self.view addSubview:self.foodListTableView];
    [self requstFoodListData];
//    [self requestCollectionData];
    
    
    
    UIButton *button =[[UIButton alloc]initWithFrame:CGRectMake(0, 0, _px(90), _px(40))];
    [button setTitle:@"搜索" forState:UIControlStateNormal];
    button.titleLabel.font = FONT_SIZE(_px(30));
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(onSearchButton) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *settBar = [[UIBarButtonItem alloc]initWithCustomView:button];
    [self.navigationItem setRightBarButtonItem:settBar];
}

- (void)onSearchButton
{
    FoodPubSearch *searchContro = [[FoodPubSearch alloc]init];
    [self.navigationController pushViewController:searchContro animated:YES];
}

- (UITableView *)foodListTableView
{
    if (_foodListTableView == nil) {
        _foodListTableView = [[UITableView alloc] initWithFrame:CGRectMake(0,0, DIME_SCREEN_W, DIME_SCREEN_H - 64) style:UITableViewStylePlain];
        _foodListTableView.rowHeight = 70;
        _foodListTableView.backgroundColor = [UIColor clearColor];
        _foodListTableView.dataSource = self;
        _foodListTableView.delegate = self;
        _foodListTableView.tableFooterView = [self footerViewForTableView];
    }
    return _foodListTableView;
}

-(UIButton *)footerViewForTableView
{
    UIButton *btn =[[UIButton alloc]initWithFrame:CGRectMake(0, 0, DIME_SCREEN_W, _px(90))];
    [btn setTitle:@"点击加载更多" forState:UIControlStateNormal];
    btn.titleLabel.font = FONT_SIZE(16);
    [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
    [btn addTarget:self action:@selector(requstFoodListData) forControlEvents:UIControlEventTouchUpInside];
    return btn;
}


#pragma mark UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _foodListArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *identifier = @"Col_UITableViewCell";
    UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.separatorInset = UIEdgeInsetsMake(0, 20, 0, 20);
        cell.backgroundColor = [UIColor clearColor];
        cell.contentView.backgroundColor = [UIColor clearColor];
        
        UIView *whiteBgView= [[UIView alloc]initWithFrame:CGRectMake(10, 0, DIME_SCREEN_W - 20, 70)];
        whiteBgView.backgroundColor = [UIColor whiteColor];
        [cell.contentView addSubview:whiteBgView];
        
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
        
        UIImageView *arr = [[UIImageView alloc]initWithFrame:CGRectMake(DIME_SCREEN_W-_DIME_LEFT - _px(40), _px(50), _px(22), _px(40))];
        [arr setImage:[UIImage imageNamed:@"arrow"]];
        arr.tag = 102;
        [ cell.contentView  addSubview:arr];
        
        UILabel *title_v2 =[[UILabel alloc]initWithFrame:CGRectMake(_DIME_LEFT + _px(172),38, _px(360), 20)];
        [title_v2 setFont:[UIFont systemFontOfSize:14.0f]];
        title_v2.textColor = [UIColor lightGrayColor];
        title_v2.tag = 103;
        [cell.contentView  addSubview:title_v2];
        
    }
    
    switch ([self.itemType integerValue]) {
        case 1:
        {
    
            FoodInfoModel *foodModel =  _foodListArray[indexPath.row];
            UIImageView *colFoodIcon = (UIImageView *)[cell.contentView viewWithTag:100];
            [colFoodIcon sd_setImageWithURL:[NSURL URLWithString:foodModel.imgPath] placeholderImage:[UIImage imageNamed:@"quan_list_img"]];
            
            UILabel *title_v = (UILabel *)[cell.contentView viewWithTag:101];
            title_v.text = foodModel.foodName;
            
            UILabel *title_v2 = (UILabel *)[cell.contentView viewWithTag:103];
            title_v2.text = foodModel.heatNum;
        }
            break;
        case 2:
        {
    
            SportCommonModel *sportModel =  _foodListArray[indexPath.row];
            UIImageView *colFoodIcon = (UIImageView *)[cell.contentView viewWithTag:100];
            [colFoodIcon sd_setImageWithURL:[NSURL URLWithString:sportModel.sportImgPath] placeholderImage:[UIImage imageNamed:@"quan_list_img"]];
            
            UILabel *title_v = (UILabel *)[cell.contentView viewWithTag:101];
            title_v.text = sportModel.sportName;
        }
            break;
        case 3:
        {
            FoodMenuModel *sportModel =  _foodListArray[indexPath.row];
            UIImageView *colFoodIcon = (UIImageView *)[cell.contentView viewWithTag:100];
            [colFoodIcon sd_setImageWithURL:[NSURL URLWithString:sportModel.menuImgPath] placeholderImage:[UIImage imageNamed:@"quan_list_img"]];
            
            UILabel *title_v = (UILabel *)[cell.contentView viewWithTag:101];
            title_v.text = sportModel.menuName;
        }
            break;
    }

    
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    FoodDetailViewController *foodDetailCtrl = [[FoodDetailViewController alloc] init];
    
    switch ([self.itemType integerValue]) {
        case 1:
        {
            FoodInfoModel *foodInfoModel =  _foodListArray[indexPath.row];
            foodDetailCtrl.typeId = @"0";
            foodDetailCtrl.objId = foodInfoModel.foodId;
        }
            break;
        case 2:
        {
            
            SportCommonModel *sportCommonModel =  _foodListArray[indexPath.row];
            foodDetailCtrl.typeId = @"2";
            foodDetailCtrl.objId = sportCommonModel.fid;
        }
            break;
        case 3:
        {
            FoodMenuModel *foodMenuModel =  _foodListArray[indexPath.row];
            foodDetailCtrl.typeId = @"1";
            foodDetailCtrl.objId = foodMenuModel.menuId;
        }
            break;
    }

    [self.navigationController pushViewController:foodDetailCtrl animated:YES];
}

#pragma mark 请求收藏的东西

#pragma mark 获取食物或者食谱列表

- (void)requstFoodListData
{
    ////////////////////////////////取消关注好友
    
    [self showHud];
    NSMutableDictionary *parametersDic = [NSMutableDictionary dictionary];
    [parametersDic setObject:[[FNDataKeeper sharedInstance] getUserId] forKey:URL_DATA_K_USER_ID];
    NSString *method= @"";
    switch ([self.itemType integerValue]) {
        case 1:
        {
            //食物分类
            method = MODELS_METHOD_QRYFOODSDETAILLIST;
            [parametersDic setObject:self.sportType forKey:URL_DATA_K_FOODTYPE];
        }
            break;
        case 2:
        {
            //运动分类
            method = MODELS_METHOD_QRY_SPORTS_DETAIL_LIST;
            [parametersDic setObject:self.sportType forKey:@"sportType"];
            
        }
            break;
        case 3:
        {
            //食谱分类
            method = MODELS_METHOD_COOK_BOOK_DETAIL_LIST;
            [parametersDic setObject:self.sportType forKey:@"menuType"];
            
        }
            break;
    }
    
    [parametersDic setObject:@(self.foodListArray.count) forKey:URL_DATA_K_INDEX];
    [parametersDic setObject:@"10" forKey:@"number"];
    
    __unsafe_unretained FoodListViewController *weakSelf = self;
    [[NetworkManager shareManager] requestParams:parametersDic withModule:MODELS_MODEL_TOOLLOOKSURFACE method:method finishBlock:^(DataServies *request, id result) {
        
        NSString *msg = [result objectForKey:@"msg"];
        if ([[result objectForKey:@"flag"] integerValue] == 1) {
            NSArray *arr = [result objectForKey:@"retDataArray"];
            switch ([self.itemType integerValue]) {
                case 1:
                {
                    for (NSDictionary *dic in arr) {
                        FoodInfoModel *foodInfoModel = [[FoodInfoModel alloc]initWithDictionary:dic];
                        [weakSelf.foodListArray addObject:foodInfoModel];
                    }
                }
                    break;
                case 2:
                {
                    for (NSDictionary *dic in arr) {
                        SportCommonModel *sportCommonModel = [[SportCommonModel alloc]initWithDictionary:dic];
                        [weakSelf.foodListArray addObject:sportCommonModel];
                    }
                }
                    break;
                case 3:
                {
                    for (NSDictionary *dic in arr) {
                        FoodMenuModel *sportCommonModel = [[FoodMenuModel alloc]initWithDictionary:dic];
                        [weakSelf.foodListArray addObject:sportCommonModel];
                    }
                }
                    break;
            }
      
            [weakSelf.foodListTableView reloadData];
        }else{
            NSLog(@"%@",msg);
        }
        [weakSelf hideHud];
        
    } failBlock:^(DataServies *request, NSError *error) {
        
        [weakSelf hideHud];
    }];
    //    UIGestureRecognizer
}


@end
