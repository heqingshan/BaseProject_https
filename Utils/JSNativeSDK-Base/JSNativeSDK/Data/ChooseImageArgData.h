//
//  ChooiceImageArgData.h
//  JSNativeSDK
//
//  Created by Mtime on 15/11/9.
//  Copyright © 2015年 Mtime. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ChooseImageArgData : NSObject
@property (nonatomic) int count;
@property (nonatomic) int uploadType;
@property (nonatomic,strong)NSString*imageFileType;
@end
