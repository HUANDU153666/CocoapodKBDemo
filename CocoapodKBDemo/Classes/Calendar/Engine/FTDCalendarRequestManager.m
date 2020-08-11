//
//  FTDCalendarRequestManager.m
//  FenqiTeamDemo
//
//  Created by Liuhuan on 2020/7/15.
//  Copyright © 2020 Liuhuan. All rights reserved.
//

#import "FTDCalendarRequestManager.h"
#import "FTDCalendarModel.h"
#import "MJExtension.h"

#define APP_VERSION [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];

@implementation FTDCalendarRequestManager

+ (void)requestData:(void(^)(FTDCalendarModel *model))completionBlock {
    YTKNetworkConfig *config = [YTKNetworkConfig sharedConfig];
    config.baseUrl = @"https://www.wanandroid.com";
    
    FTDCalendarRuquest *request = [[FTDCalendarRuquest alloc] init];
    [request startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        NSLog(@"response = %@", request.responseJSONObject);
        NSArray *array = [FTDCalendarModel mj_objectArrayWithKeyValuesArray:request.responseJSONObject[@"data"]];
        if (completionBlock && array.count > 0) {
            completionBlock(array[0]);
        }
        
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        NSLog(@"failed = %@", request.responseJSONObject);
    }];
}

@end



@implementation FTDCalendarRuquest

- (NSString *)requestUrl {
    return @"/banner/json";
}

@end
