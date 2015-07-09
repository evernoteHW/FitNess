//
//  MotionRecordViewController.m
//  FitNess
//
//  Created by liuguoyan on 14-10-6.
//  Copyright (c) 2014年 liuguoyan. All rights reserved.
//

#import "MotionRecordViewController.h"
#import "MotionFriendsController.h"

@interface MotionRecordViewController ()
{
    NSArray *_headArr;
    NSArray *_motionArr;
    NSArray *_buttonArr;
}
@end

@implementation MotionRecordViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self createView];
    [self initData];
    [self setListeners];
}


-(void) initData
{
    [self requestMotionInfo];
}

-(void) setListeners
{
   
}

//请求心情信息
-(void)requestMotionInfo
{
    NSString *today = [[[NSDate date]description]substringToIndex:10];
    [self.senceDataManager.params removeAllObjects];
    [self.senceDataManager.params setObject:[[FNDataKeeper sharedInstance] getUserId] forKey:URL_DATA_K_USER_ID];
    [self.senceDataManager.params setObject:today forKey:URL_DATA_K_DATE];
    [self.senceDataManager fetchDataWithModule:MODELS_MODEL_USERINFOMANGER method:MODELS_METHOD_GETEMATIONBYUSERDAY params:self.senceDataManager.params successListener:^(NSDictionary *result,NSString *msg){
        NSDictionary *dic = [self.senceDataManager spliteResultDictionaryWithResult:result];
        if ([dic objectForKey:@"userEmation"]) {
            int pos = [[dic objectForKey:@"userEmation"]intValue];
            [self setSelectionWithPosition:pos-1];
        }
    } failedListener:^(NSString *msg){
        
    } timeOutListener:^{
        
    }];
}

-(void) createView
{
    [self initParams];
    
    self.navigationController.navigationBar.translucent = NO;
    self.tabBarController.tabBar.translucent = NO;
    self.navigationController.navigationBar.barTintColor = COLOR_NAVIGATIONBAR_UICOLOR ;
    NSString *date = [[NSDate date] description];
    NSRange range = NSMakeRange (5, 2);
    NSString *titDate = [NSString stringWithFormat:@"%@年%@月",[date substringToIndex:4],[date substringWithRange:range]];
    [self.navigationItem setTitle:titDate];
    [self.view setBackgroundColor:R_COLOR_COMMON_BAC];
    
    _scrollView = [[UIScrollView alloc]init];
    _scrollView.frame = CGRectMake(0, _px(20), DIME_SCREEN_W, DIME_SCREEN_H - TITLE_HEI -_px(20)) ;
    [self.view addSubview:_scrollView];
    
    
    _sampleView= [[CalendarView alloc]initWithFrame:CGRectMake(_px(20), 0, _px(600), self.view.bounds.size.height)];
    _sampleView.delegate = self;
    [_sampleView setBackgroundColor:[UIColor whiteColor]];
    _sampleView.calendarDate = [NSDate date];
    [_scrollView addSubview:_sampleView];
    
   
//    UIView *_motinContianer;
    _motinContianer = [[UIView alloc]initWithFrame:CGRectMake(_px(20), _px(600), _px(600), _px(380))];
    [_motinContianer setBackgroundColor:[UIColor whiteColor]];
    [_scrollView addSubview:_motinContianer];
    
    [_scrollView setContentSize:CGSizeMake(DIME_SCREEN_W, _px(1040))];
    
//    UIButton *_head0;
    _head0 = [self generateMotionBtnWithX:_px(25) andY:0 atPos:0];
    [_motinContianer addSubview:_head0];
    
//    UIButton *_head1;
    _head1 = [self generateMotionBtnWithX:_px(205) andY:0 atPos:1];
    [_motinContianer addSubview:_head1];
//    UIButton *_head2;
    _head2 = [self generateMotionBtnWithX:_px(385) andY:0 atPos:2];
    [_motinContianer addSubview:_head2];
//    UIButton *_head3;
    _head3 = [self generateMotionBtnWithX:_px(25) andY:_px(180) atPos:3];
    [_motinContianer addSubview:_head3];
//    UIButton *_head4;
    _head4 = [self generateMotionBtnWithX:_px(205) andY:_px(180) atPos:4];
    [_motinContianer addSubview:_head4];
//    UIButton *_head5;
    _head5 = [self generateMotionBtnWithX:_px(385) andY:_px(180) atPos:5];
    [_motinContianer addSubview:_head5];
    
    _buttonArr = @[_head0,_head1,_head2,_head3,_head4,_head5];
    for (int i = 0 ; i<_buttonArr.count; i++) {
        [_buttonArr[i] setTag:i];
        [_buttonArr[i] addTarget:self action:@selector(onMotion:) forControlEvents:UIControlEventTouchUpInside];
    }
}

//心情点击事件
-(void) onMotion:(UIControl *)sender
{
    
    [self.senceDataManager.params removeAllObjects];
    [self.senceDataManager.params setObject:[[FNDataKeeper sharedInstance] getUserId] forKey:URL_DATA_K_USER_ID];
    [self.senceDataManager.params setObject:[NSString stringWithFormat:@"%d",sender.tag+1] forKey:URL_DATA_K_HEARTSTS];
    [self.senceDataManager fetchDataWithModule:MODELS_MODEL_USERINFOMANGER method:MODELS_METHOD_MODIFYHEARTSTS  params:self.senceDataManager.params successListener:^(NSDictionary *result,NSString *msg){
        [[TKAlertCenter defaultCenter] postAlertWithMessage:@"更新心情完毕～～"];
        [self setSelectionWithPosition:sender.tag];
        MotionFriendsController *contrller = [[MotionFriendsController alloc]init];
        [self.navigationController pushViewController:contrller animated:YES];
        
    } failedListener:^(NSString *msg){
        
    } timeOutListener:^{
        
    }];
}


-(void) setSelectionWithPosition:(int)pos
{
    for (int i = 0 ; i<_buttonArr.count; i++) {
        UIButton *button = _buttonArr[i];
        UIImageView *check = (UIImageView *)[button viewWithTag:10];
        [check setImage:[UIImage imageNamed:@"motion_img_02"]];
        if (i == pos) {
            [check setImage:[UIImage imageNamed:@"motion_img_03"]];
        }else{
            [check setImage:[UIImage imageNamed:@"motion_img_02"]];
        }
    }
}


-(id) generateMotionBtnWithX:(int)x andY:(int)y atPos:(int)pos
{
    
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(x, y, _px(180), _px(180))];
    UIImageView *head = [[UIImageView alloc]initWithFrame:CGRectMake(_px(25), _px(20), _px(130), _px(112))];
    [head setImage:[UIImage imageNamed:_headArr[pos]]];
    [button addSubview:head];
    
    UILabel *motion = [[UILabel alloc]initWithFrame:CGRectMake(_px(60), _px(140), _px(60), _px(30))];
    motion.font = FONT_SIZE(15);
    motion.textColor =[UIColor blackColor];
    motion.text = _motionArr[pos];
    [button addSubview:motion];
    
    UIImageView *check = [[UIImageView alloc]initWithFrame:CGRectMake(_px(146), _px(146), _px(40), _px(40))];
    [check setImage:[UIImage imageNamed:@"motion_img_02"]];
    [button addSubview:check];
    [check setTag:10];
    
    return button;
}




-(void)initParams
{
    _headArr = @[@"motion0",@"motion1",@"motion2",@"motion3",@"motion4",@"motion5"];
    _motionArr =@[@"开心",@"卖萌",@"花痴",@"生病",@"难过",@"憋屈"];
}

-(void)tappedOnDate:(NSDate *)selectedDate
{
    NSDate *newDate1 = [selectedDate dateByAddingTimeInterval:60*60*24*1];
    NSString *date = [newDate1 description];
    NSString * result = [date substringToIndex:10 ];
    NSString *today = [[[NSDate date]description]substringToIndex:10];
    
    if ([result isEqualToString:today]) {
        [self onDateClicked:today];
    }else{
        [[TKAlertCenter defaultCenter]postAlertWithMessage:@"只能选择今天的喔^_^"];
    }
}

-(void) onDateClicked:(NSString *)date
{

}
-(void)onToadyTapped:(NSDate *)today
{

}

@end
