//
//  FoodPubController.m
//  FitNess
//
//  Created by liuguoyan on 14-10-15.
//  Copyright (c) 2014年 liuguoyan. All rights reserved.
//

#import "FoodPubController.h"
#import "FoodPubSearch.h"
#import "FoodListViewController.h"
#import "SportCommonModel.h"
#import "ColFoodModel.h"
#import "FoodDetailViewController.h"
#import "AFNetworking.h"

@interface FoodPubController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSArray *itemsArray;
}
@end

@implementation FoodPubController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(queryThirdClass) name:@"Food_Collection" object:nil];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
     [self.view setBackgroundColor:R_COLOR_COMMON_BAC];
    [self.navigationItem setTitle:((!self.isSport) ? @"食物库" : @"运动库")];
    
    if (self.isSport) {
        itemsArray = @[@"常用",@"分类",@"收藏"];
        [self querySportFirstClass];
    }else{
        [self queryFirstClass];
        itemsArray = @[@"食物分类",@"食谱分类",@"收藏"];
    }
    [self createFoodPublicView];
    
}

-(void)onSearchButton
{
    FoodPubSearch *searchContro = [[FoodPubSearch alloc]init];
//    [self.navigationController pushViewController:searchContro animated:YES];
    [self.navigationController pushViewController:searchContro animated:YES];
}

-(void) createFoodPublicView
{

    
    UIButton *button =[[UIButton alloc]initWithFrame:CGRectMake(0, 0, _px(90), _px(40))];
    [button setTitle:@"搜索" forState:UIControlStateNormal];
    button.titleLabel.font = FONT_SIZE(_px(30));
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(onSearchButton) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *settBar = [[UIBarButtonItem alloc]initWithCustomView:button];
    
    [self.navigationItem setRightBarButtonItem:settBar];
    
    
    _tabBack = [[UIView alloc]initWithFrame:CGRectMake(0, 0, DIME_SCREEN_W, _px(74))];
    [_tabBack setBackgroundColor:[UIColor colorWithHexString:@"D0D0D0"]];
    [self.view addSubview:_tabBack];
    
    _firstClass = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, DIME_SCREEN_W / 3.0, _tabBack.height)];
    [_firstClass setTitleColor:[UIColor colorWithHexString:@"FF6895"] forState:UIControlStateNormal];
    [_firstClass setTitle:itemsArray[0] forState:UIControlStateNormal];
    [_firstClass addTarget:self action:@selector(onFirstClass) forControlEvents:UIControlEventTouchUpInside];
    _firstClass.titleLabel.font = FONT_SIZE(14);
    [_tabBack addSubview:_firstClass];
    
    _secondClass = [[UIButton alloc]initWithFrame:CGRectMake(DIME_SCREEN_W / 3.0,0, DIME_SCREEN_W / 3.0, _tabBack.height)];
    [_secondClass setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_secondClass setTitle:itemsArray[1] forState:UIControlStateNormal];
    [_secondClass addTarget:self action:@selector(onSecondClass) forControlEvents:UIControlEventTouchUpInside];
    _secondClass.titleLabel.font = FONT_SIZE(14);
    [_tabBack addSubview:_secondClass];
    
    
    _thirdClass = [[UIButton alloc]initWithFrame:CGRectMake((DIME_SCREEN_W / 3.0)*2, 0, DIME_SCREEN_W / 3.0, _tabBack.height)];
    [_thirdClass setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_thirdClass setTitle:itemsArray[2] forState:UIControlStateNormal];
    [_thirdClass addTarget:self action:@selector(onThirdClass) forControlEvents:UIControlEventTouchUpInside];
    _thirdClass.titleLabel.font = FONT_SIZE(14);
    [_tabBack addSubview:_thirdClass];
    
    
    _leftVerticalLine = [[UIView alloc]initWithFrame:CGRectMake(DIME_SCREEN_W / 3.0, 3.5, 1, 30)];
    [_leftVerticalLine setBackgroundColor:[UIColor lightGrayColor]];
    [_tabBack addSubview:_leftVerticalLine];
    _rightVerticalLine = [[UIView alloc]initWithFrame:CGRectMake(DIME_SCREEN_W / 3.0 * 2, 3.5, 1, 30)];
    [_rightVerticalLine setBackgroundColor:[UIColor lightGrayColor]];
    [_tabBack addSubview:_rightVerticalLine];
    
    _firstTableView = [[UITableView alloc]initWithFrame:CGRectMake(_DIME_LEFT, _tabBack.frame.size.height+1, _DIME_CONT_SIZE, DIME_SCREEN_H-(TITLE_HEI+_tabBack.frame.size.height) )];
    _firstTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_firstTableView];
    
    _secondTableView = [[UITableView alloc]initWithFrame:CGRectMake(_DIME_LEFT, _tabBack.frame.size.height+1, _DIME_CONT_SIZE, DIME_SCREEN_H-(TITLE_HEI+_tabBack.frame.size.height) )];
    _secondTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_secondTableView];
    
    _thirdTableView = [[UITableView alloc]initWithFrame:CGRectMake(_DIME_LEFT, _tabBack.frame.size.height+1, _DIME_CONT_SIZE, DIME_SCREEN_H-(TITLE_HEI+_tabBack.frame.size.height) )];
    _thirdTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_thirdTableView];
    
    [_firstTableView setDataSource:self];
    [_firstTableView setDelegate:self];
    
    [_secondTableView setDataSource:self];
    [_secondTableView setDelegate:self];
    
    [_thirdTableView setDataSource:self];
    [_thirdTableView setDelegate:self];
    
    _fDataSource = [NSMutableArray array];
    _sDataSource = [NSMutableArray array];
    _tDataSource = [NSMutableArray array];
    
    [_firstTableView setHidden:NO];
    [_secondTableView setHidden:YES];
    [_thirdTableView setHidden:YES];

}


#pragma mark -
#pragma mark 查询操作
//食物分类
-(void) queryFirstClass
{
    [self.senceDataManager.params removeAllObjects];
    [self.senceDataManager.params setObject:[[FNDataKeeper sharedInstance] getUserId] forKey:URL_DATA_K_USER_ID];
    
    [self.senceDataManager fetchDataWithModule:MODELS_MODEL_TOOLLOOKSURFACE method:MODELS_METHOD_QRYFOODLIST params:self.senceDataManager.params successListener:^(NSDictionary *result,NSString *msg){
        NSArray *arr = [result objectForKey:@"data"];
        if (arr.count>0) {
            for (int i =0 ; i<arr.count; i++) {
                FoodPubModel *model = [FoodPubModel modelWithDictionary:arr[i]];
                [_fDataSource addObject:model];
            }
            _currentData = FIRST_DATA;
            [_firstTableView reloadData];
        }
        
    } failedListener:^(NSString *msg){
        
    } timeOutListener:^{
        
    }];

}
//食谱分类
-(void) querySecondClass
{
    [self.senceDataManager.params removeAllObjects];
    [self.senceDataManager.params setObject:[[FNDataKeeper sharedInstance] getUserId] forKey:URL_DATA_K_USER_ID];
    [self.senceDataManager fetchDataWithModule:MODELS_MODEL_TOOLLOOKSURFACE method:MODELS_METHOD_QRYFOODMENULIST params:self.senceDataManager.params successListener:^(NSDictionary *result,NSString *msg){
        NSArray *arr = [result objectForKey:@"data"];
        if (arr.count>0) {
            for (int i =0 ; i<arr.count; i++) {
                FoodPubModel *model = [FoodPubModel modelWithDictionary:arr[i]];
                [_sDataSource addObject:model];
            }
            _currentData = SECOND_DATA;
            [_secondTableView reloadData];
        }
        
    } failedListener:^(NSString *msg){
        
    } timeOutListener:^{
        
    }];
}
//收藏
-(void) queryThirdClass
{
    [self showHud];
    NSMutableDictionary *parametersDic = [NSMutableDictionary dictionary];
    [parametersDic setObject:[[FNDataKeeper sharedInstance] getUserId] forKey:URL_DATA_K_USER_ID];
    [[NetworkManager shareManager] requestParams:parametersDic withModule:MODELS_MODEL_MOREINFOMANAGER method:MODELS_METHOD_GET_MY_FAVORITE finishBlock:^(DataServies *request, id result) {
        
        NSString *msg = [result objectForKey:@"msg"];
        if ([[result objectForKey:@"flag"] integerValue] == 1) {
            NSArray *retDataArray = result[@"retDataArray"];
            [_tDataSource removeAllObjects];
            for (int i = 0; i < retDataArray.count; i++) {
                ColFoodModel *model = [ColFoodModel modelWithDictionary:retDataArray[i]];
                if (self.isSport) {
                    if ([model.faveriteType integerValue] == 2) {
                        [_tDataSource addObject:model];
                    }
                    }else{
                        if ([model.faveriteType integerValue] == 0) {
                            [_tDataSource addObject:model];
                        }
                }
                
            }
            
        }else{
            NSLog(@"%@",msg);
        }
        _currentData = THIRD_DATA;
        [_thirdTableView reloadData];
        [self hideHud];
        
    } failBlock:^(DataServies *request, NSError *error) {
        
        [self hideHud];
    }];
}


//运动分类
-(void) querySportFirstClass
{
    
    [self showHud];
    NSMutableDictionary *parametersDic = [NSMutableDictionary dictionary];
    [parametersDic setObject:[[FNDataKeeper sharedInstance] getUserId] forKey:URL_DATA_K_USER_ID];
    [[NetworkManager shareManager] requestParams:parametersDic withModule:MODELS_MODEL_TOOLLOOKSURFACE method:MODELS_METHOD_GET_COMMON_SPORTS finishBlock:^(DataServies *request, id result) {
        
        NSString *msg = [result objectForKey:@"msg"];
        if ([[result objectForKey:@"flag"] integerValue] == 1) {
            NSArray *retDataArray = result[@"retDataArray"];
            for (int i = 0; i < retDataArray.count; i++) {
                SportCommonModel *model = [SportCommonModel modelWithDictionary:retDataArray[i]];
                [_fDataSource addObject:model];
            }
    
        }else{
            NSLog(@"%@",msg);
        }
        _currentData = FIRST_DATA;
        [_firstTableView reloadData];
        [self hideHud];
        
    } failBlock:^(DataServies *request, NSError *error) {
        
        [self hideHud];
    }];

}
//食谱分类
-(void) querySportSecondClass
{
    [self showHud];
    NSMutableDictionary *parametersDic = [NSMutableDictionary dictionary];
    [parametersDic setObject:[[FNDataKeeper sharedInstance] getUserId] forKey:URL_DATA_K_USER_ID];
    [[NetworkManager shareManager] requestParams:parametersDic withModule:MODELS_MODEL_TOOLLOOKSURFACE method:MODELS_METHOD_GET_SPORT_TYPES  finishBlock:^(DataServies *request, id result) {
        
        NSString *msg = [result objectForKey:@"msg"];
        if ([[result objectForKey:@"flag"] integerValue] == 1) {
            NSArray *retDataArray = result[@"retDataArray"];
            for (int i = 0; i < retDataArray.count; i++) {
                FoodPubModel *model = [FoodPubModel modelWithDictionary:retDataArray[i]];
                [_sDataSource addObject:model];
            }
            
        }else{
            NSLog(@"%@",msg);
        }
        _currentData = SECOND_DATA;
        [_secondTableView reloadData];
        [self hideHud];
        
    } failBlock:^(DataServies *request, NSError *error) {
        
        [self hideHud];
    }];
}


-(void)onFirstClass
{
    
    [_firstClass setTitleColor:[UIColor colorWithHexString:@"FF6895"] forState:UIControlStateNormal];
    [_secondClass setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_thirdClass setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    [_firstTableView setHidden:NO];
    [_secondTableView setHidden:YES];
    [_thirdTableView setHidden:YES];
    
    _currentData = FIRST_DATA;
    
    if (_fDataSource.count==0) {
        if (self.isSport) {
            [self querySportFirstClass];
        }else{
            [self queryFirstClass];
        }
    }
    
    
}

-(void)onSecondClass
{
    [_firstClass setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_secondClass setTitleColor:[UIColor colorWithHexString:@"FF6895"] forState:UIControlStateNormal];
    [_thirdClass setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    [_firstTableView setHidden:YES];
    [_secondTableView setHidden:NO];
    [_thirdTableView setHidden:YES];
    
    _currentData = SECOND_DATA;
    
    if (_sDataSource.count == 0) {
        if (self.isSport) {
            [self querySportSecondClass];
        }else{
            [self querySecondClass];
        }
    }
}
-(void)onThirdClass
{
    
    [_firstClass setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_secondClass setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_thirdClass setTitleColor:[UIColor colorWithHexString:@"FF6895"] forState:UIControlStateNormal];
    
    [_firstTableView setHidden:YES];
    [_secondTableView setHidden:YES];
    [_thirdTableView setHidden:NO];

    
    _currentData = THIRD_DATA;
    
    if (_tDataSource.count == 0) {
        if (self.isSport) {
            [self queryThirdClass];
        }else{
            [self queryThirdClass];
        }
    }
    
}


#pragma mark -
#pragma mark UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (_currentData) {
        case FIRST_DATA:
            return _fDataSource.count;
            break;
        case SECOND_DATA:
            return _sDataSource.count;
            break;
        case THIRD_DATA:
            return _tDataSource.count;
            break;
        default:
            return 0;
            break;
    }
    
    return _curreentSouce.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[Food_ViewController alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        
        
        UILabel *lineGrayLabel =[[UILabel alloc]initWithFrame:CGRectMake(0,59.5,cell.width, 0.5)];
        [lineGrayLabel setFont:[UIFont systemFontOfSize:14.0f]];
        lineGrayLabel.backgroundColor = [UIColor colorWithRed:188/255.0 green:187/255.0 blue:192/255.0 alpha:1];
        [cell.contentView  addSubview:lineGrayLabel];
        
        
        UILabel *title_v2 =[[UILabel alloc]initWithFrame:CGRectMake(60,38, _px(350), 20)];
        [title_v2 setFont:[UIFont systemFontOfSize:14.0f]];
        title_v2.textColor = [UIColor lightGrayColor];
        title_v2.tag = 103;
        title_v2.backgroundColor = [UIColor clearColor];
        [cell.contentView  addSubview:title_v2];
        
        UILabel *nameLabel =[[UILabel alloc]initWithFrame:CGRectMake(title_v2.left,15, _px(350), 20)];
        [nameLabel setFont:[UIFont systemFontOfSize:16.0f]];
        nameLabel.textColor = [UIColor blackColor];
        nameLabel.tag = 102;
        nameLabel.backgroundColor = [UIColor clearColor];
        [cell.contentView  addSubview:nameLabel];

    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    switch (_currentData) {
        case FIRST_DATA:
        {
            if (self.isSport) {
                SportCommonModel *model = _fDataSource[indexPath.row];
                if (model.sportImgPath && ![model.sportImgPath isMemberOfClass:[NSNull class]]) {
                    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:model.sportImgPath] placeholderImage:[UIImage imageNamed:@"Icon_default"]];
                }else
                {
                    [cell.imageView setImage:[UIImage imageNamed:@"Icon_default"]];
                }
                
                UILabel *title_v2 = (UILabel *)[cell.contentView viewWithTag:103];
                title_v2.text = model.sportHeat;
                
                UILabel *nameLabel = (UILabel *)[cell.contentView viewWithTag:102];
                nameLabel.text = model.sportName;
            }else
            {
            FoodPubModel *model = _fDataSource[indexPath.row];
            if (model.sourceUrl && ![model.sourceUrl isMemberOfClass:[NSNull class]]) {
                [cell.imageView sd_setImageWithURL:[NSURL URLWithString:model.sourceUrl] placeholderImage:[UIImage imageNamed:@"Icon_default"]];
            }else
            {
                [cell.imageView setImage:[UIImage imageNamed:@"Icon_default"]];
            }
//            cell.textLabel.text = model.typeTName;
                
                UILabel *nameLabel = (UILabel *)[cell.contentView viewWithTag:102];
                nameLabel.text = model.typeTName;
                
            }
        }
            break;
        case SECOND_DATA:
        {
            FoodPubModel *model = _sDataSource[indexPath.row];
            if (model.sourceUrl && [model.sourceUrl isMemberOfClass:[NSString class]] ) {
                [cell.imageView sd_setImageWithURL:[NSURL URLWithString:model.sourceUrl] placeholderImage:[UIImage imageNamed:@"Icon_default"]];
            }else{
                [cell.imageView setImage:[UIImage imageNamed:@"Icon_default"]];
            }
            UILabel *nameLabel = (UILabel *)[cell.contentView viewWithTag:102];
            nameLabel.text = model.typeTName;
//            cell.textLabel.text = model.typeTName;
        }
            break;
        case THIRD_DATA:
        {
            ColFoodModel *model = _tDataSource[indexPath.row];
            if (model.faveriteImgPath) {
                [cell.imageView sd_setImageWithURL:[NSURL URLWithString:model.faveriteImgPath] placeholderImage:[UIImage imageNamed:@"Icon_default"]];
            }else{
                [cell.imageView setImage:[UIImage imageNamed:@"Icon_default"]];
            }
            UILabel *nameLabel = (UILabel *)[cell.contentView viewWithTag:102];
            nameLabel.text = model.faveriteName;
            
//            cell.textLabel.text = model.faveriteName;
        }
            break;
        default:
            break;
    }
    
    return cell;
}

