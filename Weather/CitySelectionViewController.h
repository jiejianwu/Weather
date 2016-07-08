//
//  CitySelectionViewController.h
//  Weather
//
//  Created by 吴杰健 on 16/7/8.
//  Copyright © 2016年 吴杰健. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CityInfo.h"

@interface CitySelectionViewController : UIViewController

@property (nonatomic) void (^citySelectHandler)(CityInfo *city);

@end
