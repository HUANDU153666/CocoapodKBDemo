//
//  FTDCalendarViewModel.h
//  FenqiTeamDemo
//
//  Created by Liuhuan on 2020/7/15.
//  Copyright © 2020 Liuhuan. All rights reserved.
//

#import <Foundation/Foundation.h>

@class FTDCalendarModel;

NS_ASSUME_NONNULL_BEGIN

@protocol FTDCalendarVMDelegate <NSObject>

@required
- (void)updateUI:(FTDCalendarModel *)model;

@end

@interface FTDCalendarViewModel : NSObject

@property (nonatomic, weak) id<FTDCalendarVMDelegate>delegate;

- (void)requestData;
- (void)updateModel;

@end

NS_ASSUME_NONNULL_END
