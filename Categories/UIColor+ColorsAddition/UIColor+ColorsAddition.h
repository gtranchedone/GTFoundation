//
//  UIColor+ColorsAddition.h
//
//  Created by Gianluca Tranchedone on 20/08/11.
//  Copyright 2011 Sketch to Code. All rights reserved.
//

// This category is inspired by the post "Colorful Code" by Gallant Games 
// ( http://gallantgames.com/posts/2011/01/colorful-code ).

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

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

+ (UIColor *)magentaColor;
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
