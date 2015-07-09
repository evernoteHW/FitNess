//
//  CommonSenceDataManager.h
//  FitNess
//
//  Created by liuguoyan on 14-10-7.
//  Copyright (c) 2014年 liuguoyan. All rights reserved.
//

#import "FNSenceDataManager.h"

@interface CommonSenceDataManager : FNSenceDataManager

-(NSDictionary *)spliteResultDictionaryWithResult:(NSDictionary*)result;

-(NSArray *)spliteResultArrayWithResult:(NSDictionary*)result;

@end


/**
 [self.senceDataManager.params removeAllObjects];
 [self.senceDataManager.params setObject:[[FNDataKeeper sharedInstance] getUserId] forKey:URL_DATA_K_USER_ID];
 [self.senceDataManager fetchDataWithModule:MODELS_MODEL_USERREGISTRY method:MODELS_METHOD_GETUSERBYUSERID params:self.senceDataManager.params successListener:^(NSDictionary *result,NSString *msg){
 NSDictionary *userdic = result[@"data"][0];
 UserModel *user = [UserModel modelWithDictionary:userdic];
 [[FNDataKeeper sharedInstance] updateUser:user];
 [self refreshUI];
 } failedListener:^(NSString *msg){
 
 } timeOutListener:^{
 
 }];

 
 **/
