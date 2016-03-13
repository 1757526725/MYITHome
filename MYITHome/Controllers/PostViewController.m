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

- (NSString *)getAvatarURL:(NSString *)uid{
    NSString *theuid = uid;
    for (NSInteger i = 0; i< 9 - uid.length ; i++) {
        theuid = [NSString stringWithFormat:@"0%@",theuid];
    }
    NSString *subID= [NSString stringWithFormat:@"http://avatar.ithome.com/avatars/%@/%@/%@/%@_60.jpg",[theuid substringWithRange:NSMakeRange(0, 3)],[theuid substringWithRange:NSMakeRange(3, 2)],[theuid substringWithRange:NSMakeRange(5, 2)],[theuid substringWithRange:NSMakeRange(7, 2)]];
    return subID;
}

- (void)setViews{
    /*
        NSDictionary *dic = [[NSDictionary alloc]initWithObjectsAndKeys:cell.model.mainid,@"postid",[NSString stringWithFormat:@"%@%@",cell.model.c,cell.model.t],@"posttitle",cell.model.vc,@"viewcount",cell.model.rc,@"replycount", nil];
     */
    
    UIWebView *webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, self.view.size_Width, self.view.size_Height)];
    [webView setDelegate:self];
    [webView setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:webView];
    NSString *webViewHTMLString = [NSString stringWithFormat:
                                   @"<br /><font size=\"4\"><b>%@</b></font><br /> <br /><font color=\"#7f7f7f\" size=\"3\"><img src=\"forum_renqi.png\" height=\"17\" width=\"20\"></img>%@    <img src=\"forum_huifushu.png\" height=\"17\" width=\"20\"></img>%@</font><hr /><table width=\"100%%\"><tr><td><img style=\"border-radius:16px;\" src=\"%@\" onerror=\"javascript:this.src='noavatar.png';\" height=\"16\" width=\"16\"></td><td align=\"left\"><font size=\"1.5\" color=\"#4981da\"> %@  </font><font size=\"1.9\" color=\"%@\">%@</font></td> <td width=\"30%%\" align=\"right\"><font size=\"1\">楼主</font><br /><font size=\"1\">%@</font></p> </td></tr><tr><td></td><td colspan=\"2\"><font size=\"2.1\">%@</font></td></tr></table>",//HTML内容
                                   [_postDic objectForKey:@"posttitle"], //帖子标题
                                   [_postDic objectForKey:@"viewcount"], //查看数
                                   [_postDic objectForKey:@"replycount"],//回复数
                                   [self getAvatarURL:[_postDic objectForKey:@"uid"]],//头像URL
                                   [_postDic objectForKey:@"un"],//楼主
                                   [_model.Cl integerValue] == 1?@"#BF4CA1":([_model.Cl integerValue] == 3?@"5779CB":([_model.Cl integerValue] == 8?@"84A63F":@"#1885EA")),//设备颜色 1 WP,3 iOS, 8 安卓,10 Win10
                                   _model.Ta,//设备名称
                                   [self getDateString:[_postDic objectForKey:@"pt"]], //发帖时间
                                   _model.content//帖子具体内容
                                   ];
    for (NSInteger i = 0; i < _model.reply.count; i++) {
        NSDictionary *replyDic = [_model.reply[i] objectForKey:@"M"];
        NSArray *replyReplyArr = [_model.reply[i] objectForKey:@"R"];
        NSString *replyReplyHTMLString = @"";//楼中楼回复
        for (NSInteger i = 0; i < replyReplyArr.count; i++) {
            NSDictionary *replyReplyDic = replyReplyArr[i];
            NSLog(@"%@",replyReplyDic);
            /*
             replyReplyDic:
             A = 0;
             C = "欢迎   ，  欢迎  ！";
             Ci = 166227;
             Cl = 10;
             Ir = 0;
             N = "极客。。";
             R = 0;
             S = 2;
             T = "/Date(1452400789663)/";
             Ta = "Win10客户端";
             Ui = 1265968;
             */
            replyReplyHTMLString = [NSString stringWithFormat:@"%@ %@",replyReplyHTMLString,[NSString stringWithFormat:@"<tr><td></td> <td colspan=\"2\"  style=\"background-color:#FBF9EE\"><table width=\"100%%\"><tr> <td rowspan=\"2\" width=\"10%%\" height=\"10%%\" align=\"center\"><img style=\"border-radius:16px;\" src=\"%@\" onerror=\"javascript:this.src='noavatar.png';\" height=\"16\" width=\"16\"></td><td colspan=\"2\"><font size=\"1.2\" color=\"#4981da\">%@  </font><font size=\"1.2\" color=\"%@\">%@</font></td><td align=\"right\"><font size=\"1.1\" color=\"#C0C0C0\">%ld#</font></td></tr><tr> <td colspan=\"3\"><font size=\"1.1\" color=\"#C0C0C0\">%@</font></td></tr><tr> <td colspan=\"4\">%@</td></tr><tr><td colspan=\"4\" align=\"right\"><font size=\"1\"><a href=\"javascirpt:alert('举报');\">举报</a></font>   <img width=\"12\" height=\"12\"src=\"forum_huifu.png\"></td></tr></table></td> </tr>",
                                                                                             [self getAvatarURL:[NSString stringWithFormat:@"%@",[replyReplyDic objectForKey:@"Ui"]]],
                                                                                             [replyReplyDic objectForKey:@"N"],
                                                                                             [[replyReplyDic objectForKey:@"Cl"] integerValue] == 1?@"#BF4CA1":([[replyDic objectForKey:@"Cl"] integerValue] == 3?@"5779CB":([[replyDic objectForKey:@"Cl"] integerValue] == 8?@"84A63F":@"#1885EA")),
                                                                                             [replyReplyDic objectForKey:@"Ta"],
                                                                                             i+1,
                                                                                             [self getDateString:[replyReplyDic objectForKey:@"T"]],
                                                                                             [replyReplyDic objectForKey:@"C"]
                                                                                             ]];
        }
        
        webViewHTMLString = [NSString stringWithFormat:@"%@ %@",webViewHTMLString,[NSString stringWithFormat:@"<hr /><table width=\"100%%\"><tr><td width=\"5%%\"><img style=\"border-radius:16px;\" src=\"%@\" onerror=\"javascript:this.src='noavatar.png';\" height=\"16\" width=\"16\"></td><td><font size=\"1.5\" color=\"#4981da\"> %@  </font><font size=\"1.9\" color=\"%@\">%@</font></td> <td width=\"30%%\" align=\"right\"><font size=\"1\">%ld楼</font><br /><font size=\"1\">%@</font> </td></tr><tr><td></td><td colspan=\"2\"><font size=\"2\">%@</font></td></tr><tr><td></td><td colspan=\"2\" align=\"right\"><a href=\"javascirpt:alert('举报');\"><font size=\"1.6\" collor=\"#C0C0C0\">举报</font></a>   <img width=\"12\" height=\"12\"src=\"forum_zhichi.png\"><font size=\"1.6\" collor=\"#C0C0C0\">%@</font>  <img width=\"12\" height=\"12\"src=\"forum_fandui.png\"><font size=\"1.6\" collor=\"#C0C0C0\">%@    </font></td></tr>%@</table>",
                                                                                   [self getAvatarURL:[NSString stringWithFormat:@"%@",[replyDic objectForKey:@"Ui"]]],//头像URL
                                                                                   [replyDic objectForKey:@"N"],//用户名
                                                                                   [[replyDic objectForKey:@"Cl"] integerValue] == 1?@"#BF4CA1":([[replyDic objectForKey:@"Cl"] integerValue] == 3?@"5779CB":([[replyDic objectForKey:@"Cl"] integerValue] == 8?@"84A63F":@"#1885EA")),//设备颜色
                                                                                   [replyDic objectForKey:@"Ta"],//设备名称
                                                                                   i+1,
                                                                                   [self getDateString:[replyDic objectForKey:@"T"]],//回复时间
                                                                                   [replyDic objectForKey:@"C"],//回复内容
                                                                                   [replyDic objectForKey:@"S"],//赞同数
                                                                                   @"0",//反对数，还没发现是哪个key
                                                                                   replyReplyArr.count==0?@"":replyReplyHTMLString//楼中楼HTML语句
                                                                                   ]];
    }
    //设备颜色字段为@"Cl",1是WP RGB 191 76 161 #BF4CA1,3是iOS RGB 87 121 203 #5779CB,8是安卓 RGB 135 166 63 #87A63F,10是Win10客户端 RGB 23 133 234 #1885EA
    [webView loadHTMLString:webViewHTMLString baseURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] bundlePath]]];
}

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
                                                     "document.getElementsByTagName('head')[0].appendChild(script);",self.view.size_Width-40]];
    
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
