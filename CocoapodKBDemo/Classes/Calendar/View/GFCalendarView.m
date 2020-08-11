//
//  GFCalendarView.m
//
//  Created by Mercy on 2016/11/9.
//  Copyright © 2016年 Mercy. All rights reserved.
//

#import "GFCalendarView.h"
#import "GFCalendarScrollView.h"
#import "NSDate+GFCalendar.h"

#define NAVIGATIONBAR_COLOR UIColorFromRGB(0x55a9de) // 顶部导航颜色
#define BTN_GREEN_COLOR UIColorFromRGB(0x87c537) //绿色
#define UIColorFromRGB(rgbValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@interface GFCalendarView()
/**
 calendarView
 */
@property (nonatomic, strong) UIView *calendarView;
/**
 顶部titleView
 */
@property (nonatomic, strong) UIView *topView;
/**
 上一个月按钮
 */
@property (nonatomic, strong) UIButton *lastMounthBtn;
/**
 下一个月按钮
 */
@property (nonatomic, strong) UIButton *nextMounthBtn;
@property (nonatomic, strong) UIButton *calendarHeaderButton;
@property (nonatomic, strong) UIView *weekHeaderView;
@property (nonatomic, strong) GFCalendarScrollView *calendarScrollView;
@property (nonatomic, assign) CGFloat width;

/**
 底部bottomView
 */
@property (nonatomic, strong) UIView *bottomView;

@end

//#define kCalendarBasicColor [UIColor colorWithRed:231.0 / 255.0 green:85.0 / 255.0 blue:85.0 / 255.0 alpha:1.0]
//#define kCalendarBasicColor [UIColor colorWithRed:252.0 / 255.0 green:60.0 / 255.0 blue:60.0 / 255.0 alpha:1.0]
//#define TITLE_COLOR [UIColor greenColor]


@implementation GFCalendarView


#pragma mark - Initialization

- (instancetype)initWithFrameWidth:(CGFloat)width {
    
    // 根据宽度计算 calender 主体部分的高度
    CGFloat weekLineHight = 0.85 * (width / 7.0);
    CGFloat monthHeight = 6 * weekLineHight;
    //  topView高度
    CGFloat topViewHeight = 30;
    // 星期头部栏高度
    CGFloat weekHeaderHeight = 0.6 * weekLineHight;
    
    // calendar 头部栏高度
    CGFloat calendarHeaderHeight = 1.5 * weekLineHight;
    
    // bottomView 高度
    CGFloat bottomViewHeight = 60;
    // 最后得到整个 calender 控件的高度
    _calendarHeight = calendarHeaderHeight + weekHeaderHeight + monthHeight + bottomViewHeight + topViewHeight;
    
    if (self = [super initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)]) {
        
//        self.layer.masksToBounds = YES;
//        self.layer.borderColor = kCalendarBasicColor.CGColor;
//        self.layer.borderWidth = 2.0 / [UIScreen mainScreen].scale;
//        self.layer.cornerRadius = 0.0;
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
        self.width = width;
        
        self.calendarView = [[UIView alloc] initWithFrame:CGRectMake(([UIScreen mainScreen].bounds.size.width - width) / 2, ([UIScreen mainScreen].bounds.size.height - _calendarHeight) / 2, width, _calendarHeight)];
        self.calendarView.backgroundColor = [UIColor whiteColor];
        
        _calendarHeaderButton = [self setupCalendarHeaderButtonWithFrame:CGRectMake(width / 3, topViewHeight, width / 3, calendarHeaderHeight)];
        _weekHeaderView = [self setupWeekHeadViewWithFrame:CGRectMake(0.0, calendarHeaderHeight + topViewHeight, width, weekHeaderHeight)];
        _calendarScrollView = [self setupCalendarScrollViewWithFrame:CGRectMake(0.0, calendarHeaderHeight + weekHeaderHeight + topViewHeight, width, monthHeight)];
        
        [self addSubview:self.calendarView];
        [self.calendarView addSubview:self.topView];
        [self.calendarView addSubview:self.lastMounthBtn];
        [self.calendarView addSubview:_calendarHeaderButton];
        [self.calendarView addSubview:self.nextMounthBtn];
        [self.calendarView addSubview:_weekHeaderView];
        [self.calendarView addSubview:_calendarScrollView];
        [self.calendarView addSubview:self.bottomView];
        
        // 注册 Notification 监听
        [self addNotificationObserver];
        
    }
    
    return self;
    
}

