//
//  Me_MainViewController.m
//  FitNess
//
//  Created by liuguoyan on 14-10-4.
//  Copyright (c) 2014年 liuguoyan. All rights reserved.
//

#import "Me_MainViewController.h"
#import "WeightRecordViewController.h"
#import "MotionRecordViewController.h"
#import "CommonEditController.h"
#import "MotionFriendsController.h"
#import "DataGraphController.h"
#import "EveryDayAmountController.h"

@interface Me_MainViewController ()<CommonEditControllerDelegate>
{
    
}
@end

@implementation Me_MainViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self createMe_MainView];
    self.leftButton.hidden = YES;
}

- (void) fetchUserInfo
{
    [self.senceDataManager.params removeAllObjects];
    [self.senceDataManager.params setObject:[[FNDataKeeper sharedInstance] getUserId] forKey:URL_DATA_K_USER_ID];
    [self.senceDataManager fetchDataWithModule:MODELS_MODEL_USERREGISTRY method:MODELS_METHOD_GETUSERBYUSERID params:self.senceDataManager.params successListener:^(NSDictionary *result,NSString *msg){
        NSArray *arr = result[@"data"];
        if (arr.count > 0) {
            NSDictionary *userdic = arr[0];
            UserModel *user = [UserModel modelWithDictionary:userdic];
            [[FNDataKeeper sharedInstance] updateUser:user];
        }
        [self refreshUI];
    } failedListener:^(NSString *msg){
        
    } timeOutListener:^{
        
    }];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self fetchUserInfo];
}

#pragma mark -
#pragma mark 按钮事件

//_rBtnWeiRecord;//体重记录
-(void)onrBtnWeiRecord
{
    WeightRecordViewController *controller = [[WeightRecordViewController alloc]init];
    [controller setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:controller animated:YES];
}
//_rBtnMotRecord;//心情记录
-(void)onrBtnMotRecord
{
    MotionRecordViewController *cnotroller = [[MotionRecordViewController alloc]init];
    [cnotroller setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:cnotroller animated:YES];
}
//_rBtnDayInsect;//每天卡路里摄入量
-(void)onrBtnDayInsect
{
    EveryDayAmountController *controller = [[EveryDayAmountController alloc]init];
    controller.isFoodCalories = YES;
    controller.hidesBottomBarWhenPushed = YES;
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"isAddCol"];
    [self.navigationController pushViewController:controller animated:YES];
}
//_rBtnDayConsume;//每天卡里路消耗
-(void)onrBtnDayConsume
{
    EveryDayAmountController *controller = [[EveryDayAmountController alloc]init];
    controller.hidesBottomBarWhenPushed = YES;
    controller.isFoodCalories = NO;
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"isAddCol"];
    [self.navigationController pushViewController:controller animated:YES];
}

//_cBtnWeight;//体重曲线
-(void)oncBtnWeight
{
    DataGraphController *controller = [[DataGraphController alloc]init];
    controller.hidesBottomBarWhenPushed = YES;
    controller.graphTitle = @"体重曲线";
    [self.navigationController pushViewController:controller animated:YES];
    
    
}
//_cBtnMotion;//心情盟友
-(void)oncBtnMotion
{
    MotionFriendsController *controller = [[MotionFriendsController alloc]init];
    controller.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:controller animated:YES];
}
//_cBtnDayInsect;//每天卡路里摄入
-(void)oncBtnDayInsect
{
    DataGraphController *controller = [[DataGraphController alloc]init];
    controller.hidesBottomBarWhenPushed = YES;
    controller.graphTitle = @"摄入能量曲线";
    [self.navigationController pushViewController:controller animated:YES];
}
//_cBtnDayConsume;//每天卡路里曲线
-(void)oncBtnDayConsume
{
    DataGraphController *controller = [[DataGraphController alloc]init];
    controller.hidesBottomBarWhenPushed = YES;
    controller.graphTitle = @"消耗能量曲线";
    [self.navigationController pushViewController:controller animated:YES];
}
//编辑昵称
-(void)editNickName
{
    
    /*
    CommonEditController *controller = [[CommonEditController alloc]init];
    controller.title = @"编辑昵称";
    controller.placeholder = @"输入新昵称";
    controller.delegate = self;
    controller.flag = 1;
    controller.keyboardType = UIKeyboardTypeDefault;
    [self.navigationController pushViewController:controller animated:YES];
     **/
}
//编辑减肥宣言
-(void)editAnnounce
{
    CommonEditController *controller = [[CommonEditController alloc]init];
    controller.placeholder = @"输入减肥宣言";
    controller.delegate = self;
    controller.flag = 2;
    controller.keyboardType = UIKeyboardTypeDefault;
    [self.navigationController pushViewController:controller animated:YES];
}

