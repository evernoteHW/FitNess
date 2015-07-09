//
//  FoodPubModel.m
//  FitNess
//
//  Created by liuguoyan on 14-10-16.
//  Copyright (c) 2014年 liuguoyan. All rights reserved.
//

#import "FoodPubModel.h"

@implementation FoodPubModel


-(id) initWithDictionary: (NSDictionary *)dic
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
