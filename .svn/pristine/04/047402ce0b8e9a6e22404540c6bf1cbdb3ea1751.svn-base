//
//  FNSenceDataManager.h
//  FitNess
//
//  Created by liuguoyan on 14-10-3.
//  Copyright (c) 2014年 liuguoyan. All rights reserved.
//


#import <Foundation/Foundation.h>
#import "RequestDefine.h"

typedef void(^RequestSuccessListener) (NSDictionary *result,NSString *msg);
typedef void(^RequestFailedListener) (NSString *msg);
typedef void(^RequestTimeoutListener) ();

@interface FNSenceDataManager : NSObject

@property(nonatomic, copy)RequestSuccessListener onSuccessListener;
@property(nonatomic, copy)RequestFailedListener onFaledListener;
@property(nonatomic, copy)RequestTimeoutListener onTimeOutListener;
@property(nonatomic, strong)NSMutableDictionary * params;

+(id) senceDataManager;

+(id) senceDataManagerHasParams;

-(void) fetchDataWithModule:(NSString *)model
                     method:(NSString *)method
                     params:(NSMutableDictionary *)params
            successListener:(RequestSuccessListener)success
             failedListener:(RequestFailedListener)faild
            timeOutListener:(RequestTimeoutListener)timeout;

@end



/**
 
FNSenceDataManager *_dataManager.params = [FNSenceDataManager senceDataManagerHasParams];


 
 [_dataManager.params setObject:@"" forKey:URL_DATA_K_USERNAME];
 [_dataManager.params setObject:@"" forKey:URL_DATA_K_PASSWORD];
 [_dataManager fetchDataWithModule:MODELS_MODEL_USERLOGIN method:MODELS_METHOD_CHECKLOGIN params:_dataManager.params successListener:^(NSDictionary *result,NSString *msg){
 
 [[TKAlertCenter defaultCenter]postAlertWithMessage:@"登陆成功"];
 NSUserDefaults *userDef = [NSUserDefaults standardUserDefaults];
 NSDictionary *data = [result objectForKey:@"data"][0];
 
 } failedListener:^(NSString *msg){
 
 } timeOutListener:^{
 
 }];
**/

















