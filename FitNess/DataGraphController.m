//
//  DataGraphController.m
//  FitNess
//
//  Created by liuguoyan on 14-10-13.
//  Copyright (c) 2014年 liuguoyan. All rights reserved.
//

#import "DataGraphController.h"
#import "SHLineGraphView.h"
#import "SHPlot.h"

@interface DataGraphController ()

@property (nonatomic, strong) NSArray *dataArray;

@end

@implementation DataGraphController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.navigationItem setTitle:self.title];
    
    
    [self requestWeigthListData];
    
//    self.dataArray = @[@{@"id":@"227",@"remark":@"",@"sts":@"A",@"stsDate":@"2014-11-09 00:00:00.0",@"userId":@"213",@"userMantWeight":@"28"},
//                       @{@"id":@"227",@"remark":@"",@"sts":@"A",@"stsDate":@"2014-11-10 00:00:00.0",@"userId":@"213",@"userMantWeight":@"12"},
//                       @{@"id":@"227",@"remark":@"",@"sts":@"A",@"stsDate":@"2014-11-11 00:00:00.0",@"userId":@"213",@"userMantWeight":@"45"},
//                       @{@"id":@"227",@"remark":@"",@"sts":@"A",@"stsDate":@"2014-11-12 00:00:00.0",@"userId":@"213",@"userMantWeight":@"99"},
//                       @{@"id":@"227",@"remark":@"",@"sts":@"A",@"stsDate":@"2014-11-13 00:00:00.0",@"userId":@"213",@"userMantWeight":@"22"},
//                       @{@"id":@"227",@"remark":@"",@"sts":@"A",@"stsDate":@"2014-11-14 00:00:00.0",@"userId":@"213",@"userMantWeight":@"900"},
//                       @{@"id":@"227",@"remark":@"",@"sts":@"A",@"stsDate":@"2014-11-15 00:00:00.0",@"userId":@"213",@"userMantWeight":@"900"}];
//  [self createView];
}

///查看体重曲线

