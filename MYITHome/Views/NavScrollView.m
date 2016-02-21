//
//  NavScrollView.m
//  MYITHome
//
//  Created by 张万平 on 16/2/22.
//  Copyright © 2016年 iwpz. All rights reserved.
//

#import "NavScrollView.h"
@interface NavScrollView() <UIScrollViewDelegate>
@property (nonatomic, strong) NSMutableArray *dataArr;
@end
@implementation NavScrollView

- (instancetype)initWithFrame:(CGRect)frame data:(NSMutableArray *)dataArr
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setDelegate:self];
        _dataArr = dataArr;
        [self setFrame:frame];
        [self setView];
        [self setButtons];
    }
    return self;
}

/**
 *  配置按钮
 */
- (void)setButtons{
    CGFloat currentX = 20;
    for (NSInteger i = 0; i < _dataArr.count; i++) {
        UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(currentX, 0, [self widthOfString:[_dataArr[i] objectForKey:@"n"]]*2, 40)];
        [button setBackgroundColor:[UIColor clearColor]];
        [button setTitle:[_dataArr[i] objectForKey:@"n"] forState:UIControlStateNormal];
        [button setTitleColor:ColorWithRGB(222, 174, 175, 1) forState:UIControlStateNormal];
        [self addSubview:button];
        currentX += [self widthOfString:[_dataArr[i] objectForKey:@"n"]]*2+20;
        [button setTag:i+100];
        [button addTarget:self action:@selector(navBarButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
}

/**
 *  按钮点击事件,由InfomationViewController执行
 *
 *  @param button 所点击的按钮
 */
- (void)navBarButtonClicked:(UIButton *)button{
    if (_tBlock) {
        _tBlock(button.tag-100);
    }
}

/**
 *  根据文本计算数据需要的Size
 *
 *  @param dataArray 数据
 *
 *  @return 计算后的大小
 */
- (CGSize)sizeOfDatas:(NSMutableArray *)dataArray{
    NSDictionary *attributesDic = @{NSFontAttributeName:[UIFont systemFontOfSize:9]};
    __block CGFloat width = 0;
    CGFloat height = [[dataArray[0] objectForKey:@"n"] boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributesDic context:nil].size.height*2;
    [dataArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        width += [[dataArray[idx] objectForKey:@"n"] boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributesDic context:nil].size.width*3+10;
    }];
    return CGSizeMake(width, height);
}

/**
 *  单独计算字符串需要的宽度
 *
 *  @param string 文本
 *
 *  @return 宽度
 */
- (CGFloat)widthOfString:(NSString *)string{
    return [string boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:9]} context:nil].size.width;
}

/**
 *  配置视图
 */
- (void)setView{
    [self setBackgroundColor:[UIColor clearColor]];
    [self setContentSize:[self sizeOfDatas:_dataArr]];
    [self setPagingEnabled:NO];
    [self setBounces:NO];
    [self setShowsVerticalScrollIndicator:NO];
    [self setShowsHorizontalScrollIndicator:NO];
}
@end
