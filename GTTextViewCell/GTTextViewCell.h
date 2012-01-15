//
//  GTTextViewCell.h
//
//  Created by Gianluca Tranchedone on 27/05/11.
//  Copyright 2012 Sketch to Code. All rights reserved.
//

/**
 *
 * *********************************************************************************
 * *** Methods needed for GTTextViewCell to work and their common implementation ***
 * *********************************************************************************
 * 
 * - (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
 * {
 *     [self.tableView reloadData];
 * }
 *
 * - (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
 * {
 *    GTTextViewCell *textViewCell = [[GTTextViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
 *
 *    textViewCell.textView.text = [text objectAtIndex:indexPath.section];
 *    textViewCell.detailTextView.text = [detailText objectAtIndex:indexPath.section];
 *
 *    return textViewCell;
 * }
 *
 * - (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath 
 * {	
 *    GTTextViewCell *textViewCell = [[GTTextViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
 *
 *    textViewCell.textView.text = [text objectAtIndex:indexPath.section];
 *    textViewCell.detailTextView.text = [detailText objectAtIndex:indexPath.section];
 *
 *    return [textViewCell cellHeight];
 * }
 *
 */

#import <UIKit/UIKit.h>

@interface GTTextViewCell : UITableViewCell
{
    UITextView *_textView;
    UITextView *_detailTextView;
}

@property (nonatomic, strong) UITextView *textView;
@property (nonatomic, strong) UITextView *detailTextView;

- (CGFloat)cellHeight:(UITableView *)tableView;
+ (CGFloat)cellHeightForText:(NSString *)text andDetailText:(NSString *)detailText forTableView:(UITableView *)tableView;

@end


/*** GTTextViewDelegate Protocol ***/

@protocol GTTextViewCellDelegate

@required
// Se the example above (in comment) on how to use this class.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;

// You have to give the cell a height or it will show too small to contain the whole text
// You should use the instance method - (void)cellHeight:(UITableView *)tableView to do that.
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;

// You have to reload data here
- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration;

@end
