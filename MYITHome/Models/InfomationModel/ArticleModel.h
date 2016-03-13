//
//  ArticleModel.h
//  MYITHome
//
//  Created by 张万平 on 16/2/22.
//  Copyright © 2016年 iwpz. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface ArticleModel : NSObject
@property (nonatomic, strong) NSString *newssource;
@property (nonatomic, strong) NSString *tags;
@property (nonatomic, strong) NSString *detail;
@property (nonatomic, strong) NSString *z;
@property (nonatomic, strong) NSString *newsauthor;
- (instancetype)initWithDictionary:(NSMutableDictionary *)dic;
@end