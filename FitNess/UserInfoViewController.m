//
//  UserInfoViewController.m
//  FitNess
//
//  Created by WeiHu on 14/10/25.
//  Copyright (c) 2014年 WeiHu. All rights reserved.
//

#import "UserInfoViewController.h"
#import "PMCalendar.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import <MobileCoreServices/MobileCoreServices.h>
#import "AFHTTPRequestOperationManager.h"

@interface UserInfoViewController ()<UITextFieldDelegate,PMCalendarControllerDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
{
    UITapGestureRecognizer *singleTapGR;
    UIButton *calendarBgBtn;
    UIButton *datePickerBtn;
    UIDatePicker *datePicker;
}
@property (nonatomic, strong) PMCalendarController *pmCC;

@property (nonatomic, strong) UIScrollView *userInfoScrollView;
@property (nonatomic, strong) UIImageView *headIconImageView;
@property (nonatomic, strong) UITextField *nameTextField;           //名字
@property (nonatomic, strong) UITextField *phoneNumTextField;       //电话号码
//@property (nonatomic, strong) UILabel *sexLabel;                    //性别
@property (nonatomic, strong) UIButton *menBtn;            //保存资料
@property (nonatomic, strong) UIButton *womenBtn;            //保存资料
@property (nonatomic, strong) UIButton *selectedBtn;
@property (nonatomic, strong) UITextField *birthdayField;                //生日
@property (nonatomic, strong) UITextField *heightTextField;         //身高
@property (nonatomic, strong) UITextField *weightTextField;         //体重
@property (nonatomic, strong) UITextField *unsignTextField;         //未知
@property (nonatomic, strong) UIButton *saveUserInfoBtn;            //保存资料

@property (nonatomic, strong) UIImagePickerController *cameraController;
@property (nonatomic,assign) UIImageOrientation imageOre;

@end

@implementation UserInfoViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        //增加监听，当键盘出现或改变时收出消息
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(keyboardWillShow:)
                                                     name:UIKeyboardWillShowNotification
                                                   object:nil];
        
        //增加监听，当键退出时收出消息
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(keyboardWillHide:)
                                                     name:UIKeyboardWillHideNotification
                                                   object:nil];
   
    }
    return self;
}

