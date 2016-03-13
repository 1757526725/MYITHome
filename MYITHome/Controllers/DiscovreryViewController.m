//
//  DiscovreryViewController.m
//  MYITHome
//
//  Created by 张万平 on 16/2/20.
//  Copyright © 2016年 iwpz. All rights reserved.
//

#import "DiscovreryViewController.h"
#import "ScanViewController.h"
#import "ScanedViewController.h"

@interface DiscovreryViewController ()<UITableViewDelegate,UITableViewDataSource,ScanDelegate>

@end

@implementation DiscovreryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _UUU = @"";
    self.hidesBottomBarWhenPushed=YES;
    [self.view setBackgroundColor:ColorWithRGB(234, 234, 234, 1)];
    [self.navigationController.navigationBar setBarTintColor:ITHOMERED];
    [self.navigationController.navigationBar setTranslucent:NO];
    [self.navigationItem setTitle:@"发现"];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    [self.navigationController.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor lightGrayColor]} forState:UIControlStateNormal];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(pushResultViewController:) name:@"pleasePushResult" object:nil];
    [self setViews];
}

//- (void)pushResultViewController:(NSNotification *)noti{
//    NSDictionary *dic = noti.object;
//    ScanedViewController *svc = [[ScanedViewController alloc]initWithURL:[dic objectForKey:@"url"]];
//    [self.navigationController pushViewController:svc animated:YES];
//}

- (void)setViews{
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.size_Width, self.view.size_Height)];
    [tableView setBackgroundColor:[UIColor lightGrayColor]];
    [tableView setScrollEnabled:NO];
    [tableView setDelegate:self];
    [tableView setDataSource:self];
    [self.view addSubview:tableView];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40;
}

- (void)viewWillAppear:(BOOL)animated{
    [self.navigationController.navigationBar setTranslucent:NO];
    [self.navigationController.navigationBar setAlpha:1];
    [self.navigationController popViewControllerAnimated:YES];
    [self.navigationController.navigationBar setBarTintColor:ITHOMERED];
    if (![_UUU isEqualToString:@""]) {
        ScanedViewController *svc = [[ScanedViewController alloc]initWithURL:_UUU];
        [self.navigationController pushViewController:svc animated:YES];
        _UUU = @"";
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    switch (section) {
        case 0:
            return 1;
            break;
        case 1:
            return 1;
            break;
        case 2:
            return 2;
            break;
            
        default:
            break;
    }
    return 0;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.size_Width, 20)];
    [view setBackgroundColor:ColorWithRGB(234, 234, 234, 1)];
    return view;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *cellIdentifier = @"CellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    [cell setBackgroundColor:[UIColor whiteColor]];
    if (indexPath.section == 0) {
        [cell.imageView setImage:[UIImage imageNamed:@"扫扫看"]];
        [cell.textLabel setText:@"扫扫看"];
    }
    else if (indexPath.section == 1) {
        [cell.imageView setImage:[UIImage imageNamed:@"搜索"]];
        [cell.textLabel setText:@"搜索"];
    }
    else{
        if (indexPath.row == 0) {
            [cell.imageView setImage:[UIImage imageNamed:@"应用"]];
            [cell.textLabel setText:@"应用推荐"];
        }
        else{
            [cell.imageView setImage:[UIImage imageNamed:@"游戏"]];
            [cell.textLabel setText:@"游戏"];
        }
    }
    
    if (indexPath.section + indexPath.row == 3)/*最大的section+最大的row表示是最后一个cell */{
        [tableView setFrame:CGRectMake(0, 0, tableView.size_Width, 40*3 +cell.size_Height*4-1)];
    }
    //[cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    return cell;
}

- (void)putURL:(NSString *)url{
    _UUU = url;

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        ScanViewController *scanVC = [[ScanViewController alloc]init];
        [scanVC setDelegate:self];
        [self.navigationItem setHidesBackButton:YES];
        [self.navigationController pushViewController:scanVC animated:YES];
        if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
            self.navigationController.interactivePopGestureRecognizer.delegate = nil;
        }
    }
    else if (indexPath.section == 1) {
        NSLog(@"搜索");
    }
    else{
        if (indexPath.row == 0) {
            NSLog(@"应用推荐");
        }
        else{
            NSLog(@"游戏");
        }
    }
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
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
