//
//  MotionView.m
//  1okuen_counter
//
//  Created by 今井 響 on 2014/12/11.
//  Copyright (c) 2014年 Hibiki Imai. All rights reserved.
//

#import "MotionView.h"

@implementation MotionView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    UILabel *label = [[UILabel alloc] init];
    label.text = @"Motion取得した結果の数値はこれだ！！";
    label.textAlignment = NSTextAlignmentCenter;
    [label sizeToFit];
    label.center = CGPointMake(self.frame.size.width / 2, (self.frame.size.height / 2) - 40);
    [self addSubview:label];

    self.XLabel = [[UILabel alloc] init];
    self.XLabel.text = @"X";
    self.XLabel.textAlignment = NSTextAlignmentCenter;
    [self.XLabel sizeToFit];
    self.XLabel.center = CGPointMake(self.frame.size.width / 2, self.frame.size.height / 2);
    [self addSubview:self.XLabel];

    self.YLabel = [[UILabel alloc] init];
    self.YLabel.text = @"Y";
    self.YLabel.textAlignment = NSTextAlignmentCenter;
    [self.YLabel sizeToFit];
    self.YLabel.center = CGPointMake(self.frame.size.width / 2, (self.frame.size.height / 2) + 40);
    [self addSubview:self.YLabel];

    self.ZLabel = [[UILabel alloc] init];
    self.ZLabel.text = @"Z";
    self.ZLabel.textAlignment = NSTextAlignmentCenter;
    [self.ZLabel sizeToFit];
    self.ZLabel.center = CGPointMake(self.frame.size.width / 2, (self.frame.size.height / 2) + 80);
    [self addSubview:self.ZLabel];

    
    return self;
}

- (void)setXLabel:(UILabel *)XLabel
{
    _XLabel = XLabel;
    [self.XLabel setNeedsDisplay];
}

- (void)setYLabel:(UILabel *)YLabel
{
    _YLabel = YLabel;
    [self.YLabel setNeedsDisplay];
}

- (void)setZLabel:(UILabel *)ZLabel
{
    _ZLabel = ZLabel;
    [self.ZLabel setNeedsDisplay];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
