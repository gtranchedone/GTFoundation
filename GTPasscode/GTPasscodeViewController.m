//
//  GTPasscodeViewController.m
//
//  Created by Gianluca Tranchedone on 17/12/11.
//  Copyright 2012 SketchToCode. All rights reserved.
//
//  Redistribution and use in source and binary forms, with or without modification, are 
//  permitted provided that the following conditions are met:
//
//  * Redistributions of source code must retain the above copyright notice, this list of 
//    conditions and the following disclaimer.
//  * Redistributions in binary form must reproduce the above copyright notice, this list 
//    of conditions and the following disclaimer in the documentation and/or other materials 
//    provided with the distribution.
//  * Neither the name of KOOLISTOV nor the names of its contributors may be used to 
//    endorse or promote products derived from this software without specific prior written 
//    permission.
//
//  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY 
//  EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF 
//  MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL 
//  THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, 
//  SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT 
//  OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) 
//  HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, 
//  OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS 
//  SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
//

#import "GTPasscodeViewController.h"
#import "UIColor+ColorsAddition.h"
#import "UIView+GTExtentions.h"

NSString * const PasscodeUserDafaultsKey = @"PasscodeUserDefaultsKey";
NSString * const AskPasswordUserDafaultsKey = @"AskPasswordUserDafaultsKey";

@interface GTPasscodeViewController ()

@property (nonatomic, strong) IBOutlet UIView *animationView;

@property (nonatomic, strong) IBOutlet UILabel *titleLabel;
@property (nonatomic, strong) IBOutlet UILabel *instructionLabel;

@property (nonatomic, strong) IBOutlet UITextField *bulletField0;
@property (nonatomic, strong) IBOutlet UITextField *bulletField1;
@property (nonatomic, strong) IBOutlet UITextField *bulletField2;
@property (nonatomic, strong) IBOutlet UITextField *bulletField3;

@property (nonatomic, assign) BOOL isSettingPasscode;
@property (nonatomic, assign) BOOL isChangingPasscode;
@property (nonatomic, strong) NSString *tempPasscode;

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag;
- (void)internalResetWithAnimation:(NSNumber *)animationStyleNumber;
- (void)notifyDelegate:(NSString *)passcode;

- (void)changePasscode:(NSString *)passcode;
- (void)savePasscode:(NSString *)passcode;

@end

#pragma mark - Implementation

@implementation GTPasscodeViewController

@synthesize delegate = _delegate;
@synthesize cancelButtonEnabled = _cancelButtonEnabled;

@synthesize isSettingPasscode = _isSettingPasscode;
@synthesize isChangingPasscode = _isChangingPasscode;
@synthesize tempPasscode = _tempPasscode;

@synthesize animationView = _animationView;

@synthesize titleLabel = _titleLabel;
@synthesize instructionLabel = _instructionLabel;

@synthesize bulletField0 = _bulletField0;
@synthesize bulletField1 = _bulletField1;
@synthesize bulletField2 = _bulletField2;
@synthesize bulletField3 = _bulletField3;

#pragma mark - Class Methods

+ (void)checkForPasscodeUsingNavigationController:(UINavigationController *)navigationController
{
    BOOL shouldAskForPasscode = [[NSUserDefaults standardUserDefaults] boolForKey:AskPasswordUserDafaultsKey];
    
    if (shouldAskForPasscode)
    {
        GTPasscodeViewController *passcodeViewController = [[GTPasscodeViewController alloc] 
                                                            initWithNibName:@"GTPasscodeViewController" bundle:nil];
        passcodeViewController.instructionLabel.font = [UIFont boldSystemFontOfSize:17];
        passcodeViewController.view.backgroundColor = navigationController.topViewController.view.backgroundColor;
        passcodeViewController.cancelButtonEnabled = NO;
        passcodeViewController.isSettingPasscode = NO;
        passcodeViewController.isChangingPasscode = NO;
        
        UINavigationController *fromNavigationController = [[UINavigationController alloc] 
                                                            initWithRootViewController:passcodeViewController];
        fromNavigationController.navigationBar.tintColor = navigationController.navigationBar.tintColor;
        fromNavigationController.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
        [navigationController presentModalViewController:fromNavigationController animated:NO];
    }
}

