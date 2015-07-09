//
//  CommonUtils.m
//  FitNess
//
//  Created by liuguoyan on 14-10-7.
//  Copyright (c) 2014年 liuguoyan. All rights reserved.
//

#import "CommonUtils.h"

@implementation CommonUtils


+(void) generateRoundButton:(UIView *)button
{
    //Clip/Clear the other pieces whichever outside the rounded corner
    button.clipsToBounds = YES;
    //half of the width
    button.layer.cornerRadius = button.frame.size.width/2.0f;
    button.layer.borderColor=[UIColor whiteColor].CGColor;
    button.layer.borderWidth=1.0f;
}

+(float) heightForString:(NSString *)value fontSize:(float)fontSize andWidth:(float)width
{
//    CGSize sizeToFit = [value sizeWithFont:[UIFont systemFontOfSize:fontSize]
//                         constrainedToSize:CGSizeMake(width -16.0, CGFLOAT_MAX)
//                             lineBreakMode:NSLineBreakByWordWrapping];
    CGSize sizeToFit = [value sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:fontSize], NSFontAttributeName, nil]];
    //此处的换行类型（lineBreakMode）可根据自己的实际情况进行设置
    return sizeToFit.height + 16.0;
}

@end
