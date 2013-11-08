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

+ (GTColor *)colorFromHex:(uint32_t)hexColor
{
    CGFloat blue = (hexColor & 0xff) / 255.0f;
    CGFloat green = (hexColor >> 8 & 0xff) / 255.0f;
    CGFloat red = (hexColor >> 16 & 0xff) / 255.0f;
    
    return [GTColor GT_colorWithRed:red green:green blue:blue alpha:1.0];
}

+ (GTColor *)colorWithHexString:(NSString *)hexString
{
    return [[self class] colorWithHexString:hexString alpha:1.0];
}

+ (GTColor *)colorWithHexString:(NSString *)hexString alpha:(CGFloat)alpha
{
    // Check for hash and add the missing hash
    if('#' != [hexString characterAtIndex:0])
    {
        hexString = [NSString stringWithFormat:@"#%@", hexString];
    }
    
    // check for string length
    assert(7 == hexString.length || 4 == hexString.length);
    
    // check for 3 character HexStrings
    hexString = [[self class] hexStringTransformFromThreeCharacters:hexString];
    
    NSString *redHex    = [NSString stringWithFormat:@"0x%@", [hexString substringWithRange:NSMakeRange(1, 2)]];
    unsigned redInt = [[self class] hexValueToUnsigned:redHex];
    
    NSString *greenHex  = [NSString stringWithFormat:@"0x%@", [hexString substringWithRange:NSMakeRange(3, 2)]];
    unsigned greenInt = [[self class] hexValueToUnsigned:greenHex];
    
    NSString *blueHex   = [NSString stringWithFormat:@"0x%@", [hexString substringWithRange:NSMakeRange(5, 2)]];
    unsigned blueInt = [[self class] hexValueToUnsigned:blueHex];
    
    GTColor *color = [GTColor colorWith8BitRed:redInt green:greenInt blue:blueInt alpha:alpha];
    
    return color;
}

+ (GTColor *)colorWith8BitRed:(NSInteger)red green:(NSInteger)green blue:(NSInteger)blue
{
    return [[self class] colorWith8BitRed:red green:green blue:blue alpha:1.0];
}

+ (GTColor *)colorWith8BitRed:(NSInteger)red green:(NSInteger)green blue:(NSInteger)blue alpha:(CGFloat)alpha
{
    return [GTColor GT_colorWithRed:(red / 255.0) green:(green / 255.0) blue:(blue / 255.0) alpha:alpha];
}

+ (GTColor *)GT_colorWithWhite:(CGFloat)white alpha:(CGFloat)alpha
{
    return [self GT_colorWithRed:white green:white blue:white alpha:alpha];
}

+ (GTColor *)GT_colorWithRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue alpha:(CGFloat)alpha
{
#if TARGET_OS_IPHONE
    return [GTColor colorWithRed:red green:green blue:blue alpha:alpha];
#else
    return [GTColor colorWithCalibratedRed:red green:green blue:blue alpha:alpha];
#endif
}

+ (NSString *)hexStringTransformFromThreeCharacters:(NSString *)hexString
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

+ (GTColor *)colorFromRGBWithRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue andAlpha:(CGFloat)alpha
{
    if (alpha > 1.0) 
        alpha = 1.0;
    else if (alpha < 0.0)
        alpha = 0.0;
    
    return [[self class] colorWith8BitRed:red green:green blue:blue];
}

+ (GTColor *)randomColor
{
    CGFloat blue = arc4random() % 255;
    CGFloat red = arc4random() % 255;
    CGFloat green = arc4random() % 255;
    
    return [[self class] colorWith8BitRed:red green:green blue:blue];
}

#pragma mark - Colors

+ (GTColor *)aliceBlueColor
{
    return [GTColor GT_colorWithRed:0.941 green:0.973 blue:1.000 alpha:1.000];
}

+ (GTColor *)antiqueWhiteColor
{
    return [GTColor GT_colorWithRed:0.980 green:0.922 blue:0.843 alpha:1.000];
}

