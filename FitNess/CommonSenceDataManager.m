//
//  CommonSenceDataManager.m
//  FitNess
//
//  Created by liuguoyan on 14-10-7.
//  Copyright (c) 2014年 liuguoyan. All rights reserved.
//

#import "CommonSenceDataManager.h"

@implementation CommonSenceDataManager
- (void)fetchDataWithModule:(NSString *)model method:(NSString *)method params:(NSMutableDictionary *)params successListener:(RequestSuccessListener)success failedListener:(RequestFailedListener)faild timeOutListener:(RequestTimeoutListener)timeout
{
    
    NSMutableDictionary *requestDic = [NSMutableDictionary dictionary];
   
    [requestDic setObject:model forKey:URL_DATA_K_MOUDLENAME];
    [requestDic setObject:method forKey:URL_DATA_K_METHOD];
    [requestDic addEntriesFromDictionary:params];
    
    [super fetchDataWithModule:model method:method params:requestDic successListener:success failedListener:faild timeOutListener:timeout];
}

-(NSDictionary *)spliteResultDictionaryWithResult:(NSDictionary*)result
{
    NSArray *arr = [result objectForKey:@"data"];
    if (arr.count>0) {
        return  [result objectForKey:@"data"][0];
    }
    
    return nil;
}

-(NSArray *)spliteResultArrayWithResult:(NSDictionary*)result
{
    return [result objectForKey:@"data"];
}

@end