- (void)dealloc
{
    NSLog(@"%s",__FUNCTION__);
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

#pragma mark
#pragma mark keyboardWillShow 和 keyboardWillHide 监听键盘和键盘一起出动

//Code from Brett Schumann
-(void) keyboardWillShow:(NSNotification *)note{
    // get keyboard size and loctaion
    if (singleTapGR == nil) {
        singleTapGR  =  [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAnywhereToDismissKeyboard:)];
    }
    [self.view addGestureRecognizer:singleTapGR];
    
}
-(void) keyboardWillHide:(NSNotification *)note{
    [self.view removeGestureRecognizer:singleTapGR];
}
- (void)tapAnywhereToDismissKeyboard
{
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationItem setTitle:@"我的账号"];
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"quan_bg"]]];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.userInfoScrollView];
    
}
- (UIScrollView *)userInfoScrollView
{
    if (_userInfoScrollView == nil) {
        _userInfoScrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
        
        if (DIME_SCREEN_H > 500) {
            _userInfoScrollView.contentSize = CGSizeMake(_userInfoScrollView.width, _userInfoScrollView.height + 216);
        }else{
            _userInfoScrollView.contentSize = CGSizeMake(_userInfoScrollView.width, _userInfoScrollView.height + 216 + 40);
        }
        UserModel *userInfoModel = [[FNDataKeeper sharedInstance] getUser];
        
        self.headIconImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bac_long_btn"]];
        [self.headIconImageView sd_setImageWithURL:[NSURL URLWithString:userInfoModel.userImgPath] placeholderImage:[UIImage imageNamed:@"bac_long_btn"]];
        self.headIconImageView.frame = CGRectMake((DIME_SCREEN_W - 70) /2.0, 10, 70, 70);
        self.headIconImageView.backgroundColor = [UIColor clearColor];
        self.headIconImageView.userInteractionEnabled = YES;
        [_userInfoScrollView addSubview:self.headIconImageView];
        
        UITapGestureRecognizer *headIconTap  =  [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(changeHeadIcon)];
        [self.headIconImageView addGestureRecognizer:headIconTap];
        
        self.nameTextField  = [[UITextField alloc] initWithFrame:CGRectMake(20, self.headIconImageView.bottom + 10, 280, 40)];
        self.nameTextField .delegate = self;
        self.nameTextField .returnKeyType = UIReturnKeySearch;
        self.nameTextField .text = userInfoModel.userName;
        self.nameTextField.enabled = NO;
        self.nameTextField.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 70, 0)];
        self.nameTextField.leftViewMode = UITextFieldViewModeAlways;
        self.nameTextField .backgroundColor=[UIColor clearColor];
        self.nameTextField.background = [UIImage imageNamed:@"imp_password"];
        self.nameTextField .font = [UIFont systemFontOfSize:15.0f];
        self.nameTextField.placeholder = @"请输入用户名";
        self.nameTextField .textColor = [UIColor lightGrayColor];
        [_userInfoScrollView addSubview:self.nameTextField];
        
        self.phoneNumTextField  = [[UITextField alloc] initWithFrame:CGRectMake(self.nameTextField.left, self.nameTextField.bottom + 10,self.nameTextField.width, 40)];
        self.phoneNumTextField .delegate = self;
        self.phoneNumTextField .returnKeyType = UIReturnKeySearch;
        self.phoneNumTextField .text = userInfoModel.telNbr;
        self.phoneNumTextField .backgroundColor= [UIColor clearColor];
        self.phoneNumTextField .font = [UIFont systemFontOfSize:15.0f];
        self.phoneNumTextField.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 70, 0)];
        self.phoneNumTextField.leftViewMode = UITextFieldViewModeAlways;
        self.phoneNumTextField .textColor = [UIColor lightGrayColor];
        self.phoneNumTextField.placeholder = @"请输入手机号码";
        self.phoneNumTextField.background = [UIImage imageNamed:@"imp_number"];
        [_userInfoScrollView addSubview:self.phoneNumTextField];
        
        
        self.menBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.menBtn.frame = CGRectMake(self.nameTextField.left, self.phoneNumTextField.bottom + 10, self.nameTextField.width /2.0, 40);
        [self.menBtn setTitle:@"男" forState:UIControlStateNormal];
        self.menBtn.titleLabel.font = [UIFont boldSystemFontOfSize:16.0f];
        [self.menBtn addTarget:self action:@selector(sexBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        self.menBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
        [self.menBtn setImage:[UIImage imageNamed:@"imp_boy"] forState:UIControlStateNormal];
        [self.menBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.menBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
       
        [_userInfoScrollView addSubview:self.menBtn];

        
        self.womenBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.womenBtn.frame = CGRectMake(self.menBtn.right, self.menBtn.top, self.nameTextField.width /2.0, 40);
        [self.womenBtn setTitle:@"女" forState:UIControlStateNormal];
        self.womenBtn.titleLabel.font = [UIFont boldSystemFontOfSize:16.0f];
        self.womenBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
        [self.womenBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.womenBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
        self.womenBtn.backgroundColor = [UIColor clearColor];
        [self.womenBtn setImage:[UIImage imageNamed:@"imp_girl"] forState:UIControlStateNormal];
        [self.womenBtn addTarget:self action:@selector(sexBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        [_userInfoScrollView addSubview:self.womenBtn];
        
        if ([userInfoModel.sex integerValue] == 1) {
            [self.menBtn setImage:[UIImage imageNamed:@"imp_select_boy"] forState:UIControlStateNormal];
            [self.womenBtn setImage:[UIImage imageNamed:@"imp_girl"] forState:UIControlStateNormal];
            
            self.selectedBtn = self.menBtn;
        }else{
            [self.menBtn setImage:[UIImage imageNamed:@"imp_boy"] forState:UIControlStateNormal];
            [self.womenBtn setImage:[UIImage imageNamed:@"imp_select_girl"] forState:UIControlStateNormal];
            self.selectedBtn = self.womenBtn;
        }
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.nameTextField.left, self.menBtn.bottom + 10,self.nameTextField.width, 36)];
        imageView.image =  [UIImage imageNamed:@"imp_birth"];
        [_userInfoScrollView addSubview:imageView];
        
        self.birthdayField = [[UITextField alloc]initWithFrame:CGRectMake(90, self.menBtn.bottom + 10,self.nameTextField.width - 70, 36)];
        [self.birthdayField setFont:[UIFont systemFontOfSize:15.0f]];
        self.birthdayField.textColor = [UIColor lightGrayColor];
        self.birthdayField.delegate = self;
        self.birthdayField.backgroundColor = [UIColor clearColor];
        self.birthdayField.text = userInfoModel.birthday;
        [_userInfoScrollView  addSubview:self.birthdayField];
        
        UILabel *birthdayLabel = [[UILabel alloc] initWithFrame:self.birthdayField.bounds];
        birthdayLabel.backgroundColor = [UIColor clearColor];
        birthdayLabel.userInteractionEnabled = YES;
        [self.birthdayField addSubview:birthdayLabel];
        
        UITapGestureRecognizer *tap  =  [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectedCalendar:)];
        [birthdayLabel addGestureRecognizer:tap];
     
        UILabel *heightTextFieldLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.nameTextField.left, self.birthdayField.bottom + 5, self.nameTextField.width, 20)];
        heightTextFieldLabel.backgroundColor = [UIColor clearColor];
        heightTextFieldLabel.userInteractionEnabled = YES;
        heightTextFieldLabel.font = [UIFont systemFontOfSize:12.0f];
        heightTextFieldLabel.textColor = [UIColor lightGrayColor];
        heightTextFieldLabel.text = @"请输入身高(厘米)";
        [_userInfoScrollView addSubview:heightTextFieldLabel];
        
        self.heightTextField  = [[UITextField alloc] initWithFrame:CGRectMake(self.nameTextField.left, self.birthdayField.bottom + 30, self.nameTextField.width, 40)];
        self.heightTextField .delegate = self;
        self.heightTextField .returnKeyType = UIReturnKeySearch;
        self.heightTextField .text = userInfoModel.high;
        self.heightTextField .backgroundColor= [UIColor clearColor];
        self.heightTextField .font = [UIFont systemFontOfSize:15.0f];
        self.heightTextField .textColor = [UIColor lightGrayColor];
        self.heightTextField.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 70, 0)];
        self.heightTextField.leftViewMode = UITextFieldViewModeAlways;
        self.heightTextField.background = [UIImage imageNamed:@"imp_height"];
        self.heightTextField.placeholder = @"请输入身高(厘米)";
        self.heightTextField.keyboardType = UIKeyboardTypeNumberPad;
        [_userInfoScrollView addSubview:self.heightTextField];
        
        UILabel *weightTextFieldLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.nameTextField.left, self.heightTextField.bottom + 5, self.nameTextField.width, 20)];
        weightTextFieldLabel.backgroundColor = [UIColor clearColor];
        weightTextFieldLabel.font = [UIFont systemFontOfSize:12.0f];
        weightTextFieldLabel.textColor = [UIColor lightGrayColor];
        weightTextFieldLabel.text = @"请输入体重(kg)";
        [_userInfoScrollView addSubview:weightTextFieldLabel];
        
        self.weightTextField  = [[UITextField alloc] initWithFrame:CGRectMake(self.nameTextField.left, self.heightTextField.bottom + 30, self.nameTextField.width, 40)];
        self.weightTextField .delegate = self;
        self.weightTextField .returnKeyType = UIReturnKeySearch;
        self.weightTextField .text = userInfoModel.registyWeight;
        self.weightTextField .backgroundColor= [UIColor whiteColor];
        self.weightTextField .font = [UIFont systemFontOfSize:15.0f];
        self.weightTextField.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 70, 0)];
        self.weightTextField.leftViewMode = UITextFieldViewModeAlways;
        self.weightTextField .textColor = [UIColor lightGrayColor];
         self.weightTextField.placeholder = @"请输入体重(kg)";
        self.weightTextField.keyboardType = UIKeyboardTypeNumberPad;
        self.weightTextField.background = [UIImage imageNamed:@"imp_weight"];
        [_userInfoScrollView addSubview:self.weightTextField];
        
        UILabel *unsignTextFieldLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.nameTextField.left, self.weightTextField.bottom + 5, self.nameTextField.width, 20)];
        unsignTextFieldLabel.backgroundColor = [UIColor clearColor];
        unsignTextFieldLabel.text = @"请输入目标体重(kg)";
        unsignTextFieldLabel.font = [UIFont systemFontOfSize:12.0f];
        unsignTextFieldLabel.textColor = [UIColor lightGrayColor];
        [_userInfoScrollView addSubview:unsignTextFieldLabel];
        
        self.unsignTextField  = [[UITextField alloc] initWithFrame:CGRectMake(self.nameTextField.left, self.weightTextField.bottom + 30, self.nameTextField.width, 40)];
        self.unsignTextField .delegate = self;
        self.unsignTextField .returnKeyType = UIReturnKeySearch;
        self.unsignTextField .text = userInfoModel.permitWeight;
        self.unsignTextField .backgroundColor= [UIColor whiteColor];
        self.unsignTextField .font = [UIFont systemFontOfSize:15.0f];
        self.unsignTextField .textColor = [UIColor lightGrayColor];
        self.unsignTextField.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 70, 0)];
        self.unsignTextField.leftViewMode = UITextFieldViewModeAlways;
        self.unsignTextField.background = [UIImage imageNamed:@"imp_weight"];
        self.unsignTextField.placeholder = @"请输入目标体重(kg)";
        self.unsignTextField.keyboardType = UIKeyboardTypeNumberPad;
        [_userInfoScrollView addSubview:self.unsignTextField];
        
        self.saveUserInfoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.saveUserInfoBtn.frame = CGRectMake(self.nameTextField.left, self.unsignTextField.bottom + 10, self.nameTextField.width, 40);
        [self.saveUserInfoBtn setTitle:@"保存资料" forState:UIControlStateNormal];
        self.saveUserInfoBtn.titleLabel.font = [UIFont boldSystemFontOfSize:16.0f];
        self.saveUserInfoBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
        [self.saveUserInfoBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.saveUserInfoBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
        [self.saveUserInfoBtn addTarget:self action:@selector(changeUserInfo) forControlEvents:UIControlEventTouchUpInside];
        [self.saveUserInfoBtn setBackgroundImage:[UIImage imageNamed:@"bac_long_btn"] forState:UIControlStateNormal];
        [_userInfoScrollView addSubview:self.saveUserInfoBtn];
    }
    return _userInfoScrollView;
}

