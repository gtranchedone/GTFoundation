//
//  MFMailComposeViewController+FastInit.m
//  JapaneseGrammarDictionary
//
//  Created by Gianluca Tranchedone on 30/05/11.
//  Copyright 2011 Sketch to Code. All rights reserved.
//

#import "MFMailComposeViewController+FastInit.h"

@implementation MFMailComposeViewController (FastInit)

+ (void)presentMailComposeViewFromViewController:(UIViewController<MFMailComposeViewControllerDelegate> *)viewController WithSubject:(NSString *)subject body:(NSString *)body andRecipients:(NSArray *)recipients
{
    MFMailComposeViewController *picker = [[MFMailComposeViewController alloc] init];
    picker.mailComposeDelegate = viewController;
    
    // Mail Recipients
    [picker setToRecipients:recipients];
    
    // Mail Subject
    [picker setSubject:subject];
    
    // Fill out the email body text
    [picker setMessageBody:body isHTML:NO];
    
    // Present the eMailViewController
    [viewController presentModalViewController:picker animated:YES];
    
    // Status Bar Style
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
}

@end
