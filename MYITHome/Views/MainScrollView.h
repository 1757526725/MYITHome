//
//  MainScrollView.h
//  MYITHome
//
//  Created by 张万平 on 16/2/22.
//  Copyright © 2016年 iwpz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainScrollView : UIScrollView
@property (nonatomic, strong) void (^tBlock)(CGFloat);
- (instancetype)initWithFrame:(CGRect)frame pages:(NSMutableArray *)pagesArray;
- (void)setCurrentPage:(CGFloat)currentPage;
@end
