//
//  UserMessageVOModel.m
//  FitNess
//
//  Created by liuguoyan on 14-10-10.
//  Copyright (c) 2014年 liuguoyan. All rights reserved.
//

#import "UserMessageVOModel.h"

@implementation UserMessageVOModel

//collectNum = 0;
//commentNum = 0;
//forwardMsgId = "";
//forwardUserId = "";
//forwardUserName = "";
//id = 398;
//msgContent = xixi;
//msgImg = "";
//msgPrivige = 1;
//msgType = 1;
//pairseNum = 0;
//sts = A;
//stsDate = "2014-10-10 10:35:59.0";
//userId = 272;
//userIntrestList = "";

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

- (void)setCollectNum:(NSString *)collectNum
{
    _collectNum = collectNum;
}

@end
