//
//  SendStatusViewController.m
//  FitNess
//
//  Created by liuguoyan on 14-10-6.
//  Copyright (c) 2014年 liuguoyan. All rights reserved.
//

#import "SendStatusViewController.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import <MobileCoreServices/MobileCoreServices.h>
#import "AltFriendsViewController.h"
#import "UIViewController+TAPKeyboardPop.h"
#import "AFHTTPRequestOperation.h"
#import "AFURLSessionManager.h"
#import "AFHTTPRequestOperationManager.h"

@interface SendStatusViewController ()<UITextViewDelegate,UINavigationControllerDelegate, UIImagePickerControllerDelegate,UIKeyboardCoViewDelegate>
{
    UITapGestureRecognizer *singleTapGR ;
}
@property (nonatomic,assign) UIImageOrientation imageOre;

@end

@implementation SendStatusViewController


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
//       [self lisentKeyboard];
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.navigationItem setTitle:@"发状态"];
    [self.view setBackgroundColor:[UIColor colorWithHexString:@"EFEFEF"]];
    [self createSendStatusView];
}

- (void)viewWillAppear:(BOOL)animated
{
//    [_statusInputer becomeFirstResponder];
}

//- (void)viewWillDisappear:(BOOL)animated
//{
//    [_statusInputer resignFirstResponder];
//}

-(void) initData
{
    
}

//////////////////////////////////////////@好友

- (void) onMsgFrendsBtn
{
    AltFriendsViewController *altFriendsCtrl = [[AltFriendsViewController alloc] init];
    __unsafe_unretained SendStatusViewController *sendStatusViewCtrl = self;
    altFriendsCtrl.sendStatusBlock = ^(NSArray *altFriArr){
        sendStatusViewCtrl.statusInputer.text = [NSString stringWithFormat:@"%@%@",sendStatusViewCtrl.statusInputer.text,[altFriArr componentsJoinedByString:@""]];
        sendStatusViewCtrl.altFriArr = altFriArr;
        if (sendStatusViewCtrl.statusInputer.text.length == 0) {
            placeholder.text = @"晒美食、晒运动、晒减肥秘籍";
        }else{
            placeholder.text = @"";
        }
    };
    [self.navigationController pushViewController:altFriendsCtrl animated:YES];
}


