//
//  Me_MainViewController.h
//  FitNess
//
//  Created by liuguoyan on 14-10-4.
//  Copyright (c) 2014年 liuguoyan. All rights reserved.
//

#import "FNStepViewController.h"
#import "RTLabel.h"



@interface Me_MainViewController : FNStepViewController
{
    
    UIScrollView * _scrollView;
    
    UIImageView * _scrollBack;
    
    UIView * _titleWhiteBack;//头部白色模块背影
    UIButton * _headIcon;//头像
    UIButton * _nickView;//昵称
//    UIButton * _announceView;//减肥宣言
    UILabel * _announceViewLabel;//减肥宣言
    UIButton * _announceBtn;//编辑宣言按钮
    
    //////分界线
    UIView *_headHLine;//头部横向分界线
    UIView *_headVLLine;//头部左部竖线
    UIView *_headVRLine;//头部右部竖线
    
    //注册体重
    UIButton * _registWeight;
    
    RTLabel * _targetWeiht;//目标体重
    UILabel * _targetWeihtBot;
    RTLabel * _reducedWeight;//已减重
    UILabel * _reducedWeightBot;
    RTLabel * _dreamWeight;//理想体重
    UILabel * _dreamWeightBot;
    //
    UILabel * _canInsectMore;//还可摄入
    UILabel * _hasInsist;//已坚持
    UILabel * _needReduce;//还需要消耗
    
    //中间两个背景
    UIView * _centLeftBac;//中间左背景
    UIView * _centRigtBac;//中间右背景
    
    //记录的四个按钮
    UIImageView * _recordTitle;//记录头的图片
    UIButton * _rBtnWeiRecord;//体重记录
    UIButton * _rBtnMotRecord;//心情记录
    UIButton * _rBtnDayInsect;//每天卡路里摄入量
    UIButton * _rBtnDayConsume;//每天卡里路消耗
    
    //图表的四个按钮
    UIImageView * _chatTitle;//图表头
    UIButton * _cBtnWeight;//体重曲线
    UIButton * _cBtnMotion;//心情盟友
    UIButton * _cBtnDayInsect;//每天卡路里摄入
    UIButton * _cBtnDayConsume;//每天卡路里曲线
    
    //最下面的部分
    UIView * _btmBack;//底部背景
    UILabel * _heartTitel;//爱心数显示框
    UIButton * _heartNum;//爱心数
    UILabel * _heartWarning;//爱心提示
    
    
    
    
}
@end
