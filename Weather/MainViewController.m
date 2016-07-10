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

static NSString * const SEGUE_MODAL_FROM_MAIN_TO_CITY_LIST = @"segue_modal_from_main_to_city_list";
static NSString * const URL_GET_CITY_WEATHER_INFO = @"forecast7d/";

@interface MainViewController ()

@property (weak, nonatomic) IBOutlet UILabel *labelCity;
@property (weak, nonatomic) IBOutlet UILabel *labelUpdateTime;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollViewDaysWeather;
@property (nonatomic, strong) CityWeatherInfo *cityWeather;

@end

@implementation MainViewController


- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)refreshUI {
    self.labelCity.text = self.cityWeather.cityName;
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
    
}

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

- (IBAction)cityButtonTouched:(UIButton *)sender {
    [self performSegueWithIdentifier:SEGUE_MODAL_FROM_MAIN_TO_CITY_LIST sender:nil];
}

@end
