//
//  BMIViewController.m
//  FitNess
//
//  Created by liuguoyan on 14-10-21.
//  Copyright (c) 2014年 liuguoyan. All rights reserved.
//

#import "BMIViewController.h"
#import "RTLabel.h"
#import "FoodPubController.h"

#define BMI_MSG @"BMI_MSG"
#define BMI_VALUE @"BMI_VALUE"


#define RESULT_PATTERN  @"<font size=13 color='#333333'>%@  </font><font size=15 color='#FF6794'>%@</font>"

@interface BMIViewController ()<UIAlertViewDelegate>
{
    //身高输入框
    UITextField *_heigthInputer;
    //体输入框
    UITextField *_weightInputer;
    
    //测试结果
    RTLabel *_testResult;
    //你的BMI值
    RTLabel *_youBMI;
    //体重过轻
    RTLabel *_weigthTooLight;
    //健康体重
    RTLabel *_properWei;
    //体重超重
    RTLabel *_overWeight;
    //体重肥胖
    RTLabel *_wightFat;
    
    UIScrollView *_scrollView;
}
@end

@implementation BMIViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    [self createView];
    [self initData];
    [self setListeners];
    
}


-(void)onSubmit
{
    if (!_heigthInputer.text || _heigthInputer.text.length==0 || !_weightInputer.text || _weightInputer.text.length==0) {
        
        [[TKAlertCenter defaultCenter]postAlertWithMessage:@"请输入身高体重信息"];
        return;
    }
    float height = _heigthInputer.text.floatValue/100;
    float weight = _weightInputer.text.floatValue;
    float bmi = (weight / (height * height));
    
    NSString *testResult =@"";
    NSString *dialogMsg =@"";
    if (bmi < 18.5) {
        testResult = @"体重过轻";
        dialogMsg = [NSString stringWithFormat:@"您的BMI指数为%.2f,不在正常范围之内，你需要增重喔！",bmi];
    }
    if (18.5 <= bmi && bmi < 24) {
        testResult = @"健康体重";
        dialogMsg = [NSString stringWithFormat:@"您的BMI指数为%.2f,在正常范围之内，继续保持运动哦！",bmi];
    }
    if (24 <= bmi && bmi < 28) {
        testResult = @"体重超重";
        dialogMsg = [NSString stringWithFormat:@"您的BMI指数为%.2f,不在正常范围之内，你需要减重哦！",bmi];
    }
    if (28 <= bmi) {
        testResult = @"体重肥胖";
        dialogMsg = [NSString stringWithFormat:@"您的BMI指数为%.2f,不在正常范围之内，你需要减重哦！",bmi];
    }
    
    NSUserDefaults *userDef = [NSUserDefaults standardUserDefaults];
    [userDef setObject:testResult forKey:BMI_MSG];
    [userDef setObject:[NSString stringWithFormat:@"%.1f",bmi] forKey:BMI_VALUE];
    [userDef synchronize];
    
    NSString *wtl = [NSString stringWithFormat:RESULT_PATTERN ,@"测试结果",testResult];
    [_testResult setText:wtl];
    
    wtl = [NSString stringWithFormat:RESULT_PATTERN ,@"你的BMI值",[NSString stringWithFormat:@"%.2f",bmi]];
    [_youBMI setText:wtl];

    
    
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:dialogMsg delegate:self cancelButtonTitle:@"好的" otherButtonTitles:@"去运动", nil];
    [alertView show];
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSLog(@"button index = %d",buttonIndex);
    
    if (buttonIndex==1) {
        FoodPubController *contrller = [[FoodPubController alloc]init];
        contrller.isSport = YES;
        [contrller setHidesBottomBarWhenPushed:YES];
        [self.navigationController pushViewController:contrller animated:YES];
    }
}

