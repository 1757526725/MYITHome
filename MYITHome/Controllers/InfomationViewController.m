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
@interface InfomationViewController () <UIScrollViewDelegate>
@property (nonatomic, strong) void(^tBlock)(NSInteger);
@property (nonatomic, copy) NSMutableArray *navDataArr;
@end

@implementation InfomationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavBar];
    [self setMainScrollView];
    
}

- (void)setMainScrollView{
    MainScrollView *mainScrollView = [[MainScrollView alloc]initWithFrame:CGRectMake(0, 0, self.view.size_Width, self.view.size_Height-64) pages:_navDataArr];
    [self.view addSubview:mainScrollView];
}

- (void)setNavBar{
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:210.0f/255.0f green:45.0f/255.0f blue:49.0f/255.0f alpha:1]];//导航栏背景色
    [self.navigationController.navigationBar setTranslucent:NO];//关闭透明效果
    [self.navigationController.tabBarItem setTitle:@"资讯"];//配置tabBar
    [self.navigationController.tabBarItem setTitleTextAttributes:@{NSFontAttributeName : [UIFont fontWithName:@"HelveticaNeue-Bold" size:12.0F], NSForegroundColorAttributeName : [UIColor colorWithRed:210.0f/255.0f green:45.0f/255.0f blue:49.0f/255.0f alpha:1]} forState:UIControlStateSelected];
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
    __block NSMutableArray *weakDataArr = _navDataArr;//使用block触发导航栏按钮的点击事件
    NavScrollView *navScrollView = [[NavScrollView alloc]initWithFrame:CGRectMake(0, 0, self.view.size_Width, navigationBar.size_Height) data:dataArr];
    [navigationBar addSubview:navScrollView];
    navScrollView.tBlock = ^void(NSInteger a){
        NSDictionary *dic = weakDataArr[a];
        NSLog(@"切换到%@",dic[@"n"]);//待写
#warning NavScrollView switch views
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
