//
//  ArticleViewController.m
//  MYITHome
//
//  Created by 张万平 on 16/2/22.
//  Copyright © 2016年 iwpz. All rights reserved.
//

#import "ArticleViewController.h"
#import "ArticleModel.h"
#import "GDataXMLNode.h"
@interface ArticleViewController ()<UIScrollViewDelegate,UIWebViewDelegate>
@property (nonatomic, strong) NSString *newsSource;
@property (nonatomic, strong) NSString *newsAuthor;
@property (nonatomic, strong) NSString *newsDetail;
@property (nonatomic, strong) NSString *newsZ;
@property (nonatomic, strong) NSString *newsTags;
@property (nonatomic, strong) NSDictionary *dic;
@property (nonatomic, strong) NSMutableDictionary *dataDic;

@end

@implementation ArticleViewController

- (instancetype)initWithModel:(NSDictionary *)dic
{
    self = [super init];
    if (self) {
        _dic = dic;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://api.ithome.com/xml/newscontent/%@/%@.xml",[[_dic objectForKey:@"newsid"] substringToIndex:3],[[_dic objectForKey:@"newsid"] substringFromIndex:3]]];
    NSData *data = [NSData dataWithContentsOfURL:url];
    GDataXMLDocument *gDataDocument = [[GDataXMLDocument alloc]initWithData:data options:0 error:nil];
    GDataXMLElement *rootElement = [gDataDocument rootElement];
    //获取其他节点
    NSArray *datasArr = [rootElement elementsForName:@"channel"];
    NSArray *items = [datasArr[0] elementsForName:@"item"];
    _dataDic = [[NSMutableDictionary alloc]init];
    for (GDataXMLElement *element in items) {
        GDataXMLElement *source = [[element elementsForName:@"newssource"] objectAtIndex:0];
        NSString *newsSource = [source stringValue];
        [_dataDic setValue:newsSource forKey:@"newssource"];
        GDataXMLElement *author = [[element elementsForName:@"newsauthor"] objectAtIndex:0];
        NSString *newsAuthor = [author stringValue];
        [_dataDic setValue:newsAuthor forKey:@"newsauthor"];
        GDataXMLElement *detail = [[element elementsForName:@"detail"] objectAtIndex:0];
        NSString *newsDetail = [detail stringValue];
        [_dataDic setValue:newsDetail forKey:@"detail"];
        GDataXMLElement *z = [[element elementsForName:@"z"] objectAtIndex:0];
        NSString *newsZ = [z stringValue];
        [_dataDic setValue:newsZ forKey:@"z"];
        GDataXMLElement *tags = [[element elementsForName:@"tags"] objectAtIndex:0];
        NSString *newsTags = [tags stringValue];
        [_dataDic setValue:newsTags forKey:@"tags"];
    }
    [self setViews];
}

//配置视图,IT之家原版用的是WebView(?),所以简单的模仿了一下,不过很低端,只能实现浏览信息,还没有美化页面
- (void)setViews{
    ArticleModel *model = [[ArticleModel alloc]initWithDictionary:_dataDic];
    UIWebView *webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, self.view.size_Width, self.view.size_Height)];
    [webView setDelegate:self];
    [webView setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:webView];
    NSString *webViewHTMLString =[NSString stringWithFormat:@"<br /><font size=\"4\"><b>%@</b></font> <br/> <font color=\"#7f7f7f\" size=\"3\">%@    %@(%@)</font><br /><hr />%@",[_dic objectForKey:@"title"],[_dic objectForKey:@"postdate"],model.newssource,model.newsauthor,model.detail];
    [webView loadHTMLString:webViewHTMLString baseURL:nil];
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

- (void)viewDidAppear:(BOOL)animated{
    [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"aeroNavBar"]  forBarMetrics:UIBarMetricsDefault];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