#pragma mark CommonEditControllerDelegate
-(void) onCommonEditConfirmWithFlag:(int) flag andContent:(NSString *)content
{
    switch (flag) {
        case 1:
            [_nickView setTitle:content forState:UIControlStateNormal];
            break;
        case 2:
//            [_announceView setTitle:content forState:UIControlStateNormal];
            [self updateWeightAnnounceWithContent:content];
            break;
    }
}

-(void) updateWeightAnnounceWithContent:(NSString *)content
{
    [self showHud];
    NSMutableDictionary *parametersDic = [NSMutableDictionary dictionary];
    [parametersDic setObject:[[FNDataKeeper sharedInstance] getUserId] forKey:URL_DATA_K_USER_ID];
    [parametersDic setObject:content forKey:URL_DATA_K_INCREAMFATTIP];
    __unsafe_unretained Me_MainViewController *weakSelf = self;
    [[NetworkManager shareManager] requestParams:parametersDic withModule:MODELS_MODEL_USERREGISTRY method:MODELS_METHOD_UPDATEINCREAMFATTIPBYUSERID finishBlock:^(DataServies *request, id result) {
        
        NSString *msg = [result objectForKey:@"msg"];
        if ([[result objectForKey:@"flag"] integerValue] == 1) {
            UserModel *user = [[FNDataKeeper sharedInstance]getUser];
            user.increamFatTip = content;
             _announceViewLabel.text = user.increamFatTip;
            [[TKAlertCenter defaultCenter] postAlertWithMessage:@"修改成功"];
        }else{
            [[TKAlertCenter defaultCenter] postAlertWithMessage:@"请求超时,请检查你的网络环境"];
            NSLog(@"%@",msg);
        }
        [weakSelf hideHud];
        
    } failBlock:^(DataServies *request, NSError *error) {
        [[TKAlertCenter defaultCenter] postAlertWithMessage:@"请求超时,请检查你的网络环境"];
        [weakSelf hideHud];
    }];
    
}

-(void)refreshUI
{

    UserModel *user = [[FNDataKeeper sharedInstance]getUser];
    
    [[SDWebImageManager sharedManager] downloadImageWithURL:[NSURL URLWithString:user.userImgPath] options:SDWebImageRetryFailed progress:^(NSInteger receivedSize, NSInteger expectedSize) {
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
        [_headIcon setImage:image forState:UIControlStateNormal];
    }];
    [_nickView setTitle:user.userName forState:UIControlStateNormal];
    _announceViewLabel.text = user.increamFatTip;
    [_registWeight setTitle:[NSString stringWithFormat:@"%@kg",user.registyWeight] forState:UIControlStateNormal];
    
    NSString *format = @"<font size=16 color='#FF6794'>%@</font><font size=16 color='#9E9E9E'>kg</font>";
    [NSString stringWithFormat:format,@"12"];
    _targetWeiht.text = [NSString stringWithFormat:format,user.permitWeight];
    _reducedWeight.text = [NSString stringWithFormat:format,user.increamFatWeight.length==0 ? @"0":[NSString stringWithFormat:@"%.02f",user.increamFatWeight.floatValue]];
    _dreamWeight.text = [NSString stringWithFormat:format,user.standWeight];
    
    _canInsectMore.text = [NSString stringWithFormat:@"还可摄入\r%@\rkcal",user.alsoNeedKll];
    _hasInsist.text = [NSString stringWithFormat:@"已坚持\r%@\rdays",user.singDays];
    _needReduce.text = [NSString stringWithFormat:@"已消耗 \r%@\rkcal",user.fixCalcExpKll];
    
    [_heartNum setTitle:[NSString stringWithFormat:@" * %@",user.heartNum] forState:UIControlStateNormal];
    
    
}

