//
//  UIImage+wiRoundedRectImage.h
//  Tomato
//
//  Created by HeQingshan－Air on 15/2/17.
//  Copyright (c) 2015年 HQS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (wiRoundedRectImage)
+ (id)createRoundedRectImage:(UIImage*)image size:(CGSize)size radius:(NSInteger)r;
@end