//添加左上和右上的按钮
-(void) adTitleMenu
{
    UIButton *lbutton =[[UIButton alloc]initWithFrame:CGRectMake(0, 0, _px(100), _px(32))];
    [lbutton addTarget:self action:@selector(cancelSendMsg) forControlEvents:UIControlEventTouchUpInside];
    [lbutton setTitle:@"取消" forState:UIControlStateNormal];
    lbutton.titleLabel.font = FONT_SIZE(15);
    [lbutton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [lbutton setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    UIBarButtonItem *frendar = [[UIBarButtonItem alloc]initWithCustomView:lbutton];
    [self.navigationItem setLeftBarButtonItem:frendar];
    
    UIButton *rbutton =[[UIButton alloc]initWithFrame:CGRectMake(0, 0, _px(100), _px(32))];
    [rbutton addTarget:self action:@selector(onSendMsg) forControlEvents:UIControlEventTouchUpInside];
    [rbutton setTitle:@"确定" forState:UIControlStateNormal];
    rbutton.titleLabel.font = FONT_SIZE(15);
    [rbutton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [rbutton setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    UIBarButtonItem *msgar = [[UIBarButtonItem alloc]initWithCustomView:rbutton];
    [self.navigationItem setRightBarButtonItem:msgar];

}
//取消消息发送
- (void)cancelSendMsg{
    
    [_statusInputer resignFirstResponder];
    [self.navigationController popViewControllerAnimated:YES];
}
//发送消息事件
-(void) onSendMsg
{
    [self showHud];
    NSMutableDictionary *parametersDic = [NSMutableDictionary dictionary];
    [parametersDic setObject:[[FNDataKeeper sharedInstance] getUserId] forKey:URL_DATA_K_USER_ID];
    [parametersDic setObject:_statusInputer.text forKey:URL_DATA_K_MSG_CONTENT];
    [parametersDic setObject:((_checkBox.highlighted ) ? @"1":@"0") forKey:URL_DATA_K_MSG_PRIVIGE];
    NSString *userIntrestList = @"";
    if (self.altFriArr.count > 0) {
        userIntrestList =  [self.altFriArr componentsJoinedByString:@","];
    }
    [parametersDic setObject:userIntrestList forKey:URL_DATA_K_USER_INTRESTLIST];
    // 1是正常消息，2是转发消息，3是点赞消息
    [parametersDic setObject:@"1" forKey:URL_DATA_K_MSG_TYPE];
    if (selectedPhotiImageView.image == nil) {
        [parametersDic setObject:@"0" forKey:URL_DATA_K_IS_HAVE_FILE];
        [parametersDic setObject:@"" forKey:URL_DATA_K_IMG_FILE];
    }else{
//        [parametersDic setObject:[self tempPicPath:@"tempHeadIconPic.jpg"] forKey:URL_DATA_K_IMG_FILE];
        [parametersDic setObject:@"1" forKey:URL_DATA_K_IS_HAVE_FILE];
    }
    
    __unsafe_unretained SendStatusViewController *weakSelf = self;
    [[NetworkManager shareManager] requestParams:parametersDic withModule:MODELS_MODEL_PARTYMANAGER method:MODELS_METHOD_ADD_MYACTIVITY  finishBlock:^(DataServies *request, id result) {
        
        NSString *msg = [result objectForKey:@"msg"];
        if ([[result objectForKey:@"flag"] integerValue] == 1) {
            [[TKAlertCenter defaultCenter] postAlertWithMessage:@"发表成功"];
            if (weakSelf.sendMsgSuccessBlock) {
                weakSelf.sendMsgSuccessBlock();
            }
            [weakSelf.navigationController popToRootViewControllerAnimated:YES];
        }else{
            NSLog(@"%@",msg);
        }
        [weakSelf hideHud];
        
    } failBlock:^(DataServies *request, NSError *error) {
        
        [weakSelf hideHud];
    }];

}


-(void) createSendStatusView
{
//    [self setUpForDismissKeyboard];
    [self adTitleMenu];

    //UITextView * _statusInputer;
    _statusInputer = [[UITextView alloc] initWithFrame:CGRectMake(_px(30), _px(30), DIME_SCREEN_W-_px(60), 200)];
    [_statusInputer setFont:FONT_SIZE(14)];
    [_statusInputer setBackgroundColor:[UIColor clearColor]];
    _statusInputer.textColor = [UIColor blackColor];
    [_statusInputer setDelegate:self];
//    [_statusInputer becomeFirstResponder];
    [self.view addSubview:_statusInputer];
    
    placeholder = [[UILabel alloc]init];
    placeholder.frame =CGRectMake(_px(50), _px(15), DIME_SCREEN_W-_px(60), _px(100));
    [placeholder setTextColor:[UIColor colorWithHexString:@"#B2B2B2"]];
    [placeholder setFont:FONT_SIZE(14)];
    placeholder.backgroundColor = [UIColor clearColor];
    placeholder.text = @"晒美食、晒运动、晒减肥秘籍";
    [self.view addSubview:placeholder];
    //    UIView * _bottomContainer;
    _bottomContainer = [[UIKeyboardCoView alloc]initWithFrame:CGRectMake(0, self.view.height - 138, DIME_SCREEN_W, 74)];
    _bottomContainer.delegate = self;
    [_bottomContainer setBackgroundColor:[UIColor colorWithHexString:@"DEDEDE"]];
    [self.view addSubview:_bottomContainer];
    
    //    UIImageView *_checkBox;
    _checkBox = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"motion_img_02"] highlightedImage:[UIImage imageNamed:@"motion_img_03"]];
    _checkBox.frame = CGRectMake(_px(54), _px(14), _px(32), _px(32));
    _checkBox.backgroundColor = [UIColor clearColor];
    _checkBox.userInteractionEnabled = YES;
    [_bottomContainer addSubview:_checkBox];
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(checkBoxAction)];
    tapGesture.numberOfTapsRequired = 1;
    [_checkBox addGestureRecognizer:tapGesture];
    
    //    UILabel *_checkBoxLabel;
    _checkBoxLabel = [[UILabel alloc]initWithFrame:CGRectMake(_px(106), _px(16), _px(150), _px(30))];
    _checkBoxLabel.textColor = [UIColor grayColor];
    _checkBoxLabel.text = @"仅自己可见";
    _checkBoxLabel.font = FONT_SIZE(13);
    [_bottomContainer addSubview:_checkBoxLabel];
    
    //    UILabel *_inputCounter;
    _inputCounter = [[UILabel alloc]initWithFrame:CGRectMake(_px(520), _px(16), _px(120), _px(30))];
    _inputCounter.textColor = [UIColor grayColor];
    _inputCounter.text = @"0";
    _inputCounter.font = FONT_SIZE(13);
    [_bottomContainer addSubview:_inputCounter];
    //    UIButton *_cameraBtn;
    _cameraBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, _px(66), _px(223), _px(84))];
    [_cameraBtn setBackgroundImage:[UIImage imageNamed:@"quan_state_bottom_01"] forState:UIControlStateNormal];
    [_bottomContainer addSubview:_cameraBtn];
    //    UIButton *_picBtn;
    _picBtn = [[UIButton alloc]initWithFrame:CGRectMake(_px(223), _px(66), _px(188), _px(84))];
    [_picBtn setBackgroundImage:[UIImage imageNamed:@"quan_state_bottom_02"] forState:UIControlStateNormal];
    [_bottomContainer addSubview:_picBtn];
    
    //    UIButton *_msgFrendsBtn;
    _msgFrendsBtn = [[UIButton alloc]initWithFrame:CGRectMake(_px(411), _px(66), _px(230), _px(84))];
    [_msgFrendsBtn setBackgroundImage:[UIImage imageNamed:@"quan_state_bottom_03"] forState:UIControlStateNormal];
    [_bottomContainer addSubview:_msgFrendsBtn];
    
    //相机按钮
    [_cameraBtn addTarget:self action:@selector(onCameraBtn) forControlEvents:UIControlEventTouchUpInside];
    //图片按钮
    [_picBtn addTarget:self action:@selector(onPicBtn) forControlEvents:UIControlEventTouchUpInside];
    //@按钮
    [_msgFrendsBtn addTarget:self action:@selector(onMsgFrendsBtn) forControlEvents:UIControlEventTouchUpInside];
 
}
- (void)checkBoxAction
{
    _checkBox.highlighted = !_checkBox.highlighted;
}


