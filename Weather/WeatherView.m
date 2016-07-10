//
//  WeatherView.m
//  Weather
//
//  Created by 吴杰健 on 16/7/10.
//  Copyright © 2016年 吴杰健. All rights reserved.
//

#import "WeatherView.h"

@implementation WeatherView

static NSDictionary *weatherCodeDic;

+ (instancetype)getView:(CGRect)frame weatherInfo:(WeatherInfo *)weatherInfo {
    WeatherView *v = [[NSBundle mainBundle] loadNibNamed:@"WeatherView" owner:nil options:nil].firstObject;
    v.frame = frame;
    v.labelWeatherW.text = weatherInfo.weatherW;
    v.labelWeatherB.text = weatherInfo.weatherB;
    v.labelTemperatureW.text = weatherInfo.temperatureW;
    v.labelTemperatureB.text = weatherInfo.temperatureB;
    v.labelWindDirectionW.text = weatherInfo.windDirctionW;
    v.labelWindDirectionB.text = weatherInfo.windDirctionB;
    v.labelWindForceW.text = weatherInfo.windForceW;
    v.labelWindForceB.text = weatherInfo.windForceB;
    v.labelWeatherW.text = weatherInfo.weatherW;
    v.labelDate.text = weatherInfo.date;
    v.imageViewW.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@_0", [self getWeatherCodeDic][weatherInfo.weatherW]]];
    v.imageViewB.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@_1", [self getWeatherCodeDic][weatherInfo.weatherB]]];
    return v;
}

+ (NSDictionary *)getWeatherCodeDic {
    if (!weatherCodeDic) {
        weatherCodeDic = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"WeatherCode" ofType:@"plist"]];
    }
    return weatherCodeDic;
}

@end
