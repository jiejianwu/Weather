//
//  BaseViewController.m
//  Weather
//
//  Created by 吴杰健 on 16/7/10.
//  Copyright © 2016年 吴杰健. All rights reserved.
//

#import "BaseViewController.h"
#import "WAlertController.h"

@implementation BaseViewController

- (void)showNetworkFailAlert {
    [self showAlertControllerWithMessage:@"网络不好，请求失败"];
}

- (void)showAlertControllerWithMessage:(NSString *)message {
    WAlertController *vc = [WAlertController alertWithMessage:message];
    [self presentViewController:vc animated:YES completion:nil];
}

@end
