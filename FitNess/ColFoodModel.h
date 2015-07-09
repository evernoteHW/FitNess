//
//  ColFoodModel.h
//  FitNess
//
//  Created by WeiHu on 14/10/21.
//  Copyright (c) 2014年 WeiHu. All rights reserved.
//

#import "FNBaseModel.h"

@interface ColFoodModel : FNBaseModel

/**

 faveriteImgPath = "http://creative.adtina.com/yunduoduo_test/food_3_tt_1.jpg";
 faveriteName = "\U9992\U5934";
 faveriteObjId = 3;
 faveriteType = 0;
 faveriteTypeName = "";
 id = 52;
 sts = A;
 stsDate = "";
 userId = 213;
 */
@property (nonatomic, strong) NSString *faveriteImgPath;
@property (nonatomic, strong) NSString *faveriteTypeName;
@property (nonatomic, strong) NSString *faveriteName;
@property (nonatomic, strong) NSString *faveriteObjId;
@property (nonatomic, strong) NSString *faveriteType;
@property (nonatomic, strong) NSString *fid;
@property (nonatomic, strong) NSString *sts;
@property (nonatomic, strong) NSString *stsDate;
@property (nonatomic, strong) NSString *userId;

@end
