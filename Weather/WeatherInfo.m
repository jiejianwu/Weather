//
//  WeatherInfo.m
//  Weather
//
//  Created by 吴杰健 on 16/7/10.
//  Copyright © 2016年 吴杰健. All rights reserved.
//

#import "WeatherInfo.h"

@implementation WeatherInfo

- (instancetype)initWithDic:(NSDictionary *)dic {
    self = [super init];
    if (self) {
        self.temperatureW = dic[@"qw1"];
        self.temperatureB = dic[@"qw2"] ? dic[@"qw2"] : self.temperatureW;
        self.weatherW = dic[@"tq1"];
        self.weatherB = dic[@"tq2"] ? dic[@"tq2"] : self.weatherW;
        self.windForceW = dic[@"fl1"];
        self.windForceB = dic[@"fl2"] ? dic[@"fl2"] : self.windForceW;
        self.windDirctionW = dic[@"fx1"];
        self.windDirctionB = dic[@"fx2"] ? dic[@"fx2"] : self.windDirctionW;
        self.date = dic[@"date"];
    }
    return self;
}

@end
