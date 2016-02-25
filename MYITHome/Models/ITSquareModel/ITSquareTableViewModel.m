//
//  ITSquareTableViewModel.m
//  MYITHome
//
//  Created by 张万平 on 16/2/26.
//  Copyright © 2016年 iwpz. All rights reserved.
//

#import "ITSquareTableViewModel.h"
@implementation ITSquareTableViewModel
- (instancetype)initWithDictionary:(NSDictionary *)dic
{
    self = [super init];
    if (self) {
        [self setValuesForKeysWithDictionary:dic];
    }
    return self;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key  isEqual: @"id"]) {
        _mainid = value;
    }
}
@end

