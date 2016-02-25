//
//  ITSquareTableViewCell.h
//  MYITHome
//
//  Created by 张万平 on 16/2/26.
//  Copyright © 2016年 iwpz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ITSquareTableViewModel.h"
@interface ITSquareTableViewCell : UITableViewCell
@property (nonatomic ,assign) CGFloat height;
- (void)setViewsWithModel:(ITSquareTableViewModel *)model;
@end
