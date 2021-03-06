//
//  CaloriesModel.h
//  FitNess
//
//  Created by WeiHu on 14/10/26.
//  Copyright (c) 2014年 WeiHu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CaloriesModel : NSObject

@property (nonatomic, strong) NSString  *iconImage;
@property (nonatomic, strong) NSString  *dinnerName;
@property (nonatomic, strong) NSString  *calorsNum;
@property (nonatomic, strong) NSString  *calorsTip;
@property (nonatomic, assign) NSInteger tag;
@property (nonatomic, assign) CGFloat totalAmount;

@end
