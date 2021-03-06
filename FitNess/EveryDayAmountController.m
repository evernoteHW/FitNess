//
//  EveryDayAmountController.m
//  FitNess
//
//  Created by WeiHu on 14/10/26.
//  Copyright (c) 2014年 WeiHu. All rights reserved.
//

#import "EveryDayAmountController.h"
#import "RTLabel.h"
#import "CaloriesModel.h"
#import "FoodPubController.h"
#import "SportCommonModel.h"
#import "FoodInfoModel.h"
#import "FoodDetailViewController.h"
#import "DataGraphController.h"


static NSString *kheader = @"menuSectionHeader";
static NSString *ksubSection = @"menuSubSection";


@interface EveryDayAmountController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray *foodCaloriesArrary;
    NSMutableArray *sportCaloriesArrary;
    CGFloat totalCol1;
    CGFloat totalCol2;
}
@property (nonatomic, strong) UITableView *caloriesTableView;
@property (nonatomic, strong) NSMutableArray *caloriesArray;


@property (nonatomic, strong) UIButton  *foodCaloriresBtn;
@property (nonatomic, strong) UIButton  *sportsCaloriresBtn;

@property (nonatomic, strong)  RTLabel *normalLabel;
@property (nonatomic, strong)  UILabel *promtLabel2;

@property (nonatomic, strong)   UIView *headView;
@property (nonatomic, strong)   UIView *headView2;

@property (nonatomic, strong)   UIView *footView;
@property (nonatomic, strong)  UILabel *curveLabel;

@end

@implementation EveryDayAmountController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
//        _caloriesArray = [NSMutableArray array];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(requestEveryDayAmountData) name:@"requestEveryDayAmountData" object:nil];
        
    }
    return self;
}


- (void)dealloc
{
    NSLog(@"%s",__FUNCTION__);
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"requestEveryDayAmountData" object:nil];
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"isAddCol"];
}

- (void)initCaloriesData
{
    [foodCaloriesArrary removeAllObjects];
    [sportCaloriesArrary removeAllObjects];
    
    foodCaloriesArrary = [NSMutableArray array];
    sportCaloriesArrary = [NSMutableArray array];
    
    NSArray *iconImageArr = @[@"food_breakfast",@"food_jia",@"food_dinner",@"food_jia2",@"food_dinner"];
    NSArray *dinnerNameArr = @[@"早餐",@"加餐",@"午餐",@"加餐",@"晚餐"];
    NSArray *calorsNumArr = @[@"0.0",@"0.0",@"0.0",@"0.0",@"0.0"];
    NSArray *calorsTipArr = @[@"369cal",@"120cal",@"491cal",@"150cal",@"245cal"];
    
    for (int i = 0; i < iconImageArr.count; i++) {
        CaloriesModel *caloriesModel = [[CaloriesModel alloc] init];
        caloriesModel.iconImage = iconImageArr[i];
        caloriesModel.dinnerName = dinnerNameArr[i];
        caloriesModel.calorsNum = calorsNumArr[i];
        caloriesModel.calorsTip = calorsTipArr[i];
        caloriesModel.tag = i;
        [foodCaloriesArrary addObject:caloriesModel];
    }
    
    NSArray *iconImageArr2 = @[@"sports_mealrecord"];
    NSArray *dinnerNameArr2 = @[@"运动"];
    NSArray *calorsNumArr2 = @[@"0.0"];
    NSArray *calorsTipArr2 = @[@"452cal"];
    for (int i = 0; i < iconImageArr2.count; i++) {
        CaloriesModel *caloriesModel = [[CaloriesModel alloc] init];
        caloriesModel.iconImage = iconImageArr2[i];
        caloriesModel.dinnerName = dinnerNameArr2[i];
        caloriesModel.calorsNum = calorsNumArr2[i];
        caloriesModel.calorsTip = calorsTipArr2[i];
        caloriesModel.tag = 5;
        [sportCaloriesArrary addObject:caloriesModel];
    }
    
    if (self.isFoodCalories) {
        self.caloriesArray = foodCaloriesArrary;
       
    }else{
        self.caloriesArray = sportCaloriesArrary;
        
    }
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"卡路里摄入量";

    [self.view addSubview:self.caloriesTableView];
    [self.view addSubview:[self switchBtn]];
     [self requestEveryDayAmountData];
    // Do any additional setup after loading the view.
    
}

#pragma mark POPDDelegate

-(void) didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

}




- (UITableView *)caloriesTableView
{
    if (_caloriesTableView == nil) {
        _caloriesTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, DIME_SCREEN_W, DIME_SCREEN_H - 49 - 64) style:UITableViewStyleGrouped];
        _caloriesTableView.backgroundColor = [UIColor clearColor];
        _caloriesTableView.dataSource = self;
        _caloriesTableView.delegate = self;
        _caloriesTableView.tableFooterView = [self createCaloriesTbFoodView];
        _caloriesTableView.rowHeight = 60;
        _caloriesTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _caloriesTableView.tableHeaderView = [self createCaloriesTbHeadView];
    }
    return _caloriesTableView;
}
- (UIView *)createCaloriesTbHeadView
{
    if (self.isFoodCalories) {
        if (_headView == nil) {

            _headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, DIME_SCREEN_W, 90)];
            _headView.backgroundColor = [UIColor clearColor];
    
            UIView *grayBgView = [[UIView alloc] initWithFrame:CGRectMake(10, 10, DIME_SCREEN_W - 20, 75)];
            grayBgView.backgroundColor = [UIColor colorWithRed:214/255.0 green:214/255.0 blue:214/255.0 alpha:1];
            [_headView addSubview:grayBgView];
            
            UILabel *promtLabel = [[UILabel alloc] initWithFrame:CGRectMake(10,10, DIME_SCREEN_W, 40)];
            promtLabel.backgroundColor = [UIColor clearColor];
            promtLabel.font = [UIFont systemFontOfSize:16.0f];
            promtLabel.textAlignment = NSTextAlignmentCenter;
            promtLabel.text = @"正常需要";
            promtLabel.textColor = [UIColor blackColor];
            [_headView addSubview:promtLabel];
            
//            UIView *whiteBg = [[UIView alloc] initWithFrame:CGRectMake(15, 50, DIME_SCREEN_W - 30, 5)];
//            whiteBg.backgroundColor = [UIColor whiteColor];
//            [_headView addSubview:whiteBg];
            
            
//            UIImageView *iconImageView = [[UIImageView alloc]initWithFrame:CGRectMake(15, promtLabel.bottom + 5, 120, 25)];
//            iconImageView.image = [[UIImage imageNamed:@"food_sheru_1.png"] stretchableImageWithLeftCapWidth:50 topCapHeight:0];
//            [_headView  addSubview:iconImageView];
//
            NSString *format = @"<font size=16 color='#000000'>摄入 </font><font size=18 color='#FF6794'>%@</font><font size=16 color='#000000'> cal</font>";
            self.normalLabel = [[RTLabel alloc] initWithFrame:CGRectMake(100, 45, 300, 40)];
            self.normalLabel.backgroundColor = [UIColor clearColor];
//            self.normalLabel.font = [UIFont systemFontOfSize:16.0f];
            UserModel *model = [[FNDataKeeper sharedInstance] getUser];
            self.normalLabel.textColor = [UIColor blackColor];
//            numberOfLines = 2;
            self.normalLabel.text = [NSString stringWithFormat:format,model.alsoNeedKll];
            [_headView addSubview:self.normalLabel];
            
            
//            UIImageView *iconImageView2 = [[UIImageView alloc]initWithFrame:CGRectMake(0, self.normalLabel.top, 120, 25)];
//            iconImageView2.image = [[UIImage imageNamed:@"food_sheru2.png"] stretchableImageWithLeftCapWidth:20 topCapHeight:0];
//            iconImageView2.right = DIME_SCREEN_W - 15;
//            [_headView  addSubview:iconImageView2];
//            
//            UILabel *lessLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.normalLabel.top, 120, 25)];
//            lessLabel.backgroundColor = [UIColor clearColor];
//            lessLabel.font = [UIFont systemFontOfSize:11.0f];
//            lessLabel.textAlignment = NSTextAlignmentCenter;
//            lessLabel.right = DIME_SCREEN_W - 15;
////            lessLabel.text = @"少摄入 1798.3";
//            lessLabel.text = [NSString stringWithFormat:@"少摄入 %@",model.fixCalcImpKll];
//            lessLabel.textColor = [UIColor blackColor];
//            [_headView addSubview:lessLabel];
          
        }
        return _headView;
            
    }else{
        if (_headView2 == nil) {
            _headView2 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, DIME_SCREEN_W, 20)];
            _headView2.backgroundColor = [UIColor clearColor];
        }
        
        return _headView2;
    }
}

