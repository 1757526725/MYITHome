//
//  ScanedViewController.h
//  MYITHome
//
//  Created by 张万平 on 16/3/14.
//  Copyright © 2016年 iwpz. All rights reserved.
//

#import "ViewController.h"

@interface ScanedViewController : ViewController
@property (nonatomic, strong) NSString *url;
- (instancetype)initWithURL:(NSString *)url;
@end