- (void)requestWeigthListData
{
    [self showHud];
    NSMutableDictionary *parametersDic = [NSMutableDictionary dictionary];
    [parametersDic setObject:[[FNDataKeeper sharedInstance] getUserId] forKey:URL_DATA_K_USER_ID];
//    
    NSTimeInterval secondsPerDay = - 24 * 60 * 60 * 7;
    NSDate * startDate = [NSDate date];
    NSDate * endDate = [[NSDate alloc] initWithTimeIntervalSinceNow:secondsPerDay];
    
    NSDateFormatter *dateformatter = [[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:@"YYYY-MM-dd"];
    NSString *locationString1 = [dateformatter stringFromDate:startDate];
    NSString *locationString2 = [dateformatter stringFromDate:endDate];
    
    [parametersDic setObject:locationString2 forKey:URL_DATA_K_BEGINDATE];
    [parametersDic setObject:locationString1  forKey:URL_DATA_K_ENDDATE];
    
    NSString *method = @"";
    if ([self.graphTitle isEqualToString:@"体重曲线"]) {
        method = MODELS_METHOD_QRYWEIGHTLIST;
    }else if ([self.graphTitle isEqualToString:@"摄入能量曲线"]) {
        method = MODELS_METHOD_QRYIMPENERGYLIST;
    }else  if([self.graphTitle isEqualToString:@"消耗能量曲线"]) {
        method = QRYSPENDENERGYLIST;        
    }
    __unsafe_unretained DataGraphController *weakSelf = self;
    [[NetworkManager shareManager] requestParams:parametersDic withModule:MODELS_MODEL_USERINFOMANGER method:method finishBlock:^(DataServies *request, id result) {
        
        NSString *msg = [result objectForKey:@"msg"];
        if ([[result objectForKey:@"flag"] integerValue] == 1) {
//            NSLog(@"%@",result[@"retDataArray"]);
            weakSelf.dataArray = result[@"retDataArray"];
             [weakSelf createView];
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

- (void) createView
{
//    [self setUpForDismissKeyboard];
    
    UIView *bgView = [[UIView alloc]init];
    bgView.backgroundColor = [UIColor clearColor];
    bgView.center = CGPointMake(DIME_SCREEN_W/2, (DIME_SCREEN_H-TITLE_HEI)/2);
    bgView.bounds = CGRectMake(0,0,DIME_SCREEN_H-TITLE_HEI-_px(10), DIME_SCREEN_W-_px(10));
    bgView.transform = CGAffineTransformMakeRotation(M_PI_2);
    
    UILabel *graphLable = [[UILabel alloc]initWithFrame:CGRectMake(_px(400), _px(30), _px(250), _px(30))];
    graphLable.font = FONT_SIZE(13);
    graphLable.textColor = [UIColor grayColor];
    graphLable.text = self.graphTitle;
    [bgView addSubview:graphLable];
    
    
    //initate the graph view
    SHLineGraphView *_lineGraph = [[SHLineGraphView alloc] initWithFrame:CGRectMake(_px(30), 0, DIME_SCREEN_H-_px(200), 300)];
//    _lineGraph.yAxisRange = @(300);
    NSDictionary *_themeAttributes = @{
                                       kXAxisLabelColorKey : [UIColor colorWithRed:0.48 green:0.48 blue:0.49 alpha:0.4],
                                       kXAxisLabelFontKey : [UIFont fontWithName:@"TrebuchetMS" size:10],
                                       kYAxisLabelColorKey : [UIColor colorWithRed:0.48 green:0.48 blue:0.49 alpha:0.4],
                                       kYAxisLabelFontKey : [UIFont fontWithName:@"TrebuchetMS" size:10],
                                       kPlotBackgroundLineColorKye : [UIColor colorWithRed:0.48 green:0.48 blue:0.49 alpha:0.4]
                                       };
    _lineGraph.themeAttributes = _themeAttributes;
    
    
    //y轴的最大值

//    _lineGraph.yAxisSuffix = @"K";

    //设置x轴的字符显示的数组
    _lineGraph.xAxisValues = @[
                               @{ @1 : [self dateFormate:6] },
                               @{ @2 : [self dateFormate:5] },
                               @{ @3 : [self dateFormate:4] },
                               @{ @4 : [self dateFormate:3] },
                               @{ @5 : [self dateFormate:2] },
                               @{ @6 : [self dateFormate:1] },
                               @{ @7 : [self dateFormate:0] },
                               ];
    SHPlot *_plot1 = [[SHPlot alloc] init];
    
    //set the plot attributes
    CGFloat bigValue = 0;
    NSMutableArray *arr = [@[@(0),@(0),@(0),@(0),@(0),@(0),@(0)] mutableCopy] ;
    if ([self.graphTitle isEqualToString:@"体重曲线"]) {
        for (int i =0;i < self.dataArray.count; i++) {
            //切段字符串
            NSDictionary *dic = self.dataArray[i];
            for (int j = 0; j < 7; j++) {
                NSString *timeStr = [[dic[@"stsDate"] substringToIndex:10] stringByReplacingOccurrencesOfString:@" " withString:@""];
                NSString *dateStr = [[self dateFormate:6-j] stringByReplacingOccurrencesOfString:@" " withString:@""];
                if([timeStr isEqualToString:dateStr]){
                    [arr replaceObjectAtIndex:j withObject:@([dic[@"userMantWeight"] floatValue])];
                    break;
                }
            }
            //取数组元素的最大值
            if ([dic[@"userMantWeight"] floatValue] >= bigValue) {
                bigValue = [dic[@"userMantWeight"] floatValue];
            }
            //        [arr addObject:@([dic[@"userMantWeight"] integerValue])];
        }
    }else if ([self.graphTitle isEqualToString:@"摄入能量曲线"]) {
        for (int i =0;i < self.dataArray.count; i++) {
            //切段字符串
            NSDictionary *dic = self.dataArray[i];
            for (int j = 0; j < 7; j++) {
                NSString *timeStr = [[dic[@"createDate"] substringToIndex:10] stringByReplacingOccurrencesOfString:@" " withString:@""];
                NSString *dateStr = [[self dateFormate:6-j] stringByReplacingOccurrencesOfString:@" " withString:@""];
                if([timeStr isEqualToString:dateStr]){
                    [arr replaceObjectAtIndex:j withObject:@([dic[@"foodKll"] floatValue])];
                    break;
                }
            }
            //取数组元素的最大值
            if ([dic[@"foodKll"] floatValue] >= bigValue) {
                bigValue = [dic[@"foodKll"] floatValue];
            }
            //        [arr addObject:@([dic[@"userMantWeight"] integerValue])];
        }
    }else  if([self.graphTitle isEqualToString:@"消耗能量曲线"]) {
        for (int i =0;i < self.dataArray.count; i++) {
            //切段字符串
            NSDictionary *dic = self.dataArray[i];
            for (int j = 0; j < 7; j++) {
                NSString *timeStr = [[dic[@"createTime"] substringToIndex:10] stringByReplacingOccurrencesOfString:@" " withString:@""];
                NSString *dateStr = [[self dateFormate:6-j] stringByReplacingOccurrencesOfString:@" " withString:@""];
                if([timeStr isEqualToString:dateStr]){
                    [arr replaceObjectAtIndex:j withObject:@([dic[@"sportKll"] floatValue])];
                    break;
                }
            }
            //取数组元素的最大值
            if ([dic[@"sportKll"] integerValue] >= bigValue) {
                bigValue = [dic[@"sportKll"] integerValue];
            }
        }
    }

    //设置y轴的值
    _plot1.plottingValues = @[
                              @{ @1 : arr[0] },
                              @{ @2 : arr[1] },
                              @{ @3 : arr[2] },
                              @{ @4 : arr[3] },
                              @{ @5 : arr[4] },
                              @{ @6 : arr[5] },
                              @{ @7 : arr[6] },
                              ];
    //这里可以设置点击点的响应事件，我们不需要，所以去除
//    NSArray *arr = @[@"1", @"2", @"3", @"4", @"5", @"6" , @"7" , @"8", @"9", @"10", @"11", @"12"];
//    _plot1.plottingPointsLabels = arr;
    
    
    NSDictionary *_plotThemeAttributes = @{
                                           //设置线下面的背影色
                                           kPlotFillColorKey : [UIColor clearColor],
                                           kPlotStrokeWidthKey : @1,
                                           kPlotStrokeColorKey : [UIColor colorWithRed:0.18 green:0.36 blue:0.41 alpha:1],
                                           kPlotPointFillColorKey : [UIColor colorWithRed:0.18 green:0.36 blue:0.41 alpha:1],
                                           kPlotPointValueFontKey : [UIFont fontWithName:@"TrebuchetMS" size:18]
                                           };
    
    _plot1.plotThemeAttributes = _plotThemeAttributes;
    [_lineGraph addPlot:_plot1];
     _lineGraph.yAxisRange = @(bigValue);
    [_lineGraph setupTheView];
   
    [bgView addSubview:_lineGraph];
    [self.view addSubview:bgView];
    
}
- (NSString *)dateFormate:(NSInteger)day
{
    NSTimeInterval secondsPerDay = - 24 * 60 * 60 * day;
    NSDateFormatter *dateformatter = [[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:@"YYYY-MM-dd"];
    NSDate * endDate = [[NSDate alloc] initWithTimeIntervalSinceNow:secondsPerDay];
   NSString *locationString = [dateformatter stringFromDate:endDate];
    
    return locationString;
}

@end
