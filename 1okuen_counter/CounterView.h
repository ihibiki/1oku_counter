//
//  counterView.h
//  1okuen_counter
//
//  Created by 今井 響 on 2014/12/02.
//  Copyright (c) 2014年 Hibiki Imai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CounterView : UIView

@property int price;
@property float averageIncreasePerSecond;
@property NSMutableAttributedString *okuCounter;
@property UILabel *testLabel;

@end
