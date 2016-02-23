//
//  MainTableViewCell.m
//  MYITHome
//
//  Created by 张万平 on 16/2/22.
//  Copyright © 2016年 iwpz. All rights reserved.
//

#import "MainTableViewCell.h"
@implementation MainTableViewCell

//cell小,直接add图片和文字了
- (void)setViewsWithModel:(MainTableViewCellModel *)model{
    [self setSelectionStyle:UITableViewCellSelectionStyleNone];
    _model = model;
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, self.size_Width/4-5, 60)];
    [imageView sd_setImageWithURL:[NSURL URLWithString:model.image]];
    [self addSubview:imageView];
    UILabel *cellLabel = [[UILabel alloc]initWithFrame:CGRectMake(imageView.size_X_Width+10, 10, self.size_Width-imageView.size_Width-10, 40)];
    [cellLabel setNumberOfLines:2];
    [cellLabel setText:model.title];
    [cellLabel setTextAlignment:NSTextAlignmentLeft];
    [cellLabel setFont:[UIFont systemFontOfSize:15]];
    [self addSubview:cellLabel];
    UILabel *cellTimeLabel = [[UILabel alloc]initWithFrame:CGRectMake(imageView.size_X_Width+10, 10+cellLabel.size_Y_Height, 30, 10)];
    [cellTimeLabel setText:[[model.postdate substringFromIndex:10] substringToIndex:5]];
    [cellTimeLabel setFont:[UIFont systemFontOfSize:9]];
    [cellTimeLabel setTextColor:ColorWithRGB(170, 170, 170, 1)];
    [self addSubview:cellTimeLabel];
    UIImageView *commentCountIcon = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"iPadTable_SP_Cell_CommentCount_night"]];
    [commentCountIcon setFrame:CGRectMake(self.size_Width, 6+cellLabel.size_Y_Height, 15, 11)];
    [self addSubview:commentCountIcon];
    UILabel *commentCountLabel = [[UILabel alloc]initWithFrame:CGRectMake(commentCountIcon.size_X_Width+4, commentCountIcon.size_Y, 40, 10)];
    [commentCountLabel setText:model.commentcount];
    [commentCountLabel setFont:[UIFont systemFontOfSize:9]];
    [commentCountLabel setTextColor:ColorWithRGB(170, 170, 170, 1)];
    [self addSubview:commentCountLabel];
}
@end
