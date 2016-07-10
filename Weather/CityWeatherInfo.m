//
//  CityWeatherInfo.m
//  Weather
//
//  Created by 吴杰健 on 16/7/10.
//  Copyright © 2016年 吴杰健. All rights reserved.
//

#import "CityWeatherInfo.h"

@implementation CityWeatherInfo

- (instancetype)initWithDic:(NSDictionary *)dic {
    self = [super init];
    if (self) {
        self.cityName = dic[@"cityName"];
        self.cityCode = dic[@"cityId"];
        self.updateDate = dic[@"sj"];
        NSArray *weatherArr = dic[@"list"];
        NSMutableArray *tmp = [NSMutableArray new];
        for (NSDictionary *dic in weatherArr) {
            [tmp addObject:[[WeatherInfo alloc] initWithDic:dic]];
        }
        self.daysWeatherInfo = [tmp copy];
    }
    return self;
}

@end
