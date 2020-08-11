//
//  CTMediator+FTDCalendar.m
//  FenqiTeamDemo
//
//  Created by Liuhuan on 2020/7/19.
//  Copyright © 2020 Liuhuan. All rights reserved.
//

#import "CTMediator+FTDCalendar.h"

@implementation CTMediator (FTDCalendar)

- (UIViewController *)FTDCalendarViewControllerWithContentText:(NSString *)contentText {
    NSDictionary *params = @{@"contentText": contentText};
    return [self performTarget:@"FTDCalendar" action:@"calendarViewController" params:params shouldCacheTarget:NO];
}

@end
