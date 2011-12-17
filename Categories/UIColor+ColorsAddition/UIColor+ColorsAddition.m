//
//  UIColor+ColorsAddition.m
//
//  Created by Gianluca Tranchedone on 20/08/11.
//  Copyright 2011 Sketch to Code. All rights reserved.
//

// This category is inspired by the post "Colorful Code" by Gallant Games 
// ( http://gallantgames.com/posts/2011/01/colorful-code ).

#import "UIColor+ColorsAddition.h"

@implementation UIColor (ColorsAddition)

+ (UIColor *)colorFromHex:(uint32_t)hexColor
{
    CGFloat blue = (hexColor & 0xff) / 255.0f;
    CGFloat green = (hexColor >> 8 & 0xff) / 255.0f;
    CGFloat red = (hexColor >> 16 & 0xff) / 255.0f;
    
    return [UIColor colorWithRed:red green:green blue:blue alpha:1.0];
}

+ (UIColor *)colorFromRGBWithRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue andAlpha:(CGFloat)alpha
{
    if (alpha > 1.0) 
        alpha = 1.0;
    else if (alpha < 0.0)
        alpha = 0.0;
    
    return [UIColor colorWithRed:red/255 green:green/255 blue:blue/255 alpha:alpha];
}

+ (UIColor *)randomColor
{
    CGFloat blue = arc4random() % 255;
    CGFloat red = arc4random() % 255;
    CGFloat green = arc4random() % 255;
    
    return [self colorFromRGBWithRed:red green:green blue:blue andAlpha:1];
}

+ (NSString *)stringFromColor:(UIColor *)color
{
    // TODO;
    return nil;
}

// iOS SDK Colors

+ (UIColor *)groupTableViewTextColor
{
    return [UIColor colorWithRed:0.259 green:0.333 blue:0.400 alpha:1.000];
}

// Colors

+ (UIColor *)aliceBlueColor
{
    return [UIColor colorWithRed:0.941 green:0.973 blue:1.000 alpha:1.000];
}

+ (UIColor *)antiqueWhiteColor
{
    return [UIColor colorWithRed:0.980 green:0.922 blue:0.843 alpha:1.000];
}

+ (UIColor *)acquaColor
{
    return [UIColor colorWithRed:0.000 green:1.000 blue:1.000 alpha:1.000];
}

+ (UIColor *)acquamarineColor
{
    return [UIColor colorWithRed:0.498 green:1.000 blue:0.831 alpha:1.000];
}

+ (UIColor *)azureColor
{
    return [UIColor colorWithRed:0.498 green:1.000 blue:0.831 alpha:1.000];
}

+ (UIColor *)beigeColor
{
    return [UIColor colorWithRed:0.961 green:0.961 blue:0.863 alpha:1.000];
}

+ (UIColor *)bisqueColor
{
    return [UIColor colorWithRed:1.000 green:0.894 blue:0.769 alpha:1.000];
}

+ (UIColor *)blanchetAlmondColor
{
    return [UIColor colorWithRed:1.000 green:1.000 blue:0.804 alpha:1.000];
}

+ (UIColor *)blueVioletColor
{
    return [UIColor colorWithRed:0.541 green:0.169 blue:0.886 alpha:1.000];
}

+ (UIColor *)burlyWoodColor
{
    return [UIColor colorWithRed:0.871 green:0.722 blue:0.529 alpha:1.000];
}

+ (UIColor *)cadetBlueColor
{
    return [UIColor colorWithRed:0.373 green:0.620 blue:0.627 alpha:1.000];
}

+ (UIColor *)chartreuseColor
{
    return [UIColor colorWithRed:0.498 green:1.000 blue:0.000 alpha:1.000];
}

+ (UIColor *)chocolateColor
{
    return [UIColor colorWithRed:0.824 green:0.412 blue:0.118 alpha:1.000];
}

+ (UIColor *)coralColor
{
    return [UIColor colorWithRed:1.000 green:0.498 blue:0.314 alpha:1.000];
}

+ (UIColor *)cornflowerColor
{
    return [UIColor colorWithRed:0.392 green:0.584 blue:0.929 alpha:1.000];
}

+ (UIColor *)cornsilkColor
{
    return [UIColor colorWithRed:1.000 green:0.973 blue:0.863 alpha:1.000];
}

+ (UIColor *)crimsonColor
{
    return [UIColor colorWithRed:0.863 green:0.078 blue:0.235 alpha:1.000];
}

+ (UIColor *)darkBlueColor
{
    return [UIColor colorWithRed:0.000 green:0.000 blue:0.545 alpha:1.000];
}

+ (UIColor *)darkCyanColor
{
    return [UIColor colorWithRed:0.000 green:0.545 blue:0.545 alpha:1.000];
}

+ (UIColor *)darkGoldenrodColor
{
    return [UIColor colorWithRed:0.722 green:0.525 blue:0.043 alpha:1.000];
}

+ (UIColor *)darkGreenColor
{
    return [UIColor colorWithRed:0.000 green:0.392 blue:0.000 alpha:1.000];
}

+ (UIColor *)darkKhakiColor
{
    return [UIColor colorWithRed:0.741 green:0.718 blue:0.420 alpha:1.000];
}

+ (UIColor *)darkMagentaColor
{
    return [UIColor colorWithRed:0.545 green:0.000 blue:0.545 alpha:1.000];
}

+ (UIColor *)darkOliveGreenColor
{
    return [UIColor colorWithRed:0.333 green:0.420 blue:0.184 alpha:1.000];
}

+ (UIColor *)darkOrangeColor
{
    return [UIColor colorWithRed:1.000 green:0.549 blue:0.000 alpha:1.000];
}

+ (UIColor *)darkOrchidColor
{
    return [UIColor colorWithRed:0.600 green:0.196 blue:0.800 alpha:1.000];
}

+ (UIColor *)darkRedColor
{
    return [UIColor colorWithRed:0.545 green:0.000 blue:0.000 alpha:1.000];
}

+ (UIColor *)darkSalmonColor
{
    return [UIColor colorWithRed:0.914 green:0.588 blue:0.478 alpha:1.000];
}

+ (UIColor *)darkSeaGreenColor
{
    return [UIColor colorWithRed:0.561 green:0.737 blue:0.561 alpha:1.000];
}

+ (UIColor *)darkSlateBlueColor
{
    return [UIColor colorWithRed:0.282 green:0.239 blue:0.545 alpha:1.000];
}

+ (UIColor *)darkSlateGrayColor
{
    return [UIColor colorWithRed:0.157 green:0.310 blue:0.310 alpha:1.000];
}

+ (UIColor *)darkTurquoiseColor
{
    return [UIColor colorWithRed:0.000 green:0.808 blue:0.820 alpha:1.000];
}

+ (UIColor *)darkVioletColor
{
    return [UIColor colorWithRed:0.580 green:0.000 blue:0.827 alpha:1.000];
}

+ (UIColor *)deepPinkColor
{
    return [UIColor colorWithRed:1.000 green:0.078 blue:0.576 alpha:1.000];
}

+ (UIColor *)deepSkyBlueColor
{
    return [UIColor colorWithRed:0.000 green:0.749 blue:1.000 alpha:1.000];
}

+ (UIColor *)dimGrayColor
{
    return [UIColor colorWithWhite:0.412 alpha:1.000];
}

+ (UIColor *)dodgerBlueColor
{
    return [UIColor colorWithRed:0.118 green:0.565 blue:1.000 alpha:1.000];
}

+ (UIColor *)firebrickColor
{
    return [UIColor colorWithRed:0.698 green:0.133 blue:0.133 alpha:1.000];
}

+ (UIColor *)floralWhiteColor
{
    return [UIColor colorWithRed:1.000 green:0.980 blue:0.941 alpha:1.000];
}

+ (UIColor *)forestGreenColor
{
    return [UIColor colorWithRed:0.133 green:0.545 blue:0.133 alpha:1.000];
}

+ (UIColor *)fuschiaColor
{
    return [UIColor colorWithRed:1.000 green:0.000 blue:1.000 alpha:1.000];
}

+ (UIColor *)gainsboroColor
{
    return [UIColor colorWithWhite:0.863 alpha:1.000];
}

+ (UIColor *)ghostWhiteColor
{
    return [UIColor colorWithRed:0.973 green:0.973 blue:1.000 alpha:1.000];
}

+ (UIColor *)goldColor
{
    return [UIColor colorWithRed:1.000 green:0.843 blue:0.000 alpha:1.000];
}

+ (UIColor *)golderonColor
{
    return [UIColor colorWithRed:0.855 green:0.647 blue:0.125 alpha:1.000];
}

+ (UIColor *)greenYellowColor
{
    return [UIColor colorWithRed:0.678 green:1.000 blue:0.184 alpha:1.000];
}

+ (UIColor *)honeydewColor
{
    return [UIColor colorWithRed:0.941 green:1.000 blue:0.941 alpha:1.000];
}

+ (UIColor *)hotPinkColor
{
    return [UIColor colorWithRed:1.000 green:0.412 blue:0.706 alpha:1.000];
}

+ (UIColor *)indianRedColor
{
    return [UIColor colorWithRed:0.804 green:0.361 blue:0.361 alpha:1.000];
}

+ (UIColor *)indigoColor
{
    return [UIColor colorWithRed:0.294 green:0.000 blue:0.510 alpha:1.000];
}

+ (UIColor *)ivoryColor
{
    return [UIColor colorWithRed:1.000 green:0.941 blue:0.941 alpha:1.000];
}

+ (UIColor *)khakiColor
{
    return [UIColor colorWithRed:0.941 green:0.902 blue:0.549 alpha:1.000];
}

+ (UIColor *)lavanderColor
{
    return [UIColor colorWithRed:0.902 green:0.902 blue:0.980 alpha:1.000];
}

+ (UIColor *)lavanderBlushColor
{
    return [UIColor colorWithRed:1.000 green:0.941 blue:0.961 alpha:1.000];
}

+ (UIColor *)lawnGreenColor
{
    return [UIColor colorWithRed:0.486 green:0.988 blue:0.000 alpha:1.000];
}

+ (UIColor *)lemonChiffonColor
{
    return [UIColor colorWithRed:1.000 green:0.980 blue:0.804 alpha:1.000];
}

+ (UIColor *)lightBlueColor
{
    return [UIColor colorWithRed:0.678 green:0.847 blue:0.902 alpha:1.000];
}

+ (UIColor *)lightCoralColor
{
    return [UIColor colorWithRed:0.941 green:0.502 blue:0.502 alpha:1.000];
}

+ (UIColor *)lightCyanColor
{
    return [UIColor colorWithRed:0.878 green:1.000 blue:1.000 alpha:1.000];
}

+ (UIColor *)lightGoldenrodYellowColor
{
    return [UIColor colorWithRed:0.980 green:0.980 blue:0.824 alpha:1.000];
}

+ (UIColor *)lightGreenColor
{
    return [UIColor colorWithRed:0.565 green:0.933 blue:0.565 alpha:1.000];
}

+ (UIColor *)lightPinkColor
{
    return [UIColor colorWithRed:1.000 green:0.753 blue:0.757 alpha:1.000];
}

+ (UIColor *)lightSalmonColor
{
    return [UIColor colorWithRed:1.000 green:0.627 blue:0.478 alpha:1.000];
}

+ (UIColor *)lightSeaGreenColor
{
    return [UIColor colorWithRed:0.125 green:0.698 blue:0.667 alpha:1.000];
}

+ (UIColor *)lightSkyBlueColor
{
    return [UIColor colorWithRed:0.529 green:0.808 blue:0.980 alpha:1.000];
}

+ (UIColor *)lightSlateGrayColor
{
    return [UIColor colorWithRed:0.467 green:0.533 blue:0.600 alpha:1.000];
}

+ (UIColor *)lightSteelBlueColor
{
    return [UIColor colorWithRed:0.690 green:0.769 blue:0.871 alpha:1.000];
}

+ (UIColor *)lightYellowColor
{
    return [UIColor colorWithRed:1.000 green:1.000 blue:0.878 alpha:1.000];
}

+ (UIColor *)limeColor
{
    return [UIColor colorWithRed:0.000 green:1.000 blue:0.000 alpha:1.000];
}

+ (UIColor *)limeGreenColor
{
    return [UIColor colorWithRed:0.196 green:0.804 blue:0.196 alpha:1.000];
}

+ (UIColor *)linenColor
{
    return [UIColor colorWithRed:0.980 green:0.941 blue:0.902 alpha:1.000];
}

+ (UIColor *)magentaColor
{
    return [UIColor colorWithRed:1.000 green:0.000 blue:1.000 alpha:1.000];
}

