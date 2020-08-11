//
//  FTDCalendarModel.h
//  FenqiTeamDemo
//
//  Created by Liuhuan on 2020/7/15.
//  Copyright © 2020 Liuhuan. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FTDCalendarModel : NSObject

@property (nonatomic, copy) NSString *desc;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *imagePath;
@property (nonatomic, copy) NSString *url;
@property (nonatomic, copy) NSNumber *bannerId;
@property (nonatomic, copy) NSNumber *isVisible;
@property (nonatomic, copy) NSNumber *type;
@property (nonatomic, copy) NSNumber *order;

@end

NS_ASSUME_NONNULL_END
