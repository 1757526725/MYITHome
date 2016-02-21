//
//  MainTableViewCellModel.h
//  MYITHome
//
//  Created by 张万平 on 16/2/22.
//  Copyright © 2016年 iwpz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MainTableViewCellModel : NSObject
@property (nonatomic, strong) NSString *newsid;
@property (nonatomic, strong) NSString *forbidcomment;
@property (nonatomic, strong) NSString *tags;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *image;
@property (nonatomic, strong) NSString *v;
@property (nonatomic, strong) NSString *commentcount;
@property (nonatomic, strong) NSString *thedescription;
@property (nonatomic, strong) NSString *postdate;
@property (nonatomic, strong) NSString *hitcount;
@property (nonatomic, strong) NSString *url;
@property (nonatomic, strong) NSString *c;
- (instancetype)initWithDictionary:(NSMutableDictionary *)dic;
@end
