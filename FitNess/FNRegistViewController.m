//
//  FNRegistViewController.m
//  FitNess
//
//  Created by liuguoyan on 14-10-4.
//  Copyright (c) 2014年 liuguoyan. All rights reserved.
//

#import "FNRegistViewController.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import "VPImageCropperViewController.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import "FNHomeTabBarController.h"
#import "CustomActionSheet.h"
#import "ChooseAttentionController.h"
#import "XKRWAgreementVC.h"

@interface FNRegistViewController () <UIImagePickerControllerDelegate,VPImageCropperDelegate
,UINavigationControllerDelegate, UIImagePickerControllerDelegate ,UIActionSheetDelegate>
{
    int gender_male ;
    int gender_female ;
    int gender_selected ;
    
    CustomActionSheet *sheet;
    
    NSString *_birthday ;
    NSString *_headImg;
    
}

@end

@implementation FNRegistViewController

- (void)viewDidLoad
{
    [self setUpForDismissKeyboard];
    [super viewDidLoad];
    
    [self createView];
    [self initData];
    [self setListeners];
}



////////初始化界面元素
-(void) createView
{
    
    [self initBeforViewAppear];
    
    //设置隐藏navigation bar
    [[[self navigationController] navigationBar ]setHidden:YES];
    
//    UIImageView * _backImageView;
    _backImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, DIME_SCREEN_W, DIME_SCREEN_H)];
    [_backImageView setImage:[UIImage imageNamed:@"imporve_bg"]];
    [_backImageView setContentMode:UIViewContentModeScaleToFill];
    [self.view addSubview:_backImageView];
    
    
//    UIScrollView * _scrollView;
    _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, DIME_SCREEN_W, DIME_SCREEN_H)];
    [_scrollView showsVerticalScrollIndicator];
    [_scrollView setContentSize:CGSizeMake(DIME_SCREEN_W, _px(1130))];
    [self.view addSubview:_scrollView];
    
    
//    UIButton * _takePicBtn;
    _takePicBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _takePicBtn.frame = CGRectMake(DIME_SCREEN_W/2-_px(72), _px(100), _px(144), _px(140));
    [_takePicBtn setBackgroundImage:[UIImage imageNamed:@"imp_photo"] forState:UIControlStateNormal];
    [CommonUtils generateRoundButton:_takePicBtn];
    [_scrollView addSubview:_takePicBtn];
    
//    UITextField * _phoneInputer;
    _nickInputer = [self generateInputerWithImg:@"imp_name" hint:@"请输入用户名" yPos:250];
    [_scrollView addSubview:_nickInputer];
    
    
//    UITextField * _pwdInputer;
    _pwdInputer= [self generateInputerWithImg:@"imp_password" hint:@"请输入密码" yPos:342];
    [_scrollView addSubview:_pwdInputer];
    
    
//    UITextField * _nickInputer;
    _phoneInputer= [self generateInputerWithImg:@"imp_number" hint:@"请输入手机号码" yPos:434];
    [_scrollView addSubview:_phoneInputer];
    
    
//    UIButton * _maleSelector;
    CGRect rect = _nickInputer.frame;
    _maleSelector = [self generateGenderSelectWithNormalImg:@"imp_boy" selectedImg:@"imp_select_boy" xPos:rect.origin.x];
    _maleSelector.tag = gender_male;
    [_maleSelector addTarget:self action:@selector(onGenderClick:) forControlEvents:UIControlEventTouchUpInside];
    [_maleSelector setSelected:YES];
    [_scrollView addSubview:_maleSelector];
    
//    UIButton * _femaleSelector;
    int gx = rect.origin.x + rect.size.width - _px(246);
    _femaleSelector = [self generateGenderSelectWithNormalImg:@"imp_girl" selectedImg:@"imp_select_girl" xPos:gx];
    _femaleSelector.tag = gender_female;
    [_femaleSelector addTarget:self action:@selector(onGenderClick:) forControlEvents:UIControlEventTouchUpInside];
    [_scrollView addSubview:_femaleSelector];
    
    
//    UITextField * _dateInputer;
    _dateInputer= [self generateInputerWithImg:@"imp_birth" hint:@"请输入生日" yPos:620];
    [_dateInputer setEnabled:NO];
    _dataPlacer = [[UIButton alloc] initWithFrame:_dateInputer.frame];
    [_scrollView addSubview:_dateInputer];
    [_scrollView addSubview:_dataPlacer];
    
