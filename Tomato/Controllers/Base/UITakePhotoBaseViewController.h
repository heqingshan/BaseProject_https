//
//  TakePhotoBaseViewController.h
//  UTeam
//
//  Created by qingshan on 15/5/16.
//  Copyright (c) 2015年 HQS. All rights reserved.
//

#import "UIBaseViewController.h"
#import "VPImageCropperViewController.h"

@interface UITakePhotoBaseViewController : UIBaseViewController<VPImageCropperDelegate,UIActionSheetDelegate,UINavigationControllerDelegate, UIImagePickerControllerDelegate>

-(void)choosePhotoEnd:(UIImage*)editedImage;
@property (nonatomic, assign) BOOL shouldClip;//是否裁剪,默认为NO

@end
