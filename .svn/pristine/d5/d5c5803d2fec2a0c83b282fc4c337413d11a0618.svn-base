//
//  FNUserStatues.m
//  FitNess
//
//  Created by WeiHu on 14-10-18.
//  Copyright (c) 2014年 WeiHu. All rights reserved.
//

#import "FNUserStatues.h"

static NSString *SETTING_LOGINTYPE = @"SETTING_LOGINTYPE";
static FNUserStatues *sharedInstance = nil;

@implementation FNUserStatues

+ (FNUserStatues *)sharedInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
	return sharedInstance;
}

/*
 ********登录状态
 */

-(BOOL)loginType
{
    return [[NSUserDefaults standardUserDefaults] boolForKey:SETTING_LOGINTYPE];
}

-(void)setLoginType:(BOOL)loginType{
    [[NSUserDefaults standardUserDefaults] setBool:loginType forKey:SETTING_LOGINTYPE];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

@end
