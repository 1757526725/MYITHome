//
//  ITSquareTablesScrollView.h
//  MYITHome
//
//  Created by 张万平 on 16/2/25.
//  Copyright © 2016年 iwpz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ITSquareTablesScrollView : UIScrollView
@property (nonatomic) NSInteger detailsID;
- (instancetype)initWithFrame:(CGRect)frame detailsID:(NSInteger)detailsID;
@end
