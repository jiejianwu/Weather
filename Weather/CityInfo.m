//
//  CityInfo.m
//  Weather
//
//  Created by 吴杰健 on 16/7/8.
//  Copyright © 2016年 吴杰健. All rights reserved.
//

#import "CityInfo.h"

@implementation CityInfo

- (instancetype)initWithDic:(NSDictionary *)dic {
    self = [super init];
    if (self) {
        self.name = dic[@"name"];
        self.code = dic[@"city_id"];
    }
    return self;
}

@end
