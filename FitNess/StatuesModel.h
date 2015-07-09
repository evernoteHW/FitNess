//
//  StatuesModel.h
//  FitNess
//
//  Created by WeiHu on 14/10/23.
//  Copyright (c) 2014年 WeiHu. All rights reserved.
//

#import "FNBaseModel.h"

@class CommentsModel;
@class UserModel;
@interface StatuesModel : FNBaseModel

@property (nonatomic,strong) CommentsModel *commentsModel;
@property (nonatomic,strong) UserModel *user;

@end
