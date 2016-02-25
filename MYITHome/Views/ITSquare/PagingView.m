//
//  PagingView.m
//  MYITHome
//
//  Created by 张万平 on 16/2/25.
//  Copyright © 2016年 iwpz. All rights reserved.
//

#import "PagingView.h"

@implementation PagingView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width,50)];
        [self setBackgroundColor:ColorWithRGB(255, 255, 255, 0.6)];
        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, self.size_Height-0.3, self.size_Width, 0.3)];
        [lineView setBackgroundColor:[UIColor lightGrayColor]];
        [self addSubview:lineView];
        [self setButtons];
    }
    return self;
}

- (void)setButtons{
    NSArray *names = @[@"最新回复",@"热帖",@"最新发表"];
    for (NSInteger i = 0; i<3; i++) {
        UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake((self.size_Width*(i+1))/5-(0.5*i), 10, self.size_Width/5, self.size_Height-10-10)];
        [button.layer setBorderColor:ITHOMERED.CGColor];
        [button.layer setBorderWidth:0.5];
        [button setBackgroundColor:[UIColor clearColor]];
        [button setTitle:names[i] forState:UIControlStateNormal];
        [button setTitleColor:ITHOMERED forState:UIControlStateNormal];
        [button.titleLabel setFont:[UIFont systemFontOfSize:12]];
        [button setTag:i+100];
        [button.layer setCornerRadius:1];
        [button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
        if (i == 0) {
            [[self viewWithTag:i + 100] setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [[self viewWithTag:i + 100] setBackgroundColor:ITHOMERED];
        }
    }
}

- (void)buttonClicked:(UIButton *)button{
    [_delegate btnClicked:button];
    for (NSInteger i = 0; i<3; i++) {
        if ([self viewWithTag:i + 100].tag == button.tag) {
            [[self viewWithTag:i + 100] setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [[self viewWithTag:i + 100] setBackgroundColor:ITHOMERED];
        }
        else{
            [[self viewWithTag:i + 100] setTitleColor:ITHOMERED forState:UIControlStateNormal];
            [[self viewWithTag:i + 100] setBackgroundColor:[UIColor whiteColor]];
        }
        
    }
    NSLog(@"按钮%@被点击了",button.titleLabel.text);
}

@end
