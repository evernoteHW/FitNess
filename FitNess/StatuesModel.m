//
//  StatuesModel.m
//  FitNess
//
//  Created by WeiHu on 14/10/23.
//  Copyright (c) 2014年 WeiHu. All rights reserved.
//

#import "StatuesModel.h"
#import "ModelDef.h"
#import "CommentsModel.h"

@implementation StatuesModel

-(id) initWithDictionary: (NSDictionary *)dic
{
    self.user = [UserModel modelWithDictionary:[dic objectForKey:@"user"]];
    self.commentsModel = [CommentsModel modelWithDictionary:[dic objectForKey:@"msgCommentVO"]];
    return self;
}

@end
