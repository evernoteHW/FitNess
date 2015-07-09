//
//  ChooseAttentionController.m
//  FitNess
//
//  Created by WeiHu on 14/11/24.
//  Copyright (c) 2014年 WeiHu. All rights reserved.
//

#import "ChooseAttentionController.h"
#import "RecommendViewController.h"

@interface ChooseAttentionController ()
{
    NSMutableArray *arr ;
}

@end

@implementation ChooseAttentionController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
//    [[[self navigationController] navigationBar ]setHidden:NO];
    // Do any additional setup after loading the view.
    UIView *customNavBar = [[UIView alloc] initWithFrame:CGRectMake(0, 0, DIME_SCREEN_W, 64)];
    customNavBar.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bac_long_btn"]];
    [self.view addSubview:customNavBar];
//
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(60, 27, 200, 30)];
    titleLabel.text = @"选择你关注的";
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.font = [UIFont boldSystemFontOfSize:16.0f];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.textColor = [UIColor whiteColor];
    [customNavBar addSubview:titleLabel];
//    
    UIButton *leftBtn =[[UIButton alloc]initWithFrame:CGRectMake(16, 34,70, 16)];
    [leftBtn addTarget:self action:@selector(popToViewController) forControlEvents:UIControlEventTouchUpInside];
    [leftBtn setTitle:@"<< 上一步" forState:UIControlStateNormal];
    leftBtn.titleLabel.font = [UIFont boldSystemFontOfSize:13.0f];
    [leftBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [leftBtn setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    [customNavBar addSubview:leftBtn];
    
    UIButton *rightBtn =[[UIButton alloc]initWithFrame:CGRectMake(DIME_SCREEN_W - 16 - 70, 34, _px(140), _px(32))];
    [rightBtn setTitle:@"跳过 >>" forState:UIControlStateNormal];
    rightBtn.titleLabel.font = [UIFont boldSystemFontOfSize:13.0f];
    [rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [rightBtn setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    [rightBtn addTarget:self action:@selector(rightButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [customNavBar addSubview:rightBtn];
    
//
    NSArray *titleArr = @[@"减重",@"塑身",@"吃货",@"大学生",@"白领",@"瑜伽"];
    NSArray *iconArr = @[@"loseweigth",@"susheng",@"eatfood",@"student",@"white_trrrrr",@"yoga"];
    arr = [NSMutableArray array];
    for (NSInteger i = 0 ; i < titleArr.count ;i ++) {
        
        UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(40  + (90 + 30) * (i % 2), 20 + 64 + (90 + 20)* (i / 2), 90, 90)];
        bgView.tag = 1 + i;
        bgView.backgroundColor = [UIColor clearColor];
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(13, 5, 64, 64)];
        imageView.image = [UIImage imageNamed:iconArr[i]];
        [bgView addSubview:imageView];
        
        UIImageView *chooseImageView = [[UIImageView alloc] initWithFrame:CGRectMake(70, 55, 20, 20)];
        chooseImageView.image = [UIImage imageNamed:@"motion_img_02"];
        chooseImageView.highlightedImage = [UIImage imageNamed:@"motion_img_03"];
        chooseImageView.tag = 99;
        [bgView addSubview:chooseImageView];
        
        UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0,bgView.height - 20, bgView.width, 20)];
        [titleLabel setTextAlignment:NSTextAlignmentCenter];
        [titleLabel setFont:FONT_SIZE(15)];
        titleLabel.textColor = R_COLOR_NOMARL_GREY ;
        [titleLabel setText:titleArr[i]];
        [bgView addSubview:titleLabel];
        [self.view addSubview:bgView];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(chooseAttention:)];
        [bgView addGestureRecognizer:tap];
    }
    
    UIButton *saveUserInfoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    saveUserInfoBtn.frame = CGRectMake(60, self.view.height - 70, 200, 40);
    [saveUserInfoBtn setTitle:@"下一步" forState:UIControlStateNormal];
    saveUserInfoBtn.titleLabel.font = [UIFont boldSystemFontOfSize:16.0f];
    saveUserInfoBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    [saveUserInfoBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [saveUserInfoBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    [saveUserInfoBtn addTarget:self action:@selector(changeUserInfo) forControlEvents:UIControlEventTouchUpInside];
    [saveUserInfoBtn setBackgroundImage:[UIImage imageNamed:@"bmi_btn"] forState:UIControlStateNormal];
    [self.view addSubview:saveUserInfoBtn];

}

- (void)rightButtonAction
{
    RecommendViewController *controller = [[RecommendViewController alloc] init];
    [self.navigationController pushViewController:controller animated:YES];
}
- (void)changeUserInfo
{
    RecommendViewController *controller = [[RecommendViewController alloc] init];
    controller.arr = arr;
    [self.navigationController pushViewController:controller animated:YES];
}
- (void)chooseAttention:(UITapGestureRecognizer *)tap
{
    UIImageView *chooseImageView = (UIImageView *)[tap.view viewWithTag:99];
    chooseImageView.highlighted = !chooseImageView.highlighted;
    if (chooseImageView.highlighted) {
//        [arr addObject:@[(tap.view.tag)]];
        [arr addObject:@(tap.view.tag)];
    }else{
        [arr removeObject:@(tap.view.tag)];
    }
}

//- (void)viewWillAppear:(BOOL)animated{
//    [[[self navigationController] navigationBar ]setHidden:NO];
//}
//- (void)viewDidAppear:(BOOL)animated{
//    [[[self navigationController] navigationBar ]setHidden:NO];
//}
//- (void)viewWillDisappear:(BOOL)animated{
//    [[[self navigationController] navigationBar ]setHidden:YES];
//}
//- (void)viewDidDisappear:(BOOL)animated{
//    [[[self navigationController] navigationBar ]setHidden:NO];
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
