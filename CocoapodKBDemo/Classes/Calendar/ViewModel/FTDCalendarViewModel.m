//
//  FTDCalendarViewModel.m
//  FenqiTeamDemo
//
//  Created by Liuhuan on 2020/7/15.
//  Copyright © 2020 Liuhuan. All rights reserved.
//

#import "FTDCalendarViewModel.h"
#import "FTDCalendarRequestManager.h"
#import "FTDCalendarModel.h"

@interface FTDCalendarViewModel ()

@property (nonatomic, strong) FTDCalendarModel *model;
@property (nonatomic, strong) FTDCalendarModel *modelB;

@end

@implementation FTDCalendarViewModel

- (instancetype)init {
    if (self = [super init]) {
//        [self.model addObserver:self forKeyPath:@"title" options:NSKeyValueObservingOptionNew context:nil];
    }
    
    return self;
}

- (void)requestData {
    __weak typeof(self) weakSelf = self;
    [FTDCalendarRequestManager requestData:^(FTDCalendarModel * _Nonnull model) {
        __strong typeof(self) strongSelf = weakSelf;
        strongSelf.model = model;
        strongSelf.modelB = model;
        [self.model addObserver:self forKeyPath:@"title" options:NSKeyValueObservingOptionNew context:nil];
//        [self.model addObserver:self forKeyPath:@"title" options:NSKeyValueObservingOptionNew context:nil];
    }];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"title"]) {
        if ([self.delegate respondsToSelector:@selector(updateUI:)]) {
            [self.delegate updateUI:(FTDCalendarModel *)object];
        }
    }
}

- (void)updateModel {
    self.model.title = @"kaka";
    self.modelB.title = @"xixi";
}

- (void)dealloc {
    [self.model removeObserver:self forKeyPath:@"title"];
}

@end
