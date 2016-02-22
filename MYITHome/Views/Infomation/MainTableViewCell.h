//
//  MainTableViewCell.h
//  MYITHome
//
//  Created by 张万平 on 16/2/22.
//  Copyright © 2016年 iwpz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainTableViewCellModel.h"
@interface MainTableViewCell : UITableViewCell
@property (nonatomic, strong) MainTableViewCellModel *model;
- (void)setViewsWithModel:(MainTableViewCellModel *)model;
@end
