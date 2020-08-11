//
//  FTDCalendarModel.m
//  FenqiTeamDemo
//
//  Created by Liuhuan on 2020/7/15.
//  Copyright © 2020 Liuhuan. All rights reserved.
//

#import "FTDCalendarModel.h"
#import "MJExtension.h"

@implementation FTDCalendarModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{@"bannerId": @"id"};
}

@end