+ (UIColor *)maroonColor
{
    return [UIColor colorWithRed:0.502 green:0.000 blue:0.000 alpha:1.000];
}

+ (UIColor *)mediumAcquamarineColor
{
    return [UIColor colorWithRed:0.420 green:0.804 blue:0.667 alpha:1.000];
}

+ (UIColor *)mediumBlueColor
{
    return [UIColor colorWithRed:0.000 green:0.000 blue:0.804 alpha:1.000];
}

+ (UIColor *)mediumOrchidColor
{
    return [UIColor colorWithRed:0.729 green:0.333 blue:0.827 alpha:1.000];
}

+ (UIColor *)mediumPurpleColor
{
    return [UIColor colorWithRed:0.576 green:0.439 blue:0.859 alpha:1.000];
}

+ (UIColor *)mediumSeaGreenColor
{
    return [UIColor colorWithRed:0.235 green:0.702 blue:0.443 alpha:1.000];
}

+ (UIColor *)mediumSlateBlueColor
{
    return [UIColor colorWithRed:0.482 green:0.408 blue:0.933 alpha:1.000];
}

+ (UIColor *)mediumSpringGreenColor
{
    return [UIColor colorWithRed:0.000 green:0.980 blue:0.604 alpha:1.000];
}

+ (UIColor *)mediumTurquoiseColor
{
    return [UIColor colorWithRed:0.282 green:0.820 blue:0.800 alpha:1.000];
}

+ (UIColor *)mediumVioletRedColor
{
    return [UIColor colorWithRed:0.780 green:0.082 blue:0.439 alpha:1.000];
}

+ (UIColor *)midnightBlueColor
{
    return [UIColor colorWithRed:0.098 green:0.098 blue:0.439 alpha:1.000];
}

+ (UIColor *)mintCreamColor
{
    return [UIColor colorWithRed:0.961 green:1.000 blue:0.980 alpha:1.000];
}

+ (UIColor *)mistyRoseColor
{
    return [UIColor colorWithRed:1.000 green:0.894 blue:0.882 alpha:1.000];
}

+ (UIColor *)moccasinColor
{
    return [UIColor colorWithRed:1.000 green:0.894 blue:0.710 alpha:1.000];
}

+ (UIColor *)navajoWhiteColor
{
    return [UIColor colorWithRed:1.000 green:0.871 blue:0.678 alpha:1.000];
}

+ (UIColor *)navyColor
{
    return [UIColor colorWithRed:0.000 green:0.000 blue:0.502 alpha:1.000];
}

+ (UIColor *)oceanColor
{
    return [UIColor colorWithRed:0.000 green:0.251 blue:0.502 alpha:1.000];
}

+ (UIColor *)oldLaceColor
{
    return [UIColor colorWithRed:0.992 green:0.961 blue:0.902 alpha:1.000];
}

+ (UIColor *)oliveColor
{
    return [UIColor colorWithRed:0.502 green:0.502 blue:0.000 alpha:1.000];
}

+ (UIColor *)oliveDrabColor
{
    return [UIColor colorWithRed:0.420 green:0.557 blue:0.176 alpha:1.000];
}

+ (UIColor *)orangeRedColor
{
    return [UIColor colorWithRed:1.000 green:0.271 blue:0.000 alpha:1.000];
}

+ (UIColor *)orchidColor
{
    return [UIColor colorWithRed:0.855 green:0.439 blue:0.839 alpha:1.000];
}

+ (UIColor *)paleGoldenrodColor
{
    return [UIColor colorWithRed:0.933 green:0.910 blue:0.667 alpha:1.000];
}

+ (UIColor *)paleGreenColor
{
    return [UIColor colorWithRed:0.596 green:0.984 blue:0.596 alpha:1.000];
}

+ (UIColor *)paleTurquoiseColor
{
    return [UIColor colorWithRed:0.686 green:0.933 blue:0.933 alpha:1.000];
}

+ (UIColor *)paleVioletRedColor
{
    return [UIColor colorWithRed:0.859 green:0.439 blue:0.576 alpha:1.000];
}

+ (UIColor *)papayaWhipColor
{
    return [UIColor colorWithRed:1.000 green:0.937 blue:0.608 alpha:1.000];
}

+ (UIColor *)peachPuffColor
{
    return [UIColor colorWithRed:1.000 green:0.855 blue:0.608 alpha:1.000];
}

+ (UIColor *)peruColor
{
    return [UIColor colorWithRed:0.804 green:0.522 blue:0.247 alpha:1.000];
}

+ (UIColor *)pinkColor
{
    return [UIColor colorWithRed:1.000 green:0.753 blue:0.796 alpha:1.000];
}

+ (UIColor *)plumColor
{
    return [UIColor colorWithRed:0.867 green:0.627 blue:0.867 alpha:1.000];
}

+ (UIColor *)powderBlueColor
{
    return [UIColor colorWithRed:0.690 green:0.878 blue:0.902 alpha:1.000];
}

+ (UIColor *)rosyBrownColor
{
    return [UIColor colorWithRed:0.737 green:0.561 blue:0.561 alpha:1.000];
}

+ (UIColor *)royalBlueColor
{
    return [UIColor colorWithRed:0.255 green:0.412 blue:0.882 alpha:1.000];
}

+ (UIColor *)saddleBrownColor
{
    return [UIColor colorWithRed:0.545 green:0.271 blue:0.075 alpha:1.000];
}

+ (UIColor *)salmonColor
{
    return [UIColor colorWithRed:0.980 green:0.502 blue:0.447 alpha:1.000];
}

+ (UIColor *)sandyBrownColor
{
    return [UIColor colorWithRed:0.957 green:0.643 blue:0.376 alpha:1.000];
}

+ (UIColor *)seaGreenColor
{
    return [UIColor colorWithRed:0.180 green:0.545 blue:0.341 alpha:1.000];
}

+ (UIColor *)seaShellColor
{
    return [UIColor colorWithRed:1.000 green:0.961 blue:0.933 alpha:1.000];
}

+ (UIColor *)siennaColor
{
    return [UIColor colorWithRed:0.627 green:0.322 blue:0.176 alpha:1.000];
}

+ (UIColor *)silverColor
{
    return [UIColor colorWithWhite:0.753 alpha:1.000];
}

+ (UIColor *)skyBlueColor
{
    return [UIColor colorWithRed:0.529 green:0.808 blue:0.922 alpha:1.000];
}

+ (UIColor *)slateBlueColor
{
    return [UIColor colorWithRed:0.416 green:0.353 blue:0.804 alpha:1.000];
}

+ (UIColor *)slateGrayColor
{
    return [UIColor colorWithRed:0.439 green:0.502 blue:0.565 alpha:1.000];
}

+ (UIColor *)snowColor
{
    return [UIColor colorWithRed:1.000 green:0.980 blue:0.980 alpha:1.000];
}

+ (UIColor *)springGreenColor
{
    return [UIColor colorWithRed:0.000 green:1.000 blue:0.498 alpha:1.000];
}

+ (UIColor *)steelBlueColor
{
    return [UIColor colorWithRed:0.275 green:0.510 blue:0.706 alpha:1.000];
}

+ (UIColor *)tanColor
{
    return [UIColor colorWithRed:0.824 green:0.706 blue:0.549 alpha:1.000];
}

+ (UIColor *)tealColor
{
    return [UIColor colorWithRed:0.000 green:0.502 blue:0.502 alpha:1.000];
}

+ (UIColor *)thistleColor
{
    return [UIColor colorWithRed:0.847 green:0.749 blue:0.847 alpha:1.000];
}

+ (UIColor *)tomatoColor
{
    return [UIColor colorWithRed:0.992 green:0.388 blue:0.278 alpha:1.000];
}

+ (UIColor *)turquoiseColor
{
    return [UIColor colorWithRed:0.251 green:0.878 blue:0.816 alpha:1.000];
}

+ (UIColor *)violetColor
{
    return [UIColor colorWithRed:0.933 green:0.510 blue:0.933 alpha:1.000];
}

+ (UIColor *)wheatColor
{
    return [UIColor colorWithRed:0.961 green:0.871 blue:0.702 alpha:1.000];
}

+ (UIColor *)whiteSmokeColor
{
    return [UIColor colorWithWhite:0.961 alpha:1.000];
}

+ (UIColor *)yellowGreenColor
{
    return [UIColor colorWithRed:0.604 green:0.804 blue:0.196 alpha:1.000];
}

+ (UIColor *)STCBarColor
{
    return [UIColor colorWithRed:0.000 green:0.380 blue:0.584 alpha:1.000];
}

@end
