//
//  RecordFoodViewController.m
//  FitNess
//
//  Created by WeiHu on 14/11/8.
//  Copyright (c) 2014年 WeiHu. All rights reserved.
//

#import "RecordFoodViewController.h"
#import "UIImageView+WebCache.h"

#define NUMBERS @"0123456789\n"

@interface RecordFoodViewController ()<UITextFieldDelegate>
{
    UITextField *searchBar;
}
@property (nonatomic, strong) UIImageView *foodImageView;               //食材的头像
@property (nonatomic, strong) UILabel *foodNameLabel;               //食材的名字
@property (nonatomic, strong) UILabel *foodCommentLabel;            //食材的评价

@end

@implementation RecordFoodViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIButton *button =[[UIButton alloc]initWithFrame:CGRectMake(0, 0, _px(90), _px(40))];
    [button setTitle:@"保存" forState:UIControlStateNormal];
    button.titleLabel.font = FONT_SIZE(_px(30));
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(addColFoodWithDic) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *settBar = [[UIBarButtonItem alloc]initWithCustomView:button];
    [self.navigationItem setRightBarButtonItem:settBar];
    
    self.navigationItem.title = @"纪录";
    
    
    UIView *whtieUpView = [[UIView alloc] initWithFrame:CGRectMake(10, 10, 300, 110)];
    whtieUpView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:whtieUpView];
    
    self.foodImageView =[[UIImageView alloc]initWithFrame:CGRectMake(15, 15,70, 70)];
    self.foodImageView.backgroundColor = [UIColor clearColor];
    self.foodImageView.image = (self.img )?self.img:[UIImage imageNamed:@"icon"];
    [whtieUpView  addSubview:self.foodImageView];
    
    self.foodNameLabel =    [[UILabel alloc]initWithFrame:CGRectMake(self.foodImageView.right + 5, 5 ,180,30)];
    self.foodNameLabel.numberOfLines = 0;
    self.foodNameLabel.backgroundColor = [UIColor clearColor];
    self.foodNameLabel.text = self.nameStr;
    [whtieUpView  addSubview:self.foodNameLabel];

    self.foodCommentLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.foodImageView.right + 5, self.foodNameLabel.bottom , self.foodNameLabel.width - 10,50)];
    self.foodCommentLabel.numberOfLines = 3;
    self.foodCommentLabel.backgroundColor = [UIColor clearColor];
    self.foodCommentLabel.textColor = [UIColor blackColor];
    self.foodCommentLabel.text = @"";
    self.foodCommentLabel.text = self.commentStr;
    self.foodCommentLabel.font = [UIFont boldSystemFontOfSize:13.0f];
    [whtieUpView  addSubview:self.foodCommentLabel];
    
    searchBar = [[UITextField alloc] initWithFrame:CGRectMake(10, whtieUpView.bottom + 10, 300, 30)];
    searchBar.delegate = self;
    searchBar.returnKeyType = UIReturnKeyDone;
    NSString *tag =  [[NSUserDefaults standardUserDefaults] objectForKey:@"food_btn_tag"];
    if ([tag integerValue] != 5) {
        searchBar.placeholder = @"单位 : 克(g)";
    }else{
        searchBar.placeholder = @"时间 : 分钟";
    }
    
    searchBar.keyboardType = UIKeyboardTypeNumberPad;
    searchBar.backgroundColor=[UIColor whiteColor];
    searchBar.font = [UIFont systemFontOfSize:15.0f];
    searchBar.textColor = [UIColor blackColor];
    [self.view addSubview:searchBar];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    [self addColFoodWithDic];
    return YES;
}

- (void)addColFoodWithDic
{
    //得到完整的文件名
    if (searchBar.text.length == 0) {
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                        message:@"请输入数字"
                                                       delegate:nil
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles:nil];
        
        [alert show];
        return;
    }
    
   NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:NUMBERS] invertedSet];
    NSString *filtered = [[searchBar.text componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
    BOOL basicTest = [searchBar.text isEqualToString:filtered];
    if(!basicTest)
    {
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                        message:@"请输入数字"
                                                       delegate:nil
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles:nil];
        
        [alert show];
        return;
    }

    
    NSString *filename = nil;
   NSString *tag =  [[NSUserDefaults standardUserDefaults] objectForKey:@"food_btn_tag"];
    switch ([tag integerValue]) {
        case 0:
        {
            filename = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/food_0.plist"];
        }
            break;
        case 1:
        {
            filename = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/food_1.plist"];
        }
            break;
        case 2:
        {
            filename = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/food_2.plist"];
        }
            break;
        case 3:
        {
            filename = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/food_3.plist"];
        }
            break;
        case 4:
        {
            filename = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/food_4.plist"];
        }
            break;
        case 5:
        {
            filename = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/sport.plist"];
        }
            break;
    }
    NSMutableArray *foodArr = [[NSMutableArray alloc] initWithContentsOfFile:filename];
    if (foodArr == nil) {
        foodArr = [NSMutableArray array];
    }
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:self.selectedDic];
    [dic setObject:searchBar.text forKey:@"colCount"];
    [foodArr addObject:dic];
    [foodArr writeToFile:filename atomically:YES];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"requestEveryDayAmountData" object:nil];
    
