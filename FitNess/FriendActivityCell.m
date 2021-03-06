//
//  FriendActivityCell.m
//  FitNess
//
//  Created by liuguoyan on 14-10-10.
//  Copyright (c) 2014年 liuguoyan. All rights reserved.
//

#import "FriendActivityCell.h"
#import "CommonUtils.h"
#import "ModelDef.h"
#import "FNMacro.h"
#import "UIImageView+WebCache.h"
#import "UIButton+WebCache.h"
#import "RTLabel.h"


#define CELL_MARGIN _px(26)

@implementation FriendActivityCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    self.backgroundColor = [UIColor clearColor];
    CGFloat contw = DIME_SCREEN_W - 2 * CELL_MARGIN;
    self.cellBackView = [[UIView alloc]initWithFrame:CGRectMake(CELL_MARGIN, 0, contw, _px(240))];
    self.cellBackView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:self.cellBackView];
    
    self.headView = [[UIButton alloc] initWithFrame:CGRectMake(_px(10), _px(36), _px(96), _px(96))];
    [self.headView setImage:[UIImage imageNamed:@"quan_list_img"] forState:UIControlStateNormal];
    [CommonUtils generateRoundButton:self.headView];
    [self.cellBackView addSubview:self.headView];
    
    self.nameView = [[UILabel alloc]initWithFrame:CGRectMake(_px(120), _px(44), _px(300), _px(30))];
    self.nameView.textColor = [UIColor colorWithHexString:@"FC6995"];
    self.nameView.font = FONT_SIZE(_px(28));
    [self.cellBackView addSubview:self.nameView];
    
    self.timeView = [[UILabel alloc]initWithFrame:CGRectMake(contw-_px(250), _px(52), _px(250), _px(18))];
    self.timeView.font = FONT_SIZE(_px(18));
    self.timeView.textColor =[UIColor grayColor];
    [self.cellBackView addSubview:self.timeView];
    
    self.contView = [[RTLabel alloc]initWithFrame:CGRectMake(_px(120), _px(78), _px(466), _px(2))];
    self.contView.font = FONT_SIZE(_px(24));
    self.contView.textColor =[UIColor grayColor];
    self.contView.backgroundColor = [UIColor clearColor];
    [self.cellBackView addSubview:self.contView];
    
    self.imgContView = [[UIImageView alloc]initWithFrame:CGRectMake(_px(120), 0, _px(150), _px(150))];
    self.imgContView.contentMode = UIViewContentModeScaleAspectFit;
    self.imgContView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onImageV)];
    tapGesture.numberOfTapsRequired = 1;
    [self.imgContView addGestureRecognizer:tapGesture];
    [self.cellBackView addSubview:self.imgContView];
    
    CGFloat bottomy = self.imgContView.frame.origin.y + self.imgContView.frame.size.height + _px(16);
    
    self.heartButton = [[UIButton alloc]initWithFrame:CGRectMake(_px(114), bottomy, _px(70), _px(36))];
    [self.heartButton setImage:[UIImage imageNamed:@"quan_list_heart"] forState:UIControlStateNormal];
    [self.heartButton setTitle:@"0" forState:UIControlStateNormal];
    [self.heartButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    self.heartButton.titleLabel.font = FONT_SIZE(_px(24));
    [self.heartButton setImageEdgeInsets:UIEdgeInsetsMake(0, -5, 0, 5)];
    [self.cellBackView addSubview:self.heartButton];
    
    self.commentButton = [[UIButton alloc]initWithFrame:CGRectMake(_px(188), bottomy, _px(70), _px(36))];
    [self.commentButton setImage:[UIImage imageNamed:@"quan_list_chat"] forState:UIControlStateNormal];
    [self.commentButton setTitle:@"0" forState:UIControlStateNormal];
    [self.commentButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    self.commentButton.titleLabel.font = FONT_SIZE(_px(24));
    [self.commentButton setImageEdgeInsets:UIEdgeInsetsMake(0, -5, 0, 5)];
    [self.cellBackView addSubview:self.commentButton];
    
    self.actionButton = [[UIButton alloc]initWithFrame:CGRectMake(contw - _px(100), bottomy -5, 50, 25)];
    [self.actionButton setImage:[UIImage imageNamed:@"quan_list_more"] forState:UIControlStateNormal];
    [self.cellBackView addSubview:self.actionButton];
    
    
    [self.headView addTarget:self action:@selector(onHead) forControlEvents:UIControlEventTouchUpInside];
    [self.heartButton addTarget:self action:@selector(onHeart) forControlEvents:UIControlEventTouchUpInside];
    [self.commentButton addTarget:self action:@selector(onCommont) forControlEvents:UIControlEventTouchUpInside];
    [self.actionButton addTarget:self action:@selector(onAction) forControlEvents:UIControlEventTouchUpInside];
    
    return self;
}

//头像点击
-(void)onHead
{
    [self.delegate onHeadtButtonClicked:self.activity];
}
//爱心点击
-(void)onHeart
{
    [self.delegate onHeartButtonClicked:self.activity];
}
//评论点击
-(void)onCommont
{
    [self.delegate onCommontButtonClicked:self.activity];
}
//评论点击
-(void)onImageV
{
    [self.delegate onImageViewClicked:self.activity friendActivityCell:self];
}
//功能键点击
-(void)onAction
{
    [self.delegate onActionButtonClicked:self.activity friendActivityCell:self];
}



- (void)setActivity:(FriendActivityModel *)activity
{
    _activity = activity;
      [self refreshUI];
      [self resetLayout];
}

-(void)resetLayout
{
    //设置内容区的frame
    self.contView.height = [self.contView optimumSize].height;
    //设置图片的frame
    if (self.activity.userMessageVO.msgImg.length>0) {
        self.imgContView.top = self.contView.bottom + _px(16);
    }
    self.cellBackView.height =  [FriendActivityCell getCellHeightWithModel:self.activity.userMessageVO];
    //设置下部三个按钮的frame
    self.heartButton.top = self.cellBackView.height - _px(50);
    self.commentButton.top = self.heartButton.top;
    self.actionButton.top = self.heartButton.top;
    
}
- (void)layoutSubviews
{
    [super layoutSubviews];
  
}

-(void)refreshUI
{
    [self.headView sd_setImageWithURL:[NSURL URLWithString:self.activity.user.userImgPath] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"quan_list_img"]];
    self.nameView.text = self.activity.user.userName;
    if (self.activity.userMessageVO.stsDate.length > 19) {
        self.timeView.text = [self.activity.userMessageVO.stsDate substringToIndex:19];
    }else{
        self.timeView.text = self.activity.userMessageVO.stsDate ;
    }

    switch ([_activity.userMessageVO.msgType integerValue]) {
        case 1:
        {
            //正常
             self.contView.text = self.activity.userMessageVO.msgContent;
        }
            break;
        case 2:
        {
            //转发
             self.contView.text = [NSString stringWithFormat:@"转自:%@ %@",self.activity.userMessageVO.forwardUserName,self.activity.userMessageVO.msgContent];
        }
            break;
        case 3:
        {
            //点赞消息
            self.contView.text = self.activity.userMessageVO.msgContent;
        }
            break;
    }
    if (self.activity.userMessageVO.msgContent.length > 0){
        self.contView.hidden = NO;
    }else{
        self.contView.hidden = YES;
    }

    if (self.activity.userMessageVO.msgImg.length > 0) {
        self.imgContView.hidden = NO;
        [self.imgContView sd_setImageWithURL:[NSURL URLWithString:self.activity.userMessageVO.msgImg]  placeholderImage:[UIImage imageNamed:@"quan_list_img"]];
    }else{
        self.imgContView.hidden = YES;
    }
    [self.heartButton setTitle:self.activity.userMessageVO.pairseNum forState:UIControlStateNormal];
    [self.commentButton setTitle:self.activity.userMessageVO.commentNum forState:UIControlStateNormal];

}

+ (CGFloat) getCellHeightWithModel:(UserMessageVOModel *)model
{
    CGFloat imageHeight = 0;
    CGFloat contentHeight = 0;
    CGFloat extraHeight = _px(160);
    if (model.msgContent.length>0) {
        RTLabel *labelDemo = [[RTLabel alloc]initWithFrame:CGRectMake(_px(120), _px(78), _px(466), _px(2))];
        labelDemo.font = FONT_SIZE(_px(24));
        labelDemo.textColor =[UIColor grayColor];
        labelDemo.text = model.msgContent;
        contentHeight = labelDemo.optimumSize.height;
    }
    if (model.msgImg.length>0) {
        imageHeight = _px(150);
    }
    return imageHeight + contentHeight + extraHeight;
}

@end
