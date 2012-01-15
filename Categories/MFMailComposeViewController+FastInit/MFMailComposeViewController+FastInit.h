//
//  MFMailComposeViewController+FastInit.h
//  JapaneseGrammarDictionary
//
//  Created by Gianluca Tranchedone on 30/05/11.
//  Copyright 2012 Sketch to Code. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MessageUI/MessageUI.h>

@interface MFMailComposeViewController (FastInit)

+ (void)presentMailComposeViewFromViewController:(UIViewController<MFMailComposeViewControllerDelegate> *)viewController WithSubject:(NSString *)subject body:(NSString *)body andRecipients:(NSArray *)recipients;

@end
