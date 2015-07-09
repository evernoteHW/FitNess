//
//  WeightRecordViewController.m
//  FitNess
//
//  Created by liuguoyan on 14-10-6.
//  Copyright (c) 2014年 liuguoyan. All rights reserved.
//

#import "WeightRecordViewController.h"
#import "WeightInputerViewController.h"
#import "DataGraphController.h"

@interface WeightRecordViewController ()

@end

@implementation WeightRecordViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self createView];
    [self initData];
    [self setListeners];
}


-(void) initData
{
    
}

-(void) setListeners
{
    
}


-(void) createView
{
    self.navigationController.navigationBar.translucent = NO;
    self.tabBarController.tabBar.translucent = NO;
    self.navigationController.navigationBar.barTintColor = COLOR_NAVIGATIONBAR_UICOLOR ;
    NSString *date = [[NSDate date] description];
    NSRange range = NSMakeRange (5, 2);
    NSString *titDate = [NSString stringWithFormat:@"%@年%@月",[date substringToIndex:4],[date substringWithRange:range]];
    [self.navigationItem setTitle:titDate];
    [self.view setBackgroundColor:R_COLOR_COMMON_BAC];
    
    _sampleView= [[CalendarView alloc]initWithFrame:CGRectMake(_px(20), 0, _px(600), self.view.bounds.size.height)];
    _sampleView.delegate = self;
    [_sampleView setBackgroundColor:[UIColor whiteColor]];
    _sampleView.calendarDate = [NSDate date];
    [self.view addSubview:_sampleView];
    
    _checkChartBtn = [[UIButton alloc]initWithFrame:CGRectMake(_DIME_LEFT *2, _px(640), _DIME_CONT_SIZE-2*_DIME_LEFT, _px(87))];
    [_checkChartBtn setBackgroundImage:[UIImage imageNamed:@"common_long_btn"] forState:UIControlStateNormal];
    [_checkChartBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_checkChartBtn setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    [_checkChartBtn setTitle:@"查看体重曲线" forState:UIControlStateNormal];
    _checkChartBtn.titleLabel.font = FONT_SIZE(15);
    [_checkChartBtn addTarget:self action:@selector(onWeightChart) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_checkChartBtn];
    
}
-(void) onWeightChart
{
    DataGraphController *controller = [[DataGraphController alloc]init];
    controller.hidesBottomBarWhenPushed = YES;
    controller.graphTitle = @"体重曲线";
    [self.navigationController pushViewController:controller animated:YES];
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
    WeightInputerViewController *controller = [[WeightInputerViewController alloc]init];
    controller.submitDate = date;
    [self.navigationController pushViewController:controller animated:YES];
}
-(void)onToadyTapped:(NSDate *)today
{
    NSString *date = [[today description] substringToIndex:10];
    WeightInputerViewController *controller = [[WeightInputerViewController alloc]init];
    controller.submitDate = date;
    [self.navigationController pushViewController:controller animated:YES];
}

@end
