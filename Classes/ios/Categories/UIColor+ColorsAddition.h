//
//  UIColor+ColorsAddition.h
//  GTFoundation
//
//  Created by Gianluca Tranchedone on 14/08/13.
//  The MIT License (MIT)
//
//  Copyright (c) 2013 Gianluca Tranchedone
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy of
//  this software and associated documentation files (the "Software"), to deal in
//  the Software without restriction, including without limitation the rights to
//  use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
//  the Software, and to permit persons to whom the Software is furnished to do so,
//  subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
//  FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
//  COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
//  IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
//  CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
//
//  This category is inspired by the post "Colorful Code" by Gallant Games
//  ( http://gallantgames.com/posts/2011/01/colorful-code ).

#if TARGET_OS_IPHONE

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#define GT_INCOME_TEXT_COLOR [UIColor colorFromRGBWithRed:143 green:194 blue:72 andAlpha:1]
#define GT_EXPENSES_TEXT_COLOR [UIColor lightCoralColor]

@interface UIColor (ColorsAddition)

// Useful Methods

+ (UIColor *)colorFromHex:(uint32_t)hexColor;
+ (UIColor *)colorFromRGBWithRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue andAlpha:(CGFloat)alpha;
+ (UIColor *)randomColor;

+ (NSString *)stringFromColor:(UIColor *)color;

// iOS SDK Colors

+ (UIColor *)groupTableViewTextColor;

// Colors

+ (UIColor *)aliceBlueColor;
+ (UIColor *)antiqueWhiteColor;
+ (UIColor *)acquaColor;
+ (UIColor *)acquamarineColor;
+ (UIColor *)azureColor;

+ (UIColor *)beigeColor;
+ (UIColor *)bisqueColor;
+ (UIColor *)blanchetAlmondColor;
+ (UIColor *)blueVioletColor;
+ (UIColor *)burlyWoodColor;

+ (UIColor *)cadetBlueColor;
+ (UIColor *)chartreuseColor;
+ (UIColor *)chocolateColor;
+ (UIColor *)coralColor;
+ (UIColor *)cornflowerColor;
+ (UIColor *)cornsilkColor;
+ (UIColor *)crimsonColor;

+ (UIColor *)darkBlueColor;
+ (UIColor *)darkCyanColor;
+ (UIColor *)darkGoldenrodColor;
+ (UIColor *)darkGreenColor;
+ (UIColor *)darkKhakiColor;
+ (UIColor *)darkMagentaColor;
+ (UIColor *)darkOliveGreenColor;
+ (UIColor *)darkOrangeColor;
+ (UIColor *)darkOrchidColor;
+ (UIColor *)darkRedColor;
+ (UIColor *)darkSalmonColor;
+ (UIColor *)darkSeaGreenColor;
+ (UIColor *)darkSlateBlueColor;
+ (UIColor *)darkSlateGrayColor;
+ (UIColor *)darkTurquoiseColor;
+ (UIColor *)darkVioletColor;
+ (UIColor *)deepPinkColor;
+ (UIColor *)deepSkyBlueColor;
+ (UIColor *)dimGrayColor;
+ (UIColor *)dodgerBlueColor;

+ (UIColor *)firebrickColor;
+ (UIColor *)floralWhiteColor;
+ (UIColor *)forestGreenColor;
+ (UIColor *)fuschiaColor;

+ (UIColor *)gainsboroColor;
+ (UIColor *)ghostWhiteColor;
+ (UIColor *)goldColor;
+ (UIColor *)golderonColor;
+ (UIColor *)greenYellowColor;

+ (UIColor *)honeydewColor;
+ (UIColor *)hotPinkColor;

+ (UIColor *)indianRedColor;
+ (UIColor *)indigoColor;
+ (UIColor *)ivoryColor;

+ (UIColor *)khakiColor;

+ (UIColor *)lavanderColor;
+ (UIColor *)lavanderBlushColor;
+ (UIColor *)lawnGreenColor;
+ (UIColor *)lemonChiffonColor;
+ (UIColor *)lightBlueColor;
+ (UIColor *)lightCoralColor;
+ (UIColor *)lightCyanColor;
+ (UIColor *)lightGoldenrodYellowColor;
+ (UIColor *)lightGreenColor;
+ (UIColor *)lightPinkColor;
+ (UIColor *)lightSalmonColor;
+ (UIColor *)lightSeaGreenColor;
+ (UIColor *)lightSkyBlueColor;
+ (UIColor *)lightSlateGrayColor;
+ (UIColor *)lightSteelBlueColor;
+ (UIColor *)lightYellowColor;
+ (UIColor *)limeColor;
+ (UIColor *)limeGreenColor;
+ (UIColor *)linenColor;

+ (UIColor *)maroonColor;
+ (UIColor *)mediumAcquamarineColor;
+ (UIColor *)mediumBlueColor;
+ (UIColor *)mediumOrchidColor;
+ (UIColor *)mediumPurpleColor;
+ (UIColor *)mediumSeaGreenColor;
+ (UIColor *)mediumSlateBlueColor;
+ (UIColor *)mediumSpringGreenColor;
+ (UIColor *)mediumTurquoiseColor;
+ (UIColor *)mediumVioletRedColor;
+ (UIColor *)midnightBlueColor;
+ (UIColor *)mintCreamColor;
+ (UIColor *)mistyRoseColor;
+ (UIColor *)moccasinColor;

+ (UIColor *)navajoWhiteColor;
+ (UIColor *)navyColor;

+ (UIColor *)oceanColor;
+ (UIColor *)oldLaceColor;
+ (UIColor *)oliveColor;
+ (UIColor *)oliveDrabColor;
+ (UIColor *)orangeRedColor;
+ (UIColor *)orchidColor;

+ (UIColor *)paleGoldenrodColor;
+ (UIColor *)paleGreenColor;
+ (UIColor *)paleTurquoiseColor;
+ (UIColor *)paleVioletRedColor;
+ (UIColor *)papayaWhipColor;
+ (UIColor *)peachPuffColor;
+ (UIColor *)peruColor;
+ (UIColor *)pinkColor;
+ (UIColor *)plumColor;
+ (UIColor *)powderBlueColor;

+ (UIColor *)rosyBrownColor;
+ (UIColor *)royalBlueColor;

+ (UIColor *)saddleBrownColor;
+ (UIColor *)salmonColor;
+ (UIColor *)sandyBrownColor;
+ (UIColor *)seaGreenColor;
+ (UIColor *)seaShellColor;
+ (UIColor *)siennaColor;
+ (UIColor *)silverColor;
+ (UIColor *)skyBlueColor;
+ (UIColor *)slateBlueColor;
+ (UIColor *)slateGrayColor;
+ (UIColor *)snowColor;
+ (UIColor *)springGreenColor;
+ (UIColor *)steelBlueColor;

+ (UIColor *)tanColor;
+ (UIColor *)tealColor;
+ (UIColor *)thistleColor;
+ (UIColor *)tomatoColor;
+ (UIColor *)turquoiseColor;

+ (UIColor *)violetColor;

+ (UIColor *)wheatColor;
+ (UIColor *)whiteSmokeColor;

+ (UIColor *)yellowGreenColor;

// Sketch To Code Colors

+ (UIColor *)STCBarColor;

@end

#endif
