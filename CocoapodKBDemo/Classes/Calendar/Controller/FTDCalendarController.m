//
//  FTDCalendarController.m
//  FenqiTeamDemo
//
//  Created by renren on 16/11/30.
//  Copyright © 2016年 Liuhuan. All rights reserved.
//

#import "FTDCalendarController.h"
#import "GFCalendar.h"
#import "FTDCalendarViewModel.h"
#import "MJExtension.h"
#import "FTDCalendarModel.h"

@interface FTDCalendarController ()<FTDCalendarVMDelegate>

@property (nonatomic, strong) FTDCalendarViewModel *viewModel;
@property (nonatomic, strong) GFCalendarView *calendar;

@property (nonatomic, copy) void(^blockAction)();

@end

@implementation FTDCalendarController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.title = @"日历";
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.viewModel requestData];
    [self setupCalendar]; //  配置 Calendar
    
//    self.blockAction = ^{
////        [self setupCalendar];
//    };
//
    
}

- (GFCalendarView *)setupCalendar {
    
    CGFloat width = self.view.bounds.size.width - 70.0;
    
    GFCalendarView *calendar = [[GFCalendarView alloc] initWithFrameWidth:width];
    self.calendar = calendar;
    
    // 点击某一天的回调
    calendar.didSelectDayHandler = ^(NSInteger year, NSInteger month, NSInteger day) {
        
        //        PushedViewController *pvc = [[PushedViewController alloc] init];
        //        pvc.title = [NSString stringWithFormat:@"%ld年%ld月%ld日", year, month, day];
        //        [self.navigationController pushViewController:pvc animated:YES];
        NSLog(@"----------- %@", [NSString stringWithFormat:@"%ld年%ld月%ld日", year, month, day]);
        
        [self.viewModel updateModel];
    };
    
    [[UIApplication sharedApplication].keyWindow addSubview:calendar];
    [self printStack];
    
    return calendar;
}

- (void)printStack {
    NSArray *syms = [NSThread callStackSymbols];
    if ([syms count] > 1) {
        NSLog(@"<%@ %p> %@ - caller: %@ ", [self class], self, NSStringFromSelector(_cmd),[syms objectAtIndex:1]);
    } else {
         NSLog(@"<%@ %p> %@", [self class], self, NSStringFromSelector(_cmd));
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - FTDCalendarVMDelegate
- (void)updateUI:(FTDCalendarModel *)model {
    NSLog(@"model = %@", [model mj_keyValues]);
    [self.calendar removeFromSuperview];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.navigationController popViewControllerAnimated:YES];
    });
}

#pragma mark - getter
- (FTDCalendarViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[FTDCalendarViewModel alloc] init];
        _viewModel.delegate = self;
    }
    
    return _viewModel;
}

@end
