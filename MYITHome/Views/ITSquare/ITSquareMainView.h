//
//  ITSquareMainView.h
//  MYITHome
//
//  Created by 张万平 on 16/2/25.
//  Copyright © 2016年 iwpz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ITSquareMainView : UIView
@property (nonatomic) BOOL initFlag;
- (instancetype)initWithFrame:(CGRect)frame details:(NSInteger)detailsID;
- (void)setViewsWithDetailsID:(NSInteger)detailsID;
@end
