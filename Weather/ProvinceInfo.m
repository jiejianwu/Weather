//
//  ProvinceInfo.m
//  Weather
//
//  Created by 吴杰健 on 16/7/8.
//  Copyright © 2016年 吴杰健. All rights reserved.
//

#import "ProvinceInfo.h"

@implementation ProvinceInfo

- (instancetype)initWithDic:(NSDictionary *)dic {
    self = [super init];
    if (self) {
        self.name = dic[@"name"];
        self.code = dic[@"city_id"];
        NSMutableArray *tmp = [[NSMutableArray alloc] init];
        NSArray *cityArr = dic[@"list"];
        for (NSDictionary *cityLevelDic in cityArr) {
            NSArray *cityLevelArr = cityLevelDic[@"list"];
            if (cityLevelArr) {
                for (NSDictionary *cityDic in cityLevelArr) {
                    CityInfo *city = [[CityInfo alloc] initWithDic:cityDic];
                    [tmp addObject:city];
                }
            } else {
                CityInfo *city = [[CityInfo alloc] initWithDic:cityLevelDic];
                [tmp addObject:city];
            }
        }
        self.citys = [tmp copy];
    }
    return self;
}

@end