-(void) createView
{
    
    
    
    [self setUpForDismissKeyboard];
    
    [self.view setBackgroundColor:R_COLOR_COMMON_BAC];
    self.navigationController.navigationBar.translucent = NO;
    self.tabBarController.tabBar.translucent = NO;
    self.navigationController.navigationBar.barTintColor = COLOR_NAVIGATIONBAR_UICOLOR ;
    [self.navigationItem setTitle:@"BMI指数"];
    
    
    
    UIButton *button =[[UIButton alloc]initWithFrame:CGRectMake(0, 0, _px(88), _px(44))];
    [button setTitle:@"提交" forState:UIControlStateNormal];
    button.titleLabel.font = FONT_SIZE(13);
    [button addTarget:self action:@selector(onSubmit) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *settBar = [[UIBarButtonItem alloc]initWithCustomView:button];
    [self.navigationItem setRightBarButtonItem:settBar];
    
    
    
    _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, DIME_SCREEN_W, DIME_SCREEN_H-TITLE_HEI)];
    [_scrollView setContentSize:CGSizeMake(DIME_SCREEN_W, DIME_SCREEN_H)];
    
    [self.view addSubview:_scrollView];
    
    UILabel *iLable = [[UILabel alloc]initWithFrame:CGRectMake(_px(40), _px(34), _px(130), _px(30))];
    [iLable setTextColor:[UIColor blackColor]];
    iLable.font = FONT_SIZE(13);
    iLable.text = @"输入信息";
    [_scrollView addSubview:iLable];
    
    UIImageView *inputerbac = [[UIImageView alloc]initWithFrame:CGRectMake(_px(40), _px(76), _px(548), _px(70))];
    [inputerbac setImage:[UIImage imageNamed:@"testtool_inputer"]];
    [_scrollView addSubview:inputerbac];
    
    UILabel *hLable = [[UILabel alloc]initWithFrame:CGRectMake(_px(30), _px(20), _px(60), _px(30))];
    [hLable setTextColor:[UIColor grayColor]];
    hLable.font = FONT_SIZE(13);
    hLable.text = @"身高";
    [inputerbac addSubview:hLable];
    
    _heigthInputer =[[UITextField alloc]initWithFrame:CGRectMake(_px(170), _px(80), _px(340), _px(70))];
    [_heigthInputer setKeyboardType:UIKeyboardTypeNumberPad];
    [_heigthInputer setPlaceholder:@"输入身高(cm)"];
    _heigthInputer.font = FONT_SIZE(13);
    [_scrollView addSubview:_heigthInputer];
    
    
    
    UIImageView *winputerbac = [[UIImageView alloc]initWithFrame:CGRectMake(_px(40), _px(166), _px(548), _px(70))];
    [winputerbac setImage:[UIImage imageNamed:@"testtool_inputer"]];
    [_scrollView addSubview:winputerbac];
    
    UILabel *wLable = [[UILabel alloc]initWithFrame:CGRectMake(_px(30), _px(20), _px(60), _px(30))];
    [wLable setTextColor:[UIColor grayColor]];
    wLable.font = FONT_SIZE(13);
    wLable.text = @"体重";
    [winputerbac addSubview:wLable];
    
    
    _weightInputer =[[UITextField alloc]initWithFrame:CGRectMake(_px(170), _px(168), _px(340), _px(70))];
    [_weightInputer setPlaceholder:@"输入体重(kg)"];
    _weightInputer.font = FONT_SIZE(13);
    [_scrollView addSubview:_weightInputer];
    [_weightInputer setKeyboardType:UIKeyboardTypeNumberPad];
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, _px(272), DIME_SCREEN_W, _px(2))];
    lineView.backgroundColor = [UIColor colorWithHexString:@"cccccc"];
    [_scrollView addSubview:lineView];
    
    
    UILabel *rLable = [[UILabel alloc]initWithFrame:CGRectMake(_px(40), _px(298), _px(130), _px(30))];
    [rLable setTextColor:[UIColor blackColor]];
    rLable.font = FONT_SIZE(13);
    rLable.text = @"计算结果";
    [_scrollView addSubview:rLable];
    
    
    NSUserDefaults *userDef = [NSUserDefaults standardUserDefaults];
    NSString * msg = [userDef objectForKey:BMI_MSG];
    NSString * value = [userDef objectForKey:BMI_VALUE];
    
    UIView *resultBack = [[UIView alloc]initWithFrame:CGRectMake(_px(20), _px(342), DIME_SCREEN_W-_px(40), _px(380))];
    resultBack.backgroundColor = [UIColor whiteColor];
    [_scrollView addSubview:resultBack];
    _testResult = [[RTLabel alloc]initWithFrame:CGRectMake(_px(30), _px(26), _px(530), _px(38))];
    NSString *wtl = [NSString stringWithFormat:RESULT_PATTERN ,@"测试结果",msg==nil ? @"--":msg];
    _testResult.text = wtl;
    [resultBack addSubview:_testResult];
    
    _youBMI = [[RTLabel alloc]initWithFrame:CGRectMake(_px(30), _testResult.frame.origin.y+_testResult.frame.size.height+_px(20), _px(530), _px(38))];
    wtl = [NSString stringWithFormat:RESULT_PATTERN ,@"你的BMI值",value ==nil ? @"--":value];
    _youBMI.text = wtl;
    [resultBack addSubview:_youBMI];
    
    
    _weigthTooLight = [[RTLabel alloc]initWithFrame:CGRectMake(_px(30), _youBMI.frame.origin.y+_youBMI.frame.size.height+_px(20), _px(530), _px(38))];
    wtl = [NSString stringWithFormat:RESULT_PATTERN ,@"体重过轻",@"BMI《18.5"];
    _weigthTooLight.text = wtl;
    [resultBack addSubview:_weigthTooLight];
    
    _properWei = [[RTLabel alloc]initWithFrame:CGRectMake(_px(30), _weigthTooLight.frame.origin.y+_weigthTooLight.frame.size.height+_px(20), _px(530), _px(38))];
    wtl = [NSString stringWithFormat:RESULT_PATTERN ,@"健康体重",@"BMI《18.5《24"];
    _properWei.text = wtl;
    [resultBack addSubview:_properWei];
    
    
    _overWeight = [[RTLabel alloc]initWithFrame:CGRectMake(_px(30), _properWei.frame.origin.y+_properWei.frame.size.height+_px(20), _px(530), _px(38))];
    wtl = [NSString stringWithFormat:RESULT_PATTERN ,@"体重超重",@"24《BMI《28"];
    _overWeight.text = wtl;
    [resultBack addSubview:_overWeight];
    
    _wightFat = [[RTLabel alloc]initWithFrame:CGRectMake(_px(30), _overWeight.frame.origin.y+_overWeight.frame.size.height+_px(20), _px(530), _px(38))];
    wtl = [NSString stringWithFormat:RESULT_PATTERN ,@"体重肥胖",@"28》BMI"];
    _wightFat.text = wtl;
    [resultBack addSubview:_wightFat];
    
    
    
    
}


-(void) initData
{
    
}

-(void) setListeners
{
    
}


@end
