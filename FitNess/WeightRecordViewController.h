//
//  WeightRecordViewController.h
//  FitNess
//
//  Created by liuguoyan on 14-10-6.
//  Copyright (c) 2014年 liuguoyan. All rights reserved.
//

#import "FNStepViewController.h"
#import "CalendarView.h"

@interface WeightRecordViewController : FNStepViewController<CalendarDelegate>
{
    CalendarView *_sampleView;
    
    UIButton *_checkChartBtn;
}
@end