- (void)createMe_MainView
{
    [self.navigationItem setTitle:@"ME"];
//    UIImageView * _scrollBack;
    _scrollBack = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, DIME_SCREEN_W, DIME_SCREEN_H-(TITLE_HEI+TABBAR_HEI))];
    [_scrollBack setBackgroundColor:R_COLOR_COMMON_BAC];
    [self.view addSubview:_scrollBack];
    
//    UIScrollView * _scrollView;
    _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, DIME_SCREEN_W, DIME_SCREEN_H-(TITLE_HEI+TABBAR_HEI))];
    [_scrollView setContentSize:CGSizeMake(DIME_SCREEN_W, _px(910))];
    _scrollView.showsVerticalScrollIndicator = YES;
    [self.view addSubview:_scrollView];
    
//    UIView * _titleWhiteBack;//头部白色模块背影
    _titleWhiteBack = [[UIView alloc] initWithFrame:CGRectMake(_DIME_LEFT, _px(20), _DIME_CONT_SIZE, _px(326))];
    [_titleWhiteBack setBackgroundColor:[UIColor whiteColor]];
    [_scrollView addSubview:_titleWhiteBack];
    
//    UIButton * _headIcon;//头像
    _headIcon = [UIButton buttonWithType:UIButtonTypeCustom];
    [_headIcon setFrame:CGRectMake(_px(80) , _px(52), _px(142), _px(142))];
    [_headIcon setImage:[UIImage imageNamed:@"me_default_head_icon"] forState:UIControlStateNormal];
    [_headIcon setContentMode:UIViewContentModeScaleAspectFit];
    [CommonUtils generateRoundButton:_headIcon];
    [_scrollView addSubview:_headIcon];
    
    
//    UIButton * _nickView;//昵称
    _nickView = [UIButton buttonWithType:UIButtonTypeCustom];
    [_nickView setFrame:CGRectMake(DIME_SCREEN_W/2 - (_px(200)/2) , _px(84), _px(200), _px(30))];
    [_nickView setTitle:@"设置昵称" forState:UIControlStateNormal];
    [_nickView.titleLabel setFont:FONT_SIZE(14)];
    [_nickView setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_scrollView addSubview:_nickView];
    
//    UIButton * _announceView;//减肥宣言
//    _announceView = [UIButton buttonWithType:UIButtonTypeCustom];
//    [_announceView setFrame:CGRectMake(DIME_SCREEN_W/2 - (_px(200)/2) , _px(124), _px(200), _px(30))];
//    [_announceView setTitle:@"添加减肥宣言" forState:UIControlStateNormal];
//    [_announceView.titleLabel setFont:FONT_SIZE(12)];
//    [_announceView setTitleColor:R_COLOR_NOMARL_GREY forState:UIControlStateNormal];
//    _announceView.backgroundColor = [UIColor yellowColor];
    
    _announceViewLabel = [[UILabel alloc] initWithFrame:CGRectMake(DIME_SCREEN_W/2 - (_px(200)/2) + 20 , _px(124), _px(200), _px(80))];
    _announceViewLabel.backgroundColor = [UIColor clearColor];
    _announceViewLabel.font = FONT_SIZE(12);
    _announceViewLabel.textColor = R_COLOR_NOMARL_GREY;
    _announceViewLabel.text = @"添加减肥宣言";
    _announceViewLabel.numberOfLines = 2;
    [_scrollView addSubview:_announceViewLabel];
    
//    [_scrollView addSubview:_announceView];
    
    
//    UIButton * _announceBtn;//编辑宣言按钮
    _announceBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_announceBtn setFrame:CGRectMake(_announceViewLabel.right ,_announceViewLabel.top + 10, _px(27), _px(27))];
    [_announceBtn setImage:[UIImage imageNamed:@"me_edit_xuanyan"] forState:UIControlStateNormal];
    [_scrollView addSubview:_announceBtn];
    
    //////分界线
//    UIView *_headHLine;//头部横向分界线
    _headHLine = [[UIView alloc] initWithFrame:CGRectMake(_DIME_LEFT+_px(93), _px(214), DIME_SCREEN_W-(_DIME_LEFT*2+_px(93)), _px(2))];
    [_headHLine setBackgroundColor:R_COLOR_LINE];
    [_scrollView addSubview:_headHLine];
    
//    UIView *_headVLLine;//头部左部竖线
    _headVLLine = [[UIView alloc] initWithFrame:CGRectMake(_DIME_CONT_SIZE/3 + _DIME_LEFT, _px(226), _px(2), _px(110))];
    [_headVLLine setBackgroundColor:R_COLOR_LINE];
    [_scrollView addSubview:_headVLLine];
    
    
//    UIView *_headVRLine;//头部右部竖线
    _headVRLine = [[UIView alloc] initWithFrame:CGRectMake(_DIME_CONT_SIZE/3 *2 + _DIME_LEFT, _px(226), _px(2), _px(110))];
    [_headVRLine setBackgroundColor:R_COLOR_LINE];
    [_scrollView addSubview:_headVRLine];
    
    //注册体重
//    UIButton * _registWeight;
    _registWeight = [[UIButton alloc]initWithFrame:CGRectMake(_DIME_LEFT, _px(196), _px(93), _px(39))];
    [_registWeight setBackgroundImage:[UIImage imageNamed:@"me_body_tizhong_bg"] forState:UIControlStateNormal];
    [_registWeight setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_registWeight.titleLabel setFont:FONT_SIZE(9)];
    [_registWeight setTitle:@"0.0kg" forState:UIControlStateNormal];
    [_scrollView addSubview:_registWeight];
    
    
//    RTLabel * _targetWeiht;//目标体重
    _targetWeiht = [[RTLabel alloc]initWithFrame:CGRectMake(_DIME_LEFT, _px(240), _DIME_CONT_SIZE/3-_px(5), _px(40))];
    NSString *sample_ = @"<font size=16 color='#FF6794'>23</font><font size=16 color='#9E9E9E'>kg</font>";
    [_targetWeiht setTextAlignment:RTTextAlignmentCenter];
    [_targetWeiht setText:sample_];
    [_scrollView addSubview:_targetWeiht];
    
//    UILabel * _targetWeihtBot;
    _targetWeihtBot = [[UILabel alloc]initWithFrame:CGRectMake(_DIME_LEFT, _px(280), _DIME_CONT_SIZE/3-_px(5), _px(40))];
    [_targetWeihtBot setTextAlignment:NSTextAlignmentCenter];
    [_targetWeihtBot setFont:FONT_SIZE(15)];
    _targetWeihtBot.textColor = R_COLOR_NOMARL_GREY ;
    [_targetWeihtBot setText:@"目标体重"];
    [_scrollView addSubview:_targetWeihtBot];

    //    RTLabel * _reducedWeight;//已减重
    _reducedWeight = [[RTLabel alloc]initWithFrame:CGRectMake(_DIME_LEFT+_DIME_CONT_SIZE/3+_px(2), _px(240), _DIME_CONT_SIZE/3-_px(5), _px(40))];
    [_reducedWeight setTextAlignment:RTTextAlignmentCenter];
    [_reducedWeight setText:sample_];
    [_scrollView addSubview:_reducedWeight];
    
//    UILabel * _reducedWeightBot;
    _reducedWeightBot = [[UILabel alloc]initWithFrame:CGRectMake(_DIME_LEFT+_DIME_CONT_SIZE/3+_px(2), _px(280), _DIME_CONT_SIZE/3-_px(5), _px(40))];
    [_reducedWeightBot setTextAlignment:NSTextAlignmentCenter];
    [_reducedWeightBot setFont:FONT_SIZE(15)];
    _reducedWeightBot.textColor = R_COLOR_NOMARL_GREY ;
    [_reducedWeightBot setText:@"已减重"];
    [_scrollView addSubview:_reducedWeightBot];
    
//    RTLabel * _dreamWeight;//理想体重
    _dreamWeight = [[RTLabel alloc]initWithFrame:CGRectMake(_DIME_LEFT+_DIME_CONT_SIZE/3*2+_px(2), _px(240), _DIME_CONT_SIZE/3-_px(5), _px(40))];
    [_dreamWeight setTextAlignment:RTTextAlignmentCenter];
    [_dreamWeight setText:sample_];
    [_scrollView addSubview:_dreamWeight];
    
//    UILabel * _dreamWeightBot;
    _dreamWeightBot = [[UILabel alloc]initWithFrame:CGRectMake(_DIME_LEFT+_DIME_CONT_SIZE/3*2+_px(2), _px(280), _DIME_CONT_SIZE/3-_px(5), _px(40))];
    [_dreamWeightBot setTextAlignment:NSTextAlignmentCenter];
    [_dreamWeightBot setFont:FONT_SIZE(15)];
    _dreamWeightBot.textColor = R_COLOR_NOMARL_GREY ;
    [_dreamWeightBot setText:@"理想体重"];
    [_scrollView addSubview:_dreamWeightBot];
    
//    UILabel * _canInsectMore;//还可摄入
    _canInsectMore = [[UILabel alloc]initWithFrame:CGRectMake(_DIME_LEFT, _px(354), _DIME_CONT_SIZE/3-_px(2), _px(106))];
    UIColor *_canInsectMoreColor = [UIColor colorWithHexString:@"#FF729C"];
    [_canInsectMore setTextAlignment:NSTextAlignmentCenter];
    [_canInsectMore setBackgroundColor:_canInsectMoreColor];
    _canInsectMore.numberOfLines = 3;
    [_canInsectMore setFont:FONT_SIZE(12)];
    _canInsectMore.textColor = [UIColor whiteColor];
    [_canInsectMore setText:@"还可摄入\r0\rkcal"];
    [_scrollView addSubview:_canInsectMore];
    
//    UILabel * _hasInsist;//已坚持
    _hasInsist = [[UILabel alloc]initWithFrame:CGRectMake(_DIME_LEFT + _DIME_CONT_SIZE/3+_px(2), _px(354), _DIME_CONT_SIZE/3-_px(2), _px(106))];
    UIColor *_hasInsistColor = [UIColor colorWithHexString:@"#F3BD00"];
    [_hasInsist setTextAlignment:NSTextAlignmentCenter];
    [_hasInsist setBackgroundColor:_hasInsistColor];
    _hasInsist.numberOfLines = 3;
    [_hasInsist setFont:FONT_SIZE(12)];
    _hasInsist.textColor = [UIColor whiteColor];
    [_hasInsist setText:@"已坚持\r0\rdays"];
    [_scrollView addSubview:_hasInsist];
    
    
//    UILabel * _needReduce;//还需要消耗
    _needReduce = [[UILabel alloc]initWithFrame:CGRectMake(_DIME_LEFT + _DIME_CONT_SIZE/3*2+_px(4), _px(354), _DIME_CONT_SIZE/3-_px(2), _px(106))];
    UIColor *_needReduceColor = [UIColor colorWithHexString:@"#54CDFF"];
    [_needReduce setTextAlignment:NSTextAlignmentCenter];
    [_needReduce setBackgroundColor:_needReduceColor];
    _needReduce.numberOfLines = 3;
    [_needReduce setFont:FONT_SIZE(12)];
    _needReduce.textColor = [UIColor whiteColor];
    [_needReduce setText:@"已消耗\r0\rkcal"];
    [_scrollView addSubview:_needReduce];
    
    //中间两个背景
//    UIView * _centLeftBac;//中间左背景
    
    _centLeftBac = [[UIView alloc] initWithFrame:CGRectMake(_DIME_LEFT, _px(468), _DIME_CONT_SIZE/2-_px(2), _px(312))];
    [_centLeftBac setBackgroundColor:[UIColor whiteColor]];
    [_scrollView addSubview:_centLeftBac];
    
    
//    UIView * _centRigtBac;//中间右背景
    _centRigtBac = [[UIView alloc] initWithFrame:CGRectMake(_DIME_LEFT+_DIME_CONT_SIZE/2+_px(2), _px(468), _DIME_CONT_SIZE/2-_px(2), _px(312))];
    [_centRigtBac setBackgroundColor:[UIColor whiteColor]];
    [_scrollView addSubview:_centRigtBac];
    
    
//    UIButton * _rBtnWeiRecord;//体重记录
    _rBtnWeiRecord = [self generateBtnsWithImage:@"me_body_ic_tizhong" x:_DIME_LEFT+_px(80) y:_px(524) title:@"体重记录"];
    [_scrollView addSubview:_rBtnWeiRecord];

//    UIButton * _rBtnMotRecord;//心情记录
    _rBtnMotRecord = [self generateBtnsWithImage:@"me_body_ic_xinqing" x:_DIME_LEFT+_px(80) y:_px(586) title:@"心情记录"];
    [_scrollView addSubview:_rBtnMotRecord];

//    UIButton * _rBtnDayInsect;//每天卡路里摄入量
    _rBtnDayInsect = [self generateBtnsWithImage:@"me_body_ic_sheru" x:_DIME_LEFT+_px(80) y:_px(650) title:@"每天热量摄入"];
    [_scrollView addSubview:_rBtnDayInsect];
//    UIButton * _rBtnDayConsume;//每天卡里路消耗
    _rBtnDayConsume = [self generateBtnsWithImage:@"me_body_ic_xiaohao" x:_DIME_LEFT+_px(80) y:_px(714) title:@"每天热量消耗"];
    [_scrollView addSubview:_rBtnDayConsume];
    
    //记录的四个按钮
    //    UIImageView * _recordTitle;//记录头的图片
    _recordTitle = [[UIImageView alloc] initWithFrame:CGRectMake(_DIME_LEFT+_px(12), _px(483), _px(261), _px(70))];
    [_recordTitle setImage:[UIImage imageNamed:@"me_body_record"]];
    [_scrollView addSubview:_recordTitle];

    

    
//    UIButton * _cBtnWeight;//体重曲线
    _cBtnWeight = [self generateBtnsWithImage:@"me_body_ic_tizhong" x:DIME_SCREEN_W/2+_px(80) y:_px(524) title:@"体重曲线"];
    [_scrollView addSubview:_cBtnWeight];
//    UIButton * _cBtnMotion;//心情盟友
    _cBtnMotion = [self generateBtnsWithImage:@"me_body_ic_xinqing" x:DIME_SCREEN_W/2+_px(80) y:_px(586) title:@"心情盟友"];
    [_scrollView addSubview:_cBtnMotion];
//    UIButton * _cBtnDayInsect;//每天卡路里摄入
    _cBtnDayInsect = [self generateBtnsWithImage:@"me_body_ic_sheru" x:DIME_SCREEN_W/2+_px(80) y:_px(650) title:@"热量摄入曲线"];
    [_scrollView addSubview:_cBtnDayInsect];
//    UIButton * _cBtnDayConsume;//每天卡路里曲线
    _cBtnDayConsume = [self generateBtnsWithImage:@"me_body_ic_xiaohao" x:DIME_SCREEN_W/2+_px(80) y:_px(714) title:@"热量消耗曲线"];
    [_scrollView addSubview:_cBtnDayConsume];
    
    //图表的四个按钮
    //    UIImageView * _chatTitle;//图表头
    _chatTitle = [[UIImageView alloc] initWithFrame:CGRectMake(DIME_SCREEN_W/2+_px(16), _px(483), _px(261), _px(70))];
    [_chatTitle setImage:[UIImage imageNamed:@"me_body_chart"]];
    [_scrollView addSubview:_chatTitle];
    
    //最下面的部分
