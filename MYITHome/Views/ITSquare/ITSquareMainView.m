//
//  ITSquareMainView.m
//  MYITHome
//
//  Created by 张万平 on 16/2/25.
//  Copyright © 2016年 iwpz. All rights reserved.
//

#import "ITSquareMainView.h"
#import "ITSquareTableView.h"
#import "PagingView.h"
#import "ITSquareTablesScrollView.h"
@interface ITSquareMainView()<PagingViewDelegate>
@property (nonatomic, strong) PagingView *pagingView;
@property (nonatomic, strong) ITSquareTablesScrollView *scrollView;
@end
@implementation ITSquareMainView

- (instancetype)initWithFrame:(CGRect)frame details:(NSInteger)detailsID
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setPagingView];
        _initFlag = NO;
        if (detailsID == 0) {
            [self setViewsWithDetailsID:detailsID];
        }
    }
    return self;
}

- (void)setPagingView{
    _pagingView = [[PagingView alloc]init];
    [_pagingView setDelegate:self];
    [self addSubview:_pagingView];
}

- (void)btnClicked:(UIButton *)button{
    [_scrollView setContentOffset:CGPointMake((button.tag-100)*self.size_Width, 0)];
}
- (void)setViewsWithDetailsID:(NSInteger)detailsID{
    _initFlag = YES;
    _scrollView = [[ITSquareTablesScrollView alloc]initWithFrame:CGRectMake(0, 0, self.size_Width, self.size_Height) detailsID:detailsID];
    
    [self insertSubview:_scrollView belowSubview:_pagingView];
}

@end
