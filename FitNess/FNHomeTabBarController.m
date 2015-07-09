//
//  FNHomeTabBarController.m
//  FitNess
//
//  Created by liuguoyan on 14-10-4.
//  Copyright (c) 2014年 liuguoyan. All rights reserved.
//

#import "FNHomeTabBarController.h"
#import "FNNavigationViewController.h"
#import "Me_MainViewController.h"
#import "Check_MainController.h"
#import "Service_ViewController.h"
#import "MoreViewController.h"
#import "CircleMainViewController.h"
#import "FNUserStatues.h"
#import "FNLoginController.h"
#import "FNRegistViewController.h"


@interface FNHomeTabBarController ()<UITabBarControllerDelegate>
{
    NSArray *_nomalImagesArr ;
    NSArray *_highlightedImagesArr ;
}
@property (nonatomic, strong) UIImageView *selectedImageView;

@end

@implementation FNHomeTabBarController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _nomalImagesArr = @[@"main_me_tab_normal",@"main_search_tab_normal",@"main_quanquan_tab_normal",@"main_service_tab_normal",@"main_more_tab_normal"];
    _highlightedImagesArr = @[@"main_me_tab_pressed",@"main_search_tab_pressed",@"main_quanquan_tab_pressed",@"main_service_tab_pressed",@"main_more_tab_pressed"];
    
    Me_MainViewController* me = [[Me_MainViewController alloc]init];
    Check_MainController* check = [[Check_MainController alloc]init];
    CircleMainViewController* circle = [[CircleMainViewController alloc]init];
    Service_ViewController* service = [[Service_ViewController alloc]init];
    MoreViewController* more = [[MoreViewController alloc]init];
    
    FNNavigationViewController *meNav = [[FNNavigationViewController alloc]initWithRootViewController:me];
    FNNavigationViewController *checkNav = [[FNNavigationViewController alloc]initWithRootViewController:check];
    FNNavigationViewController *circleNav = [[FNNavigationViewController alloc]initWithRootViewController:circle];
    FNNavigationViewController *serNav = [[FNNavigationViewController alloc]initWithRootViewController:service];
    FNNavigationViewController *moreNav = [[FNNavigationViewController alloc]initWithRootViewController:more];
    
    self.viewControllers = [NSArray arrayWithObjects:meNav, checkNav,circleNav,serNav,moreNav ,nil];
    [[UITabBar appearance] setBackgroundImage:[UIImage imageNamed:@"tab_barback"]];
    self.delegate = self;
    UIImage *tabBarBackground = [[UIImage imageNamed:@"bg_tabbar"] stretchableImageWithLeftCapWidth:2 topCapHeight:0];
    UIImageView *bgImageView = [[UIImageView alloc] initWithImage:tabBarBackground];
    bgImageView.frame = self.tabBar.bounds;
    [self.tabBar addSubview:bgImageView];
    
    for (int i = 0; i < _nomalImagesArr.count; i++) {
        UIImageView *itemImageView = [[UIImageView alloc] initWithFrame:CGRectMake(i * (DIME_SCREEN_W / _nomalImagesArr.count) ,0,(DIME_SCREEN_W / _nomalImagesArr.count), 49)];
        itemImageView.userInteractionEnabled = NO;
        
        itemImageView.image = [UIImage imageNamed:_nomalImagesArr[i]];
        itemImageView.highlightedImage = [UIImage imageNamed:_highlightedImagesArr[i]];
        itemImageView.tag = 99 + i;
        [self.tabBar addSubview:itemImageView];
        if ([[NSUserDefaults standardUserDefaults] boolForKey:@"isLookrandom"]) {
            if (i == 1) {
                self.selectedImageView = itemImageView;
                self.selectedImageView.highlighted = YES;
            }
        }else{
            if (i == 0) {
                self.selectedImageView = itemImageView;
                self.selectedImageView.highlighted = YES;
            }
        }
       
    }
}
- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController
{
    NSInteger tag = [tabBarController.viewControllers indexOfObject:viewController];
    if (tag == 1 || tag == 3) {

        return YES;
    }else{
        if ([[FNDataKeeper sharedInstance] getUserId] && ![[NSString stringWithFormat:@"%@",[[FNDataKeeper sharedInstance] getUserId]] isEqualToString:@""]) {
            return YES;
        }else{
            UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@""
                                                               message:@"登陆后才可以查看"
                                                              delegate:self
                                                     cancelButtonTitle:@"去注册"
                                                     otherButtonTitles:@"忽略", nil];
            [alertView show];
            return NO;
        }
    }
    return NO;
}
- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex{
    //确定
    if (buttonIndex == 0) {
        FNRegistViewController *registController = [[FNRegistViewController alloc]init];
        [[self navigationController]pushViewController:registController animated:YES];
    }
}

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
    NSInteger tag = [tabBarController.viewControllers indexOfObject:viewController];
    UIImageView *imageView = (UIImageView *)[self.tabBar viewWithTag:99 + tag];
    self.selectedImageView.highlighted = NO;
    self.selectedImageView = imageView;
    imageView.highlighted = YES;

}

- (void)dealloc
{
    NSLog(@"%s",__FUNCTION__);
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}



@end

