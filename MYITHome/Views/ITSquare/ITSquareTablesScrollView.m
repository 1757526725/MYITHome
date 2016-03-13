//
//  ITSquareTablesScrollView.m
//  MYITHome
//
//  Created by 张万平 on 16/2/25.
//  Copyright © 2016年 iwpz. All rights reserved.
//

#import "ITSquareTablesScrollView.h"
#import "ITSquareTableView.h"
@interface ITSquareTablesScrollView()<UIScrollViewDelegate>
@end
@implementation ITSquareTablesScrollView

- (instancetype)initWithFrame:(CGRect)frame detailsID:(NSInteger)detailsID
{
    self = [super initWithFrame:frame];
    if (self) {
        _detailsID = detailsID;
        [self setBackgroundColor:[UIColor whiteColor]];
        [self setContentSize:CGSizeMake(self.size_Width * 3, self.size_Height)];
        [self setScrollEnabled:NO];
        [self setShowsVerticalScrollIndicator:NO];
        [self setShowsHorizontalScrollIndicator:NO];
        [self setTables];
    }
    return self;
}

- (void)setTables{
    for (NSInteger i = 0; i < 3; i++) {
        ITSquareTableView *tableView = [[ITSquareTableView alloc]initWithFrame:CGRectMake(self.size_Width*i, 0, self.size_Width, self.size_Height) detailsID:_detailsID typeID:i*2%3];
        [tableView setBackgroundColor:[UIColor whiteColor]];
        [self addSubview:tableView];
    }
}

@end
