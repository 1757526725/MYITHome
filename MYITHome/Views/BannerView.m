//
//  BannerView.m
//  MYITHome
//
//  Created by 张万平 on 16/2/22.
//  Copyright © 2016年 iwpz. All rights reserved.
//

#import "BannerView.h"
@interface BannerView()<UIScrollViewDelegate,NSXMLParserDelegate>
@property (nonatomic, strong) UIView *textView;
@property (nonatomic, strong) UILabel *textLabel;
@property (nonatomic, strong) UIPageControl *pageControl;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) NSMutableDictionary *xmlDataDic;
@property (nonatomic, strong) NSMutableArray *xmlDataArr;
@property (nonatomic, strong) NSString *startElement;
@property (nonatomic, strong) NSTimer *timer;
@end
@implementation BannerView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.frame = frame ;
        [self setBackgroundColor:[UIColor whiteColor]];
        NSURL *url = [NSURL URLWithString:@"http://api.ithome.com/xml/slide/slide.xml"];
        NSXMLParser *parser = [[NSXMLParser alloc]initWithContentsOfURL:url];
        [parser setDelegate:self];
        [parser parse];
        [self setViews];
    }
    return self;
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

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName{
}
- (void)setViews{
    _scrollView = [[UIScrollView alloc]initWithFrame:self.bounds];
    [_scrollView setPagingEnabled:YES];
    [_scrollView setDelegate:self];
    for (NSInteger i =0; i<4; i++) {
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(self.frame.size.width*i, 0, self.frame.size.width, self.frame.size.height)];
        [imageView setImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[[_xmlDataArr objectAtIndex:i] objectForKey:@"image"]]]]];
        [_scrollView addSubview:imageView];
    }
    [_scrollView setContentSize:CGSizeMake(self.frame.size.width*4, self.frame.size.height)];//5页,回到最初页还没写
    [self addSubview:_scrollView];
    UIView *bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, self.frame.size.height-30, self.frame.size.width, 30)];
    [bottomView setBackgroundColor:[UIColor blackColor]];
    [bottomView setAlpha:0.5];
    [self addSubview:bottomView];
    _textLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, bottomView.frame.size.width-110, bottomView.frame.size.height)];
    [_textLabel setText:[[_xmlDataArr objectAtIndex:0] objectForKey:@"title"]];
    [_textLabel setTextColor:[UIColor whiteColor]];
    [_textLabel setFont:[UIFont systemFontOfSize:12]];
    [_textLabel setBackgroundColor:[UIColor clearColor]];
    [bottomView addSubview:_textLabel];
    _pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(bottomView.frame.size.width-110, 0, 110, bottomView.frame.size.height)];
    [_pageControl setNumberOfPages:4];
    [_pageControl setBackgroundColor:[UIColor clearColor]];
    [_pageControl setPageIndicatorTintColor:[UIColor whiteColor]];
    [_pageControl setCurrentPageIndicatorTintColor:[UIColor colorWithRed:210.0f/255.0f green:45.0f/255.0f blue:49.0f/255.0f alpha:1]];
    [_pageControl setAlpha:1];
    
    [bottomView addSubview:_pageControl];
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    [_pageControl setCurrentPage:_scrollView.contentOffset.x/self.frame.size.width];
    [_textLabel setText:[[_xmlDataArr objectAtIndex:_scrollView.contentOffset.x/self.frame.size.width] objectForKey:@"title"]];
}


@end
