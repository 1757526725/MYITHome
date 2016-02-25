//
//  ITSquareTableViewCell.m
//  MYITHome
//
//  Created by 张万平 on 16/2/26.
//  Copyright © 2016年 iwpz. All rights reserved.
//

#import "ITSquareTableViewCell.h"

@implementation ITSquareTableViewCell
/*
    头像:http://avatar.ithome.com/avatars/00X/XX/XX/XX_60.jpg
                                            X为model.uid,不够前面补0
    没有头像的是http://quan.ithome.com/statics/images/noavatar.png
 
 model格式:
 "id": 21674,
 "t": "IT圈解答组成立公告",
 "c": "[置顶]",
 "cn": "科技畅谈",
 "uid": 1100238,
 "un": "赖先生",
 "rn": "赖先生",
 "pt": "/Date(1452347154387)/",
 "rt": "/Date(1456402735667)/",
 "vc": 8902,
 "rc": 336
 */
- (void)setViewsWithModel:(ITSquareTableViewModel *)model{
    UIImageView *avatrImageView = [[UIImageView alloc]initWithFrame:CGRectMake(20, 20, 30, 30)];
    [avatrImageView setBackgroundColor:[UIColor redColor]];
    [avatrImageView.layer setCornerRadius:15];
    [self addSubview:avatrImageView];
    
    UILabel *typeLabel = [[UILabel alloc]initWithFrame:CGRectMake(avatrImageView.size_X_Width+20, avatrImageView.size_Y, 40, 15)];
    [typeLabel setText:model.c];
    [typeLabel setFont:[UIFont systemFontOfSize:14]];
    [self addSubview:typeLabel];
    
    UILabel *titleLabel = [[UILabel alloc] init];
    CGSize stringSize = [model.t boundingRectWithSize:CGSizeMake(self.size_Width-typeLabel.size_Width-20-20-2,MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{ NSFontAttributeName : [UIFont systemFontOfSize:14] } context:nil].size;
    CGRect theFrame =CGRectMake(typeLabel.size_X_Width+2, typeLabel.size_Y, self.size_Width-typeLabel.size_Width-20-20-2, stringSize.height);
    [titleLabel setFrame:theFrame];
    [titleLabel setText:model.t];
    [titleLabel setTextAlignment:NSTextAlignmentLeft];
    [titleLabel setNumberOfLines:0];
    [titleLabel setFont:[UIFont systemFontOfSize:14]];
    [self addSubview:titleLabel];
}
@end
