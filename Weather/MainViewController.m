//
//  ViewController.m
//  Weather
//
//  Created by 吴杰健 on 16/7/8.
//  Copyright © 2016年 吴杰健. All rights reserved.
//

#import "MainViewController.h"
#import "CitySelectionViewController.h"
#import "Weather-Swift.h"

static NSString * const SEGUE_MODAL_FROM_MAIN_TO_CITY_LIST = @"segue_modal_from_main_to_city_list";
static NSString * const URL_GET_CITY_WEATHER_INFO = @"weatherhours/";

@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)getWeatherInfoByCityId:(NSString *)cityId {
    NSDictionary *params = @{@"city": cityId, @"key": [GlobalDataManager shareInstance].yyWeatherKey};
    [WebClient get:URL_GET_CITY_WEATHER_INFO parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id _Nullable json) {
        if (json) {
            NSLog(json);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if (segue.identifier == SEGUE_MODAL_FROM_MAIN_TO_CITY_LIST) {
        CitySelectionViewController *vc = (CitySelectionViewController *)segue.destinationViewController;
        vc.citySelectHandler = ^(CityInfo *city){
            [self getWeatherInfoByCityId:city.code];
        };
    }
}

- (IBAction)cityButtonTouched:(UIButton *)sender {
    [self performSegueWithIdentifier:SEGUE_MODAL_FROM_MAIN_TO_CITY_LIST sender:nil];
}

@end
