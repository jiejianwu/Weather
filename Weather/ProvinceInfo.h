//
//  ProvinceInfo.h
//  Weather
//
//  Created by 吴杰健 on 16/7/8.
//  Copyright © 2016年 吴杰健. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CityInfo.h"

@interface ProvinceInfo : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *code;
@property (nonatomic, strong) NSArray<CityInfo *> *citys;

- (instancetype)initWithDic:(NSDictionary *)dic;

@end
