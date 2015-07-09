//
//  FoodInfoModel.m
//  FitNess
//
//  Created by WeiHu on 14/10/23.
//  Copyright (c) 2014年 WeiHu. All rights reserved.
//

#import "FoodInfoModel.h"

@implementation FoodInfoModel

- (id) initWithDictionary: (NSDictionary *)dic
{
    NSArray *allkeys = [dic allKeys];
    NSMutableDictionary *mydic = [NSMutableDictionary dictionary];
    for (int i = 0 ; i< allkeys.count ; i++) {
        if ([allkeys[i] isEqualToString:@"foodId"]) {
            [mydic setObject:[NSString stringWithFormat:@"%@",[dic objectForKey:@"foodId"]] forKey:@"foodId"];
        }else{
            [mydic setObject:[dic objectForKey:allkeys[i]] forKey:allkeys[i]];
        }
    }
    return [super initWithDictionary:mydic];
    
}

@end
