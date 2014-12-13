//
//  WebViewController.m
//  1okuen_counter
//
//  Created by 今井 響 on 2014/12/14.
//  Copyright (c) 2014年 Hibiki Imai. All rights reserved.
//

#import "WebResponseViewController.h"
#import "WebResponseView.h"

@interface WebResponseViewController ()

@property WebResponseView *webResponseView;

@end

@implementation WebResponseViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    CGRect rect;
    rect = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    
    self.webResponseView = [[WebResponseView alloc] initWithFrame:rect];
    self.webResponseView.center = CGPointMake(self.view.frame.size.width * 0.5,
                                      self.view.frame.size.height * 0.5);
    [self.view addSubview:self.webResponseView];
    
    
    NSString* urlString = @"http://google.com";
    NSURL* googleURL = [NSURL URLWithString: urlString];
    NSURLRequest* myRequest = [NSURLRequest requestWithURL: googleURL];
    [self.webResponseView.webView loadRequest:myRequest];

    
    
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
