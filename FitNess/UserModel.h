//
//  UserModel.h
//  FitNess
//
//  Created by liuguoyan on 14-10-7.
//  Copyright (c) 2014年 liuguoyan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FNBaseModel.h"

@interface UserModel : FNBaseModel
//activityNum = "";
@property (nonatomic ,copy) NSString * activityNum;
//alsoNeedKll = "";
@property (nonatomic ,copy) NSString * alsoNeedKll;
//birthday = "1992-09-20";
@property (nonatomic ,copy) NSString * birthday;
//bmiVal = "28.4";
@property (nonatomic ,copy) NSString * bmiVal;
//email = "";
@property (nonatomic ,copy) NSString * email;
//expressPwdDate = "";
@property (nonatomic ,copy) NSString * expressPwdDate;
//fixCalcExpKll = "0.0";
@property (nonatomic ,copy) NSString * fixCalcExpKll;
//fixCalcImpKll = "2233.66";
@property (nonatomic ,copy) NSString * fixCalcImpKll;
//healthWeightScope = "58.3~71.2";
@property (nonatomic ,copy) NSString * healthWeightScope;
//heartNum = 775;
@property (nonatomic ,copy) NSString *  heartNum;
//high = 178;
@property (nonatomic ,copy) NSString *  high;
//id = 213;
@property (nonatomic ,copy) NSString *  uid;
//increamFatTip = woshishui;
@property (nonatomic ,copy) NSString * increamFatTip;
//increamFatWeight = "";
@property (nonatomic ,copy) NSString * increamFatWeight;
//password = ly;
@property (nonatomic ,copy) NSString * password;
//permitWeight = 65;
@property (nonatomic ,copy) NSString * permitWeight;
//registyWeight = 90;
@property (nonatomic ,copy) NSString * registyWeight;
//remark = "";
@property (nonatomic ,copy) NSString * remark;
//sex = 1;
@property (nonatomic ,copy) NSString * sex;
//singDays = 8;
@property (nonatomic ,copy) NSString * singDays;
//standWeight = "64.8";
@property (nonatomic ,copy) NSString * standWeight;
//sts = A;
@property (nonatomic ,copy) NSString * sts;
//stsDate = "2014-09-20 00:00:00.0";
@property (nonatomic ,copy) NSString * stsDate;
//telNbr = 13671177768;
@property (nonatomic ,copy) NSString * telNbr;
//threeSideAcct = "";
@property (nonatomic ,copy) NSString * threeSideAcct;
//threeSideType = "";
@property (nonatomic ,copy) NSString * threeSideType;
//userImgPath = "http:....../348.jpg";
@property (nonatomic ,copy) NSString * userImgPath;
//userName = ly;
@property (nonatomic ,copy) NSString * userName;
//userType = "";
@property (nonatomic ,copy) NSString * userType;
//workType = 1;
@property (nonatomic ,copy) NSString * workType;

@property (nonatomic ,copy) NSString *userTarget;
@end

