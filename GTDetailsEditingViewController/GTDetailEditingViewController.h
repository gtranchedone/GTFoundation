//
//  GTDetailEditingViewController.h
//  GTFramework
//
//  Created by Gianluca Tranchedone on 17/11/11.
//  Copyright (c) 2012 Sketch to Code. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 DetailsEditingType defines whether the return type is NSString, an NSDate or an
 NSDictionary (containg the list of choices as a NSArray of NSStrings and the index of the chosen item as a NSNumber)
 */

typedef enum {
    DetailEditingTypeText,
    DetailEditingTypeLongText, // creates a bigger text input field
    DetailEditingTypeDate,
    DetailEditingTypeChoice,
    DetailEditingTypeChoice2,
    DetailEditingTypeCashAmount,
    DetailEditingTypeUntilDateSelection,
    DetailEditingTypeRepetingDateSelection
} DetailEditingType;

NSString * const DetailEditingDelegateArrayKey;
NSString * const DetailEditingDelegateIndexKey;

@protocol GTDetailEditingDelegate;

@interface GTDetailEditingViewController : UITableViewController

@property (nonatomic, assign) id<GTDetailEditingDelegate> delegate;

@property (nonatomic, strong) UIDatePicker *datePicker;

- (id)initWithEditingType:(DetailEditingType)type objects:(id)objects delegate:(id<GTDetailEditingDelegate>)delegate indexPath:(NSIndexPath *)indexPath;

@end


// GTDetailEditingDelegate

@protocol GTDetailEditingDelegate <NSObject>

- (void)detailEditingViewDidFinishWithReturnData:(id)data indexPath:(NSIndexPath *)indexPath;

@end
