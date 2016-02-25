//
//  ITSquareTableViewModel.h
//  MYITHome
//
//  Created by 张万平 on 16/2/26.
//  Copyright © 2016年 iwpz. All rights reserved.
//

#import <Foundation/Foundation.h>
/*
 c = "[\U7f6e\U9876]";
 cn = "\U53cd\U9988\U5efa\U8bae";
 id = 3116;
 pt = "/Date(1443610243967)/";
 rc = 1892;
 rn = wjylhx;
 rt = "/Date(1456386460963)/";
 t = "\U65b0\U4eba\U62a5\U9053\U4e13\U7528\U5e16 & \U4e4b\U5bb6\U5c01\U53f7\U89c4\U8303 & \U5c0f\U5c3e\U5df4\U798f\U5229";
 uid = 47;
 un = "\U5b50\U975e";
 vc = 54633;
 */
@interface ITSquareTableViewModel : NSObject
@property (nonatomic, copy) NSString *cn;
@property (nonatomic, copy) NSString *t;
@property (nonatomic, copy) NSString *c;
@property (nonatomic, copy) NSString *mainid;
@property (nonatomic, copy) NSString *uid;
@property (nonatomic, copy) NSString *un;
@property (nonatomic, copy) NSString *pt;
@property (nonatomic, copy) NSString *rt;
@property (nonatomic, copy) NSString *rc;
@property (nonatomic, copy) NSString *rn;
@property (nonatomic, copy) NSString *vc;
- (instancetype)initWithDictionary:(NSDictionary *)dic;
@end