#pragma mark UITextViewDelegate

-(void)textViewDidChange:(UITextView *)textView{
    if (textView.text.length == 0) {
        placeholder.text = @"晒美食、晒运动、晒减肥秘籍";
    }else{
        placeholder.text = @"";
    }
//    [_inputCounter setText:[NSString stringWithFormat:@"%d/120",textView.text.length]];
    [_inputCounter setText:[NSString stringWithFormat:@"%d",textView.text.length]];
//    if (_statusInputer.text.length >120) {
//        [[TKAlertCenter defaultCenter]postAlertWithMessage:@"您的内容已经超界喽"];
//        _inputCounter.textColor = [UIColor redColor];
//    }else {
//        _inputCounter.textColor = [UIColor grayColor];
//    }
    
    
}

#pragma mark 拍照模块

- (void) onCameraBtn
{
    // 拍照
    if ([self isCameraAvailable] && [self doesCameraSupportTakingPhotos]) {
        UIImagePickerController *pickerCtrl = [[UIImagePickerController alloc] init];
        pickerCtrl.sourceType = UIImagePickerControllerSourceTypeCamera;
        //            self.isCamara = YES;
        if ([self isFrontCameraAvailable]) {
            pickerCtrl.cameraDevice = UIImagePickerControllerCameraDeviceRear;
        }
        NSMutableArray *mediaTypes = [[NSMutableArray alloc] init];
        [mediaTypes addObject:(__bridge NSString *)kUTTypeImage];
        pickerCtrl.mediaTypes = mediaTypes;
        pickerCtrl.delegate = self;
        [self presentViewController:pickerCtrl
                           animated:YES
                         completion:^(void){
                         }];
    }
}

#pragma mark 从本地选取图片

- (void) onPicBtn
{
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
#pragma mark  UIImagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [picker dismissViewControllerAnimated:YES completion:^() {
        UIImage *portraitImg = [info objectForKey:UIImagePickerControllerOriginalImage];
        //图片写入一个磁盘 临时的
    
        UIImage *image = [self imageByScalingAndCroppingForSourceImage:portraitImg targetSize:CGSizeMake(portraitImg.size.width * 0.5, portraitImg.size.height * 0.5)] ;
        NSData *imageData = UIImageJPEGRepresentation(image, 0.0001);
        
       UIImage* m_selectImage = [UIImage imageWithData:imageData];
//        NSLog(@"%f",imageData.length);
        [self saveImage:m_selectImage WithName:@"tempHeadIconPic.jpg"];
        self.imageOre = portraitImg.imageOrientation;
        [self setPhptoImage:portraitImg];
        
    }];
}

////////////////////////写入磁盘

- (void)saveImage:(UIImage *)tempImage WithName:(NSString *)imageName
{
    NSData* imageData = UIImagePNGRepresentation(tempImage);
    // and then we write it out
    [imageData writeToFile:[self tempPicPath:imageName] atomically:NO];
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


////////////////////////////////////////////添加图片

- (void)setPhptoImage:(UIImage *)image
{
     [self.view endEditing:YES];
    CGFloat image_height = 70;
    if (selectedPhotiImageView == nil) {
        selectedPhotiImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 70, image_height)];
        selectedPhotiImageView.contentMode = UIViewContentModeScaleAspectFit;
        selectedPhotiImageView.userInteractionEnabled = YES;
        UIButton *deletePhotoBtn =[[UIButton alloc]initWithFrame:CGRectMake(selectedPhotiImageView.right - 37/2.0,0,37/2.0,27/2.0)];
        [deletePhotoBtn addTarget:self action:@selector(deletePhotoImageAction) forControlEvents:UIControlEventTouchUpInside];
//        [deletePhotoBtn setTitle:@"删除" forState:UIControlStateNormal];
//        deletePhotoBtn.titleLabel.font = FONT_SIZE(12);
//        [deletePhotoBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
//        [deletePhotoBtn setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
        [deletePhotoBtn setBackgroundImage:[UIImage imageNamed:@"deleteBg"] forState:UIControlStateNormal];
        [selectedPhotiImageView addSubview:deletePhotoBtn];
    
    }
    selectedPhotiImageView.image = image;
    [_bottomContainer addSubview:selectedPhotiImageView];
    _bottomContainer.frame = CGRectMake(0, DIME_SCREEN_H - TITLE_HEI - _px(148) - (( image != nil )? image_height : 0), DIME_SCREEN_W, _px(148)  + (( image != nil )? image_height : 0));
    _checkBoxLabel.top = _checkBox.top = _inputCounter.top = _px(16) + (( image != nil )? image_height : 0);
    _msgFrendsBtn.top = _cameraBtn.top = _picBtn.top = _px(66) + (( image != nil )? image_height : 0);

}

//////////////////////////////////////////////删除图片

- (void)deletePhotoImageAction
{
    [self.view endEditing:YES];
    [selectedPhotiImageView removeFromSuperview];
    selectedPhotiImageView.image = nil;
    _bottomContainer.frame = CGRectMake(0, DIME_SCREEN_H - TITLE_HEI - _px(148) , DIME_SCREEN_W, _px(148)  +  0);
    _checkBoxLabel.top = _checkBox.top = _inputCounter.top = _px(16) +  0;
    _msgFrendsBtn.top = _cameraBtn.top = _picBtn.top = _px(66) +  0;
    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:^(){
    }];
}

#pragma mark - UI Keyboard Co View Delegate
- (void) keyboardCoViewWillAppear:(UIKeyboardCoView*)keyboardCoView{
    NSLog(@"Keyboard Co View Will Appear");
}

- (void) keyboardCoViewDidAppear:(UIKeyboardCoView*)keyboardCoView{
    NSLog(@"Keyboard Co View Did Appear");
}

- (void) keyboardCoViewWillDisappear:(UIKeyboardCoView*)keyboardCoView{
    NSLog(@"Keyboard Co View Will Disappear");
    
}


- (void) keyboardCoViewDidDisappear:(UIKeyboardCoView*)keyboardCoView{
    NSLog(@"Keyboard Co View Did Disappear");
    //    dd.frame = CGRectMake(0, 410, 320, 40);
}

//- (void)viewDidDisappear:(BOOL)animated
//{
//    [_statusInputer resignFirstResponder];
//}
- (void)dealloc
{
    NSLog(@"%s",__FUNCTION__);
}



@end