#pragma mark  选择性别

- (void)sexBtnAction:(UIButton *)btn
{
    if (btn == self.menBtn) {
        [self.menBtn setImage:[UIImage imageNamed:@"imp_select_boy"] forState:UIControlStateNormal];
        [self.womenBtn setImage:[UIImage imageNamed:@"imp_girl"] forState:UIControlStateNormal];
        self.selectedBtn = self.menBtn;
    }else{
        [self.menBtn setImage:[UIImage imageNamed:@"imp_boy"] forState:UIControlStateNormal];
        [self.womenBtn setImage:[UIImage imageNamed:@"imp_select_girl"] forState:UIControlStateNormal];
        self.selectedBtn = self.womenBtn;
    }

}

#pragma mark 选择生日

- (void)selectedCalendar:(UITapGestureRecognizer *)tap
{
    // 初始化一个日期选择控件(不用指定宽高)
    if (datePickerBtn == nil) {
        datePickerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        datePickerBtn.frame = self.view.bounds;
        datePickerBtn.backgroundColor = [UIColor clearColor];
        [datePickerBtn addTarget:self action:@selector(hidePickView) forControlEvents:UIControlEventTouchUpInside];
    }
    [self.view addSubview:datePickerBtn];
    if (datePicker == nil) {
        datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, datePickerBtn.height, DIME_SCREEN_W, 200)];
        // 设置显示中文
        datePicker.backgroundColor = [UIColor whiteColor];
        datePicker.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
        // 只显示年月日
        datePicker.datePickerMode = UIDatePickerModeDate;
        // 添加值改变的监听器
        NSDateFormatter *format = [[NSDateFormatter alloc] init];
        NSLocale *enLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"en-US"];
        [format setLocale:enLocale];
        [format setDateFormat:@"yyyy-MM-dd"];
        NSDate *dateTime = [format dateFromString:[self.birthdayField.text stringByReplacingOccurrencesOfString:@" " withString:@""]];
        datePicker.date = dateTime;
        [datePicker addTarget:self action:@selector(birthdayChange:) forControlEvents:UIControlEventValueChanged];
    }
    [datePickerBtn addSubview:datePicker];
    [UIView animateWithDuration:0.3 animations:^{
        datePicker.top = datePickerBtn.height - 200;
    }];
}
- (void)hidePickView{
    
    [UIView animateWithDuration:0.3 animations:^{
        datePicker.top = self.view.height;
    }completion:^(BOOL finished) {
        [datePickerBtn removeFromSuperview];
    }];
}
- (void)birthdayChange:(UIDatePicker *)picker {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd";
    self.birthdayField.text = [formatter stringFromDate:picker.date];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    // 只有生日和性别才不允许修改文字
    return !(textField == self.birthdayField);
}

