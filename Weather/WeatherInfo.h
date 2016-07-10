//
//  WeatherInfo.h
//  Weather
//
//  Created by 吴杰健 on 16/7/10.
//  Copyright © 2016年 吴杰健. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WeatherInfo : NSObject

@property (nonatomic, strong) NSString *temperatureW;
@property (nonatomic, strong) NSString *temperatureB;
@property (nonatomic, strong) NSString *weatherW;
@property (nonatomic, strong) NSString *weatherB;
@property (nonatomic, strong) NSString *windForceW;
@property (nonatomic, strong) NSString *windForceB;
@property (nonatomic, strong) NSString *windDirctionW;
@property (nonatomic, strong) NSString *windDirctionB;
@property (nonatomic, strong) NSString *date;

- (instancetype)initWithDic:(NSDictionary *)dic;

@end
