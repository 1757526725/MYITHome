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
#import "ITSquareMainView.h"
@interface MainScrollView() <UIScrollViewDelegate>
@property (nonatomic, strong) NSArray *pagesArray;
@end
@implementation MainScrollView
- (instancetype)initWithFrame:(CGRect)frame pages:(NSMutableArray *)pagesArray isInfo:(BOOL)isInfo
{
    self = [super initWithFrame:frame];
    if (self) {
        self.frame = frame;
        [self setDelegate:self];
        _pagesArray = pagesArray;
        _isInfo = isInfo;
        [self setViewsWithPageCount:pagesArray.count];
        [self setPageViews:pagesArray];
    }
    return self;
}

- (void)setCurrentPage:(CGFloat)currentPage{
    [self setContentOffset:CGPointMake(currentPage * self.size_Width, 0)];
}

- (void)setPageViews:(NSMutableArray *)pagesArray{
    if (_isInfo){
        for (NSInteger i = 0; i < pagesArray.count; i++) {
            NSDictionary *dic = pagesArray[i];
            InfoMainView *infoMainView = [[InfoMainView alloc]initWithFrame:CGRectMake(i*self.size_Width, 0, self.size_Width, self.size_Height) details:[[dic objectForKey:@"id"] intValue]];
            [infoMainView setTag:i+200];
            [self addSubview:infoMainView];
        }
    }
    else{
        for (NSInteger i = 0; i<pagesArray.count; i++) {
            NSDictionary *dic = pagesArray[i];
            ITSquareMainView *itSquareMainView = [[ITSquareMainView alloc]initWithFrame:CGRectMake(i*self.size_Width, 0, self.size_Width, self.size_Height) details:[[dic objectForKey:@"id"] intValue]];
            [itSquareMainView setTag:i+200];
            [self addSubview:itSquareMainView];
        }
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    _tBlock(scrollView.contentOffset.x/self.size_Width);
    NSInteger currentPage = scrollView.contentOffset.x/self.size_Width;
    if (_isInfo){
    InfoMainView *infoview = [self viewWithTag:currentPage+200];
        if (currentPage && !infoview.initFlag) {
            [infoview setViewsWithDetailsID:currentPage];
            [infoview setInitFlag:YES];
        }
    }
    else{
        ITSquareMainView *itSquareView = [self viewWithTag:currentPage + 200];
        if (currentPage && !itSquareView.initFlag) {
            NSDictionary *dic = _pagesArray[currentPage];
            [itSquareView setViewsWithDetailsID:[[dic objectForKey:@"id"] intValue]];
            [itSquareView setInitFlag:YES];
        }
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
