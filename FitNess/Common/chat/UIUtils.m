//
//  UIUtils.m
//  MaiMang
//
//  Created by WeiHu on 15/1/9.
//  Copyright (c) 2015年 WeiHu. All rights reserved.
//

#import "UIUtils.h"

@implementation UIUtils

+ (CGFloat)heightForCellWithText:(NSString *)text fontSize:(UIFont *)fontSize maxWidth:(CGFloat)maxWidth {
    
    
    if (IOS_VERSION >= 7.0) {
        
        CGSize sizeOfText = [text boundingRectWithSize: CGSizeMake(maxWidth,CGFLOAT_MAX)
                                               options: (NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading)
                                            attributes: [NSDictionary dictionaryWithObject:fontSize
                                                                                    forKey:NSFontAttributeName]
                                               context: nil].size;
        
        return  ceilf(sizeOfText.height);
    }else
    {
        CGSize sizeWithFont = [text sizeWithFont:fontSize constrainedToSize:CGSizeMake(maxWidth, CGFLOAT_MAX) lineBreakMode:NSLineBreakByWordWrapping];
        
        return sizeWithFont.height;
    }
}




@end
