//
//  GTDetailEditingViewController.m
//  GTFramework
//
//  Created by Gianluca Tranchedone on 17/11/11.
//  Copyright (c) 2012 Sketch to Code. All rights reserved.
//

#import "GTDetailEditingViewController.h"

#import "NSNumberFormatter+SharedFormatter.h"
#import "NSDateFormatter+SharedFormatter.h"

#define TextViewTopMargin 10
#define TextViewLeftMargin 20
#define LongTextViewHeight 130
#define UITableViewCellStandardHeight 30
#define MaximumNumberAllowed @"999999999999"

#define DaysInWeek 7
#define DaysInMonth 30
#define DaysInYear 365

typedef enum
{
    TimeSpanSelectionDays,
    TimeSpanSelectionWeeks,
    TimeSpanSelectionMonths,
    TimeSpanSelectionYears
} TimeSpanSelection;

@interface GTDetailEditingViewController () <UITextFieldDelegate, UITextViewDelegate, UIPickerViewDelegate, UIPickerViewDataSource>

@property (nonatomic, strong) NSIndexPath *indexPath; // Used to edit calling cell's attributes
@property (nonatomic, assign) DetailEditingType type;
@property (nonatomic, strong) id objects;

@property (nonatomic, assign) NSUInteger choiceIndex;
@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, strong) UITextView *textView;
@property (nonatomic, strong) UIDatePicker *datePicker;
@property (nonatomic, strong) UIPickerView *generalPicker;
@property (nonatomic, strong) UIButton *amountValueSwitcher;
@property (nonatomic, assign) BOOL negativeAmount;

@property (nonatomic, assign) TimeSpanSelection currentTimeSpanSelection;

- (void)sendDataBack;
- (void)changeAmountSign:(UIButton *)sender;

@end

NSString * const DetailEditingDelegateArrayKey = @"DetailEditingDelegateArrayKey";
NSString * const DetailEditingDelegateIndexKey = @"DetailEditingDelegateIndexKey";

#pragma mark - Implementation

@implementation GTDetailEditingViewController

@synthesize delegate = delegate_;
@synthesize indexPath = indexPath_;
@synthesize type = type_;
@synthesize objects = objects_;

@synthesize choiceIndex = choiceIndex_;
@synthesize textField = textField_;
@synthesize textView = textView_;
@synthesize datePicker = datePicker_;
@synthesize generalPicker = generalPicker_;
@synthesize amountValueSwitcher = amountValueSwitcher_;
@synthesize negativeAmount = negativeAmount_;

@synthesize currentTimeSpanSelection = _currentTimeSpanSelection;

#pragma mark - Initialization

- (id)initWithEditingType:(DetailEditingType)type objects:(id)objects delegate:(id<GTDetailEditingDelegate>)delegate indexPath:(NSIndexPath *)indexPath
{
    self = [super initWithStyle:UITableViewStyleGrouped];
    
    if (self)
    {
        self.type = type;
        self.objects = objects;
        self.delegate = delegate;
        self.indexPath = indexPath;
        
        if (self.objects == [NSNull null]) {
            self.objects = nil;
        }
        
        if (type == DetailEditingTypeChoice || type == DetailEditingTypeChoice2) {
            self.choiceIndex = [[self.objects objectForKey:DetailEditingDelegateIndexKey] intValue];
            self.objects = [self.objects objectForKey:DetailEditingDelegateArrayKey];
        }
    }
    
    return self;
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.title = NSLocalizedString(@"Edit", nil);
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone 
                                                                        target:self action:@selector(sendDataBack)];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    if (self.type == DetailEditingTypeDate) {
        [self.datePicker setDate:self.objects animated:YES];
        [self.tableView reloadData];
    } 
    else if (self.type == DetailEditingTypeChoice2) {
        [self.generalPicker selectRow:self.choiceIndex inComponent:0 animated:YES];
        [self.tableView reloadData];
    }
    else if (self.type == DetailEditingTypeChoice) {
        [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:self.choiceIndex inSection:0] 
                              atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
    }
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return UIInterfaceOrientationIsPortrait(interfaceOrientation);
}

