//
//  NavScrollView.h
//  MYITHome
//
//  Created by 张万平 on 16/2/22.
//  Copyright © 2016年 iwpz. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface NavScrollView : UIScrollView
@property (nonatomic, strong) void (^tBlock)(NSInteger);//导航栏按钮点击事件block
- (instancetype)initWithFrame:(CGRect)frame data:(NSMutableArray *)dataArr;//构建头需要的字典
- (void)setCurrentPage:(CGFloat)currentPage;
@end