+ (GTColor *)acquaColor
{
    return [GTColor GT_colorWithRed:0.000 green:1.000 blue:1.000 alpha:1.000];
}

+ (GTColor *)acquamarineColor
{
    return [GTColor GT_colorWithRed:0.498 green:1.000 blue:0.831 alpha:1.000];
}

+ (GTColor *)azureColor
{
    return [GTColor GT_colorWithRed:0.498 green:1.000 blue:0.831 alpha:1.000];
}

+ (GTColor *)beigeColor
{
    return [GTColor GT_colorWithRed:0.961 green:0.961 blue:0.863 alpha:1.000];
}

+ (GTColor *)bisqueColor
{
    return [GTColor GT_colorWithRed:1.000 green:0.894 blue:0.769 alpha:1.000];
}

+ (GTColor *)blanchetAlmondColor
{
    return [GTColor GT_colorWithRed:1.000 green:1.000 blue:0.804 alpha:1.000];
}

+ (GTColor *)blueVioletColor
{
    return [GTColor GT_colorWithRed:0.541 green:0.169 blue:0.886 alpha:1.000];
}

+ (GTColor *)burlyWoodColor
{
    return [GTColor GT_colorWithRed:0.871 green:0.722 blue:0.529 alpha:1.000];
}

+ (GTColor *)cadetBlueColor
{
    return [GTColor GT_colorWithRed:0.373 green:0.620 blue:0.627 alpha:1.000];
}

+ (GTColor *)chartreuseColor
{
    return [GTColor GT_colorWithRed:0.498 green:1.000 blue:0.000 alpha:1.000];
}

+ (GTColor *)chocolateColor
{
    return [GTColor GT_colorWithRed:0.824 green:0.412 blue:0.118 alpha:1.000];
}

+ (GTColor *)coralColor
{
    return [GTColor GT_colorWithRed:1.000 green:0.498 blue:0.314 alpha:1.000];
}

+ (GTColor *)cornflowerColor
{
    return [GTColor GT_colorWithRed:0.392 green:0.584 blue:0.929 alpha:1.000];
}

+ (GTColor *)cornsilkColor
{
    return [GTColor GT_colorWithRed:1.000 green:0.973 blue:0.863 alpha:1.000];
}

+ (GTColor *)crimsonColor
{
    return [GTColor GT_colorWithRed:0.863 green:0.078 blue:0.235 alpha:1.000];
}

+ (GTColor *)darkBlueColor
{
    return [GTColor GT_colorWithRed:0.000 green:0.000 blue:0.545 alpha:1.000];
}

+ (GTColor *)darkCyanColor
{
    return [GTColor GT_colorWithRed:0.000 green:0.545 blue:0.545 alpha:1.000];
}

+ (GTColor *)darkGoldenrodColor
{
    return [GTColor GT_colorWithRed:0.722 green:0.525 blue:0.043 alpha:1.000];
}

+ (GTColor *)darkGreenColor
{
    return [GTColor GT_colorWithRed:0.000 green:0.392 blue:0.000 alpha:1.000];
}

+ (GTColor *)darkKhakiColor
{
    return [GTColor GT_colorWithRed:0.741 green:0.718 blue:0.420 alpha:1.000];
}

+ (GTColor *)darkMagentaColor
{
    return [GTColor GT_colorWithRed:0.545 green:0.000 blue:0.545 alpha:1.000];
}

+ (GTColor *)darkOliveGreenColor
{
    return [GTColor GT_colorWithRed:0.333 green:0.420 blue:0.184 alpha:1.000];
}

+ (GTColor *)darkOrangeColor
{
    return [GTColor GT_colorWithRed:1.000 green:0.549 blue:0.000 alpha:1.000];
}

+ (GTColor *)darkOrchidColor
{
    return [GTColor GT_colorWithRed:0.600 green:0.196 blue:0.800 alpha:1.000];
}

+ (GTColor *)darkRedColor
{
    return [GTColor GT_colorWithRed:0.545 green:0.000 blue:0.000 alpha:1.000];
}

