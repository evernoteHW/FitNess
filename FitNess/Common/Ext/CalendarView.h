

#import <UIKit/UIKit.h>
@protocol CalendarDelegate <NSObject>

-(void)tappedOnDate:(NSDate *)selectedDate;

@optional
-(void)onToadyTapped:(NSDate *)today;

@end

@interface CalendarView : UIView
{
    NSInteger _selectedDate;
    NSArray *_weekNames;
}

@property (nonatomic,strong) NSDate *calendarDate;
@property (nonatomic,weak) id<CalendarDelegate> delegate;

@end
