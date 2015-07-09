//
//  UserModel.m
//  FitNess
//
//  Created by liuguoyan on 14-10-7.
//  Copyright (c) 2014年 liuguoyan. All rights reserved.
//

#import "UserModel.h"

#define kactivityNum         @"activityNum"
#define kalsoNeedKll         @"alsoNeedKll"
#define kbirthday            @"birthday"
#define kbmiVal              @"bmiVal"
#define kemail               @"email"
#define kexpressPwdDate      @"expressPwdDate"
#define kfixCalcExpKll       @"fixCalcExpKll"
#define kfixCalcImpKll       @"fixCalcImpKll"
#define khealthWeightScope   @"healthWeightScope"
#define kheartNum            @"heartNum"
#define khigh                @"high"
#define kuid                 @"uid"
#define kincreamFatTip       @"increamFatTip"
#define kincreamFatWeight    @"increamFatWeight"
#define kpassword            @"password"
#define kpermitWeight        @"permitWeight"
#define kregistyWeight       @"registyWeight"
#define kremark              @"remark"
#define ksex                 @"sex"
#define ksingDays            @"singDays"
#define kstandWeight         @"standWeight"
#define ksts                 @"sts"
#define kstsDate             @"stsDate"
#define ktelNbr              @"telNbr"
#define kthreeSideAcct       @"threeSideAcct"
#define kthreeSideType       @"threeSideType"
#define kuserImgPath         @"userImgPath"
#define kuserName            @"userName"
#define kuserType            @"userType"
#define kworkType            @"workType"

//  Copyright (c) 2014年 liuguoyan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FNBaseModel.h"

@interface UserModel () <NSCoding>



@end

@implementation UserModel



-(id) initWithDictionary: (NSDictionary *)dic
{
    NSArray *allkeys = [dic allKeys];
    NSMutableDictionary *mydic = [NSMutableDictionary dictionary];
    for (int i = 0 ; i< allkeys.count ; i++) {
        if ([allkeys[i] isEqualToString:@"id"]) {
            
            [mydic setObject:[dic objectForKey:@"id"] forKey:@"uid"];
        }else{
            [mydic setObject:[dic objectForKey:allkeys[i]] forKey:allkeys[i]];
        }
    }
    return [super initWithDictionary:mydic];
    
}


- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self == [super init]) {
        self.activityNum = [aDecoder decodeObjectForKey:kactivityNum];
        self.alsoNeedKll = [aDecoder decodeObjectForKey:kalsoNeedKll];
        self.birthday = [aDecoder decodeObjectForKey:kbirthday];
        self.bmiVal = [aDecoder decodeObjectForKey:kbmiVal];
        self.email = [aDecoder decodeObjectForKey:kemail];
        self.expressPwdDate =[aDecoder decodeObjectForKey:kexpressPwdDate];
        self.fixCalcExpKll = [aDecoder decodeObjectForKey:kfixCalcExpKll];
        self.fixCalcImpKll = [aDecoder decodeObjectForKey:kfixCalcImpKll];
        self.healthWeightScope = [aDecoder decodeObjectForKey:khealthWeightScope];
        self.heartNum = [aDecoder decodeObjectForKey:kheartNum];
        self.high = [aDecoder decodeObjectForKey:khigh];
        self.uid = [aDecoder decodeObjectForKey:kuid];
        self.increamFatTip = [aDecoder decodeObjectForKey:kincreamFatTip];
        self.increamFatWeight = [aDecoder decodeObjectForKey:kincreamFatWeight];
        self.password = [aDecoder decodeObjectForKey:kpassword];
        self.permitWeight = [aDecoder decodeObjectForKey:kpermitWeight];
        self.registyWeight = [aDecoder decodeObjectForKey:kregistyWeight];
        self.remark = [aDecoder decodeObjectForKey:kremark];
        self.sex = [aDecoder decodeObjectForKey:ksex];
        self.singDays = [aDecoder decodeObjectForKey:ksingDays];
        self.standWeight = [aDecoder decodeObjectForKey:kstandWeight];
        self.sts = [aDecoder decodeObjectForKey:ksts];
        self.stsDate = [aDecoder decodeObjectForKey:kstsDate];
        self.telNbr = [aDecoder decodeObjectForKey:ktelNbr];
        self.threeSideAcct = [aDecoder decodeObjectForKey:kthreeSideAcct];
        self.threeSideType = [aDecoder decodeObjectForKey:kthreeSideType];
        self.userImgPath = [aDecoder decodeObjectForKey:kuserImgPath];
        self.userName = [aDecoder decodeObjectForKey:kuserName];
        self.userType = [aDecoder decodeObjectForKey:kuserType];
        self.workType = [aDecoder decodeObjectForKey:kworkType];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.activityNum forKey:kactivityNum];
    [aCoder encodeObject:self.alsoNeedKll forKey:kalsoNeedKll];
    [aCoder encodeObject:self.birthday forKey:kbirthday];
    [aCoder encodeObject:self.bmiVal forKey:kbmiVal];
    [aCoder encodeObject:self.email forKey:kemail];
    [aCoder encodeObject:self.expressPwdDate forKey:kexpressPwdDate];
    [aCoder encodeObject:self.fixCalcExpKll forKey:kfixCalcExpKll];
    [aCoder encodeObject:self.fixCalcImpKll forKey:kfixCalcImpKll];
    [aCoder encodeObject:self.healthWeightScope forKey:khealthWeightScope];
    [aCoder encodeObject:self.heartNum forKey:kheartNum];
    [aCoder encodeObject:self.high forKey:khigh];
    [aCoder encodeObject:self.uid forKey:kuid];
    [aCoder encodeObject:self.increamFatTip forKey:kincreamFatTip];
    [aCoder encodeObject:self.increamFatWeight forKey:kincreamFatWeight];
    [aCoder encodeObject:self.password forKey:kpassword];
    [aCoder encodeObject:self.permitWeight forKey:kpermitWeight];
    [aCoder encodeObject:self.registyWeight forKey:kregistyWeight];
    [aCoder encodeObject:self.remark forKey:kremark];
    [aCoder encodeObject:self.sex forKey:ksex];
    [aCoder encodeObject:self.singDays forKey:ksingDays];
    [aCoder encodeObject:self.standWeight forKey:kstandWeight];
    [aCoder encodeObject:self.sts forKey:ksts];
    [aCoder encodeObject:self.stsDate forKey:kstsDate];
    [aCoder encodeObject:self.telNbr forKey:ktelNbr];
    [aCoder encodeObject:self.threeSideAcct forKey:kthreeSideAcct];
    [aCoder encodeObject:self.threeSideType forKey:kthreeSideType];
    [aCoder encodeObject:self.userImgPath forKey:kuserImgPath];
    [aCoder encodeObject:self.userName forKey:kuserName];
    [aCoder encodeObject:self.userType forKey:kuserType];
    [aCoder encodeObject:self.workType forKey:kworkType];
}




@end
