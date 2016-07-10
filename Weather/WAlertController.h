//
//  WAlertController.h
//  Weather
//
//  Created by 吴杰健 on 16/7/10.
//  Copyright © 2016年 吴杰健. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WAlertController : UIAlertController

+ (instancetype)alertWithMessage:(NSString *)message;
+ (instancetype)alertWithTitle:(NSString *)title message:(NSString *)message buttonTitle:(NSString *)buttonTitle;

@end
