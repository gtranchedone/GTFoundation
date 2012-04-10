//
//  GTAlertView.h
//  GTFrameworkDemo
//
//  Created by Gianluca Tranchedone on 10/04/12.
//  Copyright (c) 2012 SketchToCode. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GTAlertView : UIAlertView {
    NSMutableArray *_blocksArray;
}

- (id)initWithTitle:(NSString *)title message:(NSString *)message cancelButtonTitle:(NSString *)cancelButton cancelBlock:(void(^)(void))cancelBlock;
- (void)addButtonWithTitle:(NSString *)title selectionBlock:(void(^)(void))selectionBlock;

@end
