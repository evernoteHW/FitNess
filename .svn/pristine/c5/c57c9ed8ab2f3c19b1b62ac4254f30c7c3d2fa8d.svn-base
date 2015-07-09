//
//  MotionFriendCell.h
//  FitNess
//
//  Created by liuguoyan on 14-10-12.
//  Copyright (c) 2014年 liuguoyan. All rights reserved.
//

#import "FNBaseCell.h"
#import "RTLabel.h"

@class UserModel;

@protocol MotionFriendCellDelegate <NSObject>

-(void) onAttentionButtonWithUser:(UserModel *)user;


@end

@interface MotionFriendCell : FNBaseCell
{
    UIImageView *_headerImage;
    UIImageView *_headImage;
    RTLabel *_nickView;
    RTLabel *_annouceView;
    RTLabel *_reduceView;
    UIButton *_attionButton;
}

@property (nonatomic,strong) id<MotionFriendCellDelegate>delegate;
@property (nonatomic,strong) UserModel *user;

-(void)refreshUI;

@end