//    [self.navigationController popToViewController:self.navigationController.viewControllers[1] animated:YES];
//    recordFoodCol
    [self recordFoodCol];
}

- (void)recordFoodCol
{
    [self showHud];
    
    NSMutableDictionary *parametersDic = [NSMutableDictionary dictionary];
    NSString *tag =  [[NSUserDefaults standardUserDefaults] objectForKey:@"food_btn_tag"];
    [parametersDic setObject:[[FNDataKeeper sharedInstance] getUserId]  forKey:URL_DATA_K_USER_ID];
    NSString *method = @"";
    if ([tag integerValue]  == 5) {
        [parametersDic setObject:self.selectedDic[@"id"] forKey:URL_DATA_K_SPORTID];
//        [parametersDic setObject:@"1" forKey:URL_DATA_K_FOODDATETYPE];
        NSLog(@"%f",[self.selectedDic[@"heatNum"] floatValue]);
        CGFloat sportKll = [searchBar.text floatValue] *( [self.selectedDic[@"sportHeat"] floatValue] /60.0);
        [parametersDic setObject:[NSString stringWithFormat:@"%.1f",sportKll] forKey:@"sportKll"];
        [parametersDic setObject:@"1" forKey:URL_DATA_K_TYPE];
        [parametersDic setObject:searchBar.text forKey:@"sportTime"];
        [parametersDic setObject:self.selectedDic[@"sportName"] forKey:@"sportName"];
        method = MODELS_METHOD_ADD_USER_SPORT_DETAIL;
    }else{
        [parametersDic setObject:self.selectedDic[@"foodId"] forKey:URL_DATA_K_FOODID];
        [parametersDic setObject:@"1" forKey:URL_DATA_K_FOODDATETYPE];
        NSLog(@"%f",[self.selectedDic[@"heatNum"] floatValue]);
        CGFloat foodKll = [searchBar.text floatValue]/100.0 * [self.selectedDic[@"heatNum"] floatValue];
        [parametersDic setObject:[NSString stringWithFormat:@"%0.2f",foodKll] forKey:URL_DATA_K_FOODKLL];
        [parametersDic setObject:@"0" forKey:URL_DATA_K_TYPE];
        [parametersDic setObject:searchBar.text forKey:@"foodWeight"];
        [parametersDic setObject:self.selectedDic[@"foodName"] forKey:@"foodName"];
        method = MODELS_METHOD_ADD_USER_FOOD_DETAIL;

    }
       //今天如果是周一的话 之前的全部清空 否则 ++++
    NSDate *localDate =  [[NSUserDefaults standardUserDefaults] objectForKey:@"LocalDate"];
    
    if ([self isCurrentDay:localDate]) {
    }else{
     
        [[NSUserDefaults standardUserDefaults] setObject:[NSDate date] forKey:@"LocalDate"];
    }
    __unsafe_unretained RecordFoodViewController *weakSelf = self;
    [[NetworkManager shareManager] requestParams:parametersDic withModule:MODELS_MODEL_USERINFOMANGER method:method finishBlock:^(DataServies *request, id result) {
        
        NSString *msg = [result objectForKey:@"msg"];
        if ([[result objectForKey:@"flag"] integerValue] == 1) {
            
            [[TKAlertCenter defaultCenter] postAlertWithMessage:@"添加成功"];
            [weakSelf.navigationController popToViewController:self.navigationController.viewControllers[1] animated:YES];
        }else{
            NSLog(@"%@",msg);
        }
        [weakSelf hideHud];
        
    } failBlock:^(DataServies *request, NSError *error) {
        
        [weakSelf hideHud];
    }];
    

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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end