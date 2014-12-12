//
//  ViewController.m
//  1okuen_counter
//
//  Created by 今井 響 on 2014/12/02.
//  Copyright (c) 2014年 Hibiki Imai. All rights reserved.
//

#import "CounterViewController.h"
#import "CounterView.h"
#import "AFNetworking.h"
#import "MotionViewController.h"

@interface CounterViewController ()

@property CounterView *counterView;
@property NSMutableArray *lastGetPrices; //直近APIを叩いて取得した10日分の1億カウンターの額
@property UIButton *buttonToMotion;

@end

@implementation CounterViewController

NSTimer *timer = nil;
int sequence = 0;   //NSTimer内でのリアルタイム予想更新の回数管理変数
int autoUpdateTime = 20;  //sequenceの上限（終了したら再びAPIを叩く）



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    CGRect rect;
    rect = CGRectMake(0, 0, 200, 100);
    
    self.counterView = [[CounterView alloc] initWithFrame:rect];
    [self.counterView sizeToFit];
    self.counterView.center = CGPointMake(self.view.frame.size.width * 0.5,
                                          self.view.frame.size.height * 0.5);

    [self.view addSubview:self.counterView];
    self.lastGetPrices = [NSMutableArray array];
    
    self.buttonToMotion = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.buttonToMotion.frame = CGRectMake(10, 10, 100, 30);
    [self.buttonToMotion setTitle:@"画面遷移するよ" forState:UIControlStateNormal];
    
    [self.buttonToMotion addTarget:self action:@selector(pushButtonToMotion:)
                     forControlEvents:UIControlEventTouchDown];
    [self.buttonToMotion sizeToFit];
    self.buttonToMotion.center = CGPointMake(self.view.frame.size.width * 0.5,
                                          self.view.frame.size.height * 0.5 + 120);
    [self.view addSubview:self.buttonToMotion];

}

- (void)requestPriceToApi
{
    //APIを叩き、1億カウンターの額を取得
    NSString *url = @"http://ibeya-wake-api-server-balancer-1769943675.ap-northeast-1.elb.amazonaws.com/api/savings";
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject){
        
        //通信が正常に終了した場合の処理
        //取得したデータをjsonObjectに変換した上で、self.lastGetPricesにintとして格納する（日付はここでは格納していない）
        NSError *error = nil;
        NSDictionary *jsonObject = [NSJSONSerialization JSONObjectWithData:operation.responseObject options:NSJSONReadingAllowFragments error:&error];
        for(int i = 0; i < 10; i++)
        {
            if([self.lastGetPrices count] < 10)  //１回目の格納のタイミングでのみ、addObjectを用いている
            {
                [self.lastGetPrices addObject:[NSNumber numberWithInteger:[[[jsonObject valueForKey:@"savings"][i] valueForKey:@"value"] intValue]]];
            }else{
                [self.lastGetPrices replaceObjectAtIndex:i withObject:[NSNumber numberWithInteger:[[[jsonObject valueForKey:@"savings"][i] valueForKey:@"value"] intValue]]];
            }
        }
        
        //現在の価格をself.counterView.priceに格納。平均増加価格を計算
        //NSTimerでupdatePriceを呼び、リアルタイム予想更新を実施
        self.counterView.price = [[self.lastGetPrices objectAtIndex:0] intValue];
        [self calculateAverageIncreasePerSecond];
        [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(updatePrice:) userInfo:nil repeats:YES];
    }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        //通信が異常終了した場合の処理
        NSLog(@"%@", error);
        
    }];
    
    [operation start];
}


- (void)calculateAverageIncreasePerSecond
{
    //1億円カウンターの1秒あたりの増加額を計算。過去9日分の価格との差異から出る1秒あたり増加額の平均をとっている
    float sumIncrease;
    float currentPrice = self.counterView.price;
    for(int i = 1; i < 10; i++)
    {
        float pastPrice = [[self.lastGetPrices objectAtIndex:i] intValue];
        sumIncrease += (currentPrice - pastPrice)/(60 * 60 * 24 * i);
    }
    self.counterView.averageIncreasePerSecond = roundf(sumIncrease/10);
}

- (void)updatePrice:(NSTimer *)timer
{
    self.counterView.price += self.counterView.averageIncreasePerSecond * (rand()/20);
    //変化がないのでひとまず適当な値を以下で追加
    self.counterView.price += rand()/200000000;
    sequence++;
    if(sequence > autoUpdateTime && [timer isValid])
    {
        //設定したautoUpdateTimeが過ぎたタイミングでタイマーを停止し、再びAPIを叩いて・・・
        sequence = 0;
        [timer invalidate];
        [self requestPriceToApi];
    }
}

- (void)pushButtonToMotion:(id)sender
{
    UIViewController *next = [[MotionViewController alloc] init];
    next.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self presentViewController:next animated:YES completion:^ {
        // 完了時の処理をここに書きます
    }];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    //APIを叩いて・・・のメソッド呼び出し
    [self requestPriceToApi];
    [super viewWillAppear:animated];
}

@end
