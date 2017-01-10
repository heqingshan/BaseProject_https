//
//  SMLocationService.m
//  App
//
//  Created by 尚美 on 14-5-27.
//  Copyright (c) 2014年 Sunmay. All rights reserved.
//

#import "SMLocationService.h"
#import "TQLocationConverter.h"

@implementation SMLocationService
@synthesize curLocation;

const double a = 6378245.0;
const double ee = 0.00669342162296594323;
const double pi = 3.14159265358979324;

- (id)init
{
    self = [super init];
    if (self) {
    }
    return self;
}

//获得自己的当前的位置信息
- (void)getCurPosition:(CompleteBlock_m)completeBlock
{
    completeBlock_ = [completeBlock copy];
    //开始探测自己的位置
    if (locationManager==nil)
    {
        locationManager =[[CLLocationManager alloc] init];
        if ([CLLocationManager locationServicesEnabled] == NO) {
            UIAlertView *servicesDisabledAlert = [[UIAlertView alloc] initWithTitle:@"Location Services Disabled" message:@"You currently have all location services for this device disabled. If you proceed, you will be asked to confirm whether location services should be reenabled." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [servicesDisabledAlert show];
            return;
        }
    }
    
    if ([CLLocationManager locationServicesEnabled])
    {
        locationManager.delegate=self;
        locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        locationManager.distanceFilter=3.0f;
        locationManager.pausesLocationUpdatesAutomatically = YES;
        if (([[[UIDevice currentDevice] systemVersion] compare:@"8.0" options:NSNumericSearch] != NSOrderedAscending)) {
            [locationManager requestAlwaysAuthorization];
        }
        [locationManager startUpdatingLocation];
    }
    else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提醒" message:@"定位失败，系统将默认提取北京的数据！" delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil, nil];
        [alert show];
        if (completeBlock_) {
            completeBlock_(false);
        }
    }
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    [manager stopUpdatingLocation];
    CLLocation * newLocation = (CLLocation *)[locations objectAtIndex:0];
    //判断是不是属于国内范围
    if (![TQLocationConverter isLocationOutOfChina:[newLocation coordinate]]) {
        //转换后的coord
        CLLocationCoordinate2D coord = [TQLocationConverter transformFromWGSToGCJ:[newLocation coordinate]];
        curLocation = [TQLocationConverter transformFromGCJToBaidu:coord];
        DLog(@"+++++++++++++++++++++++++latitude:%@,longitude:%@", @(coord.latitude), @(coord.longitude));
        /*
        [[NSNotificationCenter defaultCenter] postNotificationName:@"CurrentLocationChangedNotification" object:nil];
        UIAlertView *servicesDisabledAlert = [[UIAlertView alloc] initWithTitle:@"Location Services Disabled" message:[NSString stringWithFormat:@"latitude:%f,longitude:%f", curLocation.latitude, curLocation.longitude] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [servicesDisabledAlert show];
         */
    }
    
    if (completeBlock_) {
        completeBlock_(true);
    }
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSString * errorString;
    [manager stopUpdatingLocation];
    switch ([error code]) {
        case kCLErrorDenied:
        {
            //Access denied by user
            errorString = @"Access to Location Services denied by user";
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"定位失败" message:@"请在设置中打开GPS开关或权限设置，以便定位您的位置" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
            //Do something...
        }
            break;
        case kCLErrorLocationUnknown:
        {
            //Probably temporary...
            errorString = @"Location data unavailable";
            //Do something else...
        }
            break;
        default:
        {
            errorString = @"An unknown error has occurred";
        }
        break;
    }
    if (completeBlock_) {
        completeBlock_(false);
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"prefs:root=LOCATION_SERVICES"]];
    }
}

+(CLLocationCoordinate2D)transformFromWGSToGCJ:(CLLocationCoordinate2D)wgsLoc
{
    CLLocationCoordinate2D adjustLoc;
    return adjustLoc;
}

@end
