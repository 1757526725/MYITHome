//
//  PostViewController.m
//  MYITHome
//
//  Created by 张万平 on 16/2/27.
//  Copyright © 2016年 iwpz. All rights reserved.
//

#import "PostViewController.h"
#import "ITSquarePostModel.h"
@interface PostViewController ()<UIWebViewDelegate>
@property (nonatomic, strong) NSDictionary *postDic;
@property (nonatomic, strong) ITSquarePostModel *model;
@end

@implementation PostViewController

- (instancetype)initWithDic:(NSDictionary *)dic
{
    self = [super init];
    if (self) {
        _postDic = dic;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self getJsonData];
    [self setViews];
}

- (void)getJsonData{
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://apiquan.ithome.com/api/post/%@",[_postDic objectForKey:@"postid"]]]];
    NSData *response = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSDictionary *postDataDic = [NSJSONSerialization JSONObjectWithData:response options:NSJSONReadingMutableLeaves error:nil];
    _model = [[ITSquarePostModel alloc]initWithDictionary:postDataDic];
}

- (void)setViews{
    /*
        NSDictionary *dic = [[NSDictionary alloc]initWithObjectsAndKeys:cell.model.mainid,@"postid",[NSString stringWithFormat:@"%@%@",cell.model.c,cell.model.t],@"posttitle",cell.model.vc,@"viewcount",cell.model.rc,@"replycount", nil];
     */
    UIWebView *webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, self.view.size_Width, self.view.size_Height)];
    [webView setDelegate:self];
    [webView setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:webView];
    //设备颜色字段为@"Cl",1是WP RGB 191 76 161 #BF4CA1,3是iOS RGB 87 121 203 #5779CB,8是安卓 RGB 135 166 63 #87A63F,10是Win10客户端 RGB 23 133 234 #1885EA
    [webView loadHTMLString:[NSString stringWithFormat:
                             @"<br /><font size=\"4\"><b>%@</b></font><br /> <br /><font color=\"#7f7f7f\" size=\"3\"><img src=\"forum_renqi.png\" height=\"17\" width=\"20\"></img>%@    <img src=\"forum_huifushu.png\" height=\"17\" width=\"20\"></img>%@</font><hr /><table width=\"100%%\"><tr><td align=\"left\"><img src=\"noavatar.png\" height=\"16\" width=\"16\"> <font size=\"1.5\" color=\"#4981da\"> %@  </font><font color=\"%@\">%@</font></td> <td align=\"right\"><font size=\"1\">楼主</font><br /><font size=\"1\">%@</font></p> </td></tr></table><font size=\"2\">%@</font><hr /><hr />",
                             [_postDic objectForKey:@"posttitle"], //帖子标题
                             [_postDic objectForKey:@"viewcount"], //查看数
                             [_postDic objectForKey:@"replycount"],//回复数
                             [_postDic objectForKey:@"un"],//楼主
                             [_model.Cl integerValue] == 1?@"#BF4CA1":([_model.Cl integerValue] == 3?@"5779CB":([_model.Cl integerValue] == 8?@"84A63F":@"#1885EA")),//设备颜色 1 WP,3 iOS, 8 安卓,10 Win10
                             _model.Ta,//设备名称
                             [self getDateString:[_postDic objectForKey:@"pt"]], //发帖时间
                             _model.content//帖子具体内容
                             ] baseURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] bundlePath]]];
}

/*
    <table width=\"100%%\"><tr><td align=\"left\"><img src=\"noavatar.png\" height=\"16\" width=\"16\"> <font size=\"1.5\" color=\"#4981da\"> %@  </font><font color=\"%@\">%@</font></td> <td align=\"right\"><font size=\"1\">楼主</font><br /><font size=\"1\">%@</font></p> </td></tr></table><font size=\"2\">%@</font>
 */

- (NSString *)getDateString:(NSString *)string{
    string = [string substringWithRange:NSMakeRange(6, 13)];
    NSTimeInterval interval=[string doubleValue] / 1000.0;
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:interval];
    NSDateFormatter *dateformat = [[NSDateFormatter alloc] init];
    [dateformat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    return [dateformat stringFromDate: date];
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
