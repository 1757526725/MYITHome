//
//  PagingView.h
//  MYITHome
//
//  Created by 张万平 on 16/2/25.
//  Copyright © 2016年 iwpz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ITSquareMainView.h"
@protocol PagingViewDelegate <NSObject>
- (void)btnClicked:(UIButton *)button;
@end
@interface PagingView : UIView
@property (nonatomic, strong) id<PagingViewDelegate> delegate;
@end
