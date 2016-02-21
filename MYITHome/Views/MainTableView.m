//
//  MainTableView.m
//  MYITHome
//
//  Created by 张万平 on 16/2/22.
//  Copyright © 2016年 iwpz. All rights reserved.
//

#import "MainTableView.h"
#import "MainTableViewCell.h"
#import "BannerView.h"
#import "MainTableViewCellModel.h"
@interface MainTableView()<UITableViewDelegate,UITableViewDataSource,NSXMLParserDelegate>
@property (nonatomic, assign) NSInteger detailsID;
@property (nonatomic, strong) NSMutableDictionary *xmlDataDic;
@property (nonatomic, strong) NSMutableArray *xmlDataArr;
@property (nonatomic, strong) NSString *startElement;
@property (nonatomic, strong) NSMutableArray *modelsArray;
@end
@implementation MainTableView
- (instancetype)initWithFrame:(CGRect)frame detailsID:(NSInteger)detailsID
{
    self = [super initWithFrame:frame];
    if (self) {
        _detailsID = detailsID;
            _modelsArray = [[NSMutableArray alloc]init];
            [self setDelegate:self];
            [self setDataSource:self];
            NSURL *url = [NSURL URLWithString:@"http://api.ithome.com/xml/newslist/news.xml"];
            NSXMLParser *parser = [[NSXMLParser alloc]initWithContentsOfURL:url];
            [parser setDelegate:self];
            [parser parse];
            [self arrToModel];
    }
    return self;
}


- (void)arrToModel{
    for (NSInteger i = 0; i<_xmlDataArr.count; i++) {
        MainTableViewCellModel *cellModel = [[MainTableViewCellModel alloc]initWithDictionary:_xmlDataArr[i]];
        [_modelsArray addObject:cellModel];
    }
}

- (void)parserDidStartDocument:(NSXMLParser *)parser{
    _xmlDataArr = [NSMutableArray array];
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary<NSString *,NSString *> *)attributeDict{
    if ([elementName isEqualToString:@"item"]) {
        NSMutableDictionary *dict = [[NSMutableDictionary alloc]initWithDictionary:attributeDict];
        [_xmlDataArr addObject:dict];
    }
    _startElement = elementName;
}

- (void)parserDidEndDocument:(NSXMLParser *)parser{
    _xmlDataDic = [[NSMutableDictionary alloc]initWithDictionary:@{@"channnel":_xmlDataArr}];
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string{
    string = [string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if (![string isEqualToString:@""]) {
        NSMutableDictionary *dic = [_xmlDataArr lastObject];
        [dic setValue:string forKey:_startElement];
    }
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _xmlDataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *idf = [NSString stringWithFormat:@"%ld%ld",indexPath.row,indexPath.section];
    MainTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (!cell) {
        cell = [[MainTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:idf];
    }
    if (indexPath.row == 0) {
        BannerView *banner = [[BannerView alloc]initWithFrame:CGRectMake(0, 0, self.size_Width, 187)];
        [cell addSubview:banner];
    }
    else{
        [cell setViewsWithModel:_modelsArray[indexPath.row-1]];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return 187;
    }
    else{
        return 80;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 1.0;
}
@end