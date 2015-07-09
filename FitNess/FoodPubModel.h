//
//  FoodPubModel.h
//  FitNess
//
//  Created by liuguoyan on 14-10-16.
//  Copyright (c) 2014年 liuguoyan. All rights reserved.
//

#import "FNBaseModel.h"

@interface FoodPubModel : FNBaseModel

//id = 1;
@property (nonatomic,copy) NSString *fid;

//parentCode = "t_001";
@property (nonatomic,copy) NSString *parentCode;

//remark = "http://creative.adtina.com/yunduoduo_test/tt_1_tt_1.jpg";
@property (nonatomic,copy) NSString *remark;

//sourceUrl = "http://s.boohee.cn/images/food/category/1.png";
@property (nonatomic,copy) NSString *sourceUrl;

//typeTCode = "tt_1";
@property (nonatomic,copy) NSString *typeTCode;

//typeTName = "\U8c37\U85af\U828b\U3001\U6742\U8c46\U3001\U4e3b\U98df";
@property (nonatomic,copy) NSString *typeTName;

//typeTSts = A;
@property (nonatomic,copy) NSString *typeTSts;





@end