+ (GTColor *)darkSalmonColor
{
    return [GTColor GT_colorWithRed:0.914 green:0.588 blue:0.478 alpha:1.000];
}

+ (GTColor *)darkSeaGreenColor
{
    return [GTColor GT_colorWithRed:0.561 green:0.737 blue:0.561 alpha:1.000];
}

+ (GTColor *)darkSlateBlueColor
{
    return [GTColor GT_colorWithRed:0.282 green:0.239 blue:0.545 alpha:1.000];
}

+ (GTColor *)darkSlateGrayColor
{
    return [GTColor GT_colorWithRed:0.157 green:0.310 blue:0.310 alpha:1.000];
}

+ (GTColor *)darkTurquoiseColor
{
    return [GTColor GT_colorWithRed:0.000 green:0.808 blue:0.820 alpha:1.000];
}

+ (GTColor *)darkVioletColor
{
    return [GTColor GT_colorWithRed:0.580 green:0.000 blue:0.827 alpha:1.000];
}

+ (GTColor *)deepPinkColor
{
    return [GTColor GT_colorWithRed:1.000 green:0.078 blue:0.576 alpha:1.000];
}

+ (GTColor *)deepSkyBlueColor
{
    return [GTColor GT_colorWithRed:0.000 green:0.749 blue:1.000 alpha:1.000];
}

+ (GTColor *)dimGrayColor
{
    return [GTColor GT_colorWithWhite:0.412 alpha:1.000];
}

+ (GTColor *)dodgerBlueColor
{
    return [GTColor GT_colorWithRed:0.118 green:0.565 blue:1.000 alpha:1.000];
}

+ (GTColor *)firebrickColor
{
    return [GTColor GT_colorWithRed:0.698 green:0.133 blue:0.133 alpha:1.000];
}

+ (GTColor *)floralWhiteColor
{
    return [GTColor GT_colorWithRed:1.000 green:0.980 blue:0.941 alpha:1.000];
}

+ (GTColor *)forestGreenColor
{
    return [GTColor GT_colorWithRed:0.133 green:0.545 blue:0.133 alpha:1.000];
}

+ (GTColor *)fuschiaColor
{
    return [GTColor GT_colorWithRed:1.000 green:0.000 blue:1.000 alpha:1.000];
}

+ (GTColor *)gainsboroColor
{
    return [GTColor GT_colorWithWhite:0.863 alpha:1.000];
}

+ (GTColor *)ghostWhiteColor
{
    return [GTColor GT_colorWithRed:0.973 green:0.973 blue:1.000 alpha:1.000];
}

+ (GTColor *)goldColor
{
    return [GTColor GT_colorWithRed:1.000 green:0.843 blue:0.000 alpha:1.000];
}

+ (GTColor *)golderonColor
{
    return [GTColor GT_colorWithRed:0.855 green:0.647 blue:0.125 alpha:1.000];
}

+ (GTColor *)greenYellowColor
{
    return [GTColor GT_colorWithRed:0.678 green:1.000 blue:0.184 alpha:1.000];
}

+ (GTColor *)honeydewColor
{
    return [GTColor GT_colorWithRed:0.941 green:1.000 blue:0.941 alpha:1.000];
}

+ (GTColor *)hotPinkColor
{
    return [GTColor GT_colorWithRed:1.000 green:0.412 blue:0.706 alpha:1.000];
}

+ (GTColor *)indianRedColor
{
    return [GTColor GT_colorWithRed:0.804 green:0.361 blue:0.361 alpha:1.000];
}

+ (GTColor *)indigoColor
{
    return [GTColor GT_colorWithRed:0.294 green:0.000 blue:0.510 alpha:1.000];
}

+ (GTColor *)ivoryColor
{
    return [GTColor GT_colorWithRed:1.000 green:0.941 blue:0.941 alpha:1.000];
}

+ (GTColor *)khakiColor
{
    return [GTColor GT_colorWithRed:0.941 green:0.902 blue:0.549 alpha:1.000];
}

