//
//  WeatherView.h
//  Weather
//
//  Created by 吴杰健 on 16/7/10.
//  Copyright © 2016年 吴杰健. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WeatherInfo.h"

@interface WeatherView : UIView

@property (weak, nonatomic) IBOutlet UILabel *labelWeatherW;
@property (weak, nonatomic) IBOutlet UILabel *labelWeatherB;
@property (weak, nonatomic) IBOutlet UILabel *labelTemperatureW;
@property (weak, nonatomic) IBOutlet UILabel *labelTemperatureB;
@property (weak, nonatomic) IBOutlet UILabel *labelWindDirectionW;
@property (weak, nonatomic) IBOutlet UILabel *labelWindDirectionB;
@property (weak, nonatomic) IBOutlet UILabel *labelWindForceW;
@property (weak, nonatomic) IBOutlet UILabel *labelWindForceB;
@property (weak, nonatomic) IBOutlet UIImageView *imageViewW;
@property (weak, nonatomic) IBOutlet UIImageView *imageViewB;
@property (weak, nonatomic) IBOutlet UILabel *labelDate;

+ (instancetype)getView:(CGRect)frame weatherInfo:(WeatherInfo *)weatherInfo;

@end
