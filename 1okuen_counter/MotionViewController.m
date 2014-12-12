//
//  MotionViewController.m
//  1okuen_counter
//
//  Created by 今井 響 on 2014/12/11.
//  Copyright (c) 2014年 Hibiki Imai. All rights reserved.
//

#import "MotionViewController.h"
#import "MotionView.h"
#import <CoreMotion/CoreMotion.h>//

@interface MotionViewController ()

@property MotionView *motionView;
@property CMMotionManager *motionManager;
@property UIButton *buttonToMeasure;
@property UIButton *buttonToStop;

@end

@implementation MotionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    CGRect rect;
    rect = CGRectMake(0, 0, 200, 100);
    
    self.motionManager = [[CMMotionManager alloc] init];
    self.motionManager.deviceMotionUpdateInterval = 0.1;
    
    self.motionView = [[MotionView alloc] initWithFrame:rect];
    [self.motionView sizeToFit];
    self.motionView.center = CGPointMake(self.view.frame.size.width * 0.5,
                                          self.view.frame.size.height * 0.5);
    
    [self.view addSubview:self.motionView];
    
    self.buttonToMeasure = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.buttonToMeasure.frame = CGRectMake(10, 10, 100, 30);
    [self.buttonToMeasure setTitle:@"Motion取得開始！" forState:UIControlStateNormal];
    
    [self.buttonToMeasure addTarget:self action:@selector(startMeasuring:)
                  forControlEvents:UIControlEventTouchDown];
    [self.buttonToMeasure sizeToFit];
    self.buttonToMeasure.center = CGPointMake(self.view.frame.size.width * 0.5,
                                             self.view.frame.size.height * 0.5 + 120);
    [self.view addSubview:self.buttonToMeasure];
    
    self.buttonToStop = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.buttonToStop.frame = CGRectMake(10, 10, 100, 30);
    [self.buttonToStop setTitle:@"Motion取得終了！" forState:UIControlStateNormal];
    
    [self.buttonToStop addTarget:self action:@selector(stopMeasuring:)
                   forControlEvents:UIControlEventTouchDown];
    [self.buttonToStop sizeToFit];
    self.buttonToStop.center = CGPointMake(self.view.frame.size.width * 0.5,
                                              self.view.frame.size.height * 0.5 + 200);
    [self.view addSubview:self.buttonToStop];


    
}

- (void)startMeasuring:(id)sender
{
    NSLog(@"メソッド呼ばれたよ！");
    if(self.motionManager.isDeviceMotionAvailable){
        //モーションデータ更新時のハンドラを作成
        void(^handler)(CMDeviceMotion *, NSError *) = ^(CMDeviceMotion *motion, NSError *error){
            self.motionView.XLabel.text = [NSString stringWithFormat:@"X方向の加速度は %f ,ジャイロは %f",
                                           self.motionManager.accelerometerData.acceleration.x,
                                           self.motionManager.gyroData.rotationRate.x];
            self.motionView.YLabel.text = [NSString stringWithFormat:@"Y方向の加速度は %f ,ジャイロは %f",
                                           self.motionManager.accelerometerData.acceleration.y,
                                           self.motionManager.gyroData.rotationRate.y];
            self.motionView.ZLabel.text = [NSString stringWithFormat:@"Z方向の加速度は %f ,ジャイロは %f",
                                           self.motionManager.accelerometerData.acceleration.z,
                                           self.motionManager.gyroData.rotationRate.z];
            NSLog(@"無事MorionDataは取れました");
    };
    
        NSOperationQueue *queue = [NSOperationQueue currentQueue];
        [self.motionManager startDeviceMotionUpdatesToQueue:queue withHandler:handler];
    }else{
        NSLog(@"モーション使えないわこれ");
    }
}

- (void)stopMeasuring:(id)sender
{
    NSLog(@"しっかり計測終了しました！");
    [self.motionManager stopDeviceMotionUpdates];
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
