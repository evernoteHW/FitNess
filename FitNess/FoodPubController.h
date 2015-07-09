//
//  FoodPubController.h
//  FitNess
//
//  Created by liuguoyan on 14-10-15.
//  Copyright (c) 2014年 liuguoyan. All rights reserved.
//

#import "FNStepViewController.h"

#define FIRST_DATA 0
#define SECOND_DATA 1
#define THIRD_DATA 2
@interface Food_ViewController : UITableViewCell
@end
@interface FoodPubController : FNStepViewController
{
    UIView *_tabBack;
    UIButton *_firstClass;
    UIButton *_secondClass;
    UIButton *_thirdClass;
    
    UIView *_leftVerticalLine;
    UIView *_rightVerticalLine;
    
    UITableView *_firstTableView;
    UITableView *_secondTableView;
    UITableView *_thirdTableView;
    
    
    NSMutableArray *_fDataSource;
    NSMutableArray *_sDataSource;
    NSMutableArray *_tDataSource;
    NSMutableArray *_curreentSouce;
    int _currentData;
    
}
@property (nonatomic, assign) BOOL isSport;
@end
