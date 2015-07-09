//
//  StatusCommentViewController.h
//  FitNess
//
//  Created by WeiHu on 14/10/22.
//  Copyright (c) 2014年 WeiHu. All rights reserved.
//

#import "FNStepViewController.h"
@class FriendActivityModel;

typedef void(^StatusCommentBlock)(NSString *commentNum);

@interface StatusCommentViewController : FNStepViewController

// 消息ID
@property (nonatomic, strong) NSString *userMsgId;
// 评论内容
@property (nonatomic, strong) NSString *commentContent;
// 父评论ID
@property (nonatomic, strong) NSString *parentId;
//回调到行数
@property (nonatomic, copy) StatusCommentBlock statusCommentBlock;

@property (nonatomic, strong) FriendActivityModel *selectedModel;

@end

@class StatusCommentCell;
@class StatuesModel;

typedef void(^CallBackBlock)(StatusCommentCell *cell);

@interface StatusCommentCell : UITableViewCell

@property (nonatomic, strong) UIButton *headView;
@property (nonatomic, strong) UILabel *nameView;
@property (nonatomic, strong) UILabel *timeView;
@property (nonatomic, strong) RTLabel *contView;
@property (nonatomic, strong) UIButton *commentButton;

@property (nonatomic, strong) StatuesModel *statuesModel;

@property (nonatomic ,copy) CallBackBlock callBackBlock;

@end