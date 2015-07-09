//
//  AddFriendViewController.h
//  FitNess
//
//  Created by WeiHu on 14/10/19.
//  Copyright (c) 2014年 WeiHu. All rights reserved.
//

#import "FNStepViewController.h"

typedef void(^SendStatusBlock)(NSString *altFriStr);

@interface AddFriendViewController : FNStepViewController

@property (nonatomic, copy) SendStatusBlock sendStatusBlock;
@property (nonatomic, assign) BOOL addFriend; //关注和取消关注
@end


@class AddFriendsCell;

typedef void(^AddFriendBlock)(AddFriendsCell *cell);


@interface AddFriendsCell : UITableViewCell

@property (strong , nonatomic) UIImageView *altFriHeadImageView;
@property (strong , nonatomic) UILabel *altFriLabel;
@property (strong , nonatomic) UIButton *addAttentionBtn;
//@property (strong , nonatomic) UIImageView *boxImageView;
//@property (strong , nonatomic) UIImageView *tickOffImageView;
@property (strong , nonatomic) UserModel *model;
@property (nonatomic, assign) BOOL addFriend;

@property (nonatomic, copy) AddFriendBlock addFriendBlock;

@end


