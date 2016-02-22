//
//  BannerModel.h
//  MYITHome
//
//  Created by 张万平 on 16/2/22.
//  Copyright © 2016年 iwpz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BannerModel : NSObject
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *opentype;
@property (nonatomic, strong) NSString *device;
@property (nonatomic, strong) NSString *image;
@property (nonatomic, strong) NSString *link;
- (instancetype)initWithDictionary:(NSMutableDictionary *)dic;
@end
