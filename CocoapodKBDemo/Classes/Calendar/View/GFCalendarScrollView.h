//
//  GFCalendarScrollView.h
//
//  Created by Mercy on 2016/11/9.
//  Copyright © 2016年 Mercy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GFCalendarCell.h"

typedef void (^DidSelectDayHandler)(NSInteger, NSInteger, NSInteger);

@interface GFCalendarScrollView : UIScrollView


@property (nonatomic, copy) DidSelectDayHandler didSelectDayHandler; // 日期点击回调
@property (nonatomic, strong) NSDate *currentMonthDate;
/**
 标记被选择的cell
 */
@property (nonatomic, strong) GFCalendarCell *selectedCell;

- (void)refreshToCurrentMonth; // 刷新 calendar 回到当前日期月份

- (void)scrollerToLastMounth;
- (void)scrollerToNextMounth;
@end
