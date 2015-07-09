//
//  CustomActionSheet.m
//  FitNess
//
//  Created by liuguoyan on 14-11-8.
//  Copyright (c) 2014年 liuguoyan. All rights reserved.
//

#import "CustomActionSheet.h"




#define NavBarHeight                    40
#define ViewHeight                       [UIScreen mainScreen].bounds.size.height

@interface CustomActionSheet(){
    UIDatePicker *oneDatePicker;
@private
    float customViewHeight;
}

@end

@implementation CustomActionSheet

-(id)initWithHeight:(float)height WithSheetTitle:(NSString *)title
{
    self = [super init];
    if (self) {
        customViewHeight = height;
        customTitle = title;
        self.customView = [[UIView alloc] initWithFrame:CGRectMake(0, ViewHeight - customViewHeight, 320, customViewHeight)];
    }
    
   
    
    return self;
}

//重写layoutSubviews
-(void)layoutSubviews
{
    [super layoutSubviews];
    UINavigationBar *navBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, ViewHeight - customViewHeight -NavBarHeight, 320, NavBarHeight)];
    navBar.barStyle = UIBarStyleDefault;
    UINavigationItem *navItem = [[UINavigationItem alloc]initWithTitle:customTitle];
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc]initWithTitle:@"取消" style:UIBarButtonItemStyleBordered target:self action:@selector(docancel)];
    navItem.leftBarButtonItem = leftButton;
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc]initWithTitle:@"确定" style:UIBarButtonItemStyleBordered target:self action:@selector(done)];
    navItem.rightBarButtonItem = rightButton;
    NSArray *array = [[NSArray alloc ]initWithObjects: navItem, nil];
    [navBar setItems:array];
    [self.superview addSubview:navBar];
    [self.superview addSubview:self.customView];
    
    
    
    oneDatePicker = [[UIDatePicker alloc] init];
    oneDatePicker.frame = CGRectMake(0, 0, self.superview.frame.size.width , 320); // 设置显示的位置和大小
    
    oneDatePicker.date = [NSDate date]; // 设置初始时间
    
    oneDatePicker.datePickerMode = UIDatePickerModeDate; // 设置样式
    oneDatePicker.locale = [NSLocale localeWithLocaleIdentifier:@"zh_cn"];
    [self.customView addSubview:oneDatePicker];
    self.customView.backgroundColor = [UIColor whiteColor];
    
}

- (void) done{
    self.date = [oneDatePicker.date.description substringToIndex:10];
    [self dismissWithClickedButtonIndex:0 animated:YES];
    [self.delegate actionSheet:self clickedButtonAtIndex:0];
    
    
}

- (void) docancel{
    [self dismissWithClickedButtonIndex:1 animated:YES];
    [self.delegate actionSheet:self clickedButtonAtIndex:1];
}

@end
