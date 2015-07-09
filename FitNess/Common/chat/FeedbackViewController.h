//
//  FeedbackViewController.h
//  UMeng Analysis
//
//  Created by liu yu on 7/12/12.
//  Copyright (c) 2012 Realcent. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UMFeedback.h"
#import "FNStepViewController.h"

@interface FeedbackViewController : FNStepViewController <UMFeedbackDataDelegate,UITableViewDelegate,UITableViewDelegate,UIScrollViewDelegate> {
    
    UMFeedback *feedbackClient;
}
@property (nonatomic, strong) UserMessageVOModel *userMessageVOModel;

@property (nonatomic, retain) IBOutlet UITableView *mTableView;

@property (strong, nonatomic) IBOutlet UIView *mToolBar;

@property (strong, nonatomic) IBOutlet UITextField *mTextField;

@property (nonatomic, retain)  NSArray *mFeedbackDatas;
- (IBAction)sendFeedback:(id)sender;



@end
