//
//  Check_MainController.m
//  FitNess
//
//  Created by liuguoyan on 14-10-5.
//  Copyright (c) 2014年 liuguoyan. All rights reserved.
//

#import "Check_MainController.h"
#import "FoodPubController.h"
#import "TestToolController.h"

@interface Check_MainController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSArray *attrbutesArr ;
}
@property (nonatomic, strong) UITableView *chek_MainTablView;

@end

@implementation Check_MainController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        attrbutesArr = @[@{@"leftColor": @"FFB818",@"icon": @"chacha_food_img",@"title": @"食物库",@"subTitle":@"收录7万多种常见食物"}
                         ,@{@"leftColor": @"5EB9FF",@"icon": @"chacha_run_img",@"title": @"运动库",@"subTitle":@"收录7万多种常见食物"},
                         @{@"leftColor": @"FF6895",@"icon": @"chacha_test_img",@"title": @"测试工具",@"subTitle":@"通过测试了解自己的身体指数"}];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.navigationItem setTitle:@"查查"];
     [self.view setBackgroundColor:R_COLOR_COMMON_BAC];
    [self.view addSubview:self.chek_MainTablView];
    self.leftButton.hidden = YES;
    
}
- (UITableView *)chek_MainTablView
{
    if (_chek_MainTablView == nil) {
        _chek_MainTablView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, DIME_SCREEN_W, DIME_SCREEN_H - 49 - 64) style:UITableViewStylePlain];
        _chek_MainTablView.rowHeight = 75;
        _chek_MainTablView.backgroundColor = [UIColor clearColor];
        _chek_MainTablView.dataSource = self;
        _chek_MainTablView.delegate = self;
        _chek_MainTablView.tableFooterView = [UIView new];
        
        _chek_MainTablView.tableHeaderView = [self createCheck_MainTbHeadView];
    }
    return _chek_MainTablView;
}

#pragma mark UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return attrbutesArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *identifier = @"CicleMainCell";
    UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    
        UIImageView *selectdBgImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bac_long_btn"]];
        selectdBgImageView.frame = cell.contentView.bounds;
        cell.selectedBackgroundView = selectdBgImageView;
        cell.contentView.backgroundColor = [UIColor whiteColor];
        cell.backgroundColor = [UIColor clearColor];
        
        UILabel *left= [[UILabel alloc]initWithFrame:CGRectMake(0, 5, _DIME_LEFT, _px(130))];
        left.tag = 99;
        [ cell.contentView addSubview:left];
        [cell.contentView bringSubviewToFront:left];
        
        UIImageView *icon =[[UIImageView alloc]initWithFrame:CGRectMake(_DIME_LEFT+_px(16), 5 , _px(130), _px(130))];
        icon.tag = 100;
        icon.backgroundColor = [UIColor clearColor];
        [cell.contentView  addSubview:icon];
//
        UILabel *title_v =[[UILabel alloc]initWithFrame:CGRectMake(_DIME_LEFT + _px(172), _px(40), _px(150), _px(25))];
        [title_v setFont:FONT_SIZE(12)];
        title_v.textColor = [UIColor blackColor];
        title_v.tag = 101;
        [ cell.contentView  addSubview:title_v];

        UILabel *sub_v =[[UILabel alloc]initWithFrame:CGRectMake(_DIME_LEFT + _px(172), _px(66), _px(300), _px(23))];
        [sub_v setFont:FONT_SIZE(11)];
        sub_v.textColor = [UIColor grayColor];
        sub_v.tag = 102;

        [ cell.contentView  addSubview:sub_v];

        UIImageView *arr = [[UIImageView alloc]initWithFrame:CGRectMake(DIME_SCREEN_W-_DIME_LEFT-_px(22), _px(45), _px(22), _px(40))];
        [arr setImage:[UIImage imageNamed:@"arrow"]];
        arr.tag = 103;
        [ cell.contentView  addSubview:arr];
        
        cell.separatorInset = UIEdgeInsetsZero;
    }
    UIView *left = (UIView *)[cell.contentView viewWithTag:99];
    left.backgroundColor = [UIColor colorWithHexString:attrbutesArr[indexPath.row][@"leftColor"]];
    UIImageView *icon = (UIImageView *)[cell.contentView viewWithTag:100];
    icon.image = [UIImage imageNamed:attrbutesArr[indexPath.row][@"icon"]];
    UILabel *title_v = (UILabel *)[cell.contentView viewWithTag:101];
    title_v.text = attrbutesArr[indexPath.row][@"title"];
    UILabel *sub_v = (UILabel *)[cell.contentView viewWithTag:102];
    sub_v.text = attrbutesArr[indexPath.row][@"subTitle"];
    
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    switch (indexPath.row) {
        case 0:
        {
            FoodPubController *contrller = [[FoodPubController alloc]init];
            [contrller setHidesBottomBarWhenPushed:YES];
            contrller.isSport = NO;
            [self.navigationController pushViewController:contrller animated:YES];
        }
            break;
        case 1:
        {
            FoodPubController *contrller = [[FoodPubController alloc]init];
            contrller.isSport = YES;
            [contrller setHidesBottomBarWhenPushed:YES];
            [self.navigationController pushViewController:contrller animated:YES];
        }
            break;
        case 2:
        {
            TestToolController *contrller = [[TestToolController alloc]init];
            [contrller setHidesBottomBarWhenPushed:YES];
            [self.navigationController pushViewController:contrller animated:YES];
        }
            break;
    }
}

