//
//  MainScrollView.m
//  MYITHome
//
//  Created by 张万平 on 16/2/22.
//  Copyright © 2016年 iwpz. All rights reserved.
//

#import "MainScrollView.h"
#import "InfoMainView.h"
#import "BannerView.h"
@interface MainScrollView() <UIScrollViewDelegate>
@end
@implementation MainScrollView
- (instancetype)initWithFrame:(CGRect)frame pages:(NSMutableArray *)pagesArray
{
    self = [super initWithFrame:frame];
    if (self) {
        self.frame = frame;
        [self setDelegate:self];
        [self setViewsWithPageCount:pagesArray.count];
        [self setPageViews:pagesArray];
    }
    return self;
}

- (void)setCurrentPage:(CGFloat)currentPage{
    [self setContentOffset:CGPointMake(currentPage * self.size_Width, 0)];
}

- (void)setPageViews:(NSMutableArray *)pagesArray{
    for (NSInteger i = 0; i < pagesArray.count; i++) {
        InfoMainView *infoMainView = [[InfoMainView alloc]initWithFrame:CGRectMake(i*self.size_Width, 0, self.size_Width, self.size_Height) details:i];
        [infoMainView setTag:i+200];
        [self addSubview:infoMainView];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    _tBlock(scrollView.contentOffset.x/self.size_Width);
    NSInteger currentPage = scrollView.contentOffset.x/self.size_Width;
    InfoMainView *infoview = [self viewWithTag:currentPage+200];
    if (currentPage && !infoview.initFlag) {
        [infoview setViewsWithDetailsID:currentPage];
        [infoview setInitFlag:YES];
    }
}

- (void)setViewsWithPageCount:(NSInteger)pageCount{
    [self setContentSize:CGSizeMake(self.size_Width*pageCount, 0)];
    [self setPagingEnabled:YES];
    [self setShowsHorizontalScrollIndicator:YES];
    [self setBackgroundColor:[UIColor whiteColor]];
    [self setShowsHorizontalScrollIndicator:NO];
    [self setShowsVerticalScrollIndicator:NO];
    
}
@end
