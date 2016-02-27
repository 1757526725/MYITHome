//
//  ITSquareViewController.m
//  MYITHome
//
//  Created by 张万平 on 16/2/20.
//  Copyright © 2016年 iwpz. All rights reserved.
//

#import "ITSquareViewController.h"
#import "MainScrollView.h"
#import "NavScrollView.h"
#import "PostViewController.h"

@interface ITSquareViewController ()
@property (nonatomic, strong) NavScrollView *navScrollView;
@property (nonatomic, strong) MainScrollView *mainScrollView;
@property (nonatomic, copy) NSMutableArray *navDataArr;
@end

@implementation ITSquareViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(pushPostViewController:) name:@"pushPostViewController" object:nil];//注册通知,在tableView中点击cell,由主控制器实现,push文章页
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self.navigationController.navigationBar setBarTintColor:ITHOMERED];
    [self.navigationController.navigationBar setTranslucent:NO];
    [self.navigationController.tabBarItem setTitleTextAttributes:@{NSFontAttributeName : [UIFont  systemFontOfSize:12], NSForegroundColorAttributeName : ITHOMERED} forState:UIControlStateSelected];
    [self.navigationController.tabBarItem setTitleTextAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:12],  NSForegroundColorAttributeName:[UIColor grayColor]} forState:UIControlStateNormal];
    [self setNavBar];
    [self setMainScrollView];
}

- (void)pushPostViewController:(NSNotification *)noti{
    NSDictionary *dic = noti.object;
    PostViewController *postViewController = [[PostViewController alloc]initWithDic:dic];
    [postViewController setHidesBottomBarWhenPushed:YES];
    [self.navigationItem setHidesBackButton:YES];
    [self.navigationController pushViewController:postViewController animated:YES];
}

-(void)viewWillAppear:(BOOL)animated{
    [self.navigationController.navigationBar setHidden:NO];
}

- (void)setMainScrollView{
    MainScrollView *mainScrollView = [[MainScrollView alloc]initWithFrame:CGRectMake(0, 0, self.view.size_Width, self.view.size_Height-64) pages:_navDataArr isInfo:NO];
    _mainScrollView = mainScrollView;
    mainScrollView.tBlock = ^void(CGFloat a){
        [_navScrollView setCurrentPage:a];
    };
    [self.view addSubview:mainScrollView];
}


- (void)setNavBar{
    [self.navigationController.navigationBar setBarTintColor:ColorWithRGB(210, 45, 49, 1)];//导航栏背景色
    [self.navigationController.navigationBar setTranslucent:NO];//关闭透明效果
    [self.navigationController.tabBarItem setTitle:@"资讯"];//配置tabBar
    [self.navigationController.tabBarItem setTitleTextAttributes:@{NSFontAttributeName : [UIFont fontWithName:@"HelveticaNeue-Bold" size:12.0F], NSForegroundColorAttributeName : [UIColor colorWithRed:210.0f/255.0f green:45.0f/255.0f blue:49.0f/255.0f alpha:1]} forState:UIControlStateSelected];
    [self.navigationController.tabBarItem setTitleTextAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:12.0F],  NSForegroundColorAttributeName:[UIColor grayColor]} forState:UIControlStateNormal];
    [self setNavBarViews:self.navigationController.navigationBar];
}

- (void)setNavBarViews:(UINavigationBar *)navigationBar{
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://apiquan.ithome.com/api/category"]];
    NSData *response = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSArray *responseDic = [NSJSONSerialization JSONObjectWithData:response options:NSJSONReadingMutableLeaves error:nil];
    _navDataArr = [responseDic mutableCopy];
    NavScrollView *navScrollView = [[NavScrollView alloc]initWithFrame:CGRectMake(0, 0, self.view.size_Width, navigationBar.size_Height) data:_navDataArr];
    [navigationBar addSubview:navScrollView];
    _navScrollView = navScrollView;
    navScrollView.tBlock = ^void(NSInteger a){
        [_mainScrollView setCurrentPage:a];
    };
    
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