+ (GTColor *)lavanderColor
{
    return [GTColor GT_colorWithRed:0.902 green:0.902 blue:0.980 alpha:1.000];
}

+ (GTColor *)lavanderBlushColor
{
    return [GTColor GT_colorWithRed:1.000 green:0.941 blue:0.961 alpha:1.000];
}

+ (GTColor *)lawnGreenColor
{
    return [GTColor GT_colorWithRed:0.486 green:0.988 blue:0.000 alpha:1.000];
}

+ (GTColor *)lemonChiffonColor
{
    return [GTColor GT_colorWithRed:1.000 green:0.980 blue:0.804 alpha:1.000];
}

+ (GTColor *)lightBlueColor
{
    return [GTColor GT_colorWithRed:0.678 green:0.847 blue:0.902 alpha:1.000];
}

+ (GTColor *)lightCoralColor
{
    return [GTColor GT_colorWithRed:0.941 green:0.502 blue:0.502 alpha:1.000];
}

+ (GTColor *)lightCyanColor
{
    return [GTColor GT_colorWithRed:0.878 green:1.000 blue:1.000 alpha:1.000];
}

+ (GTColor *)lightGoldenrodYellowColor
{
    return [GTColor GT_colorWithRed:0.980 green:0.980 blue:0.824 alpha:1.000];
}

+ (GTColor *)lightGreenColor
{
    return [GTColor GT_colorWithRed:0.565 green:0.933 blue:0.565 alpha:1.000];
}

+ (GTColor *)lightPinkColor
{
    return [GTColor GT_colorWithRed:1.000 green:0.753 blue:0.757 alpha:1.000];
}

+ (GTColor *)lightSalmonColor
{
    return [GTColor GT_colorWithRed:1.000 green:0.627 blue:0.478 alpha:1.000];
}

+ (GTColor *)lightSeaGreenColor
{
    return [GTColor GT_colorWithRed:0.125 green:0.698 blue:0.667 alpha:1.000];
}

+ (GTColor *)lightSkyBlueColor
{
    return [GTColor GT_colorWithRed:0.529 green:0.808 blue:0.980 alpha:1.000];
}

+ (GTColor *)lightSlateGrayColor
{
    return [GTColor GT_colorWithRed:0.467 green:0.533 blue:0.600 alpha:1.000];
}

+ (GTColor *)lightSteelBlueColor
{
    return [GTColor GT_colorWithRed:0.690 green:0.769 blue:0.871 alpha:1.000];
}

+ (GTColor *)lightYellowColor
{
    return [GTColor GT_colorWithRed:1.000 green:1.000 blue:0.878 alpha:1.000];
}

+ (GTColor *)limeColor
{
    return [GTColor GT_colorWithRed:0.000 green:1.000 blue:0.000 alpha:1.000];
}

+ (GTColor *)limeGreenColor
{
    return [GTColor GT_colorWithRed:0.196 green:0.804 blue:0.196 alpha:1.000];
}

+ (GTColor *)linenColor
{
    return [GTColor GT_colorWithRed:0.980 green:0.941 blue:0.902 alpha:1.000];
}

+ (GTColor *)maroonColor
{
    return [GTColor GT_colorWithRed:0.502 green:0.000 blue:0.000 alpha:1.000];
}

+ (GTColor *)mediumAcquamarineColor
{
    return [GTColor GT_colorWithRed:0.420 green:0.804 blue:0.667 alpha:1.000];
}

+ (GTColor *)mediumBlueColor
{
    return [GTColor GT_colorWithRed:0.000 green:0.000 blue:0.804 alpha:1.000];
}

+ (GTColor *)mediumOrchidColor
{
    return [GTColor GT_colorWithRed:0.729 green:0.333 blue:0.827 alpha:1.000];
}

+ (GTColor *)mediumPurpleColor
{
    return [GTColor GT_colorWithRed:0.576 green:0.439 blue:0.859 alpha:1.000];
}

+ (GTColor *)mediumSeaGreenColor
{
    return [GTColor GT_colorWithRed:0.235 green:0.702 blue:0.443 alpha:1.000];
}