- (void)changeAmountSign:(UIButton *)sender
{
    self.negativeAmount = !self.negativeAmount;
    
    if (self.negativeAmount) {
        [sender setBackgroundImage:[UIImage imageNamed:@"NegativeButton.png"] forState:UIControlStateNormal];
    } else {
        [sender setBackgroundImage:[UIImage imageNamed:@"PositiveButton.png"] forState:UIControlStateNormal];
    }
}

#pragma mark - TableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.type == DetailEditingTypeChoice) {
        return [self.objects count];
    } else {
        return 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.textAlignment = UITextAlignmentLeft;

    if (self.type == DetailEditingTypeChoice) 
    {
        cell.textLabel.text = [self.objects objectAtIndex:indexPath.row];

        // Accessory
        if ([UIImage imageNamed:@"CellAccessoryEmpty.png"]) { // If the app is using my set of images
            if (indexPath.row != self.choiceIndex) {
                cell.accessoryView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"CellAccessoryEmpty.png"]];
            } 
            else {
                cell.accessoryView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"CellAccessorySelected.png"]];
            }
        } 
        else {
            if (indexPath.row != self.choiceIndex) {
                cell.accessoryType = UITableViewCellAccessoryNone;
            } 
            else {
                cell.accessoryType = UITableViewCellAccessoryCheckmark;
            }
        }
    } 
    else if (self.type == DetailEditingTypeChoice2)
    {
        if (!self.generalPicker)
        {
            self.generalPicker = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 200, self.view.bounds.size.width, 250)];
            self.generalPicker.showsSelectionIndicator = YES;
            self.generalPicker.delegate = self;
            self.generalPicker.dataSource = self;
            [self.view addSubview:self.generalPicker];
        }
        
        cell.textLabel.text = [self pickerView:self.generalPicker titleForRow:self.choiceIndex forComponent:0];
        cell.textLabel.textAlignment = UITextAlignmentCenter;
    }
    else if (self.type == DetailEditingTypeRepetingDateSelection)
    {
        if (!self.generalPicker)
        {
            self.generalPicker = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 200, self.view.bounds.size.width, 250)];
            self.generalPicker.showsSelectionIndicator = YES;
            self.generalPicker.delegate = self;
            self.generalPicker.dataSource = self;
            [self.view addSubview:self.generalPicker];
        }
        
        cell.textLabel.text = [self pickerView:self.generalPicker titleForRow:self.choiceIndex forComponent:self.currentTimeSpanSelection];
        cell.textLabel.textAlignment = UITextAlignmentCenter;
    }
    else if (self.type == DetailEditingTypeText || self.type == DetailEditingTypeCashAmount)
    {
        if (!self.textField && (!self.objects || [self.objects isKindOfClass:[NSString class]]))
        {
            self.textField = [[UITextField alloc] initWithFrame:(CGRect){cell.frame.origin.x + TextViewLeftMargin, 
                cell.frame.origin.y + TextViewTopMargin, cell.bounds.size.width - (TextViewLeftMargin * 2), UITableViewCellStandardHeight}];
            self.textField.delegate = self;
            self.textField.text = self.objects;
            self.textField.returnKeyType = UIReturnKeyDone;
            self.textField.clearButtonMode = UITextFieldViewModeAlways;
            self.textField.spellCheckingType = UITextSpellCheckingTypeYes;
            self.textField.autocorrectionType = UITextAutocorrectionTypeYes;
            self.textField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
            
            if (self.type == DetailEditingTypeCashAmount) {
                self.textField.keyboardType = UIKeyboardTypeNumberPad;
                self.textField.textAlignment = UITextAlignmentRight;
                
                self.amountValueSwitcher = [UIButton buttonWithType:UIButtonTypeCustom];
                self.amountValueSwitcher.frame = (CGRect){20.0, 20.0, 30.0, 30.0};
                [self.amountValueSwitcher addTarget:self action:@selector(changeAmountSign:) forControlEvents:UIControlEventTouchUpInside];
                
                self.negativeAmount = ([[[NSNumberFormatter decimalFormatter] numberFromString:self.objects] doubleValue] < 0);
                
                if (self.negativeAmount) {
                    [self.amountValueSwitcher setBackgroundImage:[UIImage imageNamed:@"NegativeButton.png"] forState:UIControlStateNormal];
                    self.textField.text = [self.textField.text stringByReplacingOccurrencesOfString:@"-" withString:@""];
                } else {
                    [self.amountValueSwitcher setBackgroundImage:[UIImage imageNamed:@"PositiveButton.png"] forState:UIControlStateNormal];
                }
                
                [self.view addSubview:self.amountValueSwitcher];
            }
            
            [cell addSubview:self.textField];
            [self.textField becomeFirstResponder];
        }
    }
    else if (self.type == DetailEditingTypeLongText)
    {
        CGFloat height = UITableViewCellStandardHeight;
        
        if (self.type == DetailEditingTypeLongText) {
            height = LongTextViewHeight;
        }
        
        if (!self.textView && (!self.objects || [self.objects isKindOfClass:[NSString class]])) 
        {
            self.textView = [[UITextView alloc] initWithFrame:(CGRect){cell.frame.origin.x + TextViewLeftMargin, 
                cell.frame.origin.y + TextViewTopMargin, cell.bounds.size.width - (TextViewLeftMargin * 2), height}];
            self.textView.delegate = self;
            self.textView.text = self.objects;
            self.textView.font = [UIFont systemFontOfSize:14];
            self.textView.backgroundColor = [UIColor clearColor];
            self.textView.spellCheckingType = UITextSpellCheckingTypeYes;
            self.textView.autocorrectionType = UITextAutocorrectionTypeYes;
            
            [cell addSubview:self.textView];
            [self.textView becomeFirstResponder];
        }
    }
    else if (self.type == DetailEditingTypeDate)
    {
        cell.textLabel.textAlignment = UITextAlignmentCenter;

        if (!self.datePicker)
        {            
            self.datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, 200, 325, 250)];
            self.datePicker.datePickerMode = UIDatePickerModeDateAndTime;
            self.datePicker.hidden = NO;
            self.datePicker.date = [NSDate date];
            [self.datePicker addTarget:self.tableView action:@selector(reloadData)forControlEvents:UIControlEventValueChanged];
            [self.view addSubview:self.datePicker];
        }
        
        cell.textLabel.text = [[[NSDateFormatter sharedFormatter] stringFromDate:self.datePicker.date] uppercaseString];
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.type == DetailEditingTypeLongText) {
        return LongTextViewHeight + (TextViewTopMargin * 2);
    } else {
        return UITableViewCellStandardHeight + (TextViewTopMargin * 2);
    }
}

#pragma mark - TableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.type == DetailEditingTypeChoice)
    {
        self.choiceIndex = indexPath.row;
        [self.tableView reloadData];
    }
}

#pragma mark - UITextFieldDelegate

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (self.type == DetailEditingTypeCashAmount)
    {
        NSString *newText = textField.text;
        
        NSDecimalNumberHandler *behaviour = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundPlain scale:2
                                                                                        raiseOnExactness:NO raiseOnOverflow:NO 
                                                                                        raiseOnUnderflow:NO raiseOnDivideByZero:NO];
        
        if (range.length == 1 && range.location == [textField.text length] - 1) // deleting digits
        {
            NSString *unformattedAmount = [[[NSNumberFormatter decimalFormatter] numberFromString:newText] stringValue];
            NSDecimalNumber *amount = [NSDecimalNumber decimalNumberWithString:unformattedAmount];
            
            amount = [amount decimalNumberByDividingBy:[NSDecimalNumber decimalNumberWithString:@"10"] withBehavior:behaviour];        
            textField.text = [[NSNumberFormatter decimalFormatter] stringFromNumber:amount];
        } 
        else {
            // since we multiply the value extracted from the textField by 10, if the new digit is 0 we don't need to do anything
            if (![string isEqualToString:[[NSDecimalNumber zero] stringValue]]) {
                newText = [textField.text stringByAppendingString:string];
            }
            
            NSString *unformattedAmount = [[[NSNumberFormatter decimalFormatter] numberFromString:newText] stringValue];
            NSDecimalNumber *amount = [NSDecimalNumber decimalNumberWithString:unformattedAmount];
            
            amount = [amount decimalNumberByMultiplyingBy:[NSDecimalNumber decimalNumberWithString:@"10"] withBehavior:behaviour]; 
            newText = [[NSNumberFormatter decimalFormatter] stringFromNumber:amount];
            
            // this is done to prevent the nsdecimalnumber's overflow exeption to trigger
            if (!([amount compare:[NSDecimalNumber decimalNumberWithString:MaximumNumberAllowed]] == NSOrderedDescending)) {
                self.textField.text = newText;
            }
        }
        
        return NO;
    } 
    else {
        return YES;
    }
}

- (BOOL)textFieldShouldClear:(UITextField *)textField
{
    if (self.type == DetailEditingTypeCashAmount) {
        textField.text = [[NSNumberFormatter decimalFormatter] stringFromNumber:[NSNumber numberWithDouble:0.0]];
        return NO;
    } else {
        return YES;
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [textField resignFirstResponder];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self sendDataBack];
    return YES;
}

#pragma mark - UITextViewDelegate

- (void)textViewDidEndEditing:(UITextView *)textView
{
    [self sendDataBack];
}

#pragma mark - UIPickerDelegate

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (self.type == DetailEditingTypeRepetingDateSelection) {
        self.currentTimeSpanSelection = component;
    }
    
    self.choiceIndex = row;
    
    [self.tableView reloadData];
}

#pragma mark - UIPickerDataSource

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (pickerView == self.generalPicker) {
        if (self.type == DetailEditingTypeRepetingDateSelection) {
            switch (component) {
                case 0:
                    if (self.currentTimeSpanSelection == TimeSpanSelectionDays) {
                        return 30;
                    } 
                    else if (self.currentTimeSpanSelection == TimeSpanSelectionWeeks) {
                        return 4;
                    }
                    else if (self.currentTimeSpanSelection == TimeSpanSelectionMonths) {
                        return 12;
                    }
                    else if (self.currentTimeSpanSelection == TimeSpanSelectionYears) {
                        return 99;
                    }
                    else {
                        return 0;
                    }
                    
                    break;
                    
                case 1:
                    return 4;
                    break;
                
                default:
                    return 0;
                    break;
            }
        } 
        else {
            return [self.objects count];
        }
    } 
    else {
        return 0;
    }
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    if (self.type == DetailEditingTypeRepetingDateSelection) {
        return 2;
    } 
    else {
        return 1;
    }
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    if (pickerView == self.generalPicker)
    {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 0.0, self.view.frame.size.width - 25, 30.0)];
        label.font = [UIFont boldSystemFontOfSize:18];
        label.backgroundColor = [UIColor clearColor];
        label.textAlignment = UITextAlignmentCenter;
        label.textColor = [UIColor blackColor];
        
        if (self.type == DetailEditingTypeRepetingDateSelection) {
            if (component == 0) {
                label.text = [NSString stringWithFormat:@"%d", row];
            }
            else {
                if (self.currentTimeSpanSelection == TimeSpanSelectionDays) {
                    label.text = NSLocalizedString(@"Days", nil);
                } 
                else if (self.currentTimeSpanSelection == TimeSpanSelectionWeeks) {
                    label.text = NSLocalizedString(@"Weeks", nil);
                }
                else if (self.currentTimeSpanSelection == TimeSpanSelectionMonths) {
                    label.text = NSLocalizedString(@"Months", nil);
                }
                else if (self.currentTimeSpanSelection == TimeSpanSelectionYears) {
                    label.text = NSLocalizedString(@"Years", nil);
                }
            }
        } 
        else {
            label.text = [self.objects objectAtIndex:row];
        }
        
        return label;
    }
    else {
        return nil;
    }
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (self.type == DetailEditingTypeRepetingDateSelection) {
        NSString *string = [NSString stringWithFormat:@"%d", row];
        
        if (self.currentTimeSpanSelection == TimeSpanSelectionDays) {
            [string stringByAppendingString:NSLocalizedString(@"Day(s)", nil)];
        } 
        else if (self.currentTimeSpanSelection == TimeSpanSelectionWeeks) {
            [string stringByAppendingString:NSLocalizedString(@"Week(s)", nil)];
        }
        else if (self.currentTimeSpanSelection == TimeSpanSelectionMonths) {
            [string stringByAppendingString:NSLocalizedString(@"Month(s)", nil)];
        }
        else if (self.currentTimeSpanSelection == TimeSpanSelectionYears) {
            [string stringByAppendingString:NSLocalizedString(@"Year(s)", nil)];
        }
        
        return string;
    } 
    else {
        return [self.objects objectAtIndex:row];
    }
}

