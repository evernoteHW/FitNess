//
//  FNBaseModel.m
//  FitNess
//
//  Created by liuguoyan on 14-10-7.
//  Copyright (c) 2014年 liuguoyan. All rights reserved.
//

#import "FNBaseModel.h"

@implementation FNBaseModel 

+(id) modelWithDictionary: (NSDictionary *)dic
{
    return [[self alloc] initWithDictionary:dic];

}

-(id) initWithDictionary: (NSDictionary *)dic
{
    if (self == [super init]) {
        NSArray *allkeys = [dic allKeys];
        for (int i = 0 ; i<allkeys.count; i++) {
            [self setValue:[dic objectForKey:allkeys[i]] forKey:allkeys[i]];
        }
    }
    return self;
}

@end
