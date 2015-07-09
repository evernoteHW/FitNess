
#import "CalendarView.h"
#import "UIColor+RGBColor.h"


//顶部星期几的颜色
#define C_WEEK_DAY [UIColor blackColor]

//设置没有选中的日期的颜色
#define C_DAY_UNSELECTED [UIColor grayColor]

//本月的日期的框体颜色
#define C_CURRENT_MONTH_DAY_FRAME [UIColor colorWithHexString:@"AEAEAE"]

//本月第一行和最后一行，靠内边的边色
#define C_CURRENT_MONTH_DAY_TOP_BOTTOM_SINGLE [UIColor colorWithHexString:@"AEAEAE"]

//本月最左一行和最右一行，靠内边的边色,和C_CURRENT_MONTH_DAY_TOP_BOTTOM_SINGLE类似
//C_CURRENT_MONTH_DAY_LEFT_RIGHT_SINGLE
#define C_CURRENT_MONTH_DAY_LEFT_RIGHT_SINGLE [UIColor colorWithHexString:@"AEAEAE"]

//界面刚出现时，选中的日期的颜色，即界面没被动过时，今天的日期
#define C_TODAY_INITIAL_COLOR [UIColor colorWithHexString:@"FF5879"]

//前一个月的日期边框色，即表格的前几个格
#define C_FRONT_MONTH_DAY_FRAME [UIColor colorWithHexString:@"AEAEAE"]

#define C_FONT_COLOR [UIColor colorWithHexString:@"AEAEAE"]

#define D_FRAME_WIDTH 0.5

@interface CalendarView()

{
    
    NSCalendar *gregorian;
    NSInteger _selectedMonth;
    NSInteger _selectedYear;
}

@end
@implementation CalendarView

- (id)initWithFrame:(CGRect)frame
{
    
    [UIColor colorWithHexString:@"AEAEAE"];
    self = [super initWithFrame:frame];
    if (self) {
        UISwipeGestureRecognizer * swipeleft=[[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipeleft:)];
        swipeleft.direction=UISwipeGestureRecognizerDirectionLeft;
        [self addGestureRecognizer:swipeleft];
        UISwipeGestureRecognizer * swipeRight=[[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swiperight:)];
        swipeRight.direction=UISwipeGestureRecognizerDirectionRight;
        [self addGestureRecognizer:swipeRight];
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    
    [self setCalendarParameters];
    _weekNames = @[@"周日",@"周一",@"周二",@"周三",@"周四",@"周五",@"周六"];
    NSDateComponents *components = [gregorian components:(NSEraCalendarUnit | NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit) fromDate:self.calendarDate];
//    _selectedDate  =components.day;
    components.day = 1;
    NSDate *firstDayOfMonth = [gregorian dateFromComponents:components];
    NSDateComponents *comps = [gregorian components:NSWeekdayCalendarUnit fromDate:firstDayOfMonth];
    int weekday = [comps weekday];
//      NSLog(@"components%d %d %d",_selectedDate,_selectedMonth,_selectedYear);
    weekday  = weekday - 2;
    
    if(weekday < 0)
        weekday += 7;
    
    NSCalendar *c = [NSCalendar currentCalendar];
    NSRange days = [c rangeOfUnit:NSDayCalendarUnit
                           inUnit:NSMonthCalendarUnit
                          forDate:self.calendarDate];
    
    NSInteger columns = 7;
    NSInteger width = 43;
    NSInteger originX = 0;//画框的x起始值
    NSInteger originY = 2;//画框的y起始值
    NSInteger monthLength = days.length;
    
    //这一块是标题，我们这里将其去除
    /*
    UILabel *titleText = [[UILabel alloc]initWithFrame:CGRectMake(0,20, self.bounds.size.width, 40)];
    titleText.textAlignment = NSTextAlignmentCenter;
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setDateFormat:@"MMMM yyyy"];
    NSString *dateString = [[format stringFromDate:self.calendarDate] uppercaseString];
    [titleText setText:dateString];
    [titleText setFont:[UIFont fontWithName:@"Helvetica-Bold" size:15.0f]];
    [titleText setTextColor:[UIColor redColor]];
    [self addSubview:titleText];
    **/
    for (int i =0; i<_weekNames.count; i++) {
        UIButton *weekNameLabel = [UIButton buttonWithType:UIButtonTypeCustom];
        weekNameLabel.titleLabel.text = [_weekNames objectAtIndex:i];
        [weekNameLabel setTitle:[_weekNames objectAtIndex:i] forState:UIControlStateNormal];
        [weekNameLabel setFrame:CGRectMake(originX+(width*(i%columns)), originY-2, width, width)];
        //设置星期天的颜色
        [weekNameLabel setTitleColor:C_WEEK_DAY forState:UIControlStateNormal];
        [weekNameLabel.titleLabel setFont:[UIFont fontWithName:@"HelveticaNeue" size:15.0f]];
        weekNameLabel.userInteractionEnabled = NO;
        //在这里改变表上头的星期天的背景
        [weekNameLabel setBackgroundColor:[UIColor colorWithHexString:@"FFEAF1"]];
        [self addSubview:weekNameLabel];
    }
    
    for (NSInteger i= 0; i<monthLength; i++)
    {
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        
        button.tag = i+1;
        button.titleLabel.text = [NSString stringWithFormat:@"%d",i+1];
        [button setTitle:[NSString stringWithFormat:@"%d",i+1] forState:UIControlStateNormal];
        //设置没有选中的日期的颜色
        [button setTitleColor:C_DAY_UNSELECTED forState:UIControlStateNormal];
        [button.titleLabel setFont:[UIFont fontWithName:@"HelveticaNeue" size:15.0f]];
        [button addTarget:self action:@selector(tappedDate:) forControlEvents:UIControlEventTouchUpInside];
        NSInteger offsetX = (width*((i+weekday)%columns));
        NSInteger offsetY = (width *((i+weekday)/columns));
        [button setFrame:CGRectMake(originX+offsetX, originY+40+offsetY, width, width)];
        //本月的日期的框体颜色
        [button.layer setBorderColor:[C_CURRENT_MONTH_DAY_FRAME CGColor]];
        [button.layer setBorderWidth:D_FRAME_WIDTH];
        UIView *lineView = [[UIView alloc] init];
        //第一行和最后一行，靠内边的边色
        lineView.backgroundColor = C_CURRENT_MONTH_DAY_TOP_BOTTOM_SINGLE;
        if(((i+weekday)/columns)==0)
        {
            [lineView setFrame:CGRectMake(0, 0, button.frame.size.width, 0)];
            [button addSubview:lineView];
        }

        if(((i+weekday)/columns)==((monthLength+weekday-1)/columns))
        {
            [lineView setFrame:CGRectMake(0, button.frame.size.width-4, button.frame.size.width, 0)];
            [button addSubview:lineView];
        }
        
        UIView *columnView = [[UIView alloc]init];
        //本月最左一行和最右一行，靠内边的边色,和C_CURRENT_MONTH_DAY_TOP_BOTTOM_SINGLE类似
        //C_CURRENT_MONTH_DAY_LEFT_RIGHT_SINGLE
        [columnView setBackgroundColor:C_CURRENT_MONTH_DAY_LEFT_RIGHT_SINGLE];
        if((i+weekday)%7==0)
        {
            [columnView setFrame:CGRectMake(0, 0, 0, button.frame.size.width)];
            [button addSubview:columnView];
        }
        else if((i+weekday)%7==6)
        {
            [columnView setFrame:CGRectMake(button.frame.size.width-4, 0, 0, button.frame.size.width)];
            [button addSubview:columnView];
        }
        if(i+1 ==_selectedDate && components.month == _selectedMonth && components.year == _selectedYear)
        {
            //界面刚出现时，选中的日期的颜色，即界面没被动过时，今天的日期
            //C_TODAY_INITIAL_COLOR
            [button setBackgroundColor:C_TODAY_INITIAL_COLOR];
            [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            
        }
        
        [self addSubview:button];
    }
    
    NSDateComponents *previousMonthComponents = [gregorian components:(NSEraCalendarUnit | NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit) fromDate:self.calendarDate];
    previousMonthComponents.month -=1;
    NSDate *previousMonthDate = [gregorian dateFromComponents:previousMonthComponents];
    NSRange previousMonthDays = [c rangeOfUnit:NSDayCalendarUnit
                   inUnit:NSMonthCalendarUnit
                  forDate:previousMonthDate];
    NSInteger maxDate = previousMonthDays.length - weekday;
    
    
    for (int i=0; i<weekday; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.titleLabel.text = [NSString stringWithFormat:@"%d",maxDate+i+1];
        [button setTitle:[NSString stringWithFormat:@"%d",maxDate+i+1] forState:UIControlStateNormal];
        NSInteger offsetX = (width*(i%columns));
        NSInteger offsetY = (width *(i/columns));
        [button setFrame:CGRectMake(originX+offsetX, originY+40+offsetY, width, width)];
        [button.layer setBorderWidth:D_FRAME_WIDTH];
        //前一个月的日期边框色，即表格的前几个格
        //C_FRONT_MONTH_DAY_FRAME
        [button.layer setBorderColor:[C_FRONT_MONTH_DAY_FRAME CGColor]];
        UIView *columnView = [[UIView alloc]init];
        [columnView setBackgroundColor:C_FRONT_MONTH_DAY_FRAME];
        if(i==0)
        {
            [columnView setFrame:CGRectMake(0, 0, 0, button.frame.size.width)];
            [button addSubview:columnView];
        }

        UIView *lineView = [[UIView alloc]init];
        [lineView setBackgroundColor:C_FRONT_MONTH_DAY_FRAME];
        [lineView setFrame:CGRectMake(0, 0, button.frame.size.width, 0)];
        [button addSubview:lineView];
        [button setTitleColor:[UIColor colorWithRed:229.0/255.0 green:231.0/255.0 blue:233.0/255.0 alpha:1.0] forState:UIControlStateNormal];
        [button.titleLabel setFont:[UIFont fontWithName:@"HelveticaNeue" size:15.0f]];
        [button setEnabled:NO];
        [self addSubview:button];
    }
    
    NSInteger remainingDays = (monthLength + weekday) % columns;
    if(remainingDays >0){
        for (int i=remainingDays; i<columns; i++) {
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.titleLabel.text = [NSString stringWithFormat:@"%d",(i+1)-remainingDays];
            [button setTitle:[NSString stringWithFormat:@"%d",(i+1)-remainingDays] forState:UIControlStateNormal];
            NSInteger offsetX = (width*((i) %columns));
            NSInteger offsetY = (width *((monthLength+weekday)/columns));
            [button setFrame:CGRectMake(originX+offsetX, originY+40+offsetY, width, width)];
            [button.layer setBorderWidth:D_FRAME_WIDTH];
            [button.layer setBorderColor:[C_FRONT_MONTH_DAY_FRAME CGColor]];
            UIView *columnView = [[UIView alloc]init];
            [columnView setBackgroundColor:C_FRONT_MONTH_DAY_FRAME];
            if(i==columns - 1)
            {
                [columnView setFrame:CGRectMake(button.frame.size.width-4, 0, 0, button.frame.size.width)];
                [button addSubview:columnView];
            }
            UIView *lineView = [[UIView alloc]init];
            [lineView setBackgroundColor:C_FRONT_MONTH_DAY_FRAME];
            [lineView setFrame:CGRectMake(0, button.frame.size.width-4, button.frame.size.width, 0)];
            [button addSubview:lineView];
            [button setTitleColor:[UIColor colorWithRed:200.0/255.0 green:200.0/255.0 blue:200.0/255.0 alpha:1.0] forState:UIControlStateNormal];
            [button.titleLabel setFont:[UIFont fontWithName:@"HelveticaNeue" size:15.0f]];
            [button setEnabled:NO];
            [self addSubview:button];

        }
    }
    
}
-(IBAction)tappedDate:(UIButton *)sender
{
    
    
    gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *components = [gregorian components:(NSEraCalendarUnit | NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit) fromDate:self.calendarDate];
    if(!(_selectedDate == sender.tag && _selectedMonth == [components month] && _selectedYear == [components year]))
    {
        if(_selectedDate != -1)
        {
            UIButton *previousSelected =(UIButton *) [self viewWithTag:_selectedDate];
            [previousSelected setBackgroundColor:[UIColor clearColor]];
            //被点击过的日期的颜色，即点击路径色
            [previousSelected setTitleColor:C_FONT_COLOR forState:UIControlStateNormal];
            
        }
        //选中的日期的覆盖色
        [sender setBackgroundColor:C_TODAY_INITIAL_COLOR];
        [sender setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _selectedDate = sender.tag;
        NSDateComponents *components = [gregorian components:(NSEraCalendarUnit | NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit) fromDate:self.calendarDate];
        components.day = _selectedDate;
        _selectedMonth = components.month;
        _selectedYear = components.year;
        NSDate *clickedDate = [gregorian dateFromComponents:components];
        [self.delegate tappedOnDate:clickedDate];
    }else{
        [self.delegate onToadyTapped:[NSDate date]];
    }
    
    
}

-(void)swipeleft:(UISwipeGestureRecognizer*)gestureRecognizer
{
    
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    NSDateComponents *components = [gregorian components:(NSEraCalendarUnit | NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit) fromDate:self.calendarDate];
    components.day = 1;
    components.month += 1;
    self.calendarDate = [gregorian dateFromComponents:components];
    [UIView transitionWithView:self
                      duration:0.5f
                       options:UIViewAnimationOptionTransitionCrossDissolve
                    animations:^ { [self setNeedsDisplay]; }
                    completion:nil];
    
    
}

-(void)swiperight:(UISwipeGestureRecognizer*)gestureRecognizer
{
    
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    NSDateComponents *components = [gregorian components:(NSEraCalendarUnit | NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit) fromDate:self.calendarDate];
    components.day = 1;
    components.month -= 1;
    self.calendarDate = [gregorian dateFromComponents:components];
    [UIView transitionWithView:self
                      duration:0.5f
                       options:UIViewAnimationOptionTransitionCrossDissolve
                    animations:^ { [self setNeedsDisplay]; }
                    completion:nil];
}
-(void)setCalendarParameters
{
    if(gregorian == nil)
    {
        gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
        NSDateComponents *components = [gregorian components:(NSEraCalendarUnit | NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit) fromDate:self.calendarDate];
        _selectedDate  = components.day;
        _selectedMonth = components.month;
        _selectedYear = components.year;
    }
}

@end
