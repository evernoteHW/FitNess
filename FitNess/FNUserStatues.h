//
//  FNUserStatues.h
//  FitNess
//
//  Created by WeiHu on 14-10-18.
//  Copyright (c) 2014年 WeiHu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FNUserStatues : NSObject

@property (nonatomic, assign) BOOL loginType;//推送消息查看状态
+ (FNUserStatues *)sharedInstance;

@end
