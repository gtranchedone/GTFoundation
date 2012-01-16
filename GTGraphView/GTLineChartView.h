//
//  GTLineChartView.h
//  GTFrameworkDemo
//
//  Created by Gianluca Tranchedone on 15/01/12.
//  Copyright (c) 2012 SketchToCode. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GTGraphView.h"

@class GTLineChartPoint;

@interface GTLineChartView : GTGraphView

@end

/*** GTLineChartPoint ***/

@interface GTLineChartPoint : UIView

@property (nonatomic, copy) NSString *title;

@end