#pragma mark 选择头像

- (void)changeHeadIcon
{
    UIActionSheet *choiceSheet = [[UIActionSheet alloc] initWithTitle:nil
                                                             delegate:self
                                                    cancelButtonTitle:@"取消"
                                               destructiveButtonTitle:nil
                                                    otherButtonTitles:@"拍照", @"从相册中选取", nil];
    [choiceSheet showInView:self.view];
}

#pragma mark UIActionSheetDelegate

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) {
        // 拍照
        if ([self isCameraAvailable] && [self doesCameraSupportTakingPhotos]) {
            self.cameraController = [[UIImagePickerController alloc] init];
            self.cameraController.sourceType = UIImagePickerControllerSourceTypeCamera;
            //            self.isCamara = YES;
            if ([self isFrontCameraAvailable]) {
                self.cameraController.cameraDevice = UIImagePickerControllerCameraDeviceRear;
            }
            NSMutableArray *mediaTypes = [[NSMutableArray alloc] init];
            [mediaTypes addObject:(__bridge NSString *)kUTTypeImage];
            self.cameraController.mediaTypes = mediaTypes;
            self.cameraController.delegate = self;
            [self presentViewController:self.cameraController
                               animated:YES
                             completion:^(void){
                             }];
            
        }
    } else if (buttonIndex == 1) {
        // 从相册中选取
        if ([self isPhotoLibraryAvailable]) {
            UIImagePickerController *controller = [[UIImagePickerController alloc] init];
            controller.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            NSMutableArray *mediaTypes = [[NSMutableArray alloc] init];
            [mediaTypes addObject:(__bridge NSString *)kUTTypeImage];
            controller.mediaTypes = mediaTypes;
            controller.delegate = self;
            [self presentViewController:controller
                               animated:YES
                             completion:^(void){
                             }];
            
        }
    }
}

#pragma mark
#pragma mark  UIImagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [picker dismissViewControllerAnimated:YES completion:^() {
        UIImage *portraitImg = [info objectForKey:UIImagePickerControllerOriginalImage];

        [self saveImage:[self imageByScalingAndCroppingForSourceImage:portraitImg targetSize:CGSizeMake(140, 140)] WithName:@"tempHeadIconPic.jpg"];
        self.imageOre = portraitImg.imageOrientation;
        self.headIconImageView.image = portraitImg;

    }];
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:^(){
    }];
}

////////////////////////写入磁盘

- (void)saveImage:(UIImage *)tempImage WithName:(NSString *)imageName
{
    NSData* imageData = UIImagePNGRepresentation(tempImage);
    // and then we write it out
    [imageData writeToFile:[self tempPicPath:imageName] atomically:YES];
}

//////////////////////从磁盘获取文件路径

- (NSString *)tempPicPath:(NSString *)picName
{
    NSArray* paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString* documentsDirectory = [paths objectAtIndex:0];
    // Now we get the full path to the file
    return [documentsDirectory stringByAppendingPathComponent:picName];
    // and then we write it out
    
}

#pragma mark
#pragma mark 图片压缩

- (UIImage *)imageByScalingAndCroppingForSourceImage:(UIImage *)sourceImage targetSize:(CGSize)targetSize {
    UIImage *newImage = nil;
    CGSize imageSize = sourceImage.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    CGFloat targetWidth = targetSize.width;
    CGFloat targetHeight = targetSize.height;
    CGFloat scaleFactor = 0.0;
    CGFloat scaledWidth = targetWidth;
    CGFloat scaledHeight = targetHeight;
    CGPoint thumbnailPoint = CGPointMake(0.0,0.0);
    if (CGSizeEqualToSize(imageSize, targetSize) == NO)
    {
        CGFloat widthFactor = targetWidth / width;
        CGFloat heightFactor = targetHeight / height;
        
        if (widthFactor > heightFactor)
            scaleFactor = widthFactor; // scale to fit height
        else
            scaleFactor = heightFactor; // scale to fit width
        scaledWidth  = width * scaleFactor;
        scaledHeight = height * scaleFactor;
        
        // center the image
        if (widthFactor > heightFactor)
        {
            thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5;
        }
        else
            if (widthFactor < heightFactor)
            {
                thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5;
            }
    }
    UIGraphicsBeginImageContext(targetSize); // this will crop
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = thumbnailPoint;
    thumbnailRect.size.width  = scaledWidth;
    thumbnailRect.size.height = scaledHeight;
    
    [sourceImage drawInRect:thumbnailRect];
    
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    if(newImage == nil)
        //NSLog(@"could not scale image");
        
        //pop the context to get back to the default
        UIGraphicsEndImageContext();
    return newImage;
    
}



