//
//  MainTabBarController.m
//  MYITHome
//
//  Created by 张万平 on 16/2/19.
//  Copyright © 2016年 iwpz. All rights reserved.
//

#import "MainTabBarController.h"
#import "InfomationViewController.h"
#import "ITSquareViewController.h"
#import "DiscovreryViewController.h"
#import "MineViewController.h"
@interface MainTabBarController ()

@end

@implementation MainTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tabBar setTintColor:[UIColor whiteColor]];
    [self setViewControllers];
}

- (void)setViewControllers{
    InfomationViewController *informationVC = [[InfomationViewController alloc]init];
    UINavigationController *informationNav = [[UINavigationController alloc]initWithRootViewController:informationVC];
    [informationNav.tabBarItem setTitle:@"资讯"];
    [informationNav.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:ColorWithRGB(255, 143, 92, 1)} forState:UIControlStateSelected];
    //item0.selectedImage = [[UIImage imageNamed:@"recognize-1"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];;
    [informationNav.tabBarItem setImage:[[UIImage imageNamed:@"TabBarIcon_Infomation"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [informationNav.tabBarItem setSelectedImage:[[UIImage imageNamed:@"TabBarIcon_Infomation_Highlighted"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [informationNav.tabBarItem setImageInsets:UIEdgeInsetsMake(6, 6, 6, 6)];
    
    ITSquareViewController *itSquareVC = [[ITSquareViewController alloc]init];
    UINavigationController *itSquareNav = [[UINavigationController alloc]initWithRootViewController:itSquareVC];
    [itSquareNav.tabBarItem setTitle:@"IT圈"];
    [itSquareNav.tabBarItem setImage:[[UIImage imageNamed:@"TabBarIcon_ITSquare"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [itSquareNav.tabBarItem setSelectedImage:[[UIImage imageNamed:@"TabBarIcon_ITSquare_Highlighted"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [itSquareNav.tabBarItem setImageInsets:UIEdgeInsetsMake(6, 6, 6, 6)];
    
    DiscovreryViewController *discovreryVC = [[DiscovreryViewController alloc]init];
    UINavigationController *discovreryNav = [[UINavigationController alloc]initWithRootViewController:discovreryVC];
    [discovreryNav.tabBarItem setTitle:@"发现"];
    [discovreryNav.tabBarItem setImage:[[UIImage imageNamed:@"TabBarIcon_Discovrery"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [discovreryNav.tabBarItem setSelectedImage:[[UIImage imageNamed:@"TabBarIcon_Discovrery_Highlighted"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [discovreryNav.tabBarItem setImageInsets:UIEdgeInsetsMake(6, 6, 6, 6)];
    
    MineViewController *mineVC = [[MineViewController alloc]init];
    UINavigationController *mineNav = [[UINavigationController alloc]initWithRootViewController:mineVC];
    [mineNav.tabBarItem setTitle:@"我"];
    [mineNav.tabBarItem setImage:[[UIImage imageNamed:@"TabBarIcon_Mine"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [mineNav.tabBarItem setSelectedImage:[[UIImage imageNamed:@"TabBarIcon_Mine_Highlighted"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [mineNav.tabBarItem setImageInsets:UIEdgeInsetsMake(6, 6, 6, 6)];
    
    [self setViewControllers:@[informationNav,itSquareNav,discovreryNav,mineNav]];
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
