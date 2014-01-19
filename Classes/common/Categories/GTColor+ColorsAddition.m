//
//  GTColor+ColorsAddition.m
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

#import "GTColor+ColorsAddition.h"

@implementation GTColor (ColorsAddition)

#pragma mark - Helpers

+ (GTColor *)GT_colorWithHex:(uint32_t)hexColor
{
    CGFloat blue = (hexColor & 0xff) / 255.0f;
    CGFloat green = (hexColor >> 8 & 0xff) / 255.0f;
    CGFloat red = (hexColor >> 16 & 0xff) / 255.0f;
    
    return [[self class] GT_colorWithRed:red green:green blue:blue alpha:1.0];
}

+ (GTColor *)GT_colorWithHexString:(NSString *)hexString
{
    return [[self class] GT_colorWithHexString:hexString alpha:1.0];
}

+ (GTColor *)GT_colorWithHexString:(NSString *)hexString alpha:(CGFloat)alpha
{
    // Check for hash and add the missing hash
    if('#' != [hexString characterAtIndex:0])
    {
        hexString = [NSString stringWithFormat:@"#%@", hexString];
    }
    
    // check for string length
    assert(7 == hexString.length || 4 == hexString.length);
    
    // check for 3 character HexStrings
    hexString = [[self class] GT_hexStringTransformFromThreeCharacters:hexString];
    
    NSString *redHex    = [NSString stringWithFormat:@"0x%@", [hexString substringWithRange:NSMakeRange(1, 2)]];
    unsigned redInt = [[self class] hexValueToUnsigned:redHex];
    
    NSString *greenHex  = [NSString stringWithFormat:@"0x%@", [hexString substringWithRange:NSMakeRange(3, 2)]];
    unsigned greenInt = [[self class] hexValueToUnsigned:greenHex];
    
    NSString *blueHex   = [NSString stringWithFormat:@"0x%@", [hexString substringWithRange:NSMakeRange(5, 2)]];
    unsigned blueInt = [[self class] hexValueToUnsigned:blueHex];
    
    GTColor *color = [[self class] GT_colorWith8BitRed:redInt green:greenInt blue:blueInt alpha:alpha];
    
    return color;
}

+ (GTColor *)GT_colorWith8BitRed:(NSInteger)red green:(NSInteger)green blue:(NSInteger)blue
{
    return [[self class] GT_colorWith8BitRed:red green:green blue:blue alpha:1.0];
}

+ (GTColor *)GT_colorWith8BitRed:(NSInteger)red green:(NSInteger)green blue:(NSInteger)blue alpha:(CGFloat)alpha
{
    return [[self class] GT_colorWithRed:(red / 255.0) green:(green / 255.0) blue:(blue / 255.0) alpha:alpha];
}

+ (GTColor *)GT_colorWithWhite:(CGFloat)white alpha:(CGFloat)alpha
{
    return [[self class] GT_colorWithRed:white green:white blue:white alpha:alpha];
}

+ (GTColor *)GT_colorWithRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue alpha:(CGFloat)alpha
{
#if TARGET_OS_IPHONE
    return [[self class] colorWithRed:red green:green blue:blue alpha:alpha];
#else
    return [[self class] colorWithCalibratedRed:red green:green blue:blue alpha:alpha];
#endif
}

+ (NSString *)GT_hexStringTransformFromThreeCharacters:(NSString *)hexString
{
    if (hexString.length == 4) {
        hexString = [NSString stringWithFormat:@"#%@%@%@%@%@%@",
                     [hexString substringWithRange:NSMakeRange(1, 1)],[hexString substringWithRange:NSMakeRange(1, 1)],
                     [hexString substringWithRange:NSMakeRange(2, 1)],[hexString substringWithRange:NSMakeRange(2, 1)],
                     [hexString substringWithRange:NSMakeRange(3, 1)],[hexString substringWithRange:NSMakeRange(3, 1)]];
    }
    
    return hexString;
}

+ (unsigned)hexValueToUnsigned:(NSString *)hexValue
{
    unsigned value = 0;
    
    NSScanner *hexValueScanner = [NSScanner scannerWithString:hexValue];
    [hexValueScanner scanHexInt:&value];
    
    return value;
}

+ (GTColor *)GT_colorFromRGBWithRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue andAlpha:(CGFloat)alpha
{
    if (alpha > 1.0) 
        alpha = 1.0;
    else if (alpha < 0.0)
        alpha = 0.0;
    
    return [[self class] GT_colorWith8BitRed:red green:green blue:blue];
}

+ (GTColor *)GT_randomColor
{
    CGFloat blue = arc4random() % 255;
    CGFloat red = arc4random() % 255;
    CGFloat green = arc4random() % 255;
    
    return [[self class] GT_colorWith8BitRed:red green:green blue:blue];
}

#pragma mark - Colors

+ (GTColor *)GT_aliceBlueColor
{
    return [[self class] GT_colorWithRed:0.941 green:0.973 blue:1.000 alpha:1.000];
}

+ (GTColor *)GT_antiqueWhiteColor
{
    return [[self class] GT_colorWithRed:0.980 green:0.922 blue:0.843 alpha:1.000];
}

+ (GTColor *)GT_acquaColor
{
    return [[self class] GT_colorWithRed:0.000 green:1.000 blue:1.000 alpha:1.000];
}

+ (GTColor *)GT_acquamarineColor
{
    return [[self class] GT_colorWithRed:0.498 green:1.000 blue:0.831 alpha:1.000];
}

+ (GTColor *)GT_azureColor
{
    return [[self class] GT_colorWithRed:0.498 green:1.000 blue:0.831 alpha:1.000];
}

+ (GTColor *)GT_beigeColor
{
    return [[self class] GT_colorWithRed:0.961 green:0.961 blue:0.863 alpha:1.000];
}

+ (GTColor *)GT_bisqueColor
{
    return [[self class] GT_colorWithRed:1.000 green:0.894 blue:0.769 alpha:1.000];
}

+ (GTColor *)GT_blanchetAlmondColor
{
    return [[self class] GT_colorWithRed:1.000 green:1.000 blue:0.804 alpha:1.000];
}

+ (GTColor *)GT_blueVioletColor
{
    return [[self class] GT_colorWithRed:0.541 green:0.169 blue:0.886 alpha:1.000];
}

+ (GTColor *)GT_burlyWoodColor
{
    return [[self class] GT_colorWithRed:0.871 green:0.722 blue:0.529 alpha:1.000];
}

+ (GTColor *)GT_cadetBlueColor
{
    return [[self class] GT_colorWithRed:0.373 green:0.620 blue:0.627 alpha:1.000];
}

+ (GTColor *)GT_chartreuseColor
{
    return [[self class] GT_colorWithRed:0.498 green:1.000 blue:0.000 alpha:1.000];
}

+ (GTColor *)GT_chocolateColor
{
    return [[self class] GT_colorWithRed:0.824 green:0.412 blue:0.118 alpha:1.000];
}

+ (GTColor *)GT_coralColor
{
    return [[self class] GT_colorWithRed:1.000 green:0.498 blue:0.314 alpha:1.000];
}

+ (GTColor *)GT_cornflowerColor
{
    return [[self class] GT_colorWithRed:0.392 green:0.584 blue:0.929 alpha:1.000];
}

+ (GTColor *)GT_cornsilkColor
{
    return [[self class] GT_colorWithRed:1.000 green:0.973 blue:0.863 alpha:1.000];
}

+ (GTColor *)GT_crimsonColor
{
    return [[self class] GT_colorWithRed:0.863 green:0.078 blue:0.235 alpha:1.000];
}

+ (GTColor *)GT_darkBlueColor
{
    return [[self class] GT_colorWithRed:0.000 green:0.000 blue:0.545 alpha:1.000];
}

+ (GTColor *)GT_darkCyanColor
{
    return [[self class] GT_colorWithRed:0.000 green:0.545 blue:0.545 alpha:1.000];
}

+ (GTColor *)GT_darkGoldenrodColor
{
    return [[self class] GT_colorWithRed:0.722 green:0.525 blue:0.043 alpha:1.000];
}

+ (GTColor *)GT_darkGreenColor
{
    return [[self class] GT_colorWithRed:0.000 green:0.392 blue:0.000 alpha:1.000];
}

+ (GTColor *)GT_darkKhakiColor
{
    return [[self class] GT_colorWithRed:0.741 green:0.718 blue:0.420 alpha:1.000];
}

+ (GTColor *)GT_darkMagentaColor
{
    return [[self class] GT_colorWithRed:0.545 green:0.000 blue:0.545 alpha:1.000];
}

+ (GTColor *)GT_darkOliveGreenColor
{
    return [[self class] GT_colorWithRed:0.333 green:0.420 blue:0.184 alpha:1.000];
}

+ (GTColor *)GT_darkOrangeColor
{
    return [[self class] GT_colorWithRed:1.000 green:0.549 blue:0.000 alpha:1.000];
}

+ (GTColor *)GT_darkOrchidColor
{
    return [[self class] GT_colorWithRed:0.600 green:0.196 blue:0.800 alpha:1.000];
}

+ (GTColor *)GT_darkRedColor
{
    return [[self class] GT_colorWithRed:0.545 green:0.000 blue:0.000 alpha:1.000];
}

+ (GTColor *)GT_darkSalmonColor
{
    return [[self class] GT_colorWithRed:0.914 green:0.588 blue:0.478 alpha:1.000];
}

+ (GTColor *)GT_darkSeaGreenColor
{
    return [[self class] GT_colorWithRed:0.561 green:0.737 blue:0.561 alpha:1.000];
}

+ (GTColor *)GT_darkSlateBlueColor
{
    return [[self class] GT_colorWithRed:0.282 green:0.239 blue:0.545 alpha:1.000];
}

+ (GTColor *)GT_darkSlateGrayColor
{
    return [[self class] GT_colorWithRed:0.157 green:0.310 blue:0.310 alpha:1.000];
}

+ (GTColor *)GT_darkTurquoiseColor
{
    return [[self class] GT_colorWithRed:0.000 green:0.808 blue:0.820 alpha:1.000];
}

+ (GTColor *)GT_darkVioletColor
{
    return [[self class] GT_colorWithRed:0.580 green:0.000 blue:0.827 alpha:1.000];
}

+ (GTColor *)GT_deepPinkColor
{
    return [[self class] GT_colorWithRed:1.000 green:0.078 blue:0.576 alpha:1.000];
}

+ (GTColor *)GT_deepSkyBlueColor
{
    return [[self class] GT_colorWithRed:0.000 green:0.749 blue:1.000 alpha:1.000];
}

+ (GTColor *)GT_dimGrayColor
{
    return [[self class] GT_colorWithWhite:0.412 alpha:1.000];
}

+ (GTColor *)GT_dodgerBlueColor
{
    return [[self class] GT_colorWithRed:0.118 green:0.565 blue:1.000 alpha:1.000];
}

+ (GTColor *)GT_firebrickColor
{
    return [[self class] GT_colorWithRed:0.698 green:0.133 blue:0.133 alpha:1.000];
}

+ (GTColor *)GT_floralWhiteColor
{
    return [[self class] GT_colorWithRed:1.000 green:0.980 blue:0.941 alpha:1.000];
}

+ (GTColor *)GT_forestGreenColor
{
    return [[self class] GT_colorWithRed:0.133 green:0.545 blue:0.133 alpha:1.000];
}

+ (GTColor *)GT_fuschiaColor
{
    return [[self class] GT_colorWithRed:1.000 green:0.000 blue:1.000 alpha:1.000];
}

+ (GTColor *)GT_gainsboroColor
{
    return [[self class] GT_colorWithWhite:0.863 alpha:1.000];
}

+ (GTColor *)GT_ghostWhiteColor
{
    return [[self class] GT_colorWithRed:0.973 green:0.973 blue:1.000 alpha:1.000];
}

+ (GTColor *)GT_goldColor
{
    return [[self class] GT_colorWithRed:1.000 green:0.843 blue:0.000 alpha:1.000];
}

+ (GTColor *)GT_golderonColor
{
    return [[self class] GT_colorWithRed:0.855 green:0.647 blue:0.125 alpha:1.000];
}

+ (GTColor *)GT_greenYellowColor
{
    return [[self class] GT_colorWithRed:0.678 green:1.000 blue:0.184 alpha:1.000];
}

+ (GTColor *)GT_honeydewColor
{
    return [[self class] GT_colorWithRed:0.941 green:1.000 blue:0.941 alpha:1.000];
}

+ (GTColor *)GT_hotPinkColor
{
    return [[self class] GT_colorWithRed:1.000 green:0.412 blue:0.706 alpha:1.000];
}

+ (GTColor *)GT_indianRedColor
{
    return [[self class] GT_colorWithRed:0.804 green:0.361 blue:0.361 alpha:1.000];
}

+ (GTColor *)GT_indigoColor
{
    return [[self class] GT_colorWithRed:0.294 green:0.000 blue:0.510 alpha:1.000];
}

+ (GTColor *)GT_ivoryColor
{
    return [[self class] GT_colorWithRed:1.000 green:0.941 blue:0.941 alpha:1.000];
}

+ (GTColor *)GT_khakiColor
{
    return [[self class] GT_colorWithRed:0.941 green:0.902 blue:0.549 alpha:1.000];
}

+ (GTColor *)GT_lavanderColor
{
    return [[self class] GT_colorWithRed:0.902 green:0.902 blue:0.980 alpha:1.000];
}

+ (GTColor *)GT_lavanderBlushColor
{
    return [[self class] GT_colorWithRed:1.000 green:0.941 blue:0.961 alpha:1.000];
}

+ (GTColor *)GT_lawnGreenColor
{
    return [[self class] GT_colorWithRed:0.486 green:0.988 blue:0.000 alpha:1.000];
}

+ (GTColor *)GT_lemonChiffonColor
{
    return [[self class] GT_colorWithRed:1.000 green:0.980 blue:0.804 alpha:1.000];
}

+ (GTColor *)GT_lightBlueColor
{
    return [[self class] GT_colorWithRed:0.678 green:0.847 blue:0.902 alpha:1.000];
}

+ (GTColor *)GT_lightCoralColor
{
    return [[self class] GT_colorWithRed:0.941 green:0.502 blue:0.502 alpha:1.000];
}

+ (GTColor *)GT_lightCyanColor
{
    return [[self class] GT_colorWithRed:0.878 green:1.000 blue:1.000 alpha:1.000];
}

+ (GTColor *)GT_lightGoldenrodYellowColor
{
    return [[self class] GT_colorWithRed:0.980 green:0.980 blue:0.824 alpha:1.000];
}

+ (GTColor *)GT_lightGreenColor
{
    return [[self class] GT_colorWithRed:0.565 green:0.933 blue:0.565 alpha:1.000];
}

+ (GTColor *)GT_lightPinkColor
{
    return [[self class] GT_colorWithRed:1.000 green:0.753 blue:0.757 alpha:1.000];
}

+ (GTColor *)GT_lightSalmonColor
{
    return [[self class] GT_colorWithRed:1.000 green:0.627 blue:0.478 alpha:1.000];
}

+ (GTColor *)GT_lightSeaGreenColor
{
    return [[self class] GT_colorWithRed:0.125 green:0.698 blue:0.667 alpha:1.000];
}

+ (GTColor *)GT_lightSkyBlueColor
{
    return [[self class] GT_colorWithRed:0.529 green:0.808 blue:0.980 alpha:1.000];
}

+ (GTColor *)GT_lightSlateGrayColor
{
    return [[self class] GT_colorWithRed:0.467 green:0.533 blue:0.600 alpha:1.000];
}

+ (GTColor *)GT_lightSteelBlueColor
{
    return [[self class] GT_colorWithRed:0.690 green:0.769 blue:0.871 alpha:1.000];
}

+ (GTColor *)GT_lightYellowColor
{
    return [[self class] GT_colorWithRed:1.000 green:1.000 blue:0.878 alpha:1.000];
}

+ (GTColor *)GT_limeColor
{
    return [[self class] GT_colorWithRed:0.000 green:1.000 blue:0.000 alpha:1.000];
}

+ (GTColor *)GT_limeGreenColor
{
    return [[self class] GT_colorWithRed:0.196 green:0.804 blue:0.196 alpha:1.000];
}

+ (GTColor *)GT_linenColor
{
    return [[self class] GT_colorWithRed:0.980 green:0.941 blue:0.902 alpha:1.000];
}

+ (GTColor *)GT_maroonColor
{
    return [[self class] GT_colorWithRed:0.502 green:0.000 blue:0.000 alpha:1.000];
}

+ (GTColor *)GT_mediumAcquamarineColor
{
    return [[self class] GT_colorWithRed:0.420 green:0.804 blue:0.667 alpha:1.000];
}

+ (GTColor *)GT_mediumBlueColor
{
    return [[self class] GT_colorWithRed:0.000 green:0.000 blue:0.804 alpha:1.000];
}

+ (GTColor *)GT_mediumOrchidColor
{
    return [[self class] GT_colorWithRed:0.729 green:0.333 blue:0.827 alpha:1.000];
}

+ (GTColor *)GT_mediumPurpleColor
{
    return [[self class] GT_colorWithRed:0.576 green:0.439 blue:0.859 alpha:1.000];
}

+ (GTColor *)GT_mediumSeaGreenColor
{
    return [[self class] GT_colorWithRed:0.235 green:0.702 blue:0.443 alpha:1.000];
}

+ (GTColor *)GT_mediumSlateBlueColor
{
    return [[self class] GT_colorWithRed:0.482 green:0.408 blue:0.933 alpha:1.000];
}

+ (GTColor *)GT_mediumSpringGreenColor
{
    return [[self class] GT_colorWithRed:0.000 green:0.980 blue:0.604 alpha:1.000];
}

+ (GTColor *)GT_mediumTurquoiseColor
{
    return [[self class] GT_colorWithRed:0.282 green:0.820 blue:0.800 alpha:1.000];
}

+ (GTColor *)GT_mediumVioletRedColor
{
    return [[self class] GT_colorWithRed:0.780 green:0.082 blue:0.439 alpha:1.000];
}

+ (GTColor *)GT_midnightBlueColor
{
    return [[self class] GT_colorWithRed:0.098 green:0.098 blue:0.439 alpha:1.000];
}

+ (GTColor *)GT_mintCreamColor
{
    return [[self class] GT_colorWithRed:0.961 green:1.000 blue:0.980 alpha:1.000];
}

+ (GTColor *)GT_mistyRoseColor
{
    return [[self class] GT_colorWithRed:1.000 green:0.894 blue:0.882 alpha:1.000];
}

+ (GTColor *)GT_moccasinColor
{
    return [[self class] GT_colorWithRed:1.000 green:0.894 blue:0.710 alpha:1.000];
}

+ (GTColor *)GT_navajoWhiteColor
{
    return [[self class] GT_colorWithRed:1.000 green:0.871 blue:0.678 alpha:1.000];
}

+ (GTColor *)GT_navyColor
{
    return [[self class] GT_colorWithRed:0.000 green:0.000 blue:0.502 alpha:1.000];
}

+ (GTColor *)GT_oceanColor
{
    return [[self class] GT_colorWithRed:0.000 green:0.251 blue:0.502 alpha:1.000];
}

+ (GTColor *)GT_oldLaceColor
{
    return [[self class] GT_colorWithRed:0.992 green:0.961 blue:0.902 alpha:1.000];
}

+ (GTColor *)GT_oliveColor
{
    return [[self class] GT_colorWithRed:0.502 green:0.502 blue:0.000 alpha:1.000];
}

+ (GTColor *)GT_oliveDrabColor
{
    return [[self class] GT_colorWithRed:0.420 green:0.557 blue:0.176 alpha:1.000];
}

+ (GTColor *)GT_orangeRedColor
{
    return [[self class] GT_colorWithRed:1.000 green:0.271 blue:0.000 alpha:1.000];
}

+ (GTColor *)GT_orchidColor
{
    return [[self class] GT_colorWithRed:0.855 green:0.439 blue:0.839 alpha:1.000];
}

+ (GTColor *)GT_paleGoldenrodColor
{
    return [[self class] GT_colorWithRed:0.933 green:0.910 blue:0.667 alpha:1.000];
}

+ (GTColor *)GT_paleGreenColor
{
    return [[self class] GT_colorWithRed:0.596 green:0.984 blue:0.596 alpha:1.000];
}

+ (GTColor *)GT_paleTurquoiseColor
{
    return [[self class] GT_colorWithRed:0.686 green:0.933 blue:0.933 alpha:1.000];
}

+ (GTColor *)GT_paleVioletRedColor
{
    return [[self class] GT_colorWithRed:0.859 green:0.439 blue:0.576 alpha:1.000];
}

+ (GTColor *)GT_papayaWhipColor
{
    return [[self class] GT_colorWithRed:1.000 green:0.937 blue:0.608 alpha:1.000];
}

+ (GTColor *)GT_peachPuffColor
{
    return [[self class] GT_colorWithRed:1.000 green:0.855 blue:0.608 alpha:1.000];
}

+ (GTColor *)GT_peruColor
{
    return [[self class] GT_colorWithRed:0.804 green:0.522 blue:0.247 alpha:1.000];
}

