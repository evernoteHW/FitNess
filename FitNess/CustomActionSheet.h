//
//  CustomActionSheet.h
//  FitNess
//
//  Created by liuguoyan on 14-11-8.
//  Copyright (c) 2014年 liuguoyan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomActionSheet : UIActionSheet
{
    
    NSString* customTitle;
}

-(id)initWithHeight:(float)height WithSheetTitle:(NSString*)title;
@property (nonatomic, retain) UIView *customView;

@property (nonatomic, strong) NSString *date;

@end