//    UITextField * _heightInputer;
    _heightInputer= [self generateInputerWithImg:@"imp_height" hint:@"请输入身高(厘米)" yPos:710];
    [_heightInputer setKeyboardType:UIKeyboardTypeNumberPad];
    [_scrollView addSubview:_heightInputer];
    
//    UITextField * _weightInputer;
    _weightInputer= [self generateInputerWithImg:@"imp_weight" hint:@"请输入体重(kg)" yPos:802];
    [_weightInputer setKeyboardType:UIKeyboardTypeNumberPad];
    [_scrollView addSubview:_weightInputer];
    
//    UITextField * _targetWeiInputer;
    _targetWeiInputer= [self generateInputerWithImg:@"imp_weight" hint:@"请输入目标体重(kg)" yPos:890];
    [_targetWeiInputer setKeyboardType:UIKeyboardTypeNumberPad];
    [_scrollView addSubview:_targetWeiInputer];
    
//    UIButton * _registBtn;
    _registBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _registBtn.frame = CGRectMake(_px(110), _px(1002), _px(220), _px(58));
    [_registBtn setImage:[UIImage imageNamed:@"imp_join"] forState:UIControlStateNormal];
    [_scrollView addSubview:_registBtn];
    
//    UIButton * _agreeeLable;
    _agreeeLable = [UIButton buttonWithType:UIButtonTypeCustom];
    _agreeeLable.frame = CGRectMake(_px(350), _px(1020), _px(196), _px(30));
    [_agreeeLable setTitle:@"同意服务条款" forState:UIControlStateNormal];
    [_agreeeLable setImage:[UIImage imageNamed:@"imp_icon"] forState:UIControlStateNormal];
    _agreeeLable.titleLabel.font = FONT_SIZE(12);
    [_agreeeLable sizeToFit];
    [_agreeeLable addTarget:self action:@selector(_agreeeLableAction) forControlEvents:UIControlEventTouchUpInside];
    [_agreeeLable setTitleColor:R_COLOR_NOMARL_GREY forState:UIControlStateNormal];
    [_scrollView addSubview:_agreeeLable];
    
    UIButton *agreeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    agreeBtn.frame = CGRectMake(_px(350), _px(1020) + 20, _px(196), _px(30));
    [agreeBtn setTitle:@"   云朵朵服务条款" forState:UIControlStateNormal];
    agreeBtn.titleLabel.font = FONT_SIZE(12);
    [agreeBtn sizeToFit];
    [agreeBtn addTarget:self action:@selector(_agreeeLableAction) forControlEvents:UIControlEventTouchUpInside];
    [agreeBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [_scrollView addSubview:agreeBtn];
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(10, agreeBtn.height - 7, agreeBtn.width, 0.5)];
    lineView.backgroundColor = [UIColor blueColor];
    [agreeBtn addSubview:lineView];
    
//    XKRWAgreementVC
}
- (void)_agreeeLableAction
{
    UINavigationController *navCtr = [[UINavigationController alloc] initWithRootViewController:[[XKRWAgreementVC alloc] init]];
    [navCtr.navigationBar setBackgroundImage:[UIImage imageNamed:@"bac_long_btn"] forBarMetrics:UIBarMetricsDefault];
    
    [self.navigationController presentViewController:navCtr animated:YES completion:^{
        
    }];
}

-(void) initBeforViewAppear
{
    gender_male = 10;
    gender_female = 20;
    gender_selected = gender_male;
}

-(id) generateInputerWithImg:(NSString *)img hint:(NSString *)hint yPos:(int) y
{
    
    UITextField * resulTextField  = [[UITextField alloc ]initWithFrame:CGRectMake((DIME_SCREEN_W-_px(554))/2, _px(y), _px(554), _px(85))];
    [resulTextField setBackground:[UIImage imageNamed:img]];
    [resulTextField setKeyboardType:UIKeyboardTypeDefault];
    [resulTextField setPlaceholder:hint];
    resulTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    resulTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    resulTextField.textColor = [UIColor blackColor];
    resulTextField.backgroundColor = [UIColor clearColor];
    resulTextField.font = FONT_SIZE(15);
    [resulTextField setValue:[NSNumber numberWithInt:_px(140)] forKey:@"paddingLeft"];
    return resulTextField;
}

