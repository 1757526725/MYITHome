//
//  InfomationViewController.m
//  MYITHome
//
//  Created by 张万平 on 16/2/20.
//  Copyright © 2016年 iwpz. All rights reserved.
//

#import "InfomationViewController.h"
#import "NavScrollView.h"
#import "MainScrollView.h"
#import "MainTableViewCellModel.h"
#import "ArticleViewController.h"
@interface InfomationViewController () <UIScrollViewDelegate>
@property (nonatomic, strong) NavScrollView *navScrollView;
@property (nonatomic, strong) MainScrollView *mainScrollView;
@property (nonatomic, copy) NSMutableArray *navDataArr;
@end

@implementation InfomationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(pushViewController:) name:@"pushViewController" object:nil];//注册通知,在tableView中点击cell,由主控制器实现,push文章页
    [self setNavBar];
    [self setMainScrollView];
    
}


//通知触发事件
- (void)pushViewController:(NSNotification *)notif{
    NSDictionary *dic = notif.object;
    ArticleViewController *articleVC = [[ArticleViewController alloc]initWithModel:dic];
    [articleVC setHidesBottomBarWhenPushed:YES];
    [self.navigationItem setHidesBackButton:YES];
    [self.navigationController pushViewController:articleVC animated:YES];
}

//隐藏导航栏,IT之家原版客户端效果暂时还做不出来,继续努力!
-(void)viewWillAppear:(BOOL)animated{
    [self.navigationController.navigationBar setHidden:NO];
}

- (void)setMainScrollView{
    MainScrollView *mainScrollView = [[MainScrollView alloc]initWithFrame:CGRectMake(0, 0, self.view.size_Width, self.view.size_Height-64) pages:_navDataArr isInfo:YES];
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
    [self.navigationController.tabBarItem setTitleTextAttributes:@{NSFontAttributeName : [UIFont fontWithName:@"HelveticaNeue-Bold" size:12.0F], NSForegroundColorAttributeName : ITHOMERED} forState:UIControlStateSelected];
    [self.navigationController.tabBarItem setTitleTextAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:12.0F],  NSForegroundColorAttributeName:[UIColor grayColor]} forState:UIControlStateNormal];
    [self setNavBarViews:self.navigationController.navigationBar];
}

- (void)setNavBarViews:(UINavigationBar *)navigationBar{
    NSArray *array = @[@"最新",@"排行榜",@"苹果",@"手机",@"数码",@"WP",@"安卓",@"Windows"];//资讯页导航栏项目没有发现有API,所以直接构建了.
    NSMutableArray *dataArr = [[NSMutableArray alloc]init];
    //遍历数组构建数据字典
    [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSMutableDictionary *dataDic = [[NSMutableDictionary alloc]init];
        [dataDic setObject:[NSString stringWithFormat:@"%ld",idx] forKey:@"id"];
        [dataDic setObject:array[idx] forKey:@"n"];
        [dataArr addObject:dataDic];
    }];
    _navDataArr = dataArr;
    NavScrollView *navScrollView = [[NavScrollView alloc]initWithFrame:CGRectMake(0, 0, self.view.size_Width, navigationBar.size_Height) data:dataArr];
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
