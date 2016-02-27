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
    _model = model;
    //头像ImageView
    UIImageView *avatrImageView = [[UIImageView alloc]initWithFrame:CGRectMake(20, 20, 30, 30)];
    [avatrImageView setBackgroundColor:[UIColor redColor]];
    [avatrImageView.layer setMasksToBounds:YES];
    [avatrImageView setImage:[UIImage imageNamed:@"noavatar"]];
    [avatrImageView.layer setCornerRadius:15];
    [self addSubview:avatrImageView];
    
    //文章标题Label
    UILabel *titlelabel = [[UILabel alloc]initWithFrame:CGRectMake(avatrImageView.size_X_Width+20, 10, self.size_Width-avatrImageView.size_Width-20, 40)];
    [titlelabel setText:[NSString stringWithFormat:@"%@ %@",model.c,model.t]];
    [titlelabel setTextAlignment:NSTextAlignmentLeft];
    [titlelabel setFont:[UIFont systemFontOfSize:14]];
    [titlelabel setNumberOfLines:2];
    [self addSubview:titlelabel];
    
    //楼主和最新回复Label
    UILabel *authorLabel = [self stringLabel:model.un position:CGPointMake(titlelabel.size_X, titlelabel.size_Y_Height)];
    [self addSubview:authorLabel];
    UILabel *authTimeLabel = [self timeLabel:model.pt position:CGPointMake(authorLabel.size_X_Width + 2, authorLabel.size_Y)];
    [self addSubview:authTimeLabel];
    UILabel *latestReportLabel = [self stringLabel:model.rn position:CGPointMake(authTimeLabel.size_X_Width + 2, authTimeLabel.size_Y)];
    [self addSubview:latestReportLabel];
    UILabel *latestTimeLabel = [self timeLabel:model.rt position:CGPointMake(latestReportLabel.size_X_Width + 2, latestReportLabel.size_Y)];
    [self addSubview:latestTimeLabel];
    
    //右下角分类与点击数回复数
    UILabel *reportsLabel = [self stringLabel:model.cn position:CGPointMake(self.size_Width/2, latestTimeLabel.size_Y_Height + 3)];
    [reportsLabel setFrame:CGRectMake(self.size_Width/2, latestTimeLabel.size_Y_Height, (self.size_Width/2)/3+10, reportsLabel.size_Height)];
    [reportsLabel setTextAlignment:NSTextAlignmentRight];
    [reportsLabel setTextColor:ColorWithRGB(93, 93, 93, 1)];
    [self addSubview:reportsLabel];
    
    UIImageView *viewedImageView = [[UIImageView alloc]initWithFrame:CGRectMake(reportsLabel.size_X_Width + 10, reportsLabel.size_Y+2, 10, reportsLabel.size_Height)];
    [viewedImageView setImage:[UIImage imageNamed:@"forum_renqi"]];
    [self addSubview:viewedImageView];
    
    UILabel *viewedLabel = [[UILabel alloc]initWithFrame:CGRectMake(viewedImageView.size_X_Width + 2, reportsLabel.size_Y+2, 40, 10)];
    [viewedLabel setTextColor:ColorWithRGB(93, 93, 93, 1)];
    NSString *str = [NSString stringWithFormat:@"%@", model.vc];
    [viewedLabel setFont:[UIFont systemFontOfSize:10]];
    [viewedLabel setText:str];
    [self addSubview:viewedLabel];
    UIImageView *reportsImageView = [[UIImageView alloc]initWithFrame:CGRectMake(viewedLabel.size_X_Width, viewedImageView.size_Y, viewedImageView.size_Width, viewedImageView.size_Height)];
    [reportsImageView setImage:[UIImage imageNamed:@"forum_huifushu"]];
    [self addSubview:reportsImageView];
    
    UILabel *reportLabel = [[UILabel alloc]initWithFrame:CGRectMake(reportsImageView.size_X_Width + 2, reportsLabel.size_Y+2, 40, 10)];
    [reportLabel setTextColor:ColorWithRGB(93, 93, 93, 1)];
    [reportLabel setFont:[UIFont systemFontOfSize:10]];
    NSString *str1 = [NSString stringWithFormat:@"%@", model.rc];
    [reportLabel setText:str1];
    [self addSubview:reportLabel];
    
    
}

- (UILabel *)timeLabel:(NSString *)thetime position:(CGPoint)point{
    // thetime = @"/Date(1452347154387)/";
    thetime = [thetime substringWithRange:NSMakeRange(6, 13)];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:[thetime doubleValue] / 1000];
    NSString *timeString = [self prettyDateWithReference:date];
    CGSize stringSize = [timeString boundingRectWithSize:CGSizeMake(MAXFLOAT,MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{ NSFontAttributeName : [UIFont systemFontOfSize:10] } context:nil].size;
    CGRect theFrame =CGRectMake(point.x, point.y , stringSize.width, stringSize.height);
    UILabel *label = [[UILabel alloc]initWithFrame:theFrame];
    [label setText:timeString];
    [label setFont:[UIFont systemFontOfSize:10]];
    [label setTextColor:ColorWithRGB(170, 170, 170, 1)];
    return label;
}

- (UILabel *)stringLabel:(NSString *)userName position:(CGPoint)point{
    CGSize stringSize = [userName boundingRectWithSize:CGSizeMake(MAXFLOAT,MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{ NSFontAttributeName : [UIFont systemFontOfSize:10] } context:nil].size;
    CGRect theFrame =CGRectMake(point.x, point.y , stringSize.width, stringSize.height);
    UILabel *label = [[UILabel alloc]initWithFrame:theFrame];
    [label setText:userName];
    [label setFont:[UIFont systemFontOfSize:10]];
    [label setTextColor:ColorWithRGB(93, 93, 93, 1)];
    return label;
}

/**
 *  计算时间差
 * 来自http://blog.csdn.net/woaifen3344/article/details/44240915
 *  @param reference 要计算的时间
 *
 *  @return 符合条件的字符串
 */
- (NSString *)prettyDateWithReference:(NSDate *)reference {
    NSString *suffix = @"前";
    
    float different = [reference timeIntervalSinceNow];
    if (different < 0) {
        different = -different;
        suffix = @"前";
    }
    
    // days = different / (24 * 60 * 60), take the floor value
    float dayDifferent = floor(different / 86400);
    
    int days   = (int)dayDifferent;
    int weeks  = (int)ceil(dayDifferent / 7);
    int months = (int)ceil(dayDifferent / 30);
    int years  = (int)ceil(dayDifferent / 365);
    
    // It belongs to today
    if (dayDifferent <= 0) {
        // lower than 60 seconds
        if (different < 60) {
            return @"刚刚";
        }
        
        // lower than 120 seconds => one minute and lower than 60 seconds
        if (different < 120) {
            return [NSString stringWithFormat:@"1分钟%@", suffix];
        }
        
        // lower than 60 minutes
        if (different < 60 * 60) {
            return [NSString stringWithFormat:@"%d分钟%@", (int)floor(different / 60), suffix];
        }
        
        // lower than 60 * 2 minutes => one hour and lower than 60 minutes
        if (different < 7200) {
            return [NSString stringWithFormat:@"1小时%@", suffix];
        }
        
        // lower than one day
        if (different < 86400) {
            return [NSString stringWithFormat:@"%d小时%@", (int)floor(different / 3600), suffix];
        }
    }
    // lower than one week
    else if (days < 7) {
        return [NSString stringWithFormat:@"%d天%@", days, suffix];
    }
    // lager than one week but lower than a month
    else if (weeks < 4) {
        return [NSString stringWithFormat:@"%d周%@", weeks, suffix];
    }
    // lager than a month and lower than a year
    else if (months < 12) {
        return [NSString stringWithFormat:@"%d月%@", months, suffix];
    }
    // lager than a year
    else {
        return [NSString stringWithFormat:@"%d年%@", years, suffix];
    }
    
    return self.description;
}

@end
