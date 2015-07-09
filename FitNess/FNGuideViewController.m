//
//  FNGuideViewController.m
//  FitNess
//
//  Created by WeiHu on 14/11/18.
//  Copyright (c) 2014年 WeiHu. All rights reserved.
//

#import "FNGuideViewController.h"
#import "YDAppDelegate.h"
#import "FNLoginController.h"
#import "FNNavigationViewController.h"

@interface FNGuideViewController ()

@end

@implementation FNGuideViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.homeScrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    self.homeScrollView.showsHorizontalScrollIndicator = NO;
    self.homeScrollView.showsVerticalScrollIndicator = NO;
    self.homeScrollView.pagingEnabled = YES;
    self.homeScrollView.delegate = self;
//    self.homeScrollView.bounces = NO;
    self.homeScrollView.contentSize = CGSizeMake(DIME_SCREEN_W * 5, DIME_SCREEN_H);
    
    if (IOS_VERSION < 7.0) {
        self.homeScrollView.contentSize = CGSizeMake(DIME_SCREEN_W * 5, DIME_SCREEN_H - 20);
    }
    [self.view addSubview:self.homeScrollView];
    
    NSArray *images = @[@"first_userguide_show",@"second_userguide_show",@"third_userguide_show",@"fourth_userguide_show",@"fifth_userguide_show"];
    
    for (int i = 0; i < images.count; i++) {
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(DIME_SCREEN_W * i, 0, DIME_SCREEN_W, DIME_SCREEN_H)];
        UIImage *image = [UIImage imageNamed:images[i]];
        imageView.image = image;
        imageView.userInteractionEnabled = YES;
        if(i == 4){
            //
            UIButton *goButton =[[UIButton alloc]initWithFrame:CGRectMake((DIME_SCREEN_W - _px(238))/2.0, imageView.height - 100, _px(238), _px(66))];
            [goButton addTarget:self action:@selector(popToViewController) forControlEvents:UIControlEventTouchUpInside];
            [goButton setBackgroundImage:[UIImage imageNamed:@"userguide_go.png"] forState:UIControlStateNormal];
            [goButton setBackgroundImage:[UIImage imageNamed:@"userguide_go.png"] forState:UIControlStateNormal];
            [goButton addTarget:self action:@selector(goButtonAction) forControlEvents:UIControlEventTouchUpInside];
            [imageView addSubview:goButton];
        }
        [self.homeScrollView addSubview:imageView];
    }
    
    //////////小圆点
    self.homePageCtrl = [[UIPageControl alloc]initWithFrame:CGRectMake(0, self.view.height - 50, DIME_SCREEN_W, 25)];
    self.homePageCtrl.numberOfPages = images.count - 1;
    self.homePageCtrl.pageIndicatorTintColor = [UIColor lightGrayColor];
    self.homePageCtrl.currentPageIndicatorTintColor = [UIColor grayColor];
    self.homePageCtrl.currentPage = 0;
    [self.view addSubview:self.homePageCtrl];
    
    
}
- (void)goButtonAction
{
    YDAppDelegate *appDelegate = (YDAppDelegate *)[UIApplication sharedApplication].delegate;
    FNLoginController *rootContrller = [[FNLoginController alloc]init];
    FNNavigationViewController *navController = [[FNNavigationViewController alloc]initWithRootViewController:rootContrller];
    appDelegate.window.rootViewController = navController;
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
//    if (scrollView.contentOffset.x > DIME_SCREEN_W * 4 + 30) {
//        YDAppDelegate *appDelegate = (YDAppDelegate *)[UIApplication sharedApplication].delegate;
//        FNLoginController *rootContrller = [[FNLoginController alloc]init];
//        FNNavigationViewController *navController = [[FNNavigationViewController alloc]initWithRootViewController:rootContrller];
//        appDelegate.window.rootViewController = navController;
//    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    int page = scrollView.contentOffset.x / DIME_SCREEN_W;
    self.homePageCtrl.currentPage = page;
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    int page = scrollView.contentOffset.x / DIME_SCREEN_W;
    self.homePageCtrl.currentPage = page;
}
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
