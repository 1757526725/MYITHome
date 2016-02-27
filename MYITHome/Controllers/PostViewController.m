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
    [webView loadHTMLString:[NSString stringWithFormat:@"<br /><font size=\"4\"><b>%@</b></font><br /> <br /><font color=\"#7f7f7f\" size=\"3\"><img src=\"forum_renqi.png\" height=\"17\" width=\"20\"></img>%@    <img src=\"forum_huifushu.png\" height=\"17\" width=\"20\"></img>%@</font><hr />",[_postDic objectForKey:@"posttitle"],[_postDic objectForKey:@"viewcount"],[_postDic objectForKey:@"replycount"]] baseURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] bundlePath]]];
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
