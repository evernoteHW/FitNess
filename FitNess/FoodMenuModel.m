//
//  FoodMenuModel.m
//  FitNess
//
//  Created by WeiHu on 14/10/25.
//  Copyright (c) 2014年 WeiHu. All rights reserved.
//

#import "FoodMenuModel.h"

@implementation FoodMenuModel

- (id) initWithDictionary: (NSDictionary *)dic
{
    NSArray *allkeys = [dic allKeys];
    NSMutableDictionary *mydic = [NSMutableDictionary dictionary];
    for (int i = 0 ; i< allkeys.count ; i++) {
        if ([allkeys[i] isEqualToString:@"id"]) {
            [mydic setObject:[dic objectForKey:@"id"] forKey:@"menuId"];
        }else{
            [mydic setObject:[dic objectForKey:allkeys[i]] forKey:allkeys[i]];
        }
    }
    return [super initWithDictionary:mydic];
    
}

@end
