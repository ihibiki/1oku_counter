//
//  WebView.m
//  1okuen_counter
//
//  Created by 今井 響 on 2014/12/14.
//  Copyright (c) 2014年 Hibiki Imai. All rights reserved.
//

#import "WebResponseView.h"

@interface WebResponseView()

@end

@implementation WebResponseView


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.webView = [[UIWebView alloc] init];
        self.webView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
        self.webView.center = CGPointMake(self.frame.size.width / 2, self.frame.size.height / 2);
        [self addSubview:self.webView];
        
    }
    
    return self;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
