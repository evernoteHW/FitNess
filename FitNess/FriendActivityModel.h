//
//  FriendActivityModel.h
//  FitNess
//
//  Created by liuguoyan on 14-10-10.
//  Copyright (c) 2014年 liuguoyan. All rights reserved.
//

#import "FNBaseModel.h"

@class UserMessageVOModel;
@class UserModel;

@interface FriendActivityModel : FNBaseModel

@property (nonatomic,strong) UserMessageVOModel *userMessageVO;
@property (nonatomic,strong) UserModel *user;

@end
