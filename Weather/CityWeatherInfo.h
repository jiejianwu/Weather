//
//  CityWeatherInfo.h
//  Weather
//
//  Created by 吴杰健 on 16/7/10.
//  Copyright © 2016年 吴杰健. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WeatherInfo.h"

@interface CityWeatherInfo : NSObject

@property (nonatomic, strong) NSString *cityName;
@property (nonatomic, strong) NSString *cityCode;
@property (nonatomic, strong) NSString *updateDate;
@property (nonatomic, strong) NSArray<WeatherInfo *> *daysWeatherInfo;

- (instancetype)initWithDic:(NSDictionary *)dic;

@end
