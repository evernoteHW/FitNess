//
//  FNSenceDataManager.m
//  FitNess
//
//  Created by liuguoyan on 14-10-3.
//  Copyright (c) 2014年 liuguoyan. All rights reserved.
//

#import "FNSenceDataManager.h"
#import "NetworkManager.h"

@implementation FNSenceDataManager

-(void)fetchDataWithModule:(NSString *)model method:(NSString *)method params:(NSMutableDictionary *)params successListener:(RequestSuccessListener)success failedListener:(RequestFailedListener)faild timeOutListener:(RequestTimeoutListener)timeout
{
    
    self.onSuccessListener = success;
    self.onFaledListener = faild;
    self.onTimeOutListener = timeout;
    
    [[NetworkManager shareManager] requestWithURL:@"" params:params httpMethod:@"POST" finishBlock:^(DataServies *request, id result) {
        NSDictionary *dic = result;
        int flag = [[dic objectForKey:@"flag"]intValue];
        NSString *msg = [dic objectForKey:@"msg"];
        if (flag==1 && self.onSuccessListener) {
            NSArray *retArr = [dic objectForKey:@"retDataArray"];
            NSDictionary *retdic = retdic = [NSDictionary dictionaryWithObject:retArr forKey:@"data"];
            self.onSuccessListener(retdic,msg);
            self.onSuccessListener = nil;
        }else if(flag ==0 && self.onFaledListener){
            self.onFaledListener(msg);
            self.onFaledListener = nil;
        }
        
    } failBlock:^(DataServies *request,NSError *error) {
        if (self.onTimeOutListener) {
            self.onTimeOutListener();
            self.onTimeOutListener = nil;
        }
    }];
    
    
}

+(id) senceDataManager
{
    return [[self alloc]init];
}

+(id) senceDataManagerHasParams
{
    id instance = [[self alloc ] init];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [instance setParams:(params)];
    return instance;
}
@end
