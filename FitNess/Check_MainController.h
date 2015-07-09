//
//  Check_MainController.h
//  FitNess
//
//  Created by liuguoyan on 14-10-5.
//  Copyright (c) 2014年 liuguoyan. All rights reserved.
//

#import "FNStepViewController.h"

@interface Check_MainController : FNStepViewController
{
//    UIScrollView * _scrollView;
    
//    UIImageView * _scrollBack;
    
    UIView * _titleBack;//上灰色背景
    
    UIImageView * _titleLeftBac;//上部左背景
    
    UIImageView * _titleMidBac;//上部中背景
    
    UIImageView * _titleRitBac;//上部右背景
    
    UILabel * _titLeftLabel;//上部目标体重
    
    UILabel * _titleMidTopLabel;//上部还可摄入
    
    UILabel * _titleMidBotLabel;//上部已消耗
    
    UILabel * _titleRitLabel;//上部当前体重
    
    UIView * _midPartBac;//中间背景
    
    UILabel * _midLeftTitle;//中部左标题
    
    UILabel * _midRitTitle;//中部右标题
    
    UILabel * _midLeftCont;//BMI值
    
    UILabel * _midRitCont;//健康体重范围
    
    UIButton * _foodLibrary;//食物库
    
    UIButton * _sportLibrary;//运动库
    
    UIButton * _testTools;//测试工具
    
}

@end
