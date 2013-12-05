//
//  GTColor+ColorsAddition.h
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

#import <Foundation/Foundation.h>

#if TARGET_OS_IPHONE
    #import <UIKit/UIKit.h>
    #define GTColor UIColor
#else
    #import <AppKit/AppKit.h>
    #define GTColor NSColor
#endif

#warning Finish refactoring categories to use GT_ prefix for method names.

@interface GTColor (ColorsAddition)

///--------------------------------------------------
/// @name Creating Colors
///--------------------------------------------------

+ (GTColor *)GT_colorFromHex:(uint32_t)hexColor;
+ (GTColor *)GT_colorFromRGBWithRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue andAlpha:(CGFloat)alpha;

// Taken from the HexColors project
+ (GTColor *)GT_colorWithHexString:(NSString *)hexString;
+ (GTColor *)GT_colorWithHexString:(NSString *)hexString alpha:(CGFloat)alpha;
+ (GTColor *)GT_colorWith8BitRed:(NSInteger)red green:(NSInteger)green blue:(NSInteger)blue;
+ (GTColor *)GT_colorWith8BitRed:(NSInteger)red green:(NSInteger)green blue:(NSInteger)blue alpha:(CGFloat)alpha;

///--------------------------------------------------
/// @name Getting Random Colors
///--------------------------------------------------

+ (GTColor *)GT_randomColor;

///--------------------------------------------------
/// @name Getting Predefined Colors
///--------------------------------------------------

+ (GTColor *)GT_aliceBlueColor;
+ (GTColor *)GT_antiqueWhiteColor;
+ (GTColor *)GT_acquaColor;
+ (GTColor *)GT_acquamarineColor;
+ (GTColor *)GT_azureColor;

+ (GTColor *)GT_beigeColor;
+ (GTColor *)GT_bisqueColor;
+ (GTColor *)GT_blanchetAlmondColor;
+ (GTColor *)GT_blueVioletColor;
+ (GTColor *)GT_burlyWoodColor;

+ (GTColor *)cadetBlueColor;
+ (GTColor *)chartreuseColor;
+ (GTColor *)chocolateColor;
+ (GTColor *)coralColor;
+ (GTColor *)cornflowerColor;
+ (GTColor *)cornsilkColor;
+ (GTColor *)crimsonColor;

+ (GTColor *)darkBlueColor;
+ (GTColor *)darkCyanColor;
+ (GTColor *)darkGoldenrodColor;
+ (GTColor *)darkGreenColor;
+ (GTColor *)darkKhakiColor;
+ (GTColor *)darkMagentaColor;
+ (GTColor *)darkOliveGreenColor;
+ (GTColor *)darkOrangeColor;
+ (GTColor *)darkOrchidColor;
+ (GTColor *)darkRedColor;
+ (GTColor *)darkSalmonColor;
+ (GTColor *)darkSeaGreenColor;
+ (GTColor *)darkSlateBlueColor;
+ (GTColor *)darkSlateGrayColor;
+ (GTColor *)darkTurquoiseColor;
+ (GTColor *)darkVioletColor;
+ (GTColor *)deepPinkColor;
+ (GTColor *)deepSkyBlueColor;
+ (GTColor *)dimGrayColor;
+ (GTColor *)dodgerBlueColor;

+ (GTColor *)firebrickColor;
+ (GTColor *)floralWhiteColor;
+ (GTColor *)forestGreenColor;
+ (GTColor *)fuschiaColor;

+ (GTColor *)gainsboroColor;
+ (GTColor *)ghostWhiteColor;
+ (GTColor *)goldColor;
+ (GTColor *)golderonColor;
+ (GTColor *)greenYellowColor;

+ (GTColor *)honeydewColor;
+ (GTColor *)hotPinkColor;

+ (GTColor *)indianRedColor;
+ (GTColor *)indigoColor;
+ (GTColor *)ivoryColor;

+ (GTColor *)khakiColor;

+ (GTColor *)lavanderColor;
+ (GTColor *)lavanderBlushColor;
+ (GTColor *)lawnGreenColor;
+ (GTColor *)lemonChiffonColor;
+ (GTColor *)lightBlueColor;
+ (GTColor *)lightCoralColor;
+ (GTColor *)lightCyanColor;
+ (GTColor *)lightGoldenrodYellowColor;
+ (GTColor *)lightGreenColor;
+ (GTColor *)lightPinkColor;
+ (GTColor *)lightSalmonColor;
+ (GTColor *)lightSeaGreenColor;
+ (GTColor *)lightSkyBlueColor;
+ (GTColor *)lightSlateGrayColor;
+ (GTColor *)lightSteelBlueColor;
+ (GTColor *)lightYellowColor;
+ (GTColor *)limeColor;
+ (GTColor *)limeGreenColor;
+ (GTColor *)linenColor;

+ (GTColor *)maroonColor;
+ (GTColor *)mediumAcquamarineColor;
+ (GTColor *)mediumBlueColor;
+ (GTColor *)mediumOrchidColor;
+ (GTColor *)mediumPurpleColor;
+ (GTColor *)mediumSeaGreenColor;
+ (GTColor *)mediumSlateBlueColor;
+ (GTColor *)mediumSpringGreenColor;
+ (GTColor *)mediumTurquoiseColor;
+ (GTColor *)mediumVioletRedColor;
+ (GTColor *)midnightBlueColor;
+ (GTColor *)mintCreamColor;
+ (GTColor *)mistyRoseColor;
+ (GTColor *)moccasinColor;

+ (GTColor *)navajoWhiteColor;
+ (GTColor *)navyColor;

+ (GTColor *)oceanColor;
+ (GTColor *)oldLaceColor;
+ (GTColor *)oliveColor;
+ (GTColor *)oliveDrabColor;
+ (GTColor *)orangeRedColor;
+ (GTColor *)orchidColor;

+ (GTColor *)paleGoldenrodColor;
+ (GTColor *)paleGreenColor;
+ (GTColor *)paleTurquoiseColor;
+ (GTColor *)paleVioletRedColor;
+ (GTColor *)papayaWhipColor;
+ (GTColor *)peachPuffColor;
+ (GTColor *)peruColor;
+ (GTColor *)pinkColor;
+ (GTColor *)plumColor;
+ (GTColor *)powderBlueColor;

+ (GTColor *)rosyBrownColor;
+ (GTColor *)royalBlueColor;

+ (GTColor *)saddleBrownColor;
+ (GTColor *)salmonColor;
+ (GTColor *)sandyBrownColor;
+ (GTColor *)seaGreenColor;
+ (GTColor *)seaShellColor;
+ (GTColor *)siennaColor;
+ (GTColor *)silverColor;
+ (GTColor *)skyBlueColor;
+ (GTColor *)slateBlueColor;
+ (GTColor *)slateGrayColor;
+ (GTColor *)snowColor;
+ (GTColor *)springGreenColor;
+ (GTColor *)steelBlueColor;

+ (GTColor *)tanColor;
+ (GTColor *)tealColor;
+ (GTColor *)thistleColor;
+ (GTColor *)tomatoColor;
+ (GTColor *)turquoiseColor;

+ (GTColor *)violetColor;

+ (GTColor *)wheatColor;
+ (GTColor *)whiteSmokeColor;

+ (GTColor *)yellowGreenColor;

@end
