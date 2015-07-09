//
//  FNLoginSenceDataManager.m
//  FitNess
//
//  Created by liuguoyan on 14-10-3.
//  Copyright (c) 2014年 liuguoyan. All rights reserved.
//

#import "FNLoginSenceDataManager.h"
#import "NetworkManager.h"

@implementation FNLoginSenceDataManager

- (void)fetchDataWithModule:(NSString *)model method:(NSString *)method params:(NSMutableDictionary *)params successListener:(RequestSuccessListener)success failedListener:(RequestFailedListener)faild timeOutListener:(RequestTimeoutListener)timeout
{
    
    NSMutableDictionary *requestDic = [NSMutableDictionary dictionary];
    
    //登陆操作
    if ([model isEqualToString:MODELS_MODEL_USERLOGIN] && [method isEqualToString:MODELS_METHOD_CHECKLOGIN]) {
        [requestDic setObject:model forKey:URL_DATA_K_MOUDLENAME];
        [requestDic setObject:method forKey:URL_DATA_K_METHOD];
        [requestDic addEntriesFromDictionary:params];
    }
    
    
    [super fetchDataWithModule:model method:method params:requestDic successListener:success failedListener:faild timeOutListener:timeout];
}

@end