+ (GTColor *)GT_pinkColor
{
    return [[self class] GT_colorWithRed:1.000 green:0.753 blue:0.796 alpha:1.000];
}

+ (GTColor *)GT_plumColor
{
    return [[self class] GT_colorWithRed:0.867 green:0.627 blue:0.867 alpha:1.000];
}

+ (GTColor *)GT_powderBlueColor
{
    return [[self class] GT_colorWithRed:0.690 green:0.878 blue:0.902 alpha:1.000];
}

+ (GTColor *)GT_rosyBrownColor
{
    return [[self class] GT_colorWithRed:0.737 green:0.561 blue:0.561 alpha:1.000];
}

+ (GTColor *)GT_royalBlueColor
{
    return [[self class] GT_colorWithRed:0.255 green:0.412 blue:0.882 alpha:1.000];
}

+ (GTColor *)GT_saddleBrownColor
{
    return [[self class] GT_colorWithRed:0.545 green:0.271 blue:0.075 alpha:1.000];
}

+ (GTColor *)GT_salmonColor
{
    return [[self class] GT_colorWithRed:0.980 green:0.502 blue:0.447 alpha:1.000];
}

+ (GTColor *)GT_sandyBrownColor
{
    return [[self class] GT_colorWithRed:0.957 green:0.643 blue:0.376 alpha:1.000];
}

+ (GTColor *)GT_seaGreenColor
{
    return [[self class] GT_colorWithRed:0.180 green:0.545 blue:0.341 alpha:1.000];
}

+ (GTColor *)GT_seaShellColor
{
    return [[self class] GT_colorWithRed:1.000 green:0.961 blue:0.933 alpha:1.000];
}

+ (GTColor *)GT_siennaColor
{
    return [[self class] GT_colorWithRed:0.627 green:0.322 blue:0.176 alpha:1.000];
}

+ (GTColor *)GT_silverColor
{
    return [[self class] GT_colorWithWhite:0.753 alpha:1.000];
}

+ (GTColor *)GT_skyBlueColor
{
    return [[self class] GT_colorWithRed:0.529 green:0.808 blue:0.922 alpha:1.000];
}

+ (GTColor *)GT_slateBlueColor
{
    return [[self class] GT_colorWithRed:0.416 green:0.353 blue:0.804 alpha:1.000];
}

+ (GTColor *)GT_slateGrayColor
{
    return [[self class] GT_colorWithRed:0.439 green:0.502 blue:0.565 alpha:1.000];
}

+ (GTColor *)GT_snowColor
{
    return [[self class] GT_colorWithRed:1.000 green:0.980 blue:0.980 alpha:1.000];
}

+ (GTColor *)GT_springGreenColor
{
    return [[self class] GT_colorWithRed:0.000 green:1.000 blue:0.498 alpha:1.000];
}

+ (GTColor *)GT_steelBlueColor
{
    return [[self class] GT_colorWithRed:0.275 green:0.510 blue:0.706 alpha:1.000];
}

+ (GTColor *)GT_tanColor
{
    return [[self class] GT_colorWithRed:0.824 green:0.706 blue:0.549 alpha:1.000];
}

+ (GTColor *)GT_tealColor
{
    return [[self class] GT_colorWithRed:0.000 green:0.502 blue:0.502 alpha:1.000];
}

+ (GTColor *)GT_thistleColor
{
    return [[self class] GT_colorWithRed:0.847 green:0.749 blue:0.847 alpha:1.000];
}

+ (GTColor *)GT_tomatoColor
{
    return [[self class] GT_colorWithRed:0.992 green:0.388 blue:0.278 alpha:1.000];
}

+ (GTColor *)GT_turquoiseColor
{
    return [[self class] GT_colorWithRed:0.251 green:0.878 blue:0.816 alpha:1.000];
}

+ (GTColor *)GT_violetColor
{
    return [[self class] GT_colorWithRed:0.933 green:0.510 blue:0.933 alpha:1.000];
}

+ (GTColor *)GT_wheatColor
{
    return [[self class] GT_colorWithRed:0.961 green:0.871 blue:0.702 alpha:1.000];
}

+ (GTColor *)GT_whiteSmokeColor
{
    return [[self class] GT_colorWithWhite:0.961 alpha:1.000];
}

+ (GTColor *)GT_yellowGreenColor
{
    return [[self class] GT_colorWithRed:0.604 green:0.804 blue:0.196 alpha:1.000];
}

@end