+ (GTColor *)mediumSlateBlueColor
{
    return [GTColor GT_colorWithRed:0.482 green:0.408 blue:0.933 alpha:1.000];
}

+ (GTColor *)mediumSpringGreenColor
{
    return [GTColor GT_colorWithRed:0.000 green:0.980 blue:0.604 alpha:1.000];
}

+ (GTColor *)mediumTurquoiseColor
{
    return [GTColor GT_colorWithRed:0.282 green:0.820 blue:0.800 alpha:1.000];
}

+ (GTColor *)mediumVioletRedColor
{
    return [GTColor GT_colorWithRed:0.780 green:0.082 blue:0.439 alpha:1.000];
}

+ (GTColor *)midnightBlueColor
{
    return [GTColor GT_colorWithRed:0.098 green:0.098 blue:0.439 alpha:1.000];
}

+ (GTColor *)mintCreamColor
{
    return [GTColor GT_colorWithRed:0.961 green:1.000 blue:0.980 alpha:1.000];
}

+ (GTColor *)mistyRoseColor
{
    return [GTColor GT_colorWithRed:1.000 green:0.894 blue:0.882 alpha:1.000];
}

+ (GTColor *)moccasinColor
{
    return [GTColor GT_colorWithRed:1.000 green:0.894 blue:0.710 alpha:1.000];
}

+ (GTColor *)navajoWhiteColor
{
    return [GTColor GT_colorWithRed:1.000 green:0.871 blue:0.678 alpha:1.000];
}

+ (GTColor *)navyColor
{
    return [GTColor GT_colorWithRed:0.000 green:0.000 blue:0.502 alpha:1.000];
}

+ (GTColor *)oceanColor
{
    return [GTColor GT_colorWithRed:0.000 green:0.251 blue:0.502 alpha:1.000];
}

+ (GTColor *)oldLaceColor
{
    return [GTColor GT_colorWithRed:0.992 green:0.961 blue:0.902 alpha:1.000];
}

+ (GTColor *)oliveColor
{
    return [GTColor GT_colorWithRed:0.502 green:0.502 blue:0.000 alpha:1.000];
}

+ (GTColor *)oliveDrabColor
{
    return [GTColor GT_colorWithRed:0.420 green:0.557 blue:0.176 alpha:1.000];
}

+ (GTColor *)orangeRedColor
{
    return [GTColor GT_colorWithRed:1.000 green:0.271 blue:0.000 alpha:1.000];
}

+ (GTColor *)orchidColor
{
    return [GTColor GT_colorWithRed:0.855 green:0.439 blue:0.839 alpha:1.000];
}

+ (GTColor *)paleGoldenrodColor
{
    return [GTColor GT_colorWithRed:0.933 green:0.910 blue:0.667 alpha:1.000];
}

+ (GTColor *)paleGreenColor
{
    return [GTColor GT_colorWithRed:0.596 green:0.984 blue:0.596 alpha:1.000];
}

+ (GTColor *)paleTurquoiseColor
{
    return [GTColor GT_colorWithRed:0.686 green:0.933 blue:0.933 alpha:1.000];
}

+ (GTColor *)paleVioletRedColor
{
    return [GTColor GT_colorWithRed:0.859 green:0.439 blue:0.576 alpha:1.000];
}

+ (GTColor *)papayaWhipColor
{
    return [GTColor GT_colorWithRed:1.000 green:0.937 blue:0.608 alpha:1.000];
}

+ (GTColor *)peachPuffColor
{
    return [GTColor GT_colorWithRed:1.000 green:0.855 blue:0.608 alpha:1.000];
}

+ (GTColor *)peruColor
{
    return [GTColor GT_colorWithRed:0.804 green:0.522 blue:0.247 alpha:1.000];
}

+ (GTColor *)pinkColor
{
    return [GTColor GT_colorWithRed:1.000 green:0.753 blue:0.796 alpha:1.000];
}

