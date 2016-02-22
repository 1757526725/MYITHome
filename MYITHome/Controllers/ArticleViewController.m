//
//  ArticleViewController.m
//  MYITHome
//
//  Created by 张万平 on 16/2/22.
//  Copyright © 2016年 iwpz. All rights reserved.
//

#import "ArticleViewController.h"
#import "ArticleModel.h"
@interface ArticleViewController ()<UIScrollViewDelegate,NSXMLParserDelegate,UIWebViewDelegate>
@property (nonatomic, strong) NSMutableDictionary *xmlDataDic;
@property (nonatomic, strong) NSMutableArray *xmlDataArr;
@property (nonatomic, strong) NSMutableArray *modelsArr;
@property (nonatomic, strong) NSString *startElement;


@end

@implementation ArticleViewController

- (instancetype)initWithModel:(MainTableViewCellModel *)model
{
    self = [super init];
    if (self) {
        _model = model;
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

- (void)arrToModel{
    _modelsArr = [[NSMutableArray alloc]init];
    for (NSInteger i = 0; i<_xmlDataArr.count; i++) {
        ArticleModel *model = [[ArticleModel alloc]initWithDictionary:_xmlDataArr[i]];
        [_modelsArr addObject:model];
    }
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://api.ithome.com/xml/newscontent/%@/%@.xml",[_model.newsid substringToIndex:3],[_model.newsid substringFromIndex:3]]];
    NSXMLParser *parser = [[NSXMLParser alloc]initWithContentsOfURL:url];
    [parser setDelegate:self];
    [parser parse];
    [self setViews];
}

//配置视图,IT之家原版用的是WebView(?),所以简单的模仿了一下,不过很低端,只能实现浏览信息,还没有美化页面
- (void)setViews{
    [self arrToModel];
    ArticleModel *model = _modelsArr[0];
    UIWebView *webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, self.view.size_Width, self.view.size_Height)];
    [webView setDelegate:self];
    [webView setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:webView];
    [webView loadHTMLString:[NSString stringWithFormat:@"<br /><font size=\"4\"><b>%@</b></font> <br/> <font color=\"#7f7f7f\" size=\"3\">%@    %@(%@)</font><br /><hr />%@",_model.title,_model.postdate,model.newssource,model.newsauthor,model.detail] baseURL:nil];
}

//压缩图片,适配窗口大小
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    [webView stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"var script = document.createElement('script');"
                                                     "script.type = 'text/javascript';"
                                                     "script.text = \"function ResizeImages() { "
                                                     "var myimg,oldwidth;"
                                                     "var maxwidth=%f;"
                                                     "for(i=0;i <document.images.length;i++){"
                                                     "myimg = document.images[i];"
                                                     "if(myimg.width > maxwidth){"
                                                     "oldwidth = myimg.width;"
                                                     "myimg.width = maxwidth;"
                                                     "myimg.height = myimg.height * (maxwidth/oldwidth);"
                                                     "}"
                                                     "}"
                                                     "}\";"
                                                     "document.getElementsByTagName('head')[0].appendChild(script);",self.view.size_Width-10]];
    
    [webView stringByEvaluatingJavaScriptFromString:@"ResizeImages();"];
}

- (void)viewWillAppear:(BOOL)animated{
    [self.navigationController.navigationBar setHidden:YES];
}

//查到说用透明图片可以让导航栏隐藏,但是经尝试没有达成效果,继续努力
- (void)viewDidAppear:(BOOL)animated{
    [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"aeroNavBar"]  forBarMetrics:UIBarMetricsDefault];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
