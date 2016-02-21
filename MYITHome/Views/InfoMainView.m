//
//  InfoMainView.m
//  MYITHome
//
//  Created by 张万平 on 16/2/22.
//  Copyright © 2016年 iwpz. All rights reserved.
//

#import "InfoMainView.h"
#import "MainTableView.h"

@interface InfoMainView()

@end
@implementation InfoMainView
/**
 *  init函数
 *
 *  @param frame     Frame
 *  @param detailsID 内容ID
 *  @param viewType  视图类型
 *
 *  @return self
 */
- (instancetype)initWithFrame:(CGRect)frame details:(NSInteger)detailsID
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setViewsWithDetailsID:detailsID];
    }
    return self;
}

- (void)setViewsWithDetailsID:(NSInteger)detailsID{
    MainTableView *mainTable = [[MainTableView alloc]initWithFrame:CGRectMake(0, 0, self.size_Width, self.size_Height) detailsID:detailsID];
    [mainTable setBackgroundColor:ColorWithRGB(210, 34, 34, 1)];
    [self addSubview:mainTable];
}
@end
