//
//  FNDataKeeper.m
//  FitNess
//
//  Created by liuguoyan on 14-10-7.
//  Copyright (c) 2014年 liuguoyan. All rights reserved.
//

#import "FNDataKeeper.h"
#import "UserModel.h"

static FNDataKeeper * dataKeeper;

@interface FNDataKeeper()
{
    UserModel *userModel;
}
@end

@implementation FNDataKeeper

+(id) sharedInstance
{
    if (!dataKeeper) {
        dataKeeper = [[FNDataKeeper alloc]init];
    }
    return dataKeeper;
}

-(id) getUser
{
//    if (!userModel) {
//        NSLog(@"user in null in data keeper");
//        NSUserDefaults *userDef = [NSUserDefaults standardUserDefaults];
//        NSDictionary *user = [userDef objectForKey:@"user"];
//        userModel = [UserModel modelWithDictionary:user];
//    }
//    return userModel;
//    if (!userModel) {
        NSData *_data = [[NSData alloc] initWithContentsOfFile:[self getFilePathWithModelKey:@"model"]];
        NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:_data];
        //解档出数据模型Student
        userModel = [unarchiver decodeObjectForKey:@"user"];
        [unarchiver finishDecoding];
//    }
    return userModel;
}

- (void)setUserModel:(UserModel *)user
{
    userModel = user;
}

-(id)getUserId
{
    if (!userModel) {
        userModel = [self getUser];
    }
    if (userModel.uid && ![[NSString stringWithFormat:@"%@",userModel.uid] isEqualToString:@""]) {
        return userModel.uid;
    }else{
        return @"";
    }
    return userModel.uid;
}

//-(void)saveUser:(NSDictionary *)dic
//{
//    NSUserDefaults *userDef = [NSUserDefaults standardUserDefaults];
//    if (userDef) {
//        [userDef setObject:dic forKey:@"user"];
//        [userDef synchronize];
//    }
//    
//}

- (void)updateUser:(UserModel *)user
{
    NSMutableData *data = [[NSMutableData alloc] init];
    
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
    
    [archiver encodeObject:user forKey:@"user"];
    
    [archiver finishEncoding];
    
    [data writeToFile:[self getFilePathWithModelKey:@"model"] atomically:YES];
}

/**
 ///////////////////////
 NSMutableData *data = [[NSMutableData alloc] init];
 
 NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
 
 [archiver encodeObject:user forKey:@"user"];
 
 [archiver finishEncoding];
 
 [data writeToFile:[self getFilePathWithModelKey:@"model"] atomically:YES];
 
 ///////////////////////
 NSData *_data = [[NSData alloc] initWithContentsOfFile:[self getFilePathWithModelKey:@"model"]];
 NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:_data];
 //解档出数据模型Student
 UserModel *mStudent = [unarchiver decodeObjectForKey:@"user"];
 [unarchiver finishDecoding];
 
 NSLog(@"achived user = %@",mStudent);
 
 */

-(NSString *) getFilePathWithModelKey:(NSString *)modelkey
{
    
    NSArray *array =  NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    return [[array objectAtIndex:0] stringByAppendingPathComponent:modelkey];
    
}




@end
