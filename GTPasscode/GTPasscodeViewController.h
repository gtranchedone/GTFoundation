//
//  GTPasscodeViewController.h
//
//  Created by Gianluca Tranchedone on 17/12/11.
//  Copyright 2012 SketchToCode. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import <AudioToolbox/AudioServices.h>

@protocol GTPasscodeViewControllerDelegate;

extern NSString * const PasscodeUserDafaultsKey;
extern NSString * const AskPasswordUserDafaultsKey;

typedef enum GTPasscodeAnimationStyle : NSUInteger {
    GTPasscodeAnimationStyleNone,
    GTPasscodeAnimationStyleInvalid,
    GTPasscodeAnimationStyleConfirm
} GTPasscodeAnimationStyle;

@interface GTPasscodeViewController : UIViewController <UITextFieldDelegate> {
    UITextField *fakeField;
}

@property (nonatomic, weak) id <GTPasscodeViewControllerDelegate> delegate; 
@property (nonatomic, assign) BOOL cancelButtonEnabled;

//+ (void)showToChangePasscode;
+ (void)disablePasscodeCheck;
+ (void)checkForPasscodeUsingNavigationController:(UINavigationController *)navigationController;
+ (void)showToSetNewPasscodeUsingNavigationController:(UINavigationController *)navigationController;

- (void)resetWithAnimation:(GTPasscodeAnimationStyle)animationStyle;
- (void)dismissPasscodeViewController;

@end

//___________________________________

@protocol GTPasscodeViewControllerDelegate <NSObject>

@optional
- (void)passcodeController:(GTPasscodeViewController *)controller didEnterPasscode:(NSString *)passcode withSuccess:(BOOL)success;

@end
