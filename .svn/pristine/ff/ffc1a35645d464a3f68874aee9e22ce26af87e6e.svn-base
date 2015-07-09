//
//  MotionFriendCell.m
//  FitNess
//
//  Created by liuguoyan on 14-10-12.
//  Copyright (c) 2014年 liuguoyan. All rights reserved.
//

#import "MotionFriendCell.h"
#import "FNMacro.h"


#define  nickFormat  @"<font size=13 color='#484848'>昵称:</font><font size=13 color='#FF6895'>%@</font>"
#define  annoFormat  @"<font size=13 color='#484848'>减肥宣言:</font><font size=14 color='#B7ADAC'>%@</font>"
#define  reduFormat  @"<font size=13 color='#484848'>成功减肥:</font><font size=14 color='#FF6895'>%@</font>"

@implementation MotionFriendCell


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    
    self = [super initWithStyle: style reuseIdentifier: reuseIdentifier];
    
    _headerImage = [[UIImageView alloc]initWithFrame:CGRectMake(_px(10), _px(18), _px(252), _px(64))];
    [_headerImage setImage:[UIImage imageNamed:@"friend_icon"]];
    [self.contentView addSubview:_headerImage];
    
    _headImage = [[UIImageView alloc]initWithFrame:CGRectMake(_px(80), _px(116), _px(174), _px(174))];
    [_headImage setImage:[UIImage imageNamed:@"friend_image"]];
    [self.contentView addSubview:_headImage];
    
    _nickView = [[RTLabel alloc]initWithFrame:CGRectMake(_px(290), _px(116), _px(284), _px(30))];
    [_nickView setText:[NSString stringWithFormat:nickFormat,@"昵称"]];
    [self.contentView addSubview:_nickView];
    
    _annouceView = [[RTLabel alloc]initWithFrame:CGRectMake(_px(290), _px(160), _px(284), _px(64))];
    [_annouceView setText:[NSString stringWithFormat:annoFormat,@"减肥宣言"]];
    [self.contentView addSubview:_annouceView];
    
    _reduceView = [[RTLabel alloc]initWithFrame:CGRectMake(_px(290), _px(208), _px(284), _px(36))];
    [_reduceView setText:[NSString stringWithFormat:annoFormat,@"15"]];
    [self.contentView addSubview:_reduceView];
    
    _attionButton = [[UIButton alloc]initWithFrame:CGRectMake(_px(344), _px(250), _px(136), _px(36))];
    [_attionButton setImage:[UIImage imageNamed:@"friend_guanzhu"] forState:UIControlStateNormal];
    [self.contentView addSubview:_attionButton];
    
    [_attionButton addTarget:self action:@selector(onAttention) forControlEvents:UIControlEventTouchUpInside];
    
    return self;
}

-(void)refreshUI
{

    [_headImage sd_setImageWithURL:[NSURL URLWithString:self.user.userImgPath]];
    
    [_nickView setText:[NSString stringWithFormat:nickFormat,self.user.userName]];
    
    [_annouceView setText:[NSString stringWithFormat:annoFormat,self.user.increamFatTip]];

    [_reduceView setText:[NSString stringWithFormat:reduFormat,self.user.increamFatWeight]];
    
    if (self.user.remark.intValue == 1) {
        [_attionButton setImage:[UIImage imageNamed:@"friend_de_guanzhu"] forState:UIControlStateNormal];
    }else{
        [_attionButton setImage:[UIImage imageNamed:@"friend_guanzhu"] forState:UIControlStateNormal];
    }
}


-(void) onAttention
{
    [self.delegate onAttentionButtonWithUser:self.user];
}



@end
