//
//  CityInfo.h
//  Weather
//
//  Created by 吴杰健 on 16/7/8.
//  Copyright © 2016年 吴杰健. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CityInfo : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *code;

- (instancetype)initWithDic:(NSDictionary *)dic;

@end
