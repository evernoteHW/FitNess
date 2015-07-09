//
//  FNHintControlViewController.m
//  FitNess
//
//  Created by liuguoyan on 14-10-2.
//  Copyright (c) 2014年 liuguoyan. All rights reserved.
//

#import "FNHintControlViewController.h"
#import "FNLoginController.h"

@interface FNHintControlViewController ()

@end

@implementation FNHintControlViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

-(void) createView
{
//    [[[self navigationController]navigationBar] setHidden:YES];
    
    CGRect rect = CGRectMake(0, 32, 310, 320);
    UILabel *buttn = [[UILabel alloc]initWithFrame:rect];
//    [buttn setTitle:@"ds;afkdsl" forState:UIControlStateNormal];
    [buttn setText:@"d"];
    buttn.font = [UIFont fontWithName:@"Arial" size:320];
    [buttn setBackgroundColor:[UIColor yellowColor]];
    UIColor *color = [UIColor redColor];
    [buttn setTintColor:color];
    [self.view addSubview:buttn];
    
    
    CGFloat nh = self.navigationController.navigationBar.frame.size.height;
    CGFloat ch = DIME_SCREEN_H - nh;
    

    
    NSLog(@"navigation height = %f , content height = %f",nh,ch);
    
//    UIImageView *imagev = [[UIImageView alloc]initWithFrame:CGRectMake(0, 200, 640, 200)];
//    UIImageView *imagev = [[UIImageView alloc]initWithFrame:DPRECT(0, 400, 640, 400)];
//    [imagev setImage:[UIImage imageNamed:@"imp_join.png"]];
//    [self.view addSubview:imagev];
    
    
    FNLoginController *controller = [[FNLoginController alloc] init];
    [[self navigationController] pushViewController:controller animated:YES];
    
    
}

-(void) initData
{
    
}

-(void) setListeners
{
    
}

@end