#pragma mark PMCalendarControllerDelegate methods

- (void)calendarController:(PMCalendarController *)calendarController didChangePeriod:(PMPeriod *)newPeriod
{
    self.birthdayField.text = [newPeriod.startDate dateStringWithFormat:@"yyyy-MM-dd"];
    [calendarController dismissCalendarAnimated:YES];
}

#pragma mark camera utility

- (BOOL) isCameraAvailable{
    return [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera];
}

- (BOOL) isRearCameraAvailable{
    return [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceRear];
}

- (BOOL) isFrontCameraAvailable {
    return [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceFront];
}

- (BOOL) doesCameraSupportTakingPhotos {
    return [self cameraSupportsMedia:(__bridge NSString *)kUTTypeImage sourceType:UIImagePickerControllerSourceTypeCamera];
}

- (BOOL) isPhotoLibraryAvailable{
    return [UIImagePickerController isSourceTypeAvailable:
            UIImagePickerControllerSourceTypePhotoLibrary];
}
- (BOOL) canUserPickVideosFromPhotoLibrary{
    return [self
            cameraSupportsMedia:(__bridge NSString *)kUTTypeMovie sourceType:UIImagePickerControllerSourceTypePhotoLibrary];
}
- (BOOL) canUserPickPhotosFromPhotoLibrary{
    return [self
            cameraSupportsMedia:(__bridge NSString *)kUTTypeImage sourceType:UIImagePickerControllerSourceTypePhotoLibrary];
}

- (BOOL) cameraSupportsMedia:(NSString *)paramMediaType sourceType:(UIImagePickerControllerSourceType)paramSourceType{
    __block BOOL result = NO;
    if ([paramMediaType length] == 0) {
        return NO;
    }
    NSArray *availableMediaTypes = [UIImagePickerController availableMediaTypesForSourceType:paramSourceType];
    [availableMediaTypes enumerateObjectsUsingBlock: ^(id obj, NSUInteger idx, BOOL *stop) {
        NSString *mediaType = (NSString *)obj;
        if ([mediaType isEqualToString:paramMediaType]){
            result = YES;
            *stop= YES;
        }
    }];
    return result;
}

