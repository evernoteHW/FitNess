//
//  FriendActivityCell.h
//  FitNess
//
//  Created by liuguoyan on 14-10-10.
//  Copyright (c) 2014年 liuguoyan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FNBaseCell.h"

@class FriendActivityModel;
@class UserMessageVOModel;
@class FriendActivityCell;
@class RTLabel;


@protocol FriendActivityCellDelegate <NSObject>
-(void) onHeadtButtonClicked :(FriendActivityModel *)activity ;
-(void) onHeartButtonClicked :(FriendActivityModel *)activity ;
-(void) onCommontButtonClicked:(FriendActivityModel *)activity ;
-(void) onImageViewClicked:(FriendActivityModel *)activity friendActivityCell:(FriendActivityCell *)cell;
-(void) onActionButtonClicked:(FriendActivityModel *)activity friendActivityCell:(FriendActivityCell *)cell;

@end

@interface FriendActivityCell : UITableViewCell

@property (nonatomic,strong) UIView *cellBackView;
@property (nonatomic,strong) UIButton *headView;
@property (nonatomic,strong) UILabel *nameView;
@property (nonatomic,strong) UILabel *timeView;
@property (nonatomic,strong) RTLabel *contView;
@property (nonatomic,strong) UIImageView *imgContView;
@property (nonatomic,strong) UIButton *heartButton;
@property (nonatomic,strong) UIButton *commentButton;
@property (nonatomic,strong) UIButton *actionButton;

@property (nonatomic,assign) id<FriendActivityCellDelegate> delegate;

@property (nonatomic,strong) FriendActivityModel *activity;

-(void)refreshUI;


+ (CGFloat) getCellHeightWithModel:(UserMessageVOModel *)model;


@end
