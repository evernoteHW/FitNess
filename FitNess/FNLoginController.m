//
//  YDLoginController.m
//  FitNess
//
//  Created by liuguoyan on 14-10-2.
//  Copyright (c) 2014年 liuguoyan. All rights reserved.
//

#import "FNLoginController.h"
#import "FNLoginSenceDataManager.h"
#import "FNRegistViewController.h"
#import "FNHomeTabBarController.h"
#import "ChooseAttentionController.h"
#import "UMSocial.h"

@interface FNLoginController ()<UMSocialUIDelegate>

@end

@implementation FNLoginController


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad
{

    [super viewDidLoad];
    [self setUpForDismissKeyboard];
    [self createLoginView];
    [self automaticLogin];

}
-(void) createLoginView
{
    //设置隐藏navigation bar
    [[[self navigationController] navigationBar ]setHidden:YES];
    
    //UIImageView * backImageView;
    _backImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, DIME_SCREEN_W, DIME_SCREEN_H)];
    [_backImageView setImage:[UIImage imageNamed:@"regist_bg"]];
    [_backImageView setContentMode:UIViewContentModeScaleToFill];
    [self.view addSubview:_backImageView];
    
    
    //UIScrollView * scrollView;
    _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, DIME_SCREEN_W, DIME_SCREEN_H)];
    [_scrollView showsVerticalScrollIndicator];
    [_scrollView setContentSize:CGSizeMake(DIME_SCREEN_W, _px(1130))];
    [self.view addSubview:_scrollView];
    
    
    //UIImageView * logoImg;
    _logoImg = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"logo"]];
    [_logoImg setCenter:CGPointMake(DIME_SCREEN_W/2, _px(240))];
    [_logoImg setBounds:CGRectMake(_px(0), _px(0), _px(416), _px(303))];
    [_scrollView addSubview:_logoImg];
    
    //UITextField * phoneInputer;
    _phoneInputer = [[UITextField alloc ]initWithFrame:CGRectMake((DIME_SCREEN_W-_px(554))/2, _px(495), _px(554), _px(85))];
    [_phoneInputer setBackground:[UIImage imageNamed:@"imp_number"]];
    [_phoneInputer setPlaceholder:@"请输入用户名"];
    _phoneInputer.clearButtonMode = UITextFieldViewModeWhileEditing;
    _phoneInputer.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    _phoneInputer.textColor = [UIColor blackColor];
    _phoneInputer.backgroundColor = [UIColor clearColor];
    [_phoneInputer setValue:[NSNumber numberWithInt:_px(140)] forKey:@"paddingLeft"];
    _phoneInputer.font = FONT_SIZE(15);
    
    [_scrollView addSubview:_phoneInputer];
    
//    UITextField * pwdInputer;
    _pwdInputer = [[UITextField alloc ]initWithFrame:CGRectMake((DIME_SCREEN_W-_px(554))/2, _px(600), _px(554), _px(85))];
    [_pwdInputer setBackground:[UIImage imageNamed:@"imp_password"]];
    [_pwdInputer setKeyboardType:UIKeyboardTypeDefault];
    [_pwdInputer setPlaceholder:@"请输入密码"];
    _pwdInputer.clearButtonMode = UITextFieldViewModeWhileEditing;
    _pwdInputer.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    _pwdInputer.textColor = [UIColor blackColor];
    _pwdInputer.backgroundColor = [UIColor clearColor];
    _pwdInputer.font = FONT_SIZE(15);
    _pwdInputer.secureTextEntry = YES;
    _pwdInputer.returnKeyType = UIReturnKeyDone;
    [_pwdInputer setValue:[NSNumber numberWithInt:_px(140)] forKey:@"paddingLeft"];
    [_scrollView addSubview:_pwdInputer];
    
//  UIButton * _loginButton;
    
    _loginButton = [[UIButton alloc]initWithFrame:CGRectMake((DIME_SCREEN_W-_px(550))/2, _px(705), _px(550), _px(85))];
    [_loginButton setImage:[UIImage imageNamed:@"login_btn"] forState:UIControlStateNormal];
    [_loginButton addTarget:self action:@selector(onLoginClick) forControlEvents:UIControlEventTouchUpInside];
    [_scrollView addSubview:_loginButton];
    
    //_forgetPwdLable
//    _forgetPwdLable = [UIButton buttonWithType:UIButtonTypeCustom];
//    _forgetPwdLable.frame = CGRectMake(DIME_SCREEN_W-_px(150), _px(786), _px(100), _px(28));
//    [_forgetPwdLable setTitle:@"忘记密码" forState:UIControlStateNormal];
//    [_forgetPwdLable setTitleColor:R_COLOR_NOMARL_GREY forState:UIControlStateNormal];
//    [_forgetPwdLable setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
//    [_forgetPwdLable.titleLabel setFont:FONT_SIZE(_px(26))];
//    [_forgetPwdLable sizeToFit];
//    [_forgetPwdLable addTarget:self action:@selector(onForgetPwd) forControlEvents:UIControlEventTouchUpInside];
//    [_scrollView addSubview:_forgetPwdLable];
    
//    UILabel * _threePartyLandLable;
    
    _threePartyLandLable = [[UILabel alloc]initWithFrame:CGRectMake((DIME_SCREEN_W-_px(180))/2, _px(850), _px(180), _px(28))];
    [_threePartyLandLable setFont:FONT_SIZE(_px(28))];
    _threePartyLandLable.textColor = R_COLOR_NOMARL_GREY;
    _threePartyLandLable.text = @"通过第三方登陆";
    [_threePartyLandLable sizeToFit];
    [_scrollView addSubview:_threePartyLandLable];
    
//    UIButton * _sinaBtn;
    _sinaBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _sinaBtn.frame = CGRectMake(DIME_SCREEN_W/2-_px(150), _px(910), _px(150), _px(56));
    [_sinaBtn addTarget:self action:@selector(onSinaClick) forControlEvents:UIControlEventTouchUpInside];
    [_sinaBtn setBackgroundImage:[UIImage imageNamed:@"sina_logo"] forState:UIControlStateNormal];
    [_sinaBtn setContentMode:UIViewContentModeScaleAspectFit];
    [_scrollView addSubview:_sinaBtn];
    
//    UIButton * _qqBtn;
    _qqBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _qqBtn.frame = CGRectMake(DIME_SCREEN_W/2+_px(60), _px(910), _px(100), _px(56));
    [_qqBtn setBackgroundImage:[UIImage imageNamed:@"qq_logo"] forState:UIControlStateNormal];
    [_qqBtn setContentMode:UIViewContentModeScaleAspectFit];
    [_qqBtn addTarget:self action:@selector(onQQClick) forControlEvents:UIControlEventTouchUpInside];
    [_scrollView addSubview:_qqBtn];
    
//    UIButton * _registBtn;
    _registBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _registBtn.frame = CGRectMake(DIME_SCREEN_W/2-_px(150), _px(1000), _px(100), _px(38));
    [_registBtn setBackgroundImage:[UIImage imageNamed:@"quick_regist"] forState:UIControlStateNormal];
    [_registBtn addTarget:self action:@selector(onRegist) forControlEvents:UIControlEventTouchUpInside];
    [_scrollView addSubview:_registBtn];
    
//    UIButton * _wanderBtn;
    _wanderBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _wanderBtn.frame = CGRectMake(DIME_SCREEN_W/2+_px(50), _px(1000), _px(100), _px(38));
    [_wanderBtn setBackgroundImage:[UIImage imageNamed:@"look"] forState:UIControlStateNormal];
     [_wanderBtn addTarget:self action:@selector(onWander) forControlEvents:UIControlEventTouchUpInside];
    [_scrollView addSubview:_wanderBtn];
    
}

- (void) automaticLogin
{
    NSUserDefaults *userDef = [NSUserDefaults standardUserDefaults];
    NSDictionary *user = [userDef objectForKey:@"user"];
    
    if (user) {
        UserModel *mUser = [UserModel modelWithDictionary:user];
        [[FNDataKeeper sharedInstance]setUserModel:mUser];
        _phoneInputer.text = mUser.userName;
        _pwdInputer.text = mUser.password;
        [self onLoginClick];
    }
}

//登陆
-(void) onLoginClick
{

//    
//    FNHomeTabBarController *controler = [[FNHomeTabBarController alloc]init];
//    [self.navigationController pushViewController:controler animated:YES];
    ///////////////////////////////////////
    
    FNLoginSenceDataManager *mgr = [FNLoginSenceDataManager senceDataManagerHasParams];
    
    NSString *phone = _phoneInputer.text;
    NSString *pwd = _pwdInputer.text;

    if (!phone || !pwd ) {
        [[TKAlertCenter defaultCenter]postAlertWithMessage:@"请输入正确信息"];
        return;
    }
    [self showHud];
    [mgr.params setObject:phone forKey:URL_DATA_K_USERNAME];
    [mgr.params setObject:pwd forKey:URL_DATA_K_PASSWORD];
    [mgr fetchDataWithModule:MODELS_MODEL_USERLOGIN method:MODELS_METHOD_CHECKLOGIN params:mgr.params successListener:^(NSDictionary *result,NSString *msg){
        [[TKAlertCenter defaultCenter]postAlertWithMessage:@"登陆成功"];
        
        NSUserDefaults *userDef = [NSUserDefaults standardUserDefaults];
        NSDictionary *user = [result objectForKey:@"data"][0];
        if (userDef) {
            [userDef setObject:user forKey:@"user"];
            [userDef synchronize];
        }
        
        [[FNDataKeeper sharedInstance] updateUser:[UserModel modelWithDictionary:user]];
        FNHomeTabBarController *controler = [[FNHomeTabBarController alloc]init];
        NSLog(@"%@",[[[FNDataKeeper sharedInstance] getUser] userName]);
        [self.navigationController pushViewController:controler animated:YES];
        
        _pwdInputer.text = @"";
        [self hideHud];
    } failedListener:^(NSString *msg){
        [[TKAlertCenter defaultCenter]postAlertWithMessage:@"请核对您的用户信息"];
        NSLog(@"onFailedBlock %@",msg);
        [self hideHud];
    } timeOutListener:^{
        
    }];
}
//新浪按钮
-(void) onSinaClick
{
    NSLog(@"新浪按钮");
    UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToSina];
    snsPlatform.loginClickHandler(self,[UMSocialControllerService defaultControllerService],YES,^(UMSocialResponseEntity *response){
        NSLog(@"response is %@",response);
    });
    //设置回调对象
    [UMSocialControllerService defaultControllerService].socialUIDelegate = self;
    //实现授权回调
}

-(void)didFinishGetUMSocialDataInViewController:(UMSocialResponseEntity *)response
{
    if (response.viewControllerType == UMSViewControllerOauth) {
        NSLog(@"didFinishOauthAndGetAccount response is %@",response);
        [[TKAlertCenter defaultCenter] postAlertWithMessage:@"授权成功"];
    }
}

//QQ按钮
-(void) onQQClick
{
  NSLog(@"QQ按钮");
    UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToQQ];
    snsPlatform.loginClickHandler(self,[UMSocialControllerService defaultControllerService],YES,^(UMSocialResponseEntity *response){
        NSLog(@"response is %@",response);
    });
    //设置回调对象
    [UMSocialControllerService defaultControllerService].socialUIDelegate = self;

    
}
//忘记密码
-(void) onForgetPwd
{

}
//快速注册
-(void) onRegist
{
    FNRegistViewController *registController = [[FNRegistViewController alloc]init];
    [[self navigationController]pushViewController:registController animated:YES];
    
}
//随便看看
-(void) onWander
{
    
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"isLookrandom"];
    FNHomeTabBarController *controler = [[FNHomeTabBarController alloc]init];
    controler.selectedIndex = 1;
    [self.navigationController pushViewController:controler animated:YES];
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"isLookrandom"];
}




@end