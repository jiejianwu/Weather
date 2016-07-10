//
//  BaseViewController.h
//  Weather
//
//  Created by 吴杰健 on 16/7/10.
//  Copyright © 2016年 吴杰健. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Weather-Swift.h"

@interface BaseViewController : UIViewController

- (void)showNetworkFailAlert;
- (void)showAlertControllerWithMessage:(NSString *)message;

@end