+ (GTColor *)plumColor
{
    return [GTColor GT_colorWithRed:0.867 green:0.627 blue:0.867 alpha:1.000];
}

+ (GTColor *)powderBlueColor
{
    return [GTColor GT_colorWithRed:0.690 green:0.878 blue:0.902 alpha:1.000];
}

+ (GTColor *)rosyBrownColor
{
    return [GTColor GT_colorWithRed:0.737 green:0.561 blue:0.561 alpha:1.000];
}

+ (GTColor *)royalBlueColor
{
    return [GTColor GT_colorWithRed:0.255 green:0.412 blue:0.882 alpha:1.000];
}

+ (GTColor *)saddleBrownColor
{
    return [GTColor GT_colorWithRed:0.545 green:0.271 blue:0.075 alpha:1.000];
}

+ (GTColor *)salmonColor
{
    return [GTColor GT_colorWithRed:0.980 green:0.502 blue:0.447 alpha:1.000];
}

+ (GTColor *)sandyBrownColor
{
    return [GTColor GT_colorWithRed:0.957 green:0.643 blue:0.376 alpha:1.000];
}

+ (GTColor *)seaGreenColor
{
    return [GTColor GT_colorWithRed:0.180 green:0.545 blue:0.341 alpha:1.000];
}

+ (GTColor *)seaShellColor
{
    return [GTColor GT_colorWithRed:1.000 green:0.961 blue:0.933 alpha:1.000];
}

+ (GTColor *)siennaColor
{
    return [GTColor GT_colorWithRed:0.627 green:0.322 blue:0.176 alpha:1.000];
}

+ (GTColor *)silverColor
{
    return [GTColor GT_colorWithWhite:0.753 alpha:1.000];
}

+ (GTColor *)skyBlueColor
{
    return [GTColor GT_colorWithRed:0.529 green:0.808 blue:0.922 alpha:1.000];
}

+ (GTColor *)slateBlueColor
{
    return [GTColor GT_colorWithRed:0.416 green:0.353 blue:0.804 alpha:1.000];
}

+ (GTColor *)slateGrayColor
{
    return [GTColor GT_colorWithRed:0.439 green:0.502 blue:0.565 alpha:1.000];
}

+ (GTColor *)snowColor
{
    return [GTColor GT_colorWithRed:1.000 green:0.980 blue:0.980 alpha:1.000];
}

+ (GTColor *)springGreenColor
{
    return [GTColor GT_colorWithRed:0.000 green:1.000 blue:0.498 alpha:1.000];
}

+ (GTColor *)steelBlueColor
{
    return [GTColor GT_colorWithRed:0.275 green:0.510 blue:0.706 alpha:1.000];
}

+ (GTColor *)tanColor
{
    return [GTColor GT_colorWithRed:0.824 green:0.706 blue:0.549 alpha:1.000];
}

+ (GTColor *)tealColor
{
    return [GTColor GT_colorWithRed:0.000 green:0.502 blue:0.502 alpha:1.000];
}

+ (GTColor *)thistleColor
{
    return [GTColor GT_colorWithRed:0.847 green:0.749 blue:0.847 alpha:1.000];
}

+ (GTColor *)tomatoColor
{
    return [GTColor GT_colorWithRed:0.992 green:0.388 blue:0.278 alpha:1.000];
}

+ (GTColor *)turquoiseColor
{
    return [GTColor GT_colorWithRed:0.251 green:0.878 blue:0.816 alpha:1.000];
}

+ (GTColor *)violetColor
{
    return [GTColor GT_colorWithRed:0.933 green:0.510 blue:0.933 alpha:1.000];
}

+ (GTColor *)wheatColor
{
    return [GTColor GT_colorWithRed:0.961 green:0.871 blue:0.702 alpha:1.000];
}

+ (GTColor *)whiteSmokeColor
{
    return [GTColor GT_colorWithWhite:0.961 alpha:1.000];
}

+ (GTColor *)yellowGreenColor
{
    return [GTColor GT_colorWithRed:0.604 green:0.804 blue:0.196 alpha:1.000];
}

@end