- (void)removeFromSuperviewAction
{
    [calendarBgBtn removeFromSuperview];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
}

#pragma mark  修改用户资料

//运动分类
////
- (void)changeUserInfo
{
    [self showHud];
    NSMutableDictionary *parametersDic = [NSMutableDictionary dictionary];
    [parametersDic setObject:[[FNDataKeeper sharedInstance] getUserId] forKey:URL_DATA_K_USER_ID];
    UserModel *userInfoModel = [[FNDataKeeper sharedInstance] getUser];
    [parametersDic setObject:userInfoModel.password forKey:URL_DATA_K_PASSWORD];
    [parametersDic setObject:self.nameTextField.text forKey:URL_DATA_K_USER_NICKNAME];
    [parametersDic setObject:self.phoneNumTextField.text forKey:URL_DATA_K_TEL_NBR];
    [parametersDic setObject:userInfoModel.password forKey:URL_DATA_K_PASSWORD];
    //1 代表男 0 代表女
    NSString *sex = @"";
    if (self.selectedBtn == self.womenBtn) {
        sex = @"0";
    }else{
        sex = @"1";
    }
    [parametersDic setObject:sex forKey:URL_DATA_K_SEX];
    [parametersDic setObject:self.birthdayField.text forKey:URL_DATA_K_BIRTHDAY];
    [parametersDic setObject:self.heightTextField.text forKey:URL_DATA_K_HIGH];
    [parametersDic setObject:self.weightTextField.text forKey:URL_DATA_K_REGISTYWEIGHT];
    [parametersDic setObject:self.unsignTextField.text forKey:URL_DATA_K_PERMITWEIGHT];
    [parametersDic setObject:userInfoModel.workType forKey:URL_DATA_K_WORKTYPE];
    if ( [[NSFileManager defaultManager] fileExistsAtPath:[self tempPicPath:@"tempHeadIconPic.jpg"]] &&[self tempPicPath:@"tempHeadIconPic.jpg"] && ![[self tempPicPath:@"tempHeadIconPic.jpg"] isEqualToString:@""]) {
        [parametersDic setObject:@"1" forKey:URL_DATA_K_IS_HAVE_FILE];
//        [parametersDic setObject:[self tempPicPath:@"tempHeadIconPic.png"] forKey:URL_DATA_K_IMG_FILE];
        
    }else{
        [parametersDic setObject:@"0" forKey:URL_DATA_K_IS_HAVE_FILE];
        [parametersDic setObject:@"0" forKey:URL_DATA_K_IMG_FILE];
    }
    
    __unsafe_unretained UserInfoViewController *weakSelf  = self;
    [[NetworkManager shareManager] requestParams:parametersDic withModule:MODELS_MODEL_USERREGISTRY method:MODELS_METHOD_UPDATEUSERMESSAGE finishBlock:^(DataServies *request, id result) {
        
        NSString *msg = [result objectForKey:@"msg"];
        if ([[result objectForKey:@"flag"] integerValue] == 1) {
            NSArray *retDataArray = result[@"retDataArray"];
            NSDictionary *user = retDataArray[0];
            [[NSUserDefaults standardUserDefaults] setObject:user forKey:@"user"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            [[TKAlertCenter defaultCenter] postAlertWithMessage:@"修改成功"];
            [[FNDataKeeper sharedInstance] updateUser:[UserModel modelWithDictionary:user]];
            [weakSelf.navigationController popViewControllerAnimated:YES];
        }else{
            [[TKAlertCenter defaultCenter] postAlertWithMessage:@"请求超时,请检查你的网络环境"];
            NSLog(@"%@",msg);
        }
        [weakSelf hideHud];
        
    } failBlock:^(DataServies *request, NSError *error) {
        [[TKAlertCenter defaultCenter] postAlertWithMessage:@"请求超时,请检查你的网络环境"];
        [weakSelf hideHud];
    }];

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
