//
//  FNViewController.m
//  FitNess
//
//  Created by liuguoyan on 14-10-2.
//  Copyright (c) 2014年 liuguoyan. All rights reserved.
//

#import "FNNavigationViewController.h"
#import "FNMacro.h"

@interface FNNavigationViewController ()<UINavigationControllerDelegate,UIGestureRecognizerDelegate>

@end

@implementation FNNavigationViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.delegate = self;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    __weak typeof (self) weakSelf = self;
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.interactivePopGestureRecognizer.delegate = weakSelf;
    }
    
   [[UINavigationBar appearance] setTitleTextAttributes: [NSDictionary dictionaryWithObjectsAndKeys: [UIColor whiteColor], NSForegroundColorAttributeName, [UIFont boldSystemFontOfSize:20.0], NSFontAttributeName,nil]];
    self.navigationBar.translucent = NO;
    self.navigationBar.barTintColor = COLOR_NAVIGATIONBAR_UICOLOR ;
    
}
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        if (navigationController.viewControllers.count > 1) {
            self.navigationController.interactivePopGestureRecognizer.enabled = YES;
        }else{
            self.navigationController.interactivePopGestureRecognizer.enabled = NO;
        }
        
    }
 
}
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    [super pushViewController:viewController animated:animated];
    
}


@end
