//
//  FTDCalendarRequestManager.h
//  FenqiTeamDemo
//
//  Created by Liuhuan on 2020/7/15.
//  Copyright © 2020 Liuhuan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YTKNetwork.h"

@class FTDCalendarModel;

NS_ASSUME_NONNULL_BEGIN

@interface FTDCalendarRequestManager : NSObject

+ (void)requestData:(void(^)(FTDCalendarModel *model))completionBlock;

@end


@interface FTDCalendarRuquest : YTKBaseRequest

@end

NS_ASSUME_NONNULL_END
