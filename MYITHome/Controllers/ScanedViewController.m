//
//  ScanedViewController.m
//  MYITHome
//
//  Created by 张万平 on 16/3/14.
//  Copyright © 2016年 iwpz. All rights reserved.
//

#import "ScanedViewController.h"

@interface ScanedViewController ()

@end

@implementation ScanedViewController

- (instancetype)initWithURL:(NSString *)url
{
    self = [super init];
    if (self) {
        _url = url;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.hidesBottomBarWhenPushed=NO;
    [self.navigationController.navigationBar setBarTintColor:ITHOMERED];
    [self.navigationController.navigationBar setTranslucent:NO];
    UIBarButtonItem *leftBarItem = [[UIBarButtonItem alloc]init];
    [leftBarItem setImage:[[UIImage imageNamed:@"back"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [self.navigationItem setLeftBarButtonItem:leftBarItem];
    [leftBarItem setAction:@selector(leftClicked)];
    [leftBarItem setTarget:self];
    
    UIWebView *webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, self.view.size_Width, self.view.size_Height)];
    [self.view addSubview:webView];
    [webView setBackgroundColor:[UIColor whiteColor]];
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:_url]]];
}

- (void)leftClicked{
    [self.navigationController popViewControllerAnimated:YES];
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
