//
//  ServiceSubViewController.h
//  FitNess
//
//  Created by liuguoyan on 14-10-5.
//  Copyright (c) 2014年 liuguoyan. All rights reserved.
//

#import "FNStepViewController.h"

#define FLAG_WHICH_SERVICE_DETOX 10
#define FLAG_WHICH_SERVICE_FATLOSS 11
#define FLAG_WHICH_SERVICE_SERVICE 12

@interface ServiceSubViewController : FNStepViewController
{
    UIImageView *_topImage;
    
    UIView *_adBannerBac;
    
    UIImageView *_bannerTitle;
    
    UIImageView *_bannerCont;
    
    UITableView *_tableView;
    
    UIView *_bottomView;
    
    UIButton * _buyButton;
    
    UIButton * _phoneButton;
    
}

@property (nonatomic ,assign) int flag;

@end