#pragma mark UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return _px(120);
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //当手指离开某行时，就让某行的选中状态消失
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
    switch (_currentData) {
        case FIRST_DATA:
        {
            
            if (self.isSport) {
                FoodDetailViewController *foodDetailCtrl = [[FoodDetailViewController alloc] init];
                SportCommonModel *model = _fDataSource[indexPath.row];
                foodDetailCtrl.typeId = @"2";
                foodDetailCtrl.objId = model.fid;
                [self.navigationController pushViewController:foodDetailCtrl animated:YES];
            }else
            {
                FoodListViewController *foodListCtrl = [[FoodListViewController alloc] init];
                FoodPubModel *model = _fDataSource[indexPath.row];
                foodListCtrl.itemType = @"1";
                foodListCtrl.sportType = model.typeTCode;
                [self.navigationController pushViewController:foodListCtrl animated:YES];
            }
            
        }
            break;
        case SECOND_DATA:
        {
            FoodListViewController *foodListCtrl = [[FoodListViewController alloc] init];
            if (self.isSport) {
                FoodPubModel *model = _sDataSource[indexPath.row];
                foodListCtrl.sportType = model.typeTCode;
                foodListCtrl.itemType = @"2";
            }else
            {
                FoodPubModel *model = _sDataSource[indexPath.row];
                foodListCtrl.sportType = model.typeTCode;
                foodListCtrl.itemType = @"3";
            }


             [self.navigationController pushViewController:foodListCtrl animated:YES];
        }
            break;
        case THIRD_DATA:
        {
            FoodDetailViewController *foodDetailCtrl = [[FoodDetailViewController alloc] init];
            ColFoodModel *model = _tDataSource[indexPath.row];
            foodDetailCtrl.typeId = model.faveriteType;
            foodDetailCtrl.objId = model.faveriteObjId;
            [self.navigationController pushViewController:foodDetailCtrl animated:YES];
        }
            break;
    }

   
    
    
}

- (void)dealloc
{
    NSLog(@"%s",__FUNCTION__);
}

@end

@implementation Food_ViewController
- (void)layoutSubviews {
    [super layoutSubviews];
    self.imageView.frame = CGRectMake(_px(10),_px(10),_px(100),_px(100));
}
@end
