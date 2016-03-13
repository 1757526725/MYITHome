//
//  ScanViewController.h
//  MYITHome
//
//  Created by 张万平 on 16/3/14.
//  Copyright © 2016年 iwpz. All rights reserved.
//

#import "ViewController.h"
@protocol ScanDelegate
-(void)putURL:(NSString *)url;
@end
@interface ScanViewController : ViewController
@property (nonatomic, assign) id<ScanDelegate> delegate;
@end
