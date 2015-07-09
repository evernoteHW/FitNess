//
//  ServiceSubViewController.m
//  FitNess
//
//  Created by liuguoyan on 14-10-5.
//  Copyright (c) 2014年 liuguoyan. All rights reserved.
//

#import "ServiceSubViewController.h"

@interface ServiceSubViewController () <UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>
{
    NSString *_imgTitleImg;
    NSString *_imgBannerTitle;
    NSString *_imgBannerCont;
    NSArray *_imgsContent;
}
@end

@implementation ServiceSubViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self createView];
    
}

#pragma UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _imgsContent.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"servicecell"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"servicecell"];
        UIImage *image = [UIImage imageNamed:_imgsContent[indexPath.row]];
        UIImageView *imageview = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, _px(image.size.width), _px(image.size.height))];
        [imageview setImage:image];
        [imageview setTag:10];
        [cell addSubview:imageview];
    }
    
    UIImage *image = [UIImage imageNamed:_imgsContent[indexPath.row]];
    UIImageView *imageView =(UIImageView *)[cell viewWithTag:10];
    imageView.frame = CGRectMake(0, _px(10), _px(image.size.width), _px(image.size.height));
    [imageView setImage:image];
    
    return cell;
}

#pragma UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIImage *image = [UIImage imageNamed:_imgsContent[indexPath.row]];
    CGFloat heigth = _px(image.size.height)+_px(20);
    return heigth;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //当手指离开某行时，就让某行的选中状态消失
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


-(void) createView
{
    
    self.navigationController.navigationBar.translucent = NO;
    self.tabBarController.tabBar.translucent = NO;
    [self getContentWithFlag:_flag];
    
    _topImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, DIME_SCREEN_W, _px(320))];
    [_topImage setImage:[UIImage imageNamed:_imgTitleImg]];
    [self.view addSubview:_topImage];
    
//    UIView *_adBannerBac;
    
    _adBannerBac = [[UIView alloc]initWithFrame:CGRectMake(0, _px(320), DIME_SCREEN_W, _px(90))];
    [_adBannerBac setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:_adBannerBac];
    
    
//    UIImageView *_bannerTitle;
    _bannerTitle = [[UIImageView alloc]initWithFrame:CGRectMake(_px(26), _px(20), _px(162), _px(46))];
    [_bannerTitle setImage:[UIImage imageNamed:_imgBannerTitle]];
    [_adBannerBac addSubview:_bannerTitle];
    
//    UIImageView *_bannerCont;
    UIImage *contI = [UIImage imageNamed:_imgBannerCont];
    _bannerCont = [[UIImageView alloc]initWithFrame:CGRectMake(_px(200), _px(20), _px(contI.size.width),_px(contI.size.height))];
    [_bannerCont setImage:contI];
    [_adBannerBac addSubview:_bannerCont];
    
    
//    UITableView *_tableView;
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, _px(410), DIME_SCREEN_W, DIME_SCREEN_H-_px(494)-TITLE_HEI) style:UITableViewStylePlain];
    [self.view addSubview:_tableView];
    [_tableView setDataSource:self];
    [_tableView setDelegate:self];
    
//    UIView *_bottomView;
    _bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, DIME_SCREEN_H-_px(84)-TITLE_HEI, DIME_SCREEN_W, _px(84))];
    [self.view addSubview:_bottomView];
//    UIButton * _buyButton;
    _buyButton = [[UIButton alloc]initWithFrame:CGRectMake(_px(72), _px(14), _px(180), _px(54))];
    [_bottomView addSubview:_buyButton];
    [_buyButton addTarget:self action:@selector(onBuyBtn) forControlEvents:UIControlEventTouchUpInside];
//    UIButton * _phoneButton;
    _phoneButton =[[UIButton alloc]initWithFrame:CGRectMake(_px(368), _px(14), _px(180), _px(54))];
    [_bottomView addSubview:_phoneButton];
    [_phoneButton addTarget:self action:@selector(onPhoneBtn) forControlEvents:UIControlEventTouchUpInside];
    
    switch (self.flag) {
            //排毒和服务是蓝色系的
        case FLAG_WHICH_SERVICE_DETOX:
        case FLAG_WHICH_SERVICE_SERVICE:
            [_bottomView setBackgroundColor:[UIColor colorWithHexString:@"92D7FF"]];
            [_buyButton setImage:[UIImage imageNamed:@"service_selected_buy"] forState:UIControlStateNormal];
            [_buyButton setImage:[UIImage imageNamed:@"service_buy"] forState:UIControlStateHighlighted];
            [_phoneButton setImage:[UIImage imageNamed:@"service_selected_phone"] forState:UIControlStateNormal];
            [_phoneButton setImage:[UIImage imageNamed:@"service_phone"] forState:UIControlStateHighlighted];
            break;
            //只有燃脂是红色系的
        case FLAG_WHICH_SERVICE_FATLOSS:
            [_bottomView setBackgroundColor:[UIColor colorWithHexString:@"FFB3C9"]];
            [_buyButton setImage:[UIImage imageNamed:@"service_buy"] forState:UIControlStateNormal];
            [_buyButton setImage:[UIImage imageNamed:@"service_selected_buy"] forState:UIControlStateHighlighted];
            [_phoneButton setImage:[UIImage imageNamed:@"service_phone"] forState:UIControlStateNormal];
            [_phoneButton setImage:[UIImage imageNamed:@"service_selected_phone"] forState:UIControlStateHighlighted];
            break;
    }
}
//点击购买
-(void)onBuyBtn
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.plyh.com/index.php"]];
}
//电话联系
-(void)onPhoneBtn
{
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"提示！" message:@"全国咨询电话:400-889-8702" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alertView show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex==1) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel://4009700302"]];
    }
}


-(void)getContentWithFlag:(int)flag
{
    switch (flag) {
        case FLAG_WHICH_SERVICE_DETOX:
            _imgTitleImg = @"service_detox_banner";
            _imgBannerTitle = @"service_detox_btn";
            _imgBannerCont = @"service_detox_title";
            _imgsContent = @[@"service_du_img_02",@"service_du_img_03",@"service_du_img_04",@"service_du_img_05",@"service_du_img_06"];
            [self.navigationItem setTitle:@"排毒"];
            break;
        case FLAG_WHICH_SERVICE_FATLOSS:
            _imgTitleImg = @"service_serve_detail_img";
            _imgBannerTitle = @"service_fat_button";
            _imgBannerCont = @"service_burnfat_title";
            _imgsContent = @[@"service_fat_img_02",@"service_fat_img_03",@"service_fat_img_04"];
            [self.navigationItem setTitle:@"减肥"];
            break;
        case FLAG_WHICH_SERVICE_SERVICE:
            _imgTitleImg = @"service_guide_banner";
            _imgBannerTitle = @"service_guide_button";
            _imgBannerCont = @"service_guide_img_01";
            _imgsContent = @[@"service_guide_img_02",@"service_guide_img_03",@"service_guide_img_04",@"service_guide_img_05"];
            [self.navigationItem setTitle:@"服务"];
            break;
    }
}


@end