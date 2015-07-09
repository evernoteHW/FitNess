//
//  AltFriendsViewController.h
//  FitNess
//
//  Created by WeiHu on 14/10/19.
//  Copyright (c) 2014年 WeiHu. All rights reserved.
//

#import "FNStepViewController.h"

typedef void(^SendStatusBlock)(NSArray *altFriArr);

@interface AltFriendsViewController : FNStepViewController

@property (nonatomic, copy) SendStatusBlock sendStatusBlock;

@end


@class AltFriendsCell;

typedef void(^AltFriendBlock)(AltFriendsCell *cell);


@interface AltFriendsCell : UITableViewCell

@property (strong , nonatomic) UIImageView *altFriHeadImageView;
@property (strong , nonatomic) UILabel *altFriLabel;
@property (strong , nonatomic) UIImageView *boxImageView;
@property (strong , nonatomic) UIImageView *tickOffImageView;
@property (strong , nonatomic) UserModel *model;

@property (nonatomic, copy) AltFriendBlock altFriendBlock;

@end