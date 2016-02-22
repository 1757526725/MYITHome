//
//  ArticleViewController.h
//  MYITHome
//
//  Created by 张万平 on 16/2/22.
//  Copyright © 2016年 iwpz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainTableViewCellModel.h"
@interface ArticleViewController : UIViewController
@property (nonatomic, strong) MainTableViewCellModel *model;
- (instancetype)initWithModel:(MainTableViewCellModel *)model;
@end
