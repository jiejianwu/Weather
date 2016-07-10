//
//  CitySelectionViewController.m
//  Weather
//
//  Created by 吴杰健 on 16/7/8.
//  Copyright © 2016年 吴杰健. All rights reserved.
//

#import "CitySelectionViewController.h"
#import "ProvinceInfo.h"
#import "WAlertController.h"

static NSString * const URL_GET_CITY_WEATHER_INFO = @"citylist/id/1/";

@interface CitySelectionViewController () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *cityTableView;

@property (nonatomic, strong) NSArray<ProvinceInfo *> *provinces;

@end

@implementation CitySelectionViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    [self getCityList];
}

- (void)initUI {
    self.cityTableView.tableFooterView = [UIView new];
}

- (void)getCityList {
    [WebClient get:URL_GET_CITY_WEATHER_INFO
        parameters:nil
           success:^(NSURLSessionDataTask * _Nonnull task, id _Nullable json) {
        if (json) {
            NSMutableArray *tmp = [[NSMutableArray alloc] init];
            NSArray *provinceDics = json[@"list"];
            for (NSDictionary *dic in provinceDics) {
                ProvinceInfo *province = [[ProvinceInfo alloc] initWithDic:dic];
                [tmp addObject:province];
            }
            [tmp sortUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
                return [[self firstCharactorWithString:((ProvinceInfo *)obj1).name] compare:[self firstCharactorWithString:((ProvinceInfo *)obj2).name]];
            }];
            self.provinces = [tmp copy];
            [self.cityTableView reloadData];
        }
    }
           failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self showNetworkFailAlert];
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (self.provinces) {
        return self.provinces.count;
    }
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.provinces) {
        return self.provinces[section].citys.count;
    }
    return 0;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (self.provinces) {
        return self.provinces[section].name;
    }
    return @"";
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    cell.textLabel.text = self.provinces[indexPath.section].citys[indexPath.row].name;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.citySelectHandler) {
        ProvinceInfo *province = self.provinces[indexPath.section];
        self.citySelectHandler(province.citys[indexPath.row]);
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)cancelButtonTouched:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (NSString *)firstCharactorWithString:(NSString *)string {
    NSMutableString *str = [NSMutableString stringWithString:string];
    CFStringTransform((CFMutableStringRef) str, NULL, kCFStringTransformMandarinLatin, NO);
    CFStringTransform((CFMutableStringRef)str, NULL, kCFStringTransformStripDiacritics, NO);
    NSString *pinYin = [str capitalizedString];
    return [pinYin substringToIndex:1];
}

@end
