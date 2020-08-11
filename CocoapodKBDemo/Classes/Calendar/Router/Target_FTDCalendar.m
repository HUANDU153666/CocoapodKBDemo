//
//  Target_FTDCalendar.m
//  FenqiTeamDemo
//
//  Created by Liuhuan on 2020/7/19.
//  Copyright © 2020 Liuhuan. All rights reserved.
//

#import "Target_FTDCalendar.h"
#import "FTDCalendarController.h"

@implementation Target_FTDCalendar

- (UIViewController *)Action_calendarViewController:(NSDictionary *)params {
    NSString *contentText = params[@"contentText"];
    
    FTDCalendarController *calendarVC = [[FTDCalendarController alloc] init];
    calendarVC.title = contentText ? contentText : @"日历";
    return calendarVC;
}

@end
