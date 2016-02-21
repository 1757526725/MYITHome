//
//  MainTableViewCell.m
//  MYITHome
//
//  Created by 张万平 on 16/2/22.
//  Copyright © 2016年 iwpz. All rights reserved.
//

#import "MainTableViewCell.h"
@implementation MainTableViewCell

- (void)setViewsWithModel:(MainTableViewCellModel *)model{
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, self.size_Width/4-5, 60)];
    [imageView sd_setImageWithURL:[NSURL URLWithString:model.image]];
    [self addSubview:imageView];
    UILabel *cellLabel = [[UILabel alloc]initWithFrame:CGRectMake(imageView.size_X_Width+10, 10, self.size_Width-imageView.size_Width-10, 40)];
    [cellLabel setNumberOfLines:2];
    [cellLabel setText:model.title];
    [cellLabel setTextAlignment:NSTextAlignmentLeft];
    [cellLabel setFont:[UIFont systemFontOfSize:15]];
    [self addSubview:cellLabel];
}
@end