+ (void)showToSetNewPasscodeUsingNavigationController:(UINavigationController *)navigationController
{
    GTPasscodeViewController *passcodeViewController = [[GTPasscodeViewController alloc] 
                                                         initWithNibName:@"GTPasscodeViewController" bundle:nil];
    passcodeViewController.instructionLabel.font = [UIFont boldSystemFontOfSize:17];
    passcodeViewController.view.backgroundColor = navigationController.topViewController.view.backgroundColor;
    passcodeViewController.cancelButtonEnabled = YES;
    passcodeViewController.isSettingPasscode = YES;
    
    NSString *currentPasscode = [[NSUserDefaults standardUserDefaults] objectForKey:PasscodeUserDafaultsKey];
    if (currentPasscode && ![currentPasscode isEqualToString:@""]) {
        passcodeViewController.isChangingPasscode = YES;
        passcodeViewController.titleLabel.text = NSLocalizedString(@"Insert the current Passcode", @"Change Passcode Instruction");
    }
    
    UINavigationController *navigationController2 = [[UINavigationController alloc] 
                                                      initWithRootViewController:passcodeViewController];
    navigationController2.navigationBar.tintColor = navigationController.navigationBar.tintColor;
    navigationController2.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    
    [navigationController presentModalViewController:navigationController2 animated:NO];
}

+ (void)disablePasscodeCheck
{
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:AskPasswordUserDafaultsKey];
    [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:PasscodeUserDafaultsKey];
}

#pragma mark - Instance Methods

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil 
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.cancelButtonEnabled = NO;
        self.isSettingPasscode = NO;
        self.isChangingPasscode = NO;
    }
    return self;
}

- (void)didReceiveMemoryWarning 
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];

    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad 
{
    [super viewDidLoad];

    fakeField = [[UITextField alloc] initWithFrame:CGRectZero];
    fakeField.delegate = self;
    fakeField.keyboardType = UIKeyboardTypeNumberPad;
    fakeField.secureTextEntry = YES;
    fakeField.text = @"";
    [fakeField becomeFirstResponder];
    [self.view addSubview:fakeField];
    
    self.navigationItem.title = NSLocalizedString(@"Passcode", @"Passcode View Controller Title");
    
    if (self.cancelButtonEnabled) 
    {
        UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel
                                                                target:self action:@selector(dismissModalViewControllerAnimated:)];
        self.navigationItem.leftBarButtonItem = cancelButton;
    }
}

- (void)viewDidUnload 
{
    [super viewDidUnload];

    fakeField = nil;
    
    self.animationView = nil;
    
    self.titleLabel = nil;
    self.instructionLabel = nil;
    
    self.bulletField0 = nil;
    self.bulletField1 = nil;
    self.bulletField2 = nil;
    self.bulletField3 = nil;
}

