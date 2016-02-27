//
//  ITSquarePostModel.h
//  MYITHome
//
//  Created by 张万平 on 16/2/27.
//  Copyright © 2016年 iwpz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ITSquarePostModel : NSObject
@property (nonatomic, strong) NSString *content;
@property (nonatomic, strong) NSString *Cl;
@property (nonatomic, strong) NSString *Ta;
@property (nonatomic, strong) NSString *ul;
@property (nonatomic, strong) NSString *rc;
@property (nonatomic, strong) NSArray *imgs;
@property (nonatomic, strong) NSDictionary *reply;
- (instancetype)initWithDictionary:(NSDictionary *)dic;
@end
