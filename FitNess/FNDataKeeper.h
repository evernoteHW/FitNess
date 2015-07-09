//
//  FNDataKeeper.h
//  FitNess
//
//  Created by liuguoyan on 14-10-7.
//  Copyright (c) 2014年 liuguoyan. All rights reserved.
//

#import <Foundation/Foundation.h>

@class UserModel;

@interface FNDataKeeper : NSObject

+(id) sharedInstance;

-(id) getUser;

-(void) setUserModel:(UserModel *)user;

-(id) getUserId;

//-(void) saveUser:(NSDictionary *)dic;

-(void) updateUser:(UserModel *) user;

@end
