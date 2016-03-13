//
//  ScanViewController.m
//  MYITHome
//
//  Created by 张万平 on 16/3/14.
//  Copyright © 2016年 iwpz. All rights reserved.
//

#import "ScanViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface ScanViewController ()<AVCaptureMetadataOutputObjectsDelegate,UIScrollViewDelegate>
@property (nonatomic, strong)AVCaptureSession * session;
@property (nonatomic, strong) NSString *url;
@property (nonatomic, assign) BOOL flashFlag;
@property (nonatomic, strong) UIBarButtonItem *rightItem;
@property (nonatomic, strong) UIScrollView *moveScrollView;
@property (nonatomic, strong) NSTimer *timer;
@end

@implementation ScanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _flashFlag = NO;
    self.hidesBottomBarWhenPushed=NO;
    [self.navigationController.navigationBar setAlpha:0.3];
    [self.navigationController.navigationBar setTranslucent:YES];
    [self.navigationController.navigationBar setBarTintColor:[UIColor blackColor]];
        [self.navigationItem setTitle:@"扫扫看"];
    UIBarButtonItem *leftBarItem = [[UIBarButtonItem alloc]init];
    [leftBarItem setImage:[[UIImage imageNamed:@"back"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [self.navigationItem setLeftBarButtonItem:leftBarItem];
    [leftBarItem setAction:@selector(leftClicked)];
    [leftBarItem setTarget:self];
    UIBarButtonItem *rightBarItem = [[UIBarButtonItem alloc]init];
    [rightBarItem setImage:[[UIImage imageNamed:@"闪光灯关着"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [self.navigationItem setRightBarButtonItem:rightBarItem];
    _rightItem = rightBarItem;
    [rightBarItem setAction:@selector(rightClicked)];
    [rightBarItem setTarget:self];
    [leftBarItem setTarget:self];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self setAVCaptures];
}

- (void)setAVCaptures{
    AVCaptureDevice * device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    AVCaptureDeviceInput * input = [AVCaptureDeviceInput deviceInputWithDevice:device error:nil];
    AVCaptureMetadataOutput * output = [[AVCaptureMetadataOutput alloc]init];
    
    output.rectOfInterest = CGRectMake(((self.view.size_Height-self.view.size_Width*3/5)/2)/self.view.size_Height, (self.view.size_Width/5)/self.view.size_Width, (self.view.size_Width*3/5)/self.view.size_Height,(self.view.size_Width*3/5)/self.view.size_Width);
    [output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    _session = [[AVCaptureSession alloc]init];
    [_session setSessionPreset:AVCaptureSessionPresetHigh];
    [_session addInput:input];
    [_session addOutput:output];
    output.metadataObjectTypes=@[AVMetadataObjectTypeQRCode,AVMetadataObjectTypeEAN13Code, AVMetadataObjectTypeEAN8Code, AVMetadataObjectTypeCode128Code];
    
    AVCaptureVideoPreviewLayer * layer = [AVCaptureVideoPreviewLayer layerWithSession:_session];
    layer.videoGravity=AVLayerVideoGravityResizeAspectFill;
    layer.frame=self.view.layer.bounds;
    [self.view.layer insertSublayer:layer atIndex:0];
    [self setLayers];
}

- (void)setLayers{
    UIImageView *middleView = [[UIImageView alloc]initWithFrame:CGRectMake (self.view.size_Width/5 ,(self.view.size_Height-self.view.size_Width*3/5)/2 ,self.view.size_Width*3/5,self.view.size_Width*3/5)];
    [middleView setBackgroundColor:[UIColor clearColor]];
    [middleView setAlpha:0.5];
    [middleView setImage:[UIImage imageNamed:@"QRCode_FK"]];
    [self.view addSubview:middleView];
    _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(handleMaxShowTimer:) userInfo: nil repeats:YES];
    UIScrollView *blueScroll = [[UIScrollView alloc]initWithFrame:CGRectMake(middleView.size_X, middleView.size_Y, middleView.size_Width, middleView.size_Height)];
    _moveScrollView = blueScroll;
    [blueScroll setContentSize:CGSizeMake(blueScroll.size_Width, blueScroll.size_Height*3)];
    [blueScroll setShowsVerticalScrollIndicator:NO];
    [_moveScrollView setContentOffset:CGPointMake(0, _moveScrollView.size_Height*2) animated:YES];
    [blueScroll setScrollEnabled:NO];
    [blueScroll setDelegate:self];
    for (NSInteger i = 0; i<3; i++) {
        UIImageView *imgv = [[UIImageView alloc]initWithFrame:CGRectMake(0, i*blueScroll.size_Height, blueScroll.size_Width, blueScroll.size_Height)];
        [imgv setImage:[UIImage imageNamed:@"QRCode_Blue"]];
        [imgv setBackgroundColor:[UIColor clearColor]];
        [blueScroll addSubview:imgv];
    }
    [self.view addSubview:blueScroll];
    [blueScroll setBackgroundColor:[UIColor clearColor]];
    UIView *headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.size_Width, (self.view.size_Height-(self.view.size_Width/5*3))/2)];
    [headView setBackgroundColor:[UIColor blackColor]];
    [headView setAlpha:0.3];
    [self.view addSubview:headView];
    UILabel *Tags = [[UILabel alloc]initWithFrame:CGRectMake(self.view.size_Width/5, (self.view.size_Height-self.view.size_Width*3/5)/2-40, self.view.size_Width*3/5+20, 40)];
    [Tags setBackgroundColor:[UIColor clearColor]];
    [Tags setTextColor:[UIColor whiteColor]];
    [Tags setText:@"将取景器对准二维码,即可自动扫描"];
    [Tags setFont:[UIFont systemFontOfSize:15]];
    UIView *leaftView = [[UIView alloc]initWithFrame:CGRectMake(0, (self.view.size_Height-self.view.size_Width*3/5)/2, (self.view.size_Width/5), (self.view.size_Width/5)*3)];
    [leaftView setBackgroundColor:[UIColor blackColor]];
    [leaftView setAlpha:0.3];
    [self.view addSubview:leaftView];
    [self.view addSubview:Tags];
    UIView *rightView = [[UIView alloc]initWithFrame:CGRectMake((self.view.size_Width/5)*4, (self.view.size_Height-self.view.size_Width*3/5)/2, (self.view.size_Width/5), (self.view.size_Width/5)*3)];
    [rightView setBackgroundColor:[UIColor blackColor]];
    [rightView setAlpha:0.3];
    [self.view addSubview:rightView];
    UIView *footView = [[UIView alloc]initWithFrame:CGRectMake(0, headView.size_Y_Height+self.view.size_Width/5*3, self.view.size_Width, (self.view.size_Height-(self.view.size_Width/5*3))/2)];
    [footView setBackgroundColor:[UIColor blackColor]];
    [footView setAlpha:0.3];
    [self.view addSubview:footView];
}

- (void)handleMaxShowTimer:(NSTimer *)timer{
    NSInteger currentPage = _moveScrollView.contentOffset.y/_moveScrollView.size_Height;
    if (currentPage == 0) {
        [_moveScrollView setContentOffset:CGPointMake(0, _moveScrollView.size_Height*2)];
        currentPage = 2;
    }
    [_moveScrollView setContentOffset:CGPointMake(0, _moveScrollView.size_Height*(currentPage - 1)) animated:YES];
}

- (void)leftClicked{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)rightClicked{
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    if ([device hasTorch]) {
        [device lockForConfiguration:nil];
        if (_flashFlag == NO) {
            [device setTorchMode: AVCaptureTorchModeOn];
            [_rightItem setImage:[[UIImage imageNamed:@"闪光灯开着"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
            
            _flashFlag = YES;
        }
        else{
            [device setTorchMode: AVCaptureTorchModeOff];
            [_rightItem setImage:[[UIImage imageNamed:@"闪光灯关着"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
            _flashFlag = NO;
        }
        [device unlockForConfiguration];
    }
}

-(void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection{
    if (metadataObjects.count>0) {
        AVMetadataMachineReadableCodeObject * metadataObject = [metadataObjects objectAtIndex : 0 ];
        _url = metadataObject.stringValue;
        [_delegate putURL:_url];
        [_session stopRunning];
//        NSNotification *notification =[NSNotification notificationWithName:@"pleasePushResult" object:[NSDictionary dictionaryWithObjectsAndKeys:_url,@"url", nil] userInfo:nil];
//        [[NSNotificationCenter defaultCenter] postNotification:notification];
        [self.navigationController popViewControllerAnimated:NO];
    }
}

- (void)viewWillAppear:(BOOL)animated{
    [_session startRunning];
}

- (void)backToRoot{
    [self.navigationController.navigationBar setBarTintColor:ITHOMERED];
    [self.navigationController.navigationBar setTranslucent:NO];
    [self.navigationController.navigationBar setAlpha:1];
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
