//
//  SportCommonModel.h
//  FitNess
//
//  Created by WeiHu on 14/10/23.
//  Copyright (c) 2014年 WeiHu. All rights reserved.
//

#import "FNBaseModel.h"

@interface SportCommonModel : FNBaseModel

/**
 *  sportSts,
 sportHeat,
 sportIsFreq,
 sportKeepDate,
 sportStrong,
 remark,
 sportType,
 fid,
 sportDesc,
 sportImgPath,
 sportName
 */
@property (nonatomic, strong) NSString * sportSts;
@property (nonatomic, strong) NSString * sportHeat;
@property (nonatomic, strong) NSString * sportIsFreq;
@property (nonatomic, strong) NSString * sportKeepDate;
@property (nonatomic, strong) NSString * sportStrong;
@property (nonatomic, strong) NSString * remark;
@property (nonatomic, strong) NSString * sportType;
@property (nonatomic, strong) NSString * fid;
@property (nonatomic, strong) NSString * sportDesc;
@property (nonatomic, strong) NSString * sportImgPath;
@property (nonatomic, strong) NSString * sportName;
@property (nonatomic, strong) NSString * colCount;
@end