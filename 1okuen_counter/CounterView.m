//
//  counterView.m
//  1okuen_counter
//
//  Created by 今井 響 on 2014/12/02.
//  Copyright (c) 2014年 Hibiki Imai. All rights reserved.
//

#import "CounterView.h"

@interface CounterView()

@property UILabel *counterLabel;
@property UILabel *titleLabel;

@end

@implementation CounterView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.counterLabel = [self _createCounterLabel];
        [self addSubview:self.counterLabel];
        self.titleLabel = [self _createTitleLabel];
        [self addSubview:self.titleLabel];
    }
    
    return self;
}

- (UILabel *)_createCounterLabel
{
    //１億円カウンターを表示するラベル
    UILabel *label = [[UILabel alloc] init];
    
    NSDictionary *blackFontAttributes =
        @{NSForegroundColorAttributeName:[UIColor blackColor],
          NSFontAttributeName:[UIFont boldSystemFontOfSize:18.0f]};
    self.okuCounter =
    [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%i", self.price]
                                               attributes:blackFontAttributes];
    
    label.attributedText = self.okuCounter;
    label.textAlignment = NSTextAlignmentCenter;
    [label sizeToFit];
    label.center = CGPointMake(self.frame.size.width / 2, self.frame.size.height / 2);
    return label;
}

- (UILabel *)_createTitleLabel
{
    //タイトル表示のラベル
    UILabel *label = [[UILabel alloc] init];
    label.text = @"目指せ1億円！現在の価格は・・・";
    label.textAlignment = NSTextAlignmentCenter;
    [label sizeToFit];
    label.center = CGPointMake(self.frame.size.width / 2, (self.frame.size.height / 2) - 40);
    return label;
}

- (void) setPrice:(int)price
{
    //priceのセッターをオーバーライドしている
    //priceを変えた際に、(NSMutableAttributedString）okuCounterの値をセットしなおし、
    //counterLabelのプロパティもセットしなおして再描画
    
    _price = price;
    [self.okuCounter replaceCharactersInRange:NSMakeRange(0, self.okuCounter.length) withString:[NSString stringWithFormat:@"%i", self.price]];
    self.counterLabel.attributedText = self.okuCounter;
    [self.counterLabel sizeToFit];
    [self setNeedsDisplay];
}

/*
 Only override drawRect: if you perform custom drawing.
 An empty implementation adversely affects performance during animation.
*/
//- (void)drawRect:(CGRect)rect
//{
//    [super drawRect:rect];
//}


@end
