//
//  InfoMainView.h
//  MYITHome
//
//  Created by 张万平 on 16/2/22.
//  Copyright © 2016年 iwpz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InfoMainView : UIScrollView
@property (nonatomic) BOOL initFlag;
- (instancetype)initWithFrame:(CGRect)frame details:(NSInteger)detailsID;
- (void)setViewsWithDetailsID:(NSInteger)detailsID;
@end
