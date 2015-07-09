//
//  SportCommonModel.m
//  FitNess
//
//  Created by WeiHu on 14/10/23.
//  Copyright (c) 2014年 WeiHu. All rights reserved.
//

#import "SportCommonModel.h"

@implementation SportCommonModel

- (id) initWithDictionary: (NSDictionary *)dic
{
    NSArray *allkeys = [dic allKeys];
    NSMutableDictionary *mydic = [NSMutableDictionary dictionary];
    for (int i = 0 ; i< allkeys.count ; i++) {
        if ([allkeys[i] isEqualToString:@"id"]) {
            [mydic setObject:[dic objectForKey:@"id"] forKey:@"fid"];
        }else{
            [mydic setObject:[dic objectForKey:allkeys[i]] forKey:allkeys[i]];
        }
    }
    return [super initWithDictionary:mydic];
    
}

@end