- (UIView *)createCaloriesTbFoodView
{
    if (_footView == nil) {
        _footView  = [[UIView alloc] initWithFrame:CGRectMake(0, 0, DIME_SCREEN_W, 70)];
        _footView.backgroundColor = [UIColor clearColor];
        
        UIView *grayViewBg = [[UIView alloc] initWithFrame:CGRectMake(20, 10, DIME_SCREEN_W - 40, 50)];
        grayViewBg.backgroundColor = [UIColor colorWithRed:214/255.0 green:214/255.0 blue:214/255.0 alpha:1];
        [_footView addSubview:grayViewBg];
        
        self.promtLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 180, grayViewBg.height)];
        self.promtLabel2.backgroundColor = [UIColor clearColor];
        self.promtLabel2.font = [UIFont systemFontOfSize:14.0f];
        self.promtLabel2.textAlignment = NSTextAlignmentCenter;
     
        [grayViewBg addSubview:self.promtLabel2];
        
        _curveLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.promtLabel2.right, 0, grayViewBg.width - self.promtLabel2.width, grayViewBg.height)];
        _curveLabel.backgroundColor = [UIColor clearColor];
        _curveLabel.font = [UIFont systemFontOfSize:14.0f];
        _curveLabel.textAlignment = NSTextAlignmentCenter;
        _curveLabel.userInteractionEnabled = YES;
        _curveLabel.textColor = [UIColor colorWithHexString:@"C5004F"];
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGestureAcition)];
        tapGesture.numberOfTapsRequired = 1;
        [_curveLabel addGestureRecognizer:tapGesture];
        
        if (self.isFoodCalories) {
            
        }else{
            
        }
        
        [grayViewBg addSubview:_curveLabel];
    }
  
    if (self.isFoodCalories) {
        _curveLabel.text = @"摄入曲线";
        self.promtLabel2.text =  @"饮食摄入总量 : 0.0 cal";
    }else{
        _curveLabel.text = @"消耗曲线";
        self.promtLabel2.text =  @"运动消耗总量 : 0.0 cal";
    }
    
    return _footView;
}

- (UIView *)switchBtn
{
    UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.height - 49 - 64, self.view.width ,49)];
    bottomView.backgroundColor = [UIColor clearColor];
    
    self.foodCaloriresBtn = [[UIButton alloc] initWithFrame:CGRectMake(0,0,self.view.width/2.0,bottomView.height)];
    [self.foodCaloriresBtn setTitle:@"" forState:UIControlStateNormal];
    self.foodCaloriresBtn.titleLabel.font = FONT_SIZE(16);
    [self.foodCaloriresBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.foodCaloriresBtn setBackgroundImage:[UIImage imageNamed:@"BMR_none_img.png"] forState:UIControlStateNormal];
    [self.foodCaloriresBtn addTarget:self action:@selector(refreshCaloriesUI:) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:self.foodCaloriresBtn];
    
    self.sportsCaloriresBtn = [[UIButton alloc] initWithFrame:CGRectMake(self.view.width/2.0,0,self.view.width/2.0,bottomView.height)];
    [self.sportsCaloriresBtn setTitle:@"" forState:UIControlStateNormal];
    self.sportsCaloriresBtn.titleLabel.font = FONT_SIZE(16);
    [self.sportsCaloriresBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.sportsCaloriresBtn setBackgroundImage:[UIImage imageNamed:@"BMR_none_img.png"] forState:UIControlStateNormal];
    [self.sportsCaloriresBtn addTarget:self action:@selector(refreshCaloriesUI:) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:self.sportsCaloriresBtn];
    
    if (self.isFoodCalories) {
        [self.foodCaloriresBtn setBackgroundImage:[UIImage imageNamed:@"food_none_bottom.png"] forState:UIControlStateNormal];
        [self.sportsCaloriresBtn setBackgroundImage:[UIImage imageNamed:@"food_select_run.png"] forState:UIControlStateNormal];
    }else{
        [self.foodCaloriresBtn setBackgroundImage:[UIImage imageNamed:@"food_select_bottom.png"] forState:UIControlStateNormal];
        [self.sportsCaloriresBtn setBackgroundImage:[UIImage imageNamed:@"food_none_run.png"] forState:UIControlStateNormal];
    }

    
    return bottomView;
}

- (void)tapGestureAcition
{
    DataGraphController *dataGraphCtrl = [[DataGraphController alloc] init];
    
    if (self.isFoodCalories) {
        dataGraphCtrl.title = @"摄入曲线";
        dataGraphCtrl.graphTitle = @"摄入能量曲线";
    }else{
        dataGraphCtrl.title = @"消耗曲线";
        dataGraphCtrl.graphTitle = @"消耗能量曲线";
    }

    [self.navigationController pushViewController:dataGraphCtrl animated:YES];
}

- (void)refreshCaloriesUI:(UIButton *)btn
{
    if (btn == self.foodCaloriresBtn) {
        self.isFoodCalories = YES;
    }else{
        self.isFoodCalories = NO;
    }

    
    if (self.isFoodCalories) {
        [self.foodCaloriresBtn setBackgroundImage:[UIImage imageNamed:@"food_none_bottom.png"] forState:UIControlStateNormal];
        [self.sportsCaloriresBtn setBackgroundImage:[UIImage imageNamed:@"food_select_run.png"] forState:UIControlStateNormal];
    }else{
        [self.foodCaloriresBtn setBackgroundImage:[UIImage imageNamed:@"food_select_bottom.png"] forState:UIControlStateNormal];
        [self.sportsCaloriresBtn setBackgroundImage:[UIImage imageNamed:@"food_none_run.png"] forState:UIControlStateNormal];
    }

    
    _caloriesTableView.tableFooterView = [self createCaloriesTbFoodView];
    _caloriesTableView.tableHeaderView = [self createCaloriesTbHeadView];
    
    self.caloriesArray = ((self.isFoodCalories) ? foodCaloriesArrary : sportCaloriesArrary);
    if (self.isFoodCalories) {
        
        self.promtLabel2.text =  [NSString stringWithFormat:@"饮食摄入总量 : %.1f cal",totalCol1];
    }else{
        self.promtLabel2.text =  [NSString stringWithFormat:@"运动消耗总量 : %.1f cal",totalCol2];
        
    }
    [self.caloriesTableView reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
   return _caloriesArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    id model = _caloriesArray[indexPath.row];
    if ([model isMemberOfClass:[CaloriesModel class]]) {
        static NSString *identifier = @"FoodSearch_TableViewCell";
        UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:identifier];
        
        
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.separatorInset = UIEdgeInsetsMake(0, 20, 0, 20);
            cell.backgroundColor = [UIColor clearColor];
            cell.contentView.backgroundColor = [UIColor clearColor];
            //        //
            
            UIView *whiteBgView = [[UIView alloc] initWithFrame:CGRectMake(10, 0, DIME_SCREEN_W - 20, 60)];
            whiteBgView.backgroundColor = [UIColor whiteColor];
            [cell.contentView  addSubview:whiteBgView];
            
            UIView *lineGrayView = [[UIView alloc] initWithFrame:CGRectMake(0, 59.5, whiteBgView.width, 0.5)];
            lineGrayView.backgroundColor = [UIColor lightGrayColor];
            [whiteBgView  addSubview:lineGrayView];
            
            UIImageView *iconImageView = [[UIImageView alloc]initWithFrame:CGRectMake(15, 5,60, 50)];
            iconImageView.tag = 100;;
            [cell.contentView  addSubview:iconImageView];
            
            UILabel *title_v =[[UILabel alloc]initWithFrame:CGRectMake(iconImageView.right , 0,50, whiteBgView.height)];
            [title_v setFont:[UIFont systemFontOfSize:15.0f]];
            title_v.textColor = [UIColor blackColor];
            title_v.textAlignment = NSTextAlignmentCenter;
            title_v.tag = 101;
            [cell.contentView  addSubview:title_v];
            //
            //        //
            UILabel *sub_title_v =[[UILabel alloc]initWithFrame:CGRectMake(title_v.right,0, 70, whiteBgView.height)];
            [sub_title_v setFont:[UIFont systemFontOfSize:13.0f]];
            sub_title_v.textColor = [UIColor colorWithHexString:@"C5004F"];
            sub_title_v.textAlignment = NSTextAlignmentCenter;
            sub_title_v.tag = 102;
            [cell.contentView  addSubview:sub_title_v];
            
            UILabel *adviseLabel =[[UILabel alloc]initWithFrame:CGRectMake(sub_title_v.right + 5,0, 60, whiteBgView.height)];
            [adviseLabel setFont:[UIFont systemFontOfSize:13.0f]];
            adviseLabel.numberOfLines = 2;
            adviseLabel.textColor = [UIColor grayColor];
            adviseLabel.tag = 103;
            [cell.contentView  addSubview:adviseLabel];
            
            UIButton  *addCaloriresBtn = [[UIButton alloc] initWithFrame:CGRectMake(adviseLabel.right - 30,0,69,52)];
            [addCaloriresBtn setImage:[UIImage imageNamed:@"food_select_add.png"] forState:UIControlStateNormal];
            [addCaloriresBtn addTarget:self action:@selector(addCaloriresBtnAction:) forControlEvents:UIControlEventTouchUpInside];
            [cell.contentView addSubview:addCaloriresBtn];
            
        }
        //
        CaloriesModel *caloriesModel =  _caloriesArray[indexPath.row];
        
        UIImageView *iconImageView = (UIImageView *)[cell.contentView viewWithTag:100];
        
        iconImageView.image = [UIImage imageNamed:caloriesModel.iconImage];
        
        UIButton *btn = [cell.contentView.subviews lastObject];
        btn.tag = caloriesModel.tag;
        
        UILabel *title_v = (UILabel *)[cell.contentView viewWithTag:101];
        title_v.text = caloriesModel.dinnerName;
        
        UILabel *sub_title_v = (UILabel *)[cell.contentView viewWithTag:102];
        if (self.isFoodCalories) {
            sub_title_v.text = [NSString stringWithFormat:@"%.2f",caloriesModel.totalAmount];
        }else{
            sub_title_v.text = [NSString stringWithFormat:@"%.1f",caloriesModel.totalAmount];

        }
        
        
        UILabel *adviseLabel = (UILabel *)[cell.contentView viewWithTag:103];
        adviseLabel.text = [NSString stringWithFormat:@"/建议：\n%@",caloriesModel.calorsTip];
        
        
        return cell;
    }else{
    
        static NSString *identifier2 = @"FoodSearch_TableViewCell_Child";
        UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:identifier2];
        if (cell == nil) {
    
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier2];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.separatorInset = UIEdgeInsetsMake(0, 20, 0, 20);
            cell.backgroundColor = [UIColor clearColor];
            cell.contentView.backgroundColor = [UIColor clearColor];
            
            UIView *whiteBgView = [[UIView alloc] initWithFrame:CGRectMake(10, 0, DIME_SCREEN_W - 20, 60)];
            whiteBgView.backgroundColor = RGB(205, 205, 205);
            [cell.contentView  addSubview:whiteBgView];
            
            UILabel *title_v =[[UILabel alloc]initWithFrame:CGRectMake(15, 10,220, 20)];
            [title_v setFont:[UIFont systemFontOfSize:13.0f]];
            title_v.textColor = [UIColor blackColor];
            title_v.textAlignment = NSTextAlignmentLeft;
            title_v.tag = 101;
            [cell.contentView  addSubview:title_v];
            //
            //        //
            UILabel *sub_title_v =[[UILabel alloc]initWithFrame:CGRectMake(title_v.left,30, 220, 19)];
            [sub_title_v setFont:[UIFont systemFontOfSize:13.0f]];
            sub_title_v.textColor = [UIColor grayColor];
            sub_title_v.textAlignment = NSTextAlignmentLeft;
            sub_title_v.tag = 102;
            [cell.contentView  addSubview:sub_title_v];
            
            UIButton  *reduceCaloriresBtn = [[UIButton alloc] initWithFrame:CGRectMake(sub_title_v.right + 2,0,69,52)];
            [reduceCaloriresBtn setImage:[UIImage imageNamed:@"food_select_reduce.png"] forState:UIControlStateNormal];
            [reduceCaloriresBtn addTarget:self action:@selector(reduceCaloriresBtn:) forControlEvents:UIControlEventTouchUpInside];
            reduceCaloriresBtn.tag = 103;
            reduceCaloriresBtn.titleLabel.textColor = [UIColor clearColor];
            [cell.contentView addSubview:reduceCaloriresBtn];
        }
        id model = _caloriesArray[indexPath.row];
        if ([model isMemberOfClass:[SportCommonModel class]]) {
            
            SportCommonModel *sportCommonModel = _caloriesArray[indexPath.row];
            
            UILabel *title_v = (UILabel *)[cell.contentView viewWithTag:101];
            title_v.text = sportCommonModel.sportDesc;
            
            UILabel *sub_title_v = (UILabel *)[cell.contentView viewWithTag:102];
            sub_title_v.text = [NSString stringWithFormat:@"%@cal/%@分",sportCommonModel.sportHeat,sportCommonModel.colCount];
            
            UIButton  *reduceCaloriresBtn = (UIButton *)[cell.contentView viewWithTag:103];
            reduceCaloriresBtn.titleLabel.text = [NSString stringWithFormat:@"sports_info_%@",sportCommonModel.fid];
            
        }else{
            
            FoodInfoModel *foodInfoModel = _caloriesArray[indexPath.row];
            
            UILabel *title_v = (UILabel *)[cell.contentView viewWithTag:101];
            title_v.text = foodInfoModel.foodName;
            
            UILabel *sub_title_v = (UILabel *)[cell.contentView viewWithTag:102];
            sub_title_v.text = [NSString stringWithFormat:@"%@cal/%@克",foodInfoModel.heatNum,foodInfoModel.colCount];
            
            UIButton  *reduceCaloriresBtn = (UIButton *)[cell.contentView viewWithTag:103];
            reduceCaloriresBtn.titleLabel.text = [NSString stringWithFormat:@"food_info_%@",foodInfoModel.foodId];
            
        }
        
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    FoodDetailViewController *contrller = [[FoodDetailViewController alloc]init];
    [contrller setHidesBottomBarWhenPushed:YES];
    id model = _caloriesArray[indexPath.row];
    
    if ([model isMemberOfClass:[FoodInfoModel class]]) {
        contrller.typeId = @"0";
        contrller.objId = ((FoodInfoModel *)model).foodId;
        [self.navigationController pushViewController:contrller animated:YES];
    }else if([model isMemberOfClass:[SportCommonModel class]]){
        contrller.typeId = @"2";
        contrller.objId = ((SportCommonModel *)model).fid;
        [self.navigationController pushViewController:contrller animated:YES];
    }else{
    
    }
    
    

}

