//
//  BMRViewController.m
//  FitNess
//
//  Created by liuguoyan on 14-10-28.
//  Copyright (c) 2014年 liuguoyan. All rights reserved.
//

#import "BMRViewController.h"
#import "FoodPubController.h"
#import "RTLabel.h"

#define BMR_MSG @"BMR_MSG"
#define BMR_VALUE @"BMR_VALUE"


#define RESULT_PATTERN  @"<font size=13 color='#333333'>%@  </font><font size=15 color='#FF6794'>%@</font>"

@interface BMRViewController ()
{
    //男
    UIButton *_maleSelector;
    //女
    UIButton *_femaleSelector;
    
    //年龄输入框
    UITextField *_ageInputer;
    //身高输入框
    UITextField *_heigthInputer;
    //体输入框
    UITextField *_weightInputer;
    
    //测试结果
    RTLabel *_testResult;
    //你的BMI值
    RTLabel *_youBMI;

    UIScrollView *_scrollView;
    
    
    int gender_male ;
    int gender_female ;
    int gender_selected ;
    
}
@end

@implementation BMRViewController



- (void)viewDidLoad
{
    [super viewDidLoad];
    [self createView];
    [self initData];
    [self setListeners];
}




-(double)calculatorBmrWithage:(double)age height:(double)height weight:(double)wight isBody:(BOOL)isbody
{
    double result = 0;
    if (isbody) {
        result = 66 + (13.7 * wight) + (5.0 * height) - (6.8 * age);
    } else {
        result = 655 + (9.6 * wight) + (1.7 * height) - (4.7 * age);
    }
    return result;
}


-(void)onSubmit
{
    if (!_heigthInputer.text || _heigthInputer.text.length==0 || !_weightInputer.text || _weightInputer.text.length==0) {
        
        [[TKAlertCenter defaultCenter]postAlertWithMessage:@"请输入身高体重信息"];
        return;
    }
    double age = _ageInputer.text.doubleValue;
    double height = _heigthInputer.text.doubleValue;
    double weight = _weightInputer.text.doubleValue;
    double bmr = [self calculatorBmrWithage:age height:height weight:weight isBody:gender_selected==gender_male?YES:NO ];
    
    NSString *testResult =@"";
    NSString *dialogMsg =@"";
    
    
    if(bmr<1650){
        dialogMsg = [NSString stringWithFormat:@"您的BMR指数为%.1f,您的BMR指数过低，请注意增加营养！",bmr];
        testResult = @"BMR指数过低";
    }else if(bmr > 1750){
        dialogMsg = [NSString stringWithFormat:@"您的BMR指数为%.1f,您的BMR指数过高，请注意保持体形！",bmr];
        testResult = @"BMR指数过高";
    }else{
        dialogMsg = [NSString stringWithFormat:@"您的BMR指数为%.1f,您的BMR指数在正常范围，继续保持哦！",bmr];
        testResult = @"BMR指数正常";
    }
    
    NSUserDefaults *userDef = [NSUserDefaults standardUserDefaults];
    [userDef setObject:testResult forKey:BMR_MSG];
    [userDef setObject:[NSString stringWithFormat:@"%.1f",bmr] forKey:BMR_VALUE];
    [userDef synchronize];
    
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:dialogMsg delegate:self cancelButtonTitle:@"好的" otherButtonTitles:@"去运动", nil];
    [alertView show];
    
    NSString *bmrstr = [NSString stringWithFormat:@"%.1f",bmr];
    
    NSString *wtl = [NSString stringWithFormat:RESULT_PATTERN ,@"测试结果",testResult==nil ? @"--":testResult];
    _testResult.text = wtl;

    wtl = [NSString stringWithFormat:RESULT_PATTERN ,@"你的基础代谢",bmrstr ==nil ? @"--":bmrstr];
    _youBMI.text = wtl;
    
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
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
    [self.navigationItem setTitle:@"BMR测试"];
    
    gender_male = 10;
    gender_female = 20;
    gender_selected = gender_male;
    
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
    
    
    //    UIButton * _maleSelector;
    _maleSelector = [self generateGenderSelectWithNormalImg:@"imp_boy" selectedImg:@"imp_select_boy" xPos:_px(40)];
    _maleSelector.tag = gender_male;
    [_maleSelector addTarget:self action:@selector(onGenderClick:) forControlEvents:UIControlEventTouchUpInside];
    [_maleSelector setSelected:YES];
    [_scrollView addSubview:_maleSelector];
    
    //    UIButton * _femaleSelector;
    _femaleSelector = [self generateGenderSelectWithNormalImg:@"imp_girl" selectedImg:@"imp_select_girl" xPos:_px(346)];
    _femaleSelector.tag = gender_female;
    [_femaleSelector addTarget:self action:@selector(onGenderClick:) forControlEvents:UIControlEventTouchUpInside];
    [_scrollView addSubview:_femaleSelector];
    
    
    
    ///////年龄
    
    UIImageView *ainputerbac = [[UIImageView alloc]initWithFrame:CGRectMake(_px(40), _px(168), _px(548), _px(70))];
    [ainputerbac setImage:[UIImage imageNamed:@"testtool_inputer"]];
    [_scrollView addSubview:ainputerbac];
    
    UILabel *ahLable = [[UILabel alloc]initWithFrame:CGRectMake(_px(30), _px(20), _px(60), _px(30))];
    [ahLable setTextColor:[UIColor grayColor]];
    ahLable.font = FONT_SIZE(13);
    ahLable.text = @"年龄";
    [ainputerbac addSubview:ahLable];
    
    _heigthInputer =[[UITextField alloc]initWithFrame:CGRectMake(_px(170), _px(172), _px(340), _px(70))];
    [_heigthInputer setPlaceholder:@"输入年龄"];
    [_heigthInputer setKeyboardType:UIKeyboardTypeNumberPad];
    _heigthInputer.font = FONT_SIZE(13);
    [_scrollView addSubview:_heigthInputer];
    
    
    //////身高
    
    
    UIImageView *inputerbac = [[UIImageView alloc]initWithFrame:CGRectMake(_px(40), _px(256), _px(548), _px(70))];
    [inputerbac setImage:[UIImage imageNamed:@"testtool_inputer"]];
    [_scrollView addSubview:inputerbac];
    
    UILabel *hLable = [[UILabel alloc]initWithFrame:CGRectMake(_px(30), _px(20), _px(60), _px(30))];
    [hLable setTextColor:[UIColor grayColor]];
    hLable.font = FONT_SIZE(13);
    hLable.text = @"身高";
    [inputerbac addSubview:hLable];
    
    _heigthInputer =[[UITextField alloc]initWithFrame:CGRectMake(_px(170), _px(260), _px(340), _px(70))];
    [_heigthInputer setPlaceholder:@"输入身高(cm)"];
    _heigthInputer.font = FONT_SIZE(13);
    [_heigthInputer setKeyboardType:UIKeyboardTypeNumberPad];
    [_scrollView addSubview:_heigthInputer];
    
    //////体重
    
    UIImageView *winputerbac = [[UIImageView alloc]initWithFrame:CGRectMake(_px(40), _px(346), _px(548), _px(70))];
    [winputerbac setImage:[UIImage imageNamed:@"testtool_inputer"]];
    [_scrollView addSubview:winputerbac];
    
    UILabel *wLable = [[UILabel alloc]initWithFrame:CGRectMake(_px(30), _px(20), _px(60), _px(30))];
    [wLable setTextColor:[UIColor grayColor]];
    wLable.font = FONT_SIZE(13);
    wLable.text = @"体重";
    [winputerbac addSubview:wLable];
    
    
    _weightInputer =[[UITextField alloc]initWithFrame:CGRectMake(_px(170), _px(348), _px(340), _px(70))];
    [_weightInputer setPlaceholder:@"输入体重(kg)"];
    _weightInputer.font = FONT_SIZE(13);
    [_weightInputer setKeyboardType:UIKeyboardTypeNumberPad];
    [_scrollView addSubview:_weightInputer];
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, _px(452), DIME_SCREEN_W, _px(2))];
    lineView.backgroundColor = [UIColor colorWithHexString:@"cccccc"];
    [_scrollView addSubview:lineView];
    
    
    UILabel *rLable = [[UILabel alloc]initWithFrame:CGRectMake(_px(40), _px(478), _px(130), _px(30))];
    [rLable setTextColor:[UIColor blackColor]];
    rLable.font = FONT_SIZE(13);
    rLable.text = @"计算结果";
    [_scrollView addSubview:rLable];
    
    
    NSUserDefaults *userDef = [NSUserDefaults standardUserDefaults];
    NSString * msg = [userDef objectForKey:BMR_MSG];
    NSString * value = [userDef objectForKey:BMR_VALUE];
    
    UIView *resultBack = [[UIView alloc]initWithFrame:CGRectMake(_px(20), _px(522), DIME_SCREEN_W-_px(40), _px(200))];
    resultBack.backgroundColor = [UIColor whiteColor];
    [_scrollView addSubview:resultBack];
    
    _testResult = [[RTLabel alloc]initWithFrame:CGRectMake(_px(30), _px(30), _px(530), _px(38))];
    NSString *wtl = [NSString stringWithFormat:RESULT_PATTERN ,@"测试结果",msg==nil ? @"--":msg];
    _testResult.text = wtl;
    [resultBack addSubview:_testResult];
    
    _youBMI = [[RTLabel alloc]initWithFrame:CGRectMake(_px(30), _testResult.frame.origin.y+_testResult.frame.size.height+_px(20), _px(530), _px(38))];
    wtl = [NSString stringWithFormat:RESULT_PATTERN ,@"你的基础代谢",value ==nil ? @"--":value];
    _youBMI.text = wtl;
    [resultBack addSubview:_youBMI];

    
}



-(id) generateGenderSelectWithNormalImg:(NSString*)imgdef selectedImg:(NSString *)imgselc xPos:(int)x
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(x, _px(76), _px(246), _px(78));
    [button setImage:[UIImage imageNamed:imgdef] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:imgselc] forState:UIControlStateSelected];
    button.adjustsImageWhenHighlighted = FALSE;
    
    return button;
}

-(void) onGenderClick:(UIButton*)sender
{
    
    NSLog(@"tag = %d",sender.tag);
    
    if (sender.tag == gender_male) {
        [_maleSelector setSelected:YES];
        [_femaleSelector setSelected:NO];
        gender_selected = gender_male;
    } else {
        [_maleSelector setSelected:NO];
        [_femaleSelector setSelected:YES];
        gender_selected = gender_female;
    }
}


-(void) initData
{

}

-(void) setListeners
{
    
}






@end
