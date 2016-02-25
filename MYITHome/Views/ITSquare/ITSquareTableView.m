//
//  ITSquareTableView.m
//  MYITHome
//
//  Created by 张万平 on 16/2/25.
//  Copyright © 2016年 iwpz. All rights reserved.
//

#import "ITSquareTableView.h"
#import "ITSquareTableViewCell.h"
#import "ITSquareTableViewModel.h"
#import "MJRefresh.h"
@interface ITSquareTableView()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) NSArray *dataArr;
@property (nonatomic, strong) NSMutableArray *modelArr;
@end
@implementation ITSquareTableView
/*
 全部 最新回复http://apiquan.ithome.com/api/post/?categoryid=0&type=0&orderTime&visistCount&pageLength
 全部 热贴列表http://apiquan.ithome.com/api/post/?categoryid=0&type=2&orderTime&visistCount&pageLength
 全部 最新发表http://apiquan.ithome.com/api/post/?categoryid=0&type=1&orderTime&visistCount&pageLength
 */
- (instancetype)initWithFrame:(CGRect)frame detailsID:(NSInteger)detailsID typeID:(NSInteger)typeID
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setDelegate:self];
        [self setDataSource:self];
        self.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://apiquan.ithome.com/api/post/?categoryid=%ld&type=%ld&orderTime&visistCount&pageLength",detailsID,typeID]]];
        //将请求的url数据放到NSData对象中
        NSData *response = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
        //IOS5自带解析类NSJSONSerialization从response中解析出数据放到字典中
        NSArray *dataArr = [NSJSONSerialization JSONObjectWithData:response options:NSJSONReadingMutableLeaves error:nil];
        _dataArr = dataArr;
        [self arrToModel];
    }
    return self;
}

- (void)loadNewData{
    [self.mj_header endRefreshing];
}

- (void)arrToModel{
    _modelArr = [[NSMutableArray alloc]init];
    for (NSInteger i = 0; i < _dataArr.count; i++) {
        ITSquareTableViewModel *model = [[ITSquareTableViewModel alloc]initWithDictionary:_dataArr[i]];
        [_modelArr addObject:model];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return 50;
    }
    else return 60;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 20;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *idf = [NSString stringWithFormat:@"%ld%ld",indexPath.row,indexPath.section];
    ITSquareTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (!cell) {
        cell = [[ITSquareTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:idf];
    }
    if (indexPath.row == 0) {
        [cell setBackgroundColor:[UIColor whiteColor]];
    }
    else{
        [cell setViewsWithModel:_modelArr[indexPath.row-1]];
    }
    return cell;
}
@end
