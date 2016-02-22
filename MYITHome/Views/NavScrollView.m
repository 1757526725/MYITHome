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

//用block传递,控制导航栏和主scrollview联动
- (void)setCurrentPage:(CGFloat)currentPage{
    for (NSInteger i = 0; i < _dataArr.count; i++){
        UIButton *thebtn = [self viewWithTag:i+100];
        if (i + 100 == currentPage+100) {
            [thebtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [thebtn.titleLabel setFont:[UIFont systemFontOfSize:18]];
        }
        else{
            [thebtn.titleLabel setFont:[UIFont systemFontOfSize:16]];
            [thebtn setTitleColor:ColorWithRGB(222, 174, 175, 1) forState:UIControlStateNormal];
        }
    }
    [self setContentOffset:CGPointMake(currentPage * [self widthOfString:@"排行榜"], 0)];
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
        [button.titleLabel setFont:[UIFont systemFontOfSize:16]];
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
    for (NSInteger i = 0; i < _dataArr.count; i++){
        UIButton *thebtn = [self viewWithTag:i+100];
        if (i + 100 == button.tag) {
            [thebtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [thebtn.titleLabel setFont:[UIFont systemFontOfSize:18]];
        }
        else{
            [thebtn.titleLabel setFont:[UIFont systemFontOfSize:16]];
            [thebtn setTitleColor:ColorWithRGB(222, 174, 175, 1) forState:UIControlStateNormal];
        }
    }
    [self setContentOffset:CGPointMake((button.tag-100) * [self widthOfString:@"排行榜"], 0)];

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
    NSDictionary *attributesDic = @{NSFontAttributeName:[UIFont systemFontOfSize:16]};
    __block CGFloat width = 0;
    CGFloat height = [[dataArray[0] objectForKey:@"n"] boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributesDic context:nil].size.height;
    [dataArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        width += [[dataArray[idx] objectForKey:@"n"] boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributesDic context:nil].size.width*2+10;
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