- (void)viewWillAppear:(BOOL)animated 
{
    if (self.isChangingPasscode || !self.isSettingPasscode) {
        self.titleLabel.text = NSLocalizedString(@"Insert your Passcode", @"Passcode entry view instruction");
    }
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation 
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - View Animations

- (void)internalResetWithAnimation:(NSNumber *)animationStyleNumber 
{    
    GTPasscodeAnimationStyle animationStyle = [animationStyleNumber intValue];
    
    switch (animationStyle) 
    {
        case GTPasscodeAnimationStyleInvalid:
        {
            // Vibrate to indicate error
            AudioServicesPlayAlertSound(kSystemSoundID_Vibrate);
            
            CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"position"];
            [animation setDelegate:self]; 
            [UIView setAnimationDidStopSelector:@selector(animationDidStop:finished:)];
            [animation setDuration:0.025];
            [animation setRepeatCount:8];
            [animation setAutoreverses:YES];
            [animation setFromValue:[NSValue valueWithCGPoint:
                                     CGPointMake([self.animationView center].x - 14.0f, [self.animationView center].y)]];
            [animation setToValue:[NSValue valueWithCGPoint:
                                   CGPointMake([self.animationView center].x + 14.0f, [self.animationView center].y)]];
            [[self.animationView layer] addAnimation:animation forKey:@"position"];
            
            self.instructionLabel.text = NSLocalizedString(@"Wrong Passcode Inserted", @"Confirm Passcode Instruction");
            self.instructionLabel.textColor = [UIColor redColor];
        }
            break;
            
        case GTPasscodeAnimationStyleConfirm:
        {
            // This will cause the 'new' fields to appear without bullets already in them
            self.bulletField0.text = nil;
            self.bulletField1.text = nil;
            self.bulletField2.text = nil;
            self.bulletField3.text = nil;
            
            CATransition *transition = [CATransition animation]; 
            [transition setDelegate:self]; 
            [UIView setAnimationDidStopSelector:@selector(animationDidStop:finished:)];
            [transition setType:kCATransitionPush]; 
            [transition setSubtype:kCATransitionFromRight]; 
            [transition setDuration:0.5f];
            [transition setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]]; 
            [self.view exchangeSubviewAtIndex:0 withSubviewAtIndex:1]; 
            [[self.animationView layer] addAnimation:transition forKey:@"swipe"];

            if (!self.isChangingPasscode) {
                self.titleLabel.text = NSLocalizedString(@"Rewrite your new Passcode to confirm", @"Confirm Passcode Instruction");
            } else {
                self.instructionLabel.text = @"";
                self.instructionLabel.textColor = [UIColor groupTableViewTextColor];
            }
        }
            break;
        case GTPasscodeAnimationStyleNone:
        default:
        {
            self.bulletField0.text = nil;
            self.bulletField1.text = nil;
            self.bulletField2.text = nil;
            self.bulletField3.text = nil;
            
            fakeField.text = @"";
            
            self.instructionLabel.text = @"";
            self.instructionLabel.textColor = [UIColor groupTableViewTextColor];
        }
            break;
    }
}

