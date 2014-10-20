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

@interface GTColor (ColorsAddition)

///--------------------------------------------------
/// @name Creating Colors
///--------------------------------------------------

+ (GTColor *)GT_colorWithHex:(uint32_t)hexColor;
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

+ (GTColor *)GT_cadetBlueColor;
+ (GTColor *)GT_chartreuseColor;
+ (GTColor *)GT_chocolateColor;
+ (GTColor *)GT_coralColor;
+ (GTColor *)GT_cornflowerColor;
+ (GTColor *)GT_cornsilkColor;
+ (GTColor *)GT_crimsonColor;

+ (GTColor *)GT_darkBlueColor;
+ (GTColor *)GT_darkCyanColor;
+ (GTColor *)GT_darkGoldenrodColor;
+ (GTColor *)GT_darkGreenColor;
+ (GTColor *)GT_darkKhakiColor;
+ (GTColor *)GT_darkMagentaColor;
+ (GTColor *)GT_darkOliveGreenColor;
+ (GTColor *)GT_darkOrangeColor;
+ (GTColor *)GT_darkOrchidColor;
+ (GTColor *)GT_darkRedColor;
+ (GTColor *)GT_darkSalmonColor;
+ (GTColor *)GT_darkSeaGreenColor;
+ (GTColor *)GT_darkSlateBlueColor;
+ (GTColor *)GT_darkSlateGrayColor;
+ (GTColor *)GT_darkTurquoiseColor;
+ (GTColor *)GT_darkVioletColor;
+ (GTColor *)GT_deepPinkColor;
+ (GTColor *)GT_deepSkyBlueColor;
+ (GTColor *)GT_dimGrayColor;
+ (GTColor *)GT_dodgerBlueColor;

+ (GTColor *)GT_firebrickColor;
+ (GTColor *)GT_floralWhiteColor;
+ (GTColor *)GT_forestGreenColor;
+ (GTColor *)GT_fuschiaColor;

+ (GTColor *)GT_gainsboroColor;
+ (GTColor *)GT_ghostWhiteColor;
+ (GTColor *)GT_goldColor;
+ (GTColor *)GT_golderonColor;
+ (GTColor *)GT_greenYellowColor;

+ (GTColor *)GT_honeydewColor;
+ (GTColor *)GT_hotPinkColor;

+ (GTColor *)GT_indianRedColor;
+ (GTColor *)GT_indigoColor;
+ (GTColor *)GT_ivoryColor;

+ (GTColor *)GT_khakiColor;

+ (GTColor *)GT_lavanderColor;
+ (GTColor *)GT_lavanderBlushColor;
+ (GTColor *)GT_lawnGreenColor;
+ (GTColor *)GT_lemonChiffonColor;
+ (GTColor *)GT_lightBlueColor;
+ (GTColor *)GT_lightCoralColor;
+ (GTColor *)GT_lightCyanColor;
+ (GTColor *)GT_lightGoldenrodYellowColor;
+ (GTColor *)GT_lightGreenColor;
+ (GTColor *)GT_lightPinkColor;
+ (GTColor *)GT_lightSalmonColor;
+ (GTColor *)GT_lightSeaGreenColor;
+ (GTColor *)GT_lightSkyBlueColor;
+ (GTColor *)GT_lightSlateGrayColor;
+ (GTColor *)GT_lightSteelBlueColor;
+ (GTColor *)GT_lightYellowColor;
+ (GTColor *)GT_limeColor;
+ (GTColor *)GT_limeGreenColor;
+ (GTColor *)GT_linenColor;

+ (GTColor *)GT_maroonColor;
+ (GTColor *)GT_mediumAcquamarineColor;
+ (GTColor *)GT_mediumBlueColor;
+ (GTColor *)GT_mediumOrchidColor;
+ (GTColor *)GT_mediumPurpleColor;
+ (GTColor *)GT_mediumSeaGreenColor;
+ (GTColor *)GT_mediumSlateBlueColor;
+ (GTColor *)GT_mediumSpringGreenColor;
+ (GTColor *)GT_mediumTurquoiseColor;
+ (GTColor *)GT_mediumVioletRedColor;
+ (GTColor *)GT_midnightBlueColor;
+ (GTColor *)GT_mintCreamColor;
+ (GTColor *)GT_mistyRoseColor;
+ (GTColor *)GT_moccasinColor;

+ (GTColor *)GT_navajoWhiteColor;
+ (GTColor *)GT_navyColor;

+ (GTColor *)GT_oceanColor;
+ (GTColor *)GT_oldLaceColor;
+ (GTColor *)GT_oliveColor;
+ (GTColor *)GT_oliveDrabColor;
+ (GTColor *)GT_orangeRedColor;
+ (GTColor *)GT_orchidColor;

+ (GTColor *)GT_paleGoldenrodColor;
+ (GTColor *)GT_paleGreenColor;
+ (GTColor *)GT_paleTurquoiseColor;
+ (GTColor *)GT_paleVioletRedColor;
+ (GTColor *)GT_papayaWhipColor;
+ (GTColor *)GT_peachPuffColor;
+ (GTColor *)GT_peruColor;
+ (GTColor *)GT_pinkColor;
+ (GTColor *)GT_plumColor;
+ (GTColor *)GT_powderBlueColor;

+ (GTColor *)GT_rosyBrownColor;
+ (GTColor *)GT_royalBlueColor;

+ (GTColor *)GT_saddleBrownColor;
+ (GTColor *)GT_salmonColor;
+ (GTColor *)GT_sandyBrownColor;
+ (GTColor *)GT_seaGreenColor;
+ (GTColor *)GT_seaShellColor;
+ (GTColor *)GT_siennaColor;
+ (GTColor *)GT_silverColor;
+ (GTColor *)GT_skyBlueColor;
+ (GTColor *)GT_slateBlueColor;
+ (GTColor *)GT_slateGrayColor;
+ (GTColor *)GT_snowColor;
+ (GTColor *)GT_springGreenColor;
+ (GTColor *)GT_steelBlueColor;

+ (GTColor *)GT_tanColor;
+ (GTColor *)GT_tealColor;
+ (GTColor *)GT_thistleColor;
+ (GTColor *)GT_tomatoColor;
+ (GTColor *)GT_turquoiseColor;

+ (GTColor *)GT_violetColor;

+ (GTColor *)GT_wheatColor;
+ (GTColor *)GT_whiteSmokeColor;

+ (GTColor *)GT_yellowGreenColor;

@end