- (void)addCaloriresBtnAction:(UIButton *)btn
{
    NSLog(@"%d",btn.tag);
    [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%d",btn.tag] forKey:@"food_btn_tag"];
    FoodPubController *contrller = [[FoodPubController alloc]init];
    [contrller setHidesBottomBarWhenPushed:YES];
    if (self.isFoodCalories) {
        contrller.isSport = NO;
    }else{
        contrller.isSport = YES;
    }
    
    [self.navigationController pushViewController:contrller animated:YES];
}
- (void)reduceCaloriresBtn:(UIButton *)btn
{
    if ([btn.titleLabel.text rangeOfString:@"sports_info_"].location != NSNotFound) {
        //判读点击的是 哪个
        NSString *sportId =  [btn.titleLabel.text substringFromIndex:12];
        NSString *filename  = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/sport.plist"];
        NSMutableArray *colArr = [[NSMutableArray alloc] initWithContentsOfFile:filename];
        if (colArr != nil) {
            CGFloat sportTotalAmount = 0;
            for (NSDictionary *dic in colArr) {
                if ([[NSString stringWithFormat:@"%@",dic[@"id"]] isEqualToString:sportId]) {
                    [colArr removeObject:dic];
                    if([colArr writeToFile:filename atomically:YES]){
                        NSLog(@"成功");
                    }else{
                        NSLog(@"删除失败");
                    }
                    [self requestEveryDayAmountData];
                    break;
                }
            }
            ((CaloriesModel *)sportCaloriesArrary[0]).totalAmount = sportTotalAmount;
            //插入到指定位置
        }

    }else{
        NSString *foodId =  [btn.titleLabel.text substringFromIndex:10];
        NSArray *contentArr = @[@"Documents/food_0.plist",@"Documents/food_1.plist",@"Documents/food_2.plist",@"Documents/food_3.plist",@"Documents/food_4.plist"];
        BOOL isFind = NO;
        for (int j = 0;j < contentArr.count;j++) {
            if (!isFind ) {
                NSString *filename  = [NSHomeDirectory() stringByAppendingPathComponent:contentArr[j]];
                NSMutableArray *colArr = [[NSMutableArray alloc] initWithContentsOfFile:filename];
                if (colArr && colArr.count > 0) {
                    for (NSDictionary *dic in colArr) {
                        if ([[NSString stringWithFormat:@"%@",dic[@"foodId"]] isEqualToString:foodId]) {
                            NSLog(@"找到了");
                            isFind = YES;
                            [colArr removeObject:dic];
                            if([colArr writeToFile:filename atomically:YES]){
                                NSLog(@"成功");
                            }else{
                                NSLog(@"删除失败");
                            }
                            [self requestEveryDayAmountData];
                            break;
                            }
                        }
                    }else {
                }
            }
        }
    }
}

- (void)requestEveryDayAmountData
{
    [self calculateDateCol];
    
    //难道里面的东西。。。。。。。。。。
    [self initCaloriesData];
    totalCol1 = 0;
    totalCol2 = 0;
    
    NSArray *contentArr = @[@"Documents/food_0.plist",@"Documents/food_1.plist",@"Documents/food_2.plist",@"Documents/food_3.plist",@"Documents/food_4.plist"];
    for (int j = 0;j < contentArr.count;j++) {
        NSString *filename  = [NSHomeDirectory() stringByAppendingPathComponent:contentArr[j]];
        NSMutableArray *colArr = [[NSMutableArray alloc] initWithContentsOfFile:filename];
        if (colArr != nil) {
            NSMutableArray *tempArr = [NSMutableArray array];
            //卡路里总数
            CGFloat foodTotalAmount = 0;
            for (NSDictionary *dic in colArr) {
                FoodInfoModel *foodInfoModel = [[FoodInfoModel alloc] init];
                foodInfoModel.foodName = dic[@"foodName"];
                foodInfoModel.heatNum =  [NSString stringWithFormat:@"%.2f",[dic[@"heatNum"] floatValue]];
                foodInfoModel.weight = [NSString stringWithFormat:@"%.2f",[dic[@"weight"] floatValue]];
                foodInfoModel.colCount = dic[@"colCount"];
                //截取字符串
                foodInfoModel.foodId = dic[@"foodId"];
                foodTotalAmount += (([foodInfoModel.colCount floatValue]/[foodInfoModel.weight floatValue])*[foodInfoModel.heatNum floatValue]);
                [tempArr addObject:foodInfoModel];
            }
            //遍历
            NSInteger flag = 0;
            
            for (int i = 0; i < foodCaloriesArrary.count; i++) {
                
                id model = foodCaloriesArrary[i];
                if ([model isMemberOfClass:[CaloriesModel class]]) {
                    if (((CaloriesModel *)model).tag == j) {
                        flag = i;
                        ((CaloriesModel *)model).totalAmount = foodTotalAmount;
                    }
                }
                
            }
            for (int k=0;k<tempArr.count;k++) {
                [foodCaloriesArrary  insertObject:tempArr[k] atIndex:k + flag + 1];
            }
            //插入到指定位置
        }
        
    }

    //饮食摄入总量

    //难道里面的东西。。。。。。。。。。
    
    NSString *filename  = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/sport.plist"];
    NSMutableArray *colArr = [[NSMutableArray alloc] initWithContentsOfFile:filename];
    if (colArr != nil) {
        CGFloat sportTotalAmount = 0;
        for (NSDictionary *dic in colArr) {
            if ([filename rangeOfString:@"sport"].location != NSNotFound) {
                SportCommonModel *sportCommonModel = [[SportCommonModel alloc] init];
                sportCommonModel.sportDesc = dic[@"sportDesc"];
                sportCommonModel.sportHeat = dic[@"sportHeat"];
                sportCommonModel.sportKeepDate = dic[@"sportKeepDate"];
                sportCommonModel.sportName = dic[@"sportName"];
                sportCommonModel.sportName = dic[@"sportName"];
                sportCommonModel.colCount = dic[@"colCount"];
                sportCommonModel.fid = dic[@"id"];
                sportTotalAmount+= ([sportCommonModel.sportHeat floatValue] / [sportCommonModel.sportKeepDate floatValue])* [sportCommonModel.colCount floatValue];
                [sportCaloriesArrary addObject:sportCommonModel];
            }
        }
        ((CaloriesModel *)sportCaloriesArrary[0]).totalAmount = sportTotalAmount;
        //插入到指定位置
    }
    
    [_caloriesTableView reloadData];
    
    for (int i = 0; i < foodCaloriesArrary.count; i++) {
        
        id model = foodCaloriesArrary[i];
        if ([model isMemberOfClass:[CaloriesModel class]]) {
            totalCol1 += ((CaloriesModel *)model).totalAmount;
            
        }
        
    }
    for (int i = 0; i < sportCaloriesArrary.count; i++) {
        id model = sportCaloriesArrary[i];
        if ([model isMemberOfClass:[CaloriesModel class]]) {
            totalCol2 += ((CaloriesModel *)model).totalAmount;
            
        }
        
    }
    
    if (self.isFoodCalories) {
        self.promtLabel2.text =  [NSString stringWithFormat:@"饮食摄入总量 : %.1f cal",totalCol1];
    }else{
        self.promtLabel2.text =  [NSString stringWithFormat:@"运动消耗总量 : %.1f cal",totalCol2];
        
    }
    

}

//计算日期

- (void)calculateDateCol
{
    //今天如果是周一的话 之前的全部清空 否则 ++++
    NSDate *localDate =  [[NSUserDefaults standardUserDefaults] objectForKey:@"LocalDate"];
    
    if ([self isCurrentDay:localDate]) {
        //是同一天的话
        
    }else{
         //删除文件
        NSArray *contentArr = @[@"Documents/food_0.plist",@"Documents/food_1.plist",@"Documents/food_2.plist",@"Documents/food_3.plist",@"Documents/food_4.plist",@"Documents/sport.plist"];
        for (NSString *contentStr in contentArr) {
            NSString *filename  = [NSHomeDirectory() stringByAppendingPathComponent:contentStr];
            [[NSFileManager defaultManager] removeItemAtPath:filename error:nil];
        }
        [[NSUserDefaults standardUserDefaults] setObject:[NSDate date] forKey:@"LocalDate"];
    }

   
}


//判断两个星期是否为同一天

- (BOOL)isCurrentDay:(NSDate *)aDate
{
    if (aDate==nil) return NO;
    
    NSCalendar *cal = [NSCalendar currentCalendar];
    NSDateComponents *components = [cal components:(NSEraCalendarUnit|NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit) fromDate:[NSDate date]];
    NSDate *today = [cal dateFromComponents:components];
    components = [cal components:(NSEraCalendarUnit|NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit) fromDate:aDate];
    NSDate *otherDate = [cal dateFromComponents:components];
    if([today isEqualToDate:otherDate])
        return YES;
    
    return NO;
}

- (void)viewDidAppear:(BOOL)animated
{
//    [self requestEveryDayAmountDta];
//    [self calculateDateCol];
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