#pragma mark - Delegations

- (void)sendDataBack
{
    if (self.type == DetailEditingTypeChoice || self.type == DetailEditingTypeChoice2)
    {
        NSDictionary *dictionary = [NSDictionary dictionaryWithObjectsAndKeys:
                                    self.objects, DetailEditingDelegateArrayKey,
                                    [NSNumber numberWithInt:self.choiceIndex], DetailEditingDelegateIndexKey, nil];
        
        if ([self.delegate respondsToSelector:@selector(detailEditingViewDidFinishWithReturnData:indexPath:)]) {
            [self.delegate detailEditingViewDidFinishWithReturnData:dictionary indexPath:self.indexPath];
        }
    }
    else if (self.type == DetailEditingTypeText || self.type == DetailEditingTypeCashAmount)
    {
        [self.textField resignFirstResponder];

        if ([self.delegate respondsToSelector:@selector(detailEditingViewDidFinishWithReturnData: indexPath:)]) {
            if (self.negativeAmount) {
                [self.delegate detailEditingViewDidFinishWithReturnData:[@"-" stringByAppendingString:self.textField.text] 
                                                              indexPath:self.indexPath];
            } else {
                [self.delegate detailEditingViewDidFinishWithReturnData:self.textField.text indexPath:self.indexPath];
            }
        }
    }
    else if (self.type == DetailEditingTypeLongText)
    {
        [self.textView resignFirstResponder];
        
        if ([self.delegate respondsToSelector:@selector(detailEditingViewDidFinishWithReturnData: indexPath:)]) {
            [self.delegate detailEditingViewDidFinishWithReturnData:self.textView.text indexPath:self.indexPath];
        }
    }
    else if (self.type == DetailEditingTypeDate)
    {
        if ([self.delegate respondsToSelector:@selector(detailEditingViewDidFinishWithReturnData:indexPath:)]) {
            [self.delegate detailEditingViewDidFinishWithReturnData:self.datePicker.date indexPath:self.indexPath];
        }
    }
    else if (self.type == DetailEditingTypeRepetingDateSelection)
    {
        NSInteger selectedDays = 1;
        if (self.currentTimeSpanSelection == TimeSpanSelectionWeeks) {
            selectedDays = DaysInWeek;
        }
        else if (self.currentTimeSpanSelection == TimeSpanSelectionMonths) {
            selectedDays = DaysInMonth;
        }
        else if (self.currentTimeSpanSelection == TimeSpanSelectionYears) {
            selectedDays = DaysInYear;
        }
        
        
        NSNumber *numberOfDays = [NSNumber numberWithInt:selectedDays];
        
        if ([self.delegate respondsToSelector:@selector(detailEditingViewDidFinishWithReturnData:indexPath:)]) {
            [self.delegate detailEditingViewDidFinishWithReturnData:numberOfDays indexPath:self.indexPath];
        }
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}

@end
