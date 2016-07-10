//
//  WAlertController.m
//  Weather
//
//  Created by 吴杰健 on 16/7/10.
//  Copyright © 2016年 吴杰健. All rights reserved.
//

#import "WAlertController.h"

@implementation WAlertController

+ (instancetype)alertWithMessage:(NSString *)message {    return [WAlertController alertWithTitle:@"" message:message buttonTitle:@"知道了"];
}

+ (instancetype)alertWithTitle:(NSString *)title message:(NSString *)message buttonTitle:(NSString *)buttonTitle {
    WAlertController *alertVC = [WAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    [alertVC addAction:[UIAlertAction actionWithTitle:buttonTitle style:UIAlertActionStyleCancel handler:nil]];
    return alertVC;
}

@end