- (UIView *)createCheck_MainTbHeadView
{
    UserModel *user = [[FNDataKeeper sharedInstance]getUser];
    UIView *tableHeadView = [[UIView alloc] initWithFrame:CGRectMake(10, 10, DIME_SCREEN_W - 20, 224)];
//    tableHeadView.clipsToBounds = YES;
    //1035
    
//    UIView * _titleBack;//上灰色背景
    _titleBack = [[UIView alloc] initWithFrame:CGRectMake(_DIME_LEFT, _px(20), _DIME_CONT_SIZE, _px(320))];
    [_titleBack setBackgroundColor:[UIColor whiteColor]];
    [tableHeadView addSubview:_titleBack];
    
//    UIImageView * _titleLeftBac;//上部左背景
    _titleLeftBac = [[UIImageView alloc] initWithFrame:CGRectMake(_DIME_CONT_CENTER - _px(260), _px(120), _px(122), _px(122))];
    [_titleLeftBac setImage:[UIImage imageNamed:@"chacha_mubiao"]];
    [tableHeadView addSubview:_titleLeftBac];
    
//    UIImageView * _titleMidBac;//上部中背景
    _titleMidBac = [[UIImageView alloc] initWithFrame:CGRectMake(_DIME_CONT_CENTER - _px(120), _px(62), _px(236), _px(236))];
    [_titleMidBac setImage:[UIImage imageNamed:@"chacha_should_sheru"]];
    [tableHeadView addSubview:_titleMidBac];
//    UIImageView * _titleRitBac;//上部右背景
    _titleLeftBac = [[UIImageView alloc] initWithFrame:CGRectMake(_DIME_CONT_CENTER + _px(140), _px(120), _px(122), _px(122))];
    [_titleLeftBac setImage:[UIImage imageNamed:@"chacha_current"]];
    [tableHeadView addSubview:_titleLeftBac];
    
//    UILabel * _titLeftLabel;//上部目标体重
    _titLeftLabel = [[UILabel alloc]initWithFrame:CGRectMake(_DIME_CONT_CENTER - _px(224), _px(192), _px(34), _px(25))];
    [_titLeftLabel setTextAlignment:NSTextAlignmentCenter];
    [_titLeftLabel setFont:FONT_SIZE(11)];
    _titLeftLabel.textColor = [UIColor colorWithHexString:@"61B9FF"];
//    [_titLeftLabel setText:@"0"];
    _titLeftLabel.text = user.permitWeight;
    [tableHeadView addSubview:_titLeftLabel];
    
//    UILabel * _titleMidTopLabel;//上部还可摄入
    _titleMidTopLabel = [[UILabel alloc]initWithFrame:CGRectMake(_DIME_CONT_CENTER - _px(110), _px(120), _px(132), _px(50))];
    [_titleMidTopLabel setTextAlignment:NSTextAlignmentCenter];
    [_titleMidTopLabel setFont:FONT_SIZE(14)];
    _titleMidTopLabel.textColor = [UIColor colorWithHexString:@"FD6693"];
//    [_titleMidTopLabel setText:@"0.0"];
    _titleMidTopLabel.text = user.alsoNeedKll;
    [tableHeadView addSubview:_titleMidTopLabel];
    
//    UILabel * _titleMidBotLabel;//上部已消耗
    _titleMidBotLabel = [[UILabel alloc]initWithFrame:CGRectMake(_DIME_CONT_CENTER - _px(40), _px(222), _px(46), _px(50))];
    [_titleMidBotLabel setTextAlignment:NSTextAlignmentCenter];
    [_titleMidBotLabel setFont:FONT_SIZE(13)];
    _titleMidBotLabel.textColor = [UIColor colorWithHexString:@"FD6693"];
    [_titleMidBotLabel setText:@"0"];
    [tableHeadView addSubview:_titleMidBotLabel];
    
//    UILabel * _titleRitLabel;//上部当前体重
    _titleRitLabel = [[UILabel alloc]initWithFrame:CGRectMake(_DIME_CONT_CENTER + _px(170), _px(192), _px(34), _px(25))];
    [_titleRitLabel setTextAlignment:NSTextAlignmentCenter];
    [_titleRitLabel setFont:FONT_SIZE(11)];
    _titleRitLabel.textColor = [UIColor colorWithHexString:@"FFBF51"];
//    [_titleRitLabel setText:@"0"];
    _titleRitLabel.text = user.registyWeight ;
    [tableHeadView addSubview:_titleRitLabel];
    
//    UIView * _midPartBac;//中间背景
    _midPartBac = [[UIView alloc] initWithFrame:CGRectMake(_DIME_LEFT, _px(360), _DIME_CONT_SIZE, _px(64))];
    [_midPartBac setBackgroundColor:[UIColor colorWithHexString:@"FF6895"]];
    [tableHeadView addSubview:_midPartBac];
    
    
//    UILabel * _midLeftTitle;//中部左标题
    _midLeftTitle = [[UILabel alloc]initWithFrame:CGRectMake(_DIME_LEFT + _px(28), _px(380), _px(140), _px(25))];
    [_midLeftTitle setTextAlignment:NSTextAlignmentCenter];
    [_midLeftTitle setFont:FONT_SIZE(11)];
    _midLeftTitle.textColor = [UIColor whiteColor];
    [_midLeftTitle setText:@"您的BMI值是"];
    [tableHeadView addSubview:_midLeftTitle];
    
    
//    UILabel * _midRitTitle;//中部右标题
    _midRitTitle = [[UILabel alloc]initWithFrame:CGRectMake(_DIME_LEFT + _px(240), _px(380), _px(140), _px(25))];
    [_midRitTitle setTextAlignment:NSTextAlignmentCenter];
    [_midRitTitle setFont:FONT_SIZE(11)];
    _midRitTitle.textColor = [UIColor whiteColor];
    [_midRitTitle setText:@"健康体重范围"];
    [tableHeadView addSubview:_midRitTitle];
    
//    UILabel * _midLeftCont;//BMI值
    _midLeftCont = [[UILabel alloc]initWithFrame:CGRectMake(_DIME_LEFT + _px(170), _px(380), _px(60), _px(25))];
    [_midLeftCont setTextAlignment:NSTextAlignmentCenter];
    [_midLeftCont setFont:FONT_SIZE(11)];
    _midLeftCont.textColor = [UIColor colorWithHexString:@"FF6795"];
    [_midLeftCont setBackgroundColor:[UIColor whiteColor]];
    _midLeftCont.text = user.bmiVal;
    [tableHeadView addSubview:_midLeftCont];

//    UILabel * _midRitCont;//健康体重范围
    _midRitCont = [[UILabel alloc]initWithFrame:CGRectMake(_DIME_LEFT + _px(384), _px(380), _px(160), _px(25))];
    [_midRitCont setTextAlignment:NSTextAlignmentCenter];
    [_midRitCont setFont:FONT_SIZE(11)];
    _midRitCont.textColor = [UIColor colorWithHexString:@"FF6795"];
    [_midRitCont setBackgroundColor:[UIColor whiteColor]];
    _midRitCont.text = user.healthWeightScope;
    [tableHeadView addSubview:_midRitCont];
    
    
    return tableHeadView;
}


@end
