//
//  ITSquareViewController.m
//  MYITHome
//
//  Created by 张万平 on 16/2/20.
//  Copyright © 2016年 iwpz. All rights reserved.
//

#import "ITSquareViewController.h"

@interface ITSquareViewController ()

@end

@implementation ITSquareViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:210.0f/255.0f green:45.0f/255.0f blue:49.0f/255.0f alpha:1]];
    [self.navigationController.navigationBar setTranslucent:NO];
    [self.navigationItem setTitle:@"IT圈"];
    [self.navigationController.tabBarItem setTitle:@"IT圈"];
    [self.navigationController.tabBarItem setTitleTextAttributes:@{NSFontAttributeName : [UIFont fontWithName:@"HelveticaNeue-Bold" size:12.0F], NSForegroundColorAttributeName : [UIColor colorWithRed:210.0f/255.0f green:45.0f/255.0f blue:49.0f/255.0f alpha:1]} forState:UIControlStateSelected];
    [self.navigationController.tabBarItem setTitleTextAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:12.0F],  NSForegroundColorAttributeName:[UIColor grayColor]} forState:UIControlStateNormal];
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