- (void)dealloc {
    // 移除监听
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (UIButton *)setupCalendarHeaderButtonWithFrame:(CGRect)frame {
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = frame;
//    button.backgroundColor = NAVIGATIONBAR_COLOR;
    [button setTitleColor:NAVIGATIONBAR_COLOR forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:15.0];
    [button addTarget:self action:@selector(refreshToCurrentMonthAction:) forControlEvents:UIControlEventTouchUpInside];
    
    return button;
}

- (UIView *)setupWeekHeadViewWithFrame:(CGRect)frame {
    
    CGFloat height = frame.size.height;
    CGFloat width = frame.size.width / 7.0;
    
    UIView *view = [[UIView alloc] initWithFrame:frame];
//    view.backgroundColor = kCalendarBasicColor;
    
    NSArray *weekArray = @[@"日", @"一", @"二", @"三", @"四", @"五", @"六"];
    for (int i = 0; i < 7; ++i) {
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(i * width, 0.0, width, height)];
        label.backgroundColor = [UIColor clearColor];
        label.text = weekArray[i];
        label.textColor = [UIColor blackColor];
        label.font = [UIFont systemFontOfSize:13.5];
        label.textAlignment = NSTextAlignmentCenter;
        [view addSubview:label];
        
    }
    
    return view;
    
}
- (UIView *)topView {
    if (_topView == nil) {
        _topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.width, 30)];
        UILabel *titleLbl = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, _topView.bounds.size.width - 10, 30)];
        titleLbl.text = @"请选择预计送回日期";
        titleLbl.font = [UIFont systemFontOfSize:15];
        titleLbl.textColor = [UIColor whiteColor];
        [_topView addSubview:titleLbl];
        _topView.backgroundColor = BTN_GREEN_COLOR;
    }
    return _topView;
}
- (UIButton *)lastMounthBtn {
    if (_lastMounthBtn == nil) {
        _lastMounthBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 30, self.width / 3, self.calendarHeaderButton.bounds.size.height)];
        [_lastMounthBtn setTitle:@"上个月" forState:UIControlStateNormal];
        _lastMounthBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [_lastMounthBtn setTitleColor:NAVIGATIONBAR_COLOR forState:UIControlStateNormal];
        [_lastMounthBtn addTarget:self action:@selector(clickLastMounth) forControlEvents:UIControlEventTouchUpInside];
    }
    return _lastMounthBtn;
}
- (UIButton *)nextMounthBtn {
    if (_nextMounthBtn == nil) {
        _nextMounthBtn = [[UIButton alloc] initWithFrame:CGRectMake(self.width / 3 * 2, 30, self.width / 3, self.calendarHeaderButton.bounds.size.height)];
        [_nextMounthBtn setTitle:@"下个月" forState:UIControlStateNormal];
        _nextMounthBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [_nextMounthBtn setTitleColor:NAVIGATIONBAR_COLOR forState:UIControlStateNormal];
        [_nextMounthBtn addTarget:self action:@selector(clickNextMounth) forControlEvents:UIControlEventTouchUpInside];
    }
    return _nextMounthBtn;
}
- (UIView *)bottomView {
    if (_bottomView == nil) {
        _bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.calendarScrollView.frame), self.width, 60)];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.width, 20)];
        label.text = @"左右滑动切换月份";
        label.font = [UIFont systemFontOfSize:10];
        [_bottomView addSubview:label];
        
        UIButton *cancelBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 25, self.width / 2 - 5, 30)];
        [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        cancelBtn.backgroundColor = [UIColor grayColor];
        [cancelBtn addTarget:self action:@selector(clickCancelBtn) forControlEvents:UIControlEventTouchUpInside];
        
        UIButton *sureBtn = [[UIButton alloc] initWithFrame:CGRectMake(self.width / 2 + 5, 25, self.width / 2 - 5, 30)];
        [sureBtn setTitle:@"确定" forState:UIControlStateNormal];
        sureBtn.backgroundColor = NAVIGATIONBAR_COLOR;
        [sureBtn addTarget:self action:@selector(clickSureBtn) forControlEvents:UIControlEventTouchUpInside];
        [_bottomView addSubview:cancelBtn];
        [_bottomView addSubview:sureBtn];
    }
    return _bottomView;
}
- (GFCalendarScrollView *)setupCalendarScrollViewWithFrame:(CGRect)frame {
    GFCalendarScrollView *scrollView = [[GFCalendarScrollView alloc] initWithFrame:frame];
    return scrollView;
}

- (void)setDidSelectDayHandler:(DidSelectDayHandler)didSelectDayHandler {
    _didSelectDayHandler = didSelectDayHandler;
    if (_calendarScrollView != nil) {
        _calendarScrollView.didSelectDayHandler = _didSelectDayHandler; // 传递 block
    }
}

- (void)addNotificationObserver {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeCalendarHeaderAction:) name:@"ChangeCalendarHeaderNotification" object:nil];
}


#pragma mark - Actions
- (void)clickLastMounth {
    NSLog(@"上个月");
    
    [self.calendarScrollView scrollerToLastMounth];
}
- (void)clickNextMounth {
    NSLog(@"下个月");
    
    [self.calendarScrollView scrollerToNextMounth];
}
- (void)clickCancelBtn {
    NSLog(@"点击取消");
    
    [self removeFromSuperview];
}
- (void)clickSureBtn {
    NSLog(@"点击确定---");
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth) fromDate:self.calendarScrollView.currentMonthDate];
    NSDate *currentDate = [calendar dateFromComponents:components];
    
    GFCalendarCell *cell = self.calendarScrollView.selectedCell;
    
    NSInteger year = [currentDate dateYear];
    NSInteger month = [currentDate dateMonth];
    NSInteger day = [cell.todayLabel.text integerValue];
    
//    NSLog(@"-------------- %@", cell);
    if (day == 0) {
        NSLog(@"请选择日期");
        return;
    }
    if (month == [[NSDate date] dateMonth] && year == [[NSDate date] dateYear] && day < [[NSDate date] dateDay]) {
        
        NSLog(@"请选择有效日期");
        return;
    }
    
    if (self.calendarScrollView.didSelectDayHandler) {
        self.didSelectDayHandler(year, month, day); // 执行回调
    }

    
}
- (void)refreshToCurrentMonthAction:(UIButton *)sender {
    
    NSInteger year = [[NSDate date] dateYear];
    NSInteger month = [[NSDate date] dateMonth];
    
    NSString *title = [NSString stringWithFormat:@"%ld年%ld月", year, month];
    
    [_calendarHeaderButton setTitle:title forState:UIControlStateNormal];
    
    [_calendarScrollView refreshToCurrentMonth];
    
}

- (void)changeCalendarHeaderAction:(NSNotification *)sender {
    
    NSDictionary *dic = sender.userInfo;
    
    NSNumber *year = dic[@"year"];
    NSNumber *month = dic[@"month"];
    
    NSString *title = [NSString stringWithFormat:@"%@年%@月", year, month];
    
    [_calendarHeaderButton setTitle:title forState:UIControlStateNormal];
}

@end