- (void)resetWithAnimation:(GTPasscodeAnimationStyle)animationStyle 
{   
    // Do the animation a little later (for better animation) as it's likely this method is called in our delegate method
    [self performSelector:@selector(internalResetWithAnimation:) withObject:[NSNumber numberWithInt:animationStyle] afterDelay:0];
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag 
{
    self.bulletField0.text = nil;
    self.bulletField1.text = nil;
    self.bulletField2.text = nil;
    self.bulletField3.text = nil;
    
    fakeField.text = @"";
}

#pragma mark - Delegating Methods

- (void)notifyDelegate:(NSString *)passcode 
{
    NSString *setPassword = [[NSUserDefaults standardUserDefaults] objectForKey:PasscodeUserDafaultsKey];
    
    BOOL success = NO;
    
    if ([setPassword isEqualToString:passcode])
    {
        success = YES;
        self.instructionLabel.text = NSLocalizedString(@"Passcode Accepted", nil);
        self.instructionLabel.textColor = [UIColor groupTableViewTextColor];
        
        [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(dismissModalViewControllerAnimated:) 
                                       userInfo:nil repeats:NO];
    }
    else
    {
        success = NO;
        [self resetWithAnimation:GTPasscodeAnimationStyleInvalid];
        self.instructionLabel.text = NSLocalizedString(@"Wrong Passcode", nil);
        self.instructionLabel.textColor = [UIColor redColor];
    }
    
    if ([self.delegate respondsToSelector:@selector(passcodeController:didEnterPasscode:withSuccess:)]) {
        [self.delegate passcodeController:self didEnterPasscode:passcode withSuccess:success];
    }
    
    fakeField.text = @"";
}

#pragma mark - Passcode Insertion

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSString *passcode = [textField text];
    passcode = [passcode stringByReplacingCharactersInRange:range withString:string];

    switch ([passcode length]) {
        case 0:
            self.bulletField0.text = nil;
            self.bulletField1.text = nil;
            self.bulletField2.text = nil;
            self.bulletField3.text = nil;
            break;
        case 1:
            self.bulletField0.text = @"*";
            self.bulletField1.text = nil;
            self.bulletField2.text = nil;
            self.bulletField3.text = nil;
            break;
        case 2:
            self.bulletField0.text = @"*";
            self.bulletField1.text = @"*";
            self.bulletField2.text = nil;
            self.bulletField3.text = nil;
            break;
        case 3:
            self.bulletField0.text = @"*";
            self.bulletField1.text = @"*";
            self.bulletField2.text = @"*";
            self.bulletField3.text = nil;
            break;
        case 4:
            self.bulletField0.text = @"*";
            self.bulletField1.text = @"*";
            self.bulletField2.text = @"*";
            self.bulletField3.text = @"*";
        
            // Notify delegate a little later so we have a chance to show the 4th bullet
            if (self.isSettingPasscode) {
                [self performSelector:@selector(changePasscode:) withObject:passcode afterDelay:0];
            }
            else {
                [self performSelector:@selector(notifyDelegate:) withObject:passcode afterDelay:0];
            }
            
            return NO;
            
            break;
        default:
            break;
    }

    return YES;
}

- (void)changePasscode:(NSString *)passcode
{
    NSString *currentPasscode = [[NSUserDefaults standardUserDefaults] objectForKey:PasscodeUserDafaultsKey];
    
    if (self.isChangingPasscode)
    {
        if ([self.titleLabel.text isEqualToString:NSLocalizedString(@"Set The New Passcode", @"Confirm Passcode Instruction")]) 
        {
            self.tempPasscode = passcode;
            self.isChangingPasscode = NO; // To skip all steps 'till the last check and save.
            self.titleLabel.text = NSLocalizedString(@"Rewrite your new Passcode to confirm", @"Confirm Passcode Instruction");
            [self resetWithAnimation:GTPasscodeAnimationStyleConfirm];
        }
        else if ([currentPasscode isEqualToString:passcode])
        {
            [self resetWithAnimation:GTPasscodeAnimationStyleConfirm];
            self.titleLabel.text = NSLocalizedString(@"Set The New Passcode", @"Confirm Passcode Instruction");
        } else {
            [self resetWithAnimation:GTPasscodeAnimationStyleInvalid];
        }
    }
    else if ((currentPasscode == nil || currentPasscode != passcode) && !self.tempPasscode)
    {
        self.tempPasscode = passcode;
        [self resetWithAnimation:GTPasscodeAnimationStyleConfirm];
    }
    else
    {        
        if ([self.tempPasscode isEqualToString:passcode])
        {                        
            self.instructionLabel.text = NSLocalizedString(@"Passcode saved!", @"New Passcode Saved Message");
            self.instructionLabel.textColor = [UIColor groupTableViewTextColor];
            self.tempPasscode = nil;
            
            [self savePasscode:passcode];
        }
        else
        {
            [self resetWithAnimation:GTPasscodeAnimationStyleInvalid];
        }
    }
}

- (void)savePasscode:(NSString *)passcode
{
    [[NSUserDefaults standardUserDefaults] setObject:passcode forKey:PasscodeUserDafaultsKey];
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:AskPasswordUserDafaultsKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [self dismissPasscodeViewController];
}

- (void)dismissPasscodeViewController
{
    [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(dismissModalViewControllerAnimated:) 
                                   userInfo:nil repeats:NO];
}

@end
