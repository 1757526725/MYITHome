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
#import "ArticleViewController.h"
@interface MainTableView()<UITableViewDelegate,UITableViewDataSource,NSXMLParserDelegate>
@property (nonatomic, assign) NSInteger detailsID;
@property (nonatomic, strong) NSMutableDictionary *xmlDataDic;
@property (nonatomic, strong) NSMutableArray *xmlDataArr;
@property (nonatomic, strong) NSString *startElement;
@property (nonatomic, strong) NSMutableArray *modelsArray;
@property (nonatomic, strong) NSArray *urlArray;
@end
@implementation MainTableView
- (instancetype)initWithFrame:(CGRect)frame detailsID:(NSInteger)detailsID
{
    self = [super initWithFrame:frame];
    if (self) {
        _detailsID = detailsID;//栏目ID
        /*7个栏目的API,banner = 有banner的tableView, ranking = 分4组的排行榜, nobanner = 没有banner的tableView
         "http://api.ithome.com/xml/newslist/news.xml"       0 banner
         "http://api.ithome.com/xml/newslist/rank.xml"       1 ranking
         "http://api.ithome.com/xml/newslist/ios.xml"        2 banner
         "http://api.ithome.com/xml/newslist/phone.xml"      3 nobanner
         "http://api.ithome.com/xml/newslist/digi.xml"       4 nobanner
         "http://api.ithome.com/xml/newslist/wp.xml"         5 banner
         "http://api.ithome.com/xml/newslist/android.xml"    6 banner
         "http://api.ithome.com/xml/newslist/windows.xml"    7 banner
         */
        NSArray *urlArray = [NSArray arrayWithObjects:@"http://api.ithome.com/xml/newslist/news.xml",
                              @"http://api.ithome.com/xml/newslist/rank.xml",
                              @"http://api.ithome.com/xml/newslist/ios.xml",
                              @"http://api.ithome.com/xml/newslist/phone.xml",
                              @"http://api.ithome.com/xml/newslist/digi.xml",
                              @"http://api.ithome.com/xml/newslist/wp.xml",
                              @"http://api.ithome.com/xml/newslist/android.xml",
                              @"http://api.ithome.com/xml/newslist/windows.xml", nil];
        _urlArray = urlArray;
            _modelsArray = [[NSMutableArray alloc]init];
            [self setDelegate:self];
            [self setDataSource:self];
            NSURL *url = [NSURL URLWithString:urlArray[_detailsID]];
            NSXMLParser *parser = [[NSXMLParser alloc]initWithContentsOfURL:url];
            [parser setDelegate:self];
            [parser parse];
            [self arrToModel];
    }
    return self;
}

/**
 *  将解析xml得到的数据存到model中
 */
- (void)arrToModel{
    for (NSInteger i = 0; i<_xmlDataArr.count; i++) {
        MainTableViewCellModel *cellModel = [[MainTableViewCellModel alloc]initWithDictionary:_xmlDataArr[i]];
        [_modelsArray addObject:cellModel];
    }
}

/**
 *  构建第二页 排行榜 的分组头视图
 */
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    NSArray *arr = @[@"双日榜",@"周榜",@"热评",@"月榜"];
    UILabel *textLabel = [[UILabel alloc]initWithFrame:CGRectMake((self.size_Width-100)/2, 0, 100, 30)];
    [textLabel setText:arr[section]];
    [textLabel setTextAlignment:NSTextAlignmentCenter];
    [textLabel setTextColor:[UIColor whiteColor]];
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.size_Width, 30)];
    [view setBackgroundColor:ColorWithRGB(127, 127, 127, 0.8)];
    [view addSubview:textLabel];
    return view;
}

//排行榜有4组,其他页只有1组
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (_detailsID == 1) {
        return 4;
    }
    else{
        return 1;
    }
    
}

//如果ID=1 3 4,没有banner,所有cell都80高,否则banner cell 187高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (_detailsID == 1 || _detailsID == 3 || _detailsID == 4) {
        return 80;
    }
    else{
        if (indexPath.row == 0) {
            return 187;
        }
        else{
            return 80;
        }
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}

//如果是排行榜页,头30高,否则0
- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (_detailsID != 1) {
        return 0;
    }
    else{
        return 30.0;
    }
}

//点击cell后push到文章页VC
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    MainTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    NSNotification *notification =[NSNotification notificationWithName:@"pushViewController" object:cell.model userInfo:nil];
    [[NSNotificationCenter defaultCenter] postNotification:notification];
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

//如果是排行榜页,每组只有12个,解析到的数据12*4存放
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (_detailsID != 1) {
        return _xmlDataArr.count;
    }
    else{
        return _xmlDataArr.count/4;
    }
}

//如果是0 2 5 6 7 banner页
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (_detailsID == 0 ||  _detailsID == 2 || _detailsID == 5 || _detailsID == 6 || _detailsID == 7) {
        NSString *idf = [NSString stringWithFormat:@"%ld%ld",indexPath.row,indexPath.section];
        MainTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        if (!cell) {
            cell = [[MainTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:idf];
        }
        if (indexPath.row == 0) {//第一个cell放bannerView
            BannerView *banner = [[BannerView alloc]initWithFrame:CGRectMake(0, 0, self.size_Width, 187) url:[NSURL URLWithString:(_detailsID == 0)?[[_urlArray[_detailsID] stringByReplacingOccurrencesOfString:@"/newslist/" withString:@"/slide/"] stringByReplacingOccurrencesOfString:@"slide/news" withString:@"slide/slide"]:[_urlArray[_detailsID] stringByReplacingOccurrencesOfString:@"/newslist/" withString:@"/slide/"]]];
            [cell addSubview:banner];
        }
        else{
            [cell setViewsWithModel:_modelsArray[indexPath.row-1]];
        }
        return cell;
    }
    else if (_detailsID == 1) {//如果是排行榜页
        NSString *idf = [NSString stringWithFormat:@"%ld%ld",indexPath.row,indexPath.section];
        MainTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        if (!cell) {//全部统一cell样式
            cell = [[MainTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:idf];
        }
        [cell setViewsWithModel:_modelsArray[indexPath.row+12*indexPath.section]];
        return cell;
    }
    else{
        NSString *idf = [NSString stringWithFormat:@"%ld%ld",indexPath.row,indexPath.section];
        MainTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        if (!cell) {
            cell = [[MainTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:idf];
        }
        [cell setViewsWithModel:_modelsArray[indexPath.row]];
        return cell;
    }
}
@end