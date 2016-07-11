//
//  ViewController.m
//  Weather
//
//  Created by 吴杰健 on 16/7/8.
//  Copyright © 2016年 吴杰健. All rights reserved.
//

#import "MainViewController.h"
#import "CitySelectionViewController.h"
#import "WeatherInfo.h"
#import "WeatherView.h"
#import "CityWeatherInfo.h"
#import <CoreLocation/CoreLocation.h>

static NSString * const SEGUE_MODAL_FROM_MAIN_TO_CITY_LIST = @"segue_modal_from_main_to_city_list";
static NSString * const URL_GET_CITY_WEATHER_INFO = @"forecast7d/";

@interface MainViewController () <CLLocationManagerDelegate>

@property (weak, nonatomic) IBOutlet UILabel *labelCity;
@property (weak, nonatomic) IBOutlet UILabel *labelUpdateTime;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollViewDaysWeather;
@property (nonatomic, strong) CityWeatherInfo *cityWeather;
@property (nonatomic, strong) CLLocationManager *locationManager;

@end

@implementation MainViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    [self startStandardUpdates];
}

#pragma mark - Common

- (void)refreshUI {
    self.labelCity.text = self.cityWeather.cityName;
    self.title = self.cityWeather.cityName;
    self.labelUpdateTime.text = [self.cityWeather.updateDate stringByAppendingString:@"更新"];
    for (UIView *v in self.scrollViewDaysWeather.subviews) {
        [v removeFromSuperview];
    }
    CGFloat width = CGRectGetWidth(self.scrollViewDaysWeather.bounds);
    CGFloat height = CGRectGetHeight(self.scrollViewDaysWeather.bounds);
    self.scrollViewDaysWeather.contentSize = CGSizeMake(width * self.cityWeather.daysWeatherInfo.count, height);
    for (NSInteger i = 0; i < self.cityWeather.daysWeatherInfo.count; i++) {
        WeatherView *v = [WeatherView getView:CGRectMake(width * i, 0, width, height) weatherInfo:self.cityWeather.daysWeatherInfo[i]];
        [self.scrollViewDaysWeather addSubview:v];
    }
    [self.scrollViewDaysWeather setContentOffset:CGPointMake(0, 0)];
    
}

- (void)startStandardUpdates {
    
    if (![CLLocationManager locationServicesEnabled]) {
        self.labelCity.text = @"定位服务未开启";
        return;
    }
    
    if (!self.locationManager) {
        self.locationManager = [[CLLocationManager alloc] init];
    }
    
    if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusNotDetermined) {
        [self.locationManager requestWhenInUseAuthorization];
    } else if ([CLLocationManager authorizationStatus] != kCLAuthorizationStatusAuthorizedAlways && [CLLocationManager authorizationStatus] != kCLAuthorizationStatusAuthorizedWhenInUse) {    self.labelCity.text = @"定位权限不够";
        return;
    }
    
    self.locationManager.delegate = self;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyKilometer;
    self.locationManager.distanceFilter = 1000;
    
    [self.locationManager startUpdatingLocation];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:SEGUE_MODAL_FROM_MAIN_TO_CITY_LIST]) {
        UINavigationController *nvc = (UINavigationController *)segue.destinationViewController;
        CitySelectionViewController *vc = nvc.viewControllers.firstObject;
        vc.citySelectHandler = ^(CityInfo *city){
            self.title = city.name;
            [self getWeatherInfoByCityId:city.code];
        };
    }
}

#pragma mark - Http Request

- (void)getWeatherInfoByCityId:(NSString *)cityId {
    NSDictionary *params = @{@"city": cityId, @"key": [GlobalDataManager shareInstance].yyWeatherKey};
    [WebClient get:URL_GET_CITY_WEATHER_INFO
        parameters:params
           success:^(NSURLSessionDataTask * _Nonnull task, id _Nullable json) {
        self.cityWeather = nil;
        if (json) {
            if ([json[@"code"]  isEqual: @1]) {
                NSDictionary *data = json[@"data"];
                self.cityWeather = [[CityWeatherInfo alloc] initWithDic:data];
            } else {
                [self showAlertControllerWithMessage:json[@"msg"]];
            }
        }
        [self refreshUI];
    }
           failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self showNetworkFailAlert];
    }];
}

#pragma mark - Http Request

- (IBAction)cityButtonTouched:(UIButton *)sender {
    [self performSegueWithIdentifier:SEGUE_MODAL_FROM_MAIN_TO_CITY_LIST sender:nil];
}

#pragma mark - CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status {
    if (self.cityWeather) {
        return;
    }
    
    if (status == kCLAuthorizationStatusAuthorizedWhenInUse || status == kCLAuthorizationStatusAuthorizedAlways) {
        [self startStandardUpdates];
    } else if (status == kCLAuthorizationStatusDenied) {
        self.labelCity.text = @"定位权限不够";
    }
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    if (locations.lastObject) {
        [self.locationManager stopUpdatingLocation];
        self.locationManager = nil;
        CLLocationCoordinate2D coordinate = locations.lastObject.coordinate;
        [self getWeatherInfoByCityId:[NSString stringWithFormat:@"%.2f,%.2f", coordinate.latitude, coordinate.longitude]];
    }
}

@end