-(id) generateGenderSelectWithNormalImg:(NSString*)imgdef selectedImg:(NSString *)imgselc xPos:(int)x
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(x, _px(526), _px(246), _px(78));
    [button setImage:[UIImage imageNamed:imgdef] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:imgselc] forState:UIControlStateSelected];
    button.adjustsImageWhenHighlighted = FALSE;
    
    return button;
}

-(void) onGenderClick:(UIButton*)sender
{
    if (sender.tag == gender_male) {
        [_maleSelector setSelected:YES];
        [_femaleSelector setSelected:NO];
        gender_selected = gender_male;
    } else {
        [_maleSelector setSelected:NO];
        [_femaleSelector setSelected:YES];
        gender_selected = gender_female;
    }
}

////////初始化数据
-(void) initData
{
    
}

////////设置元素监听
-(void) setListeners
{
    [_takePicBtn addTarget:self action:@selector(onTakePicBtn) forControlEvents:UIControlEventTouchUpInside];
    [_dataPlacer addTarget:self action:@selector(onBirthBtn) forControlEvents:UIControlEventTouchUpInside];
    [_registBtn addTarget:self action:@selector(onConfirmBtn) forControlEvents:UIControlEventTouchUpInside];
}
//点击拍照
-(void) onTakePicBtn
{
    UIActionSheet *_choiceSheet = [[UIActionSheet alloc] initWithTitle:nil
                                                             delegate:self
                                                    cancelButtonTitle:@"取消"
                                               destructiveButtonTitle:nil
                                                    otherButtonTitles:@"拍照", @"从相册中选取", nil];
    [_choiceSheet showInView:self.view];
}
//加入云朵朵按钮
-(void) onConfirmBtn
{
    
    NSString * nullInfo = nil;
    if (_phoneInputer.text.length==0) {
        nullInfo = @"请输入昵称";
        [[TKAlertCenter defaultCenter]postAlertWithMessage:nullInfo];
        return;
    }
    if (_pwdInputer.text.length == 0) {
        nullInfo = @"请输入密码";
        [[TKAlertCenter defaultCenter]postAlertWithMessage:nullInfo];
        return;
    }
    if (_nickInputer.text.length == 0) {
        nullInfo = @"请输入电话";
        [[TKAlertCenter defaultCenter]postAlertWithMessage:nullInfo];
        return;
    }
    if (_dateInputer.text.length == 0) {
        nullInfo = @"请选择生日";
        [[TKAlertCenter defaultCenter]postAlertWithMessage:nullInfo];
        return;
    }
    if (_heightInputer.text.length == 0) {
        nullInfo = @"输入身高";
        [[TKAlertCenter defaultCenter]postAlertWithMessage:nullInfo];
        return;
    }
    if (_weightInputer.text.length == 0) {
        nullInfo = @"输入体重";
        [[TKAlertCenter defaultCenter]postAlertWithMessage:nullInfo];
        return;
    }
    if (_targetWeiInputer.text.length == 0) {
        nullInfo = @"输入目标体重";
        [[TKAlertCenter defaultCenter]postAlertWithMessage:nullInfo];
        return;
    }
    
    NSMutableDictionary *parametersDic = [NSMutableDictionary dictionary];
    
    [parametersDic setObject:_phoneInputer.text forKey:URL_DATA_K_TEL_NBR];
    [parametersDic setObject:_pwdInputer.text forKey:URL_DATA_K_PASSWORD];
    [parametersDic setObject:_nickInputer.text forKey:URL_DATA_K_NICKNAME];
    [parametersDic setObject:(gender_selected == gender_male ? @"0" : @"1" )forKey:URL_DATA_K_SEX];
    
    
    [parametersDic setObject:_heightInputer.text forKey:URL_DATA_K_HIGH];
    [parametersDic setObject:_targetWeiInputer.text forKey:URL_DATA_K_PERMITWEIGHT];
    [parametersDic setObject:_weightInputer.text forKey:URL_DATA_K_REGISTYWEIGHT];
    [parametersDic setObject:_birthday forKey:URL_DATA_K_BIRTHDAY];
    [parametersDic setObject:@"1" forKey:URL_DATA_K_WORKTYPE];
    
    if (_headImg) {
        [parametersDic setObject:@"1" forKey:URL_DATA_K_IS_HAVE_FILE];
//        [parametersDic setObject:_headImg forKey:URL_DATA_K_IMG_FILE];
    }else{
        [parametersDic setObject:@"0" forKey:URL_DATA_K_IS_HAVE_FILE];
    }
    
    
    [[NetworkManager shareManager] requestParams:parametersDic withModule:MODELS_MODEL_USERREGISTRY method:MODELS_METHOD_SAVEUSERREGISTRYINFO  finishBlock:^(DataServies *request, id result) {
        
        NSString *msg = [result objectForKey:@"msg"];
        if ([[result objectForKey:@"flag"] integerValue] == 1) {
            NSLog(@"注册成功。。。。-============-%@",result);
            NSDictionary *user = [[result objectForKey:@"retDataArray"]objectAtIndex:0];
            //序列化到文件中
            [[FNDataKeeper sharedInstance] updateUser:[UserModel modelWithDictionary:user]];
            //存于USerDefaults中
            NSUserDefaults *userDef = [NSUserDefaults standardUserDefaults];
            if (userDef) {
                [userDef setObject:user forKey:@"user"];
                [userDef synchronize];
            }
            
            [[FNDataKeeper sharedInstance] updateUser:[UserModel modelWithDictionary:user]];
            ChooseAttentionController *controler = [[ChooseAttentionController alloc]init];
            [self.navigationController pushViewController:controler animated:YES];
            
//            FNHomeTabBarController *controler = [[FNHomeTabBarController alloc]init];
//            [self.navigationController pushViewController:controler animated:YES];
            
        }else{
            NSLog(@"%@",msg);
        }
        
    } failBlock:^(DataServies *request, NSError *error) {
        
        
    }];
    
    
    
    
}
//选择生日
-(void) onBirthBtn
{

    sheet = [[CustomActionSheet alloc]initWithHeight:220 WithSheetTitle:@"选择日期"];
    [sheet setTag:100];
    sheet.delegate = self;
    [sheet showInView:self.view];
}


#pragma mark --
#pragma mark  UIActionSheetDelegate

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    //这是选择生日
    if (actionSheet.tag == 100) {
        _birthday = sheet.date;
        _dateInputer.text = _birthday;
    }
    //拍照
    else{
    
    if (buttonIndex == 0) {
        // 拍照
        if ([self isCameraAvailable] && [self doesCameraSupportTakingPhotos]) {
            self.cameraController = [[UIImagePickerController alloc] init];
            self.cameraController.sourceType = UIImagePickerControllerSourceTypeCamera;
            //            self.isCamara = YES;
            if ([self isFrontCameraAvailable]) {
                self.cameraController.cameraDevice = UIImagePickerControllerCameraDeviceRear;
            }
            
            UIView *navBarView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, DIME_SCREEN_W, 44 + 20)];
            navBarView.backgroundColor = [UIColor blackColor];
            
            UIButton *rearAndFrontButton = [UIButton buttonWithType:UIButtonTypeCustom];
            rearAndFrontButton.frame = CGRectMake(DIME_SCREEN_W - 60 , 20 , 45, 45 );
            [rearAndFrontButton addTarget:self action:@selector(toggleCamera) forControlEvents:UIControlEventTouchUpInside];
            [rearAndFrontButton setImage:[UIImage imageNamed:@"camera"] forState:UIControlStateNormal];
            rearAndFrontButton.exclusiveTouch = YES;
            rearAndFrontButton.backgroundColor = [UIColor clearColor];
            [navBarView addSubview:rearAndFrontButton];
            
            UIButton *flashButton = [UIButton buttonWithType:UIButtonTypeCustom];
            flashButton.frame = CGRectMake(10 , 20 , 45, 45);
            flashButton.exclusiveTouch = YES;
            [flashButton addTarget:self action:@selector(flashButtonAction) forControlEvents:UIControlEventTouchUpInside];
            [flashButton setImage:[UIImage imageNamed:@"camera-set"] forState:UIControlStateNormal];
            flashButton.backgroundColor = [UIColor clearColor];
            [navBarView addSubview:flashButton];
            
            self.flashTitleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            self.flashTitleBtn.frame = CGRectMake(flashButton.right - 5, flashButton.top + 7.5, 40, 30);
            self.flashTitleBtn.backgroundColor = [UIColor clearColor];
            self.flashTitleBtn.titleLabel.textColor = [UIColor whiteColor];
            self.flashTitleBtn.exclusiveTouch = YES;
            self.cameraController.cameraFlashMode = UIImagePickerControllerCameraFlashModeAuto;
            [self.flashTitleBtn setTitle:@"自动" forState:UIControlStateNormal];
            [navBarView addSubview:self.flashTitleBtn];
            [self.cameraController.view addSubview:navBarView];
            if (IOS_VERSION < 7.0) {
                rearAndFrontButton.top = 0;
                flashButton.top = 0;
                self.flashTitleBtn.top = 5;
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
    
    
}
- (void)toggleCamera
{
    if (self.cameraController.cameraDevice == UIImagePickerControllerCameraDeviceRear) {
        self.cameraController.cameraDevice = UIImagePickerControllerCameraDeviceFront;
    }else
    {
        self.cameraController.cameraDevice = UIImagePickerControllerCameraDeviceRear;
    }
}
- (void)flashButtonAction
{
    //切换闪光灯
    if(self.cameraController.cameraFlashMode == UIImagePickerControllerCameraFlashModeOff){
        self.cameraController.cameraFlashMode = UIImagePickerControllerCameraFlashModeAuto;
        [self.flashTitleBtn setTitle:@"自动" forState:UIControlStateNormal];
    }else if (self.cameraController.cameraFlashMode == UIImagePickerControllerCameraFlashModeAuto)
    {
        self.cameraController.cameraFlashMode = UIImagePickerControllerCameraFlashModeOn;
        [self.flashTitleBtn setTitle:@"打开" forState:UIControlStateNormal];
    }else if (self.cameraController.cameraFlashMode == UIImagePickerControllerCameraFlashModeOn){
        self.cameraController.cameraFlashMode = UIImagePickerControllerCameraFlashModeOff;
        [self.flashTitleBtn setTitle:@"关闭" forState:UIControlStateNormal];
    }
    
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


#pragma mark
#pragma mark VPImageCropperDelegate

- (void)imageCropper:(VPImageCropperViewController *)cropperViewController didFinished:(UIImage *)editedImage {
    
    [_takePicBtn setImage:editedImage forState:UIControlStateNormal];
    [cropperViewController dismissViewControllerAnimated:YES completion:nil];
    
    [self saveImage:editedImage WithName:@"tempHeadIconPic.jpg"];
    _headImg = [self tempPicPath:@"tempHeadIconPic.jpg"];
    
    /**
    NSData *data = nil;
    UIImage *newImage = [UIImage imageWithCGImage:editedImage.CGImage scale:1 orientation:self.imageOre];
    UIImageView *rightImageView = (UIImageView *)[selectedCell.contentView viewWithTag:105];
    if (index == 1) {
        rightImageView.image = [self imageByScalingAndCroppingForSourceImage:newImage targetSize:CGSizeMake(640, 640)];
        data = UIImageJPEGRepresentation(rightImageView.image,1);
        [data writeToFile:[self imagePath] atomically:YES];
    }else
    {
        rightImageView.image = newImage;
        newImage = [self imageByScalingAndCroppingForSourceImage:newImage targetSize:CGSizeMake(140, 140)];
        data = UIImageJPEGRepresentation(newImage,1);
        [data writeToFile:[self imagePath] atomically:YES];
    }
    
    [self commitShopHeadImageAndBgImage];
    [cropperViewController dismissViewControllerAnimated:YES completion:^{
        // TO DO
    }];
     **/
    
}
- (void)imageCropperDidCancel:(VPImageCropperViewController *)cropperViewController {
    [cropperViewController dismissViewControllerAnimated:YES completion:^{
        
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
#pragma mark  UIImagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    
    [picker dismissViewControllerAnimated:YES completion:^() {
        UIImage *portraitImg = [info objectForKey:UIImagePickerControllerOriginalImage];
        self.imageOre = portraitImg.imageOrientation;
        VPImageCropperViewController *imgEditorVC = [[VPImageCropperViewController alloc] initWithImage:portraitImg cropFrame:CGRectMake(0, 100.0f, self.view.frame.size.width, self.view.frame.size.width) limitScaleRatio:3.0];
        imgEditorVC.delegate = self;
        [self presentViewController:imgEditorVC animated:YES completion:^{
            
        }];
    }];
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:^(){
        
    }];
}


#pragma mark
#pragma mark 截取图片

/**
 *  截取图片
 *
 *  @return
 */

- (UIImage *)imageFromImage:(UIImage *)image inRect:(CGRect)rect {
    CGImageRef sourceImageRef = [image CGImage];
    CGImageRef newImageRef = CGImageCreateWithImageInRect(sourceImageRef, rect);
    UIImage *newImage = [UIImage imageWithCGImage:newImageRef];
    CGImageRelease(newImageRef);
    return newImage;
}

/**
 *  提交头像和背景
 */

#pragma mark
#pragma mark 上传头像和背景

- (void)commitShopHeadImageAndBgImage
{
    
    /**
    //上传服务器
    NSMutableDictionary *params = [[NSMutableDictionary alloc]initWithCapacity:23];
    [self addPublicParameters:params];
    [self showHUD:@""];
    //接口名称
    if (index == 1) {
        [params setObject:@"back" forKey:@"headOrback"];
    }else
    {
        [params setObject:@"head" forKey:@"headOrback"];
    }
    [params setObject:[SettingsManager sharedSettingsManager].sessionid forKey:@"sessionid"];
    if (![SettingsManager sharedSettingsManager].shopId && [[SettingsManager sharedSettingsManager].shopId  isEqualToString:@""]) {
        [[TKAlertCenter defaultCenter] postAlertWithMessage:@"店铺id为空或者不存在"];
        return;
    }
    [params setObject:[SettingsManager sharedSettingsManager].shopId forKey:@"shopid"];
    NSString *url = kUploadFilesUrl;
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL: [NSURL URLWithString: url]];
    NSMutableDictionary *headDic = [NSMutableDictionary dictionaryWithObject:@"multipart/form-data" forKey:@"enctype"];
    [request setRequestMethod:@"POST"];
    [request setRequestHeaders:headDic];
    [request setFile:[self imagePath] forKey: @"files"];
    [request buildRequestHeaders];
    
    NSArray *allkeys = [params allKeys];
    for (NSString *key in allkeys) {
        id value = [params objectForKey:key];
        [request addPostValue:value forKey:key];
    }
    __weak ASIFormDataRequest *weakRequestSelf = request;
    __unsafe_unretained YTBeautifyShopViewController *beautifyCtrl = self;
    [request setCompletionBlock:^{
        ASIFormDataRequest *strongRequestSelf = weakRequestSelf;
        //        CLog(@"%@",strongRequestSelf.responseString);
        NSRange range = [strongRequestSelf.responseString rangeOfString:@"True"];
        NSRange range1 = [strongRequestSelf.responseString rangeOfString:@"\"statusCode\":200"];
        if (range.location != NSNotFound && range1.location != NSNotFound) {
            NSDictionary *userDic = nil;
            NSRange fileNameRange = [strongRequestSelf.responseString rangeOfString:@"filename"];
            NSString *imageStr = [strongRequestSelf.responseString  substringFromIndex:fileNameRange.location + fileNameRange.length + 3];
            NSRange jpgRange = [imageStr rangeOfString:@"jpg"];
            NSString *newImagePath = [imageStr substringToIndex:jpgRange.location + 3];
            if (index == 0) {
                [MobClick event:@"2000"];
                [ADBMobile trackAction:@"changeShopHead" data:nil];
                userDic = [NSDictionary dictionaryWithObjectsAndKeys:@"3",@"ChangeShopType",newImagePath,@"HeadImageView",nil];
            }else
            {
                [MobClick event:@"2001"];
                [ADBMobile trackAction:@"changeShopBG" data:nil];
                userDic = [NSDictionary dictionaryWithObjectsAndKeys:@"4",@"ChangeShopType",newImagePath,@"ShopBgImageView",nil];
            }
            [[NSNotificationCenter defaultCenter] postNotificationName:YTCHANGE_SHOP_INFO object:nil userInfo:userDic];
        }else
        {
            [[TKAlertCenter defaultCenter] postAlertWithMessage:@"上传失败"];
        }
        if ([[NSFileManager defaultManager] removeItemAtPath: [beautifyCtrl imagePath] error:NULL]) {
            CLog(@"移除掉原来的图片成功");
        }
        [beautifyCtrl hideHUD];
    }];
    [request setFailedBlock:^{
        [[TKAlertCenter defaultCenter] postAlertWithMessage:@"上传失败"];
        [beautifyCtrl hideHUD];
    }];
    [request startAsynchronous];
    */
}



@end
