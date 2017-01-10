//
//  ViewController.h
//  JSNativeSDK
//
//  Created by Mtime on 15/11/4.
//  Copyright © 2015年 Mtime. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JSNativeSDK.h"
@interface ViewController : UIViewController
@property (strong, nonatomic) IBOutlet UIWebView *webView;
@property (strong,nonatomic) JSNativeSDK *nativeSDK;
@end