//    UIView * _btmBack;//底部背景
    _btmBack = [[UIView alloc] initWithFrame:CGRectMake(_DIME_LEFT, _px(788), _DIME_CONT_SIZE, _px(104))];
    [_btmBack setBackgroundColor:[UIColor whiteColor]];
    [_scrollView addSubview:_btmBack];
    
//    UILabel * _heartTitel;//爱心数显示框
    _heartTitel = [[UILabel alloc]initWithFrame:CGRectMake(_DIME_LEFT+_px(32), _px(806), _px(108), _px(30))];
    [_heartTitel setTextColor:[UIColor blackColor]];
    [_heartTitel setFont:FONT_SIZE(15)];
    [_heartTitel setText:@"爱心数:"];
    [_scrollView addSubview:_heartTitel];
    
//    UIButton * _heartNum;//爱心数
    _heartNum = [[UIButton alloc]initWithFrame:CGRectMake(_DIME_LEFT+_px(150), _px(806), _px(250), _px(30))];
    [_heartNum setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    [_heartNum setImage:[UIImage imageNamed:@"me_body_ic_heart"] forState:UIControlStateNormal];
    [_heartNum setTitle:@"*0" forState:UIControlStateNormal];
    [_heartNum setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_scrollView addSubview:_heartNum];
    
//    UILabel * _heartWarning;//爱心提示
    _heartWarning = [[UILabel alloc]initWithFrame:CGRectMake(_DIME_LEFT+_px(32), _px(850), _px(350), _px(30))];
    [_heartWarning setTextColor:R_COLOR_NOMARL_GREY];
    [_heartWarning setFont:FONT_SIZE(12)];
    [_heartWarning setText:@"每日登陆奖励，累积获得爱心！"];
    [_heartWarning setTextAlignment:NSTextAlignmentLeft];
    [_scrollView addSubview:_heartWarning];
    
    [_rBtnWeiRecord addTarget:self action:@selector(onrBtnWeiRecord) forControlEvents:UIControlEventTouchUpInside];
    [_rBtnMotRecord addTarget:self action:@selector(onrBtnMotRecord) forControlEvents:UIControlEventTouchUpInside];
    [_rBtnDayInsect addTarget:self action:@selector(onrBtnDayInsect) forControlEvents:UIControlEventTouchUpInside];
    [_rBtnDayConsume addTarget:self action:@selector(onrBtnDayConsume) forControlEvents:UIControlEventTouchUpInside];
    
    [_cBtnWeight addTarget:self action:@selector(oncBtnWeight) forControlEvents:UIControlEventTouchUpInside];
    [_cBtnMotion addTarget:self action:@selector(oncBtnMotion) forControlEvents:UIControlEventTouchUpInside];
    [_cBtnDayInsect addTarget:self action:@selector(oncBtnDayInsect) forControlEvents:UIControlEventTouchUpInside];
    [_cBtnDayConsume addTarget:self action:@selector(oncBtnDayConsume) forControlEvents:UIControlEventTouchUpInside];
    
    [_nickView addTarget:self action:@selector(editNickName) forControlEvents:UIControlEventTouchUpInside];
    [_announceBtn addTarget:self action:@selector(editAnnounce) forControlEvents:UIControlEventTouchUpInside];
}



-(id) generateBtnsWithImage:(NSString *)img x:(int)x y:(int)y title:(NSString*)title
{
    
    UIButton *btn  =[[UIButton alloc]initWithFrame:CGRectMake(x, y, _px(194), _px(60))];
    [btn setBackgroundImage:[UIImage imageNamed:@"me_body_record_item_bg"] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:img] forState:UIControlStateNormal];
    [btn setTitle:title forState:UIControlStateNormal];
    btn.titleLabel.font = FONT_SIZE(12);
    [btn setTitleColor:R_COLOR_NOMARL_GREY forState:UIControlStateNormal];
    [btn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    [btn setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
    
    return btn;
}





@end
