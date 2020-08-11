//
//  CTMediator+FTDCalendar.h
//  FenqiTeamDemo
//
//  Created by Liuhuan on 2020/7/19.
//  Copyright © 2020 Liuhuan. All rights reserved.
//

#import "CTMediator.h"
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CTMediator (FTDCalendar)

- (UIViewController *)FTDCalendarViewControllerWithContentText:(NSString *)contentText;

@end

NS_ASSUME_NONNULL_END
