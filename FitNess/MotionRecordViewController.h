//
//  MotionRecordViewController.h
//  FitNess
//
//  Created by liuguoyan on 14-10-6.
//  Copyright (c) 2014年 liuguoyan. All rights reserved.
//

#import "FNStepViewController.h"
#import "CalendarView.h"

@interface MotionRecordViewController : FNStepViewController <CalendarDelegate>
{
    UIScrollView *_scrollView;
    
    CalendarView *_sampleView;
    
    UIView *_motinContianer;
    
    UIButton *_head0;
    UIButton *_head1;
    UIButton *_head2;
    UIButton *_head3;
    UIButton *_head4;
    UIButton *_head5;
    
    
}
@end
