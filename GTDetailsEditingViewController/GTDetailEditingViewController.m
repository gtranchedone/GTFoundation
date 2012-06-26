//
//  GTDetailEditingViewController.m
//  GTFramework
//
//  Created by Gianluca Tranchedone on 17/11/11.
//  Copyright (c) 2012 Sketch to Code. All rights reserved.
//

// TODO: typeDate -> add days of the week selection, "never", "soon" and "forever"

#import "GTDetailEditingViewController.h"

#import "NSNumberFormatter+SharedFormatter.h"
#import "NSDateFormatter+SharedFormatter.h"
#import "GTAmountField.h"

#define TextViewTopMargin 10
#define TextViewLeftMargin 20
#define LongTextViewHeight 130
#define UITableViewCellStandardHeight 30
#define MaximumNumberAllowed @"999999999999"

#define DaysInWeek 7
#define DaysInMonth 30
#define DaysInYear 365

static NSUInteger days = 0;

typedef enum
{
    TimeSpanSelectionDays,
    TimeSpanSelectionWeeks,
    TimeSpanSelectionMonths,
    TimeSpanSelectionYears
} TimeSpanSelection;

@interface GTDetailEditingViewController () <UITextFieldDelegate, UITextViewDelegate, UIPickerViewDelegate, UIPickerViewDataSource, 
                                                GTAmountFieldDelegate>

@property (nonatomic, strong) NSIndexPath *indexPath; // Used to edit calling cell's attributes
@property (nonatomic, assign) DetailEditingType type;
@property (nonatomic, strong) id objects;

@property (nonatomic, assign) NSUInteger choiceIndex;
@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, strong) UITextView *textView;
@property (nonatomic, strong) GTAmountField *amountField;
@property (nonatomic, strong) UIPickerView *generalPicker;
@property (nonatomic, strong) UIButton *amountValueSwitcher;
@property (nonatomic, assign) BOOL negativeAmount;

@property (nonatomic, assign) TimeSpanSelection currentTimeSpanSelection;
@property (nonatomic, assign) UIDatePickerMode datePickerMode;
@property (nonatomic, assign) BOOL neverRepeat;

- (void)sendDataBack;
- (void)setRepetitionToNever;
- (void)changeAmountSign:(UIButton *)sender;

@end

NSString * const DetailEditingDelegateArrayKey = @"DetailEditingDelegateArrayKey";
NSString * const DetailEditingDelegateIndexKey = @"DetailEditingDelegateIndexKey";

#pragma mark - Implementation

@implementation GTDetailEditingViewController

@synthesize delegate = _delegate;
@synthesize indexPath = _indexPath;
@synthesize type = _type;
@synthesize objects = _objects;
@synthesize datePickerMode = _datePickerMode;

@synthesize choiceIndex = _choiceIndex;
@synthesize textField = _textField;
@synthesize textView = _textView;
@synthesize datePicker = _datePicker;
@synthesize amountField = _amountField;
@synthesize generalPicker = _generalPicker;
@synthesize amountValueSwitcher = _amountValueSwitcher;
@synthesize negativeAmount = _negativeAmount;

@synthesize currentTimeSpanSelection = _currentTimeSpanSelection;
@synthesize neverRepeat = _neverRepeat;

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
        
        if (type == DetailEditingTypeUntilDateSelection) {
            self.type = DetailEditingTypeDate;
            self.datePickerMode = UIDatePickerModeDate;
        }
        else if (type == DetailEditingTypeDate) {
            self.datePickerMode = UIDatePickerModeDateAndTime;
        }
        else if (type == DetailEditingTypeRepetingDateSelection) {
            self.choiceIndex = [self.objects intValue];
        }
        
        if (type == DetailEditingTypeChoice || type == DetailEditingTypeChoice2) {
            self.choiceIndex = [[self.objects objectForKey:DetailEditingDelegateIndexKey] intValue];
            self.objects = [self.objects objectForKey:DetailEditingDelegateArrayKey];
        }
        
        if (type != DetailEditingTypeChoice) {
            self.tableView.scrollEnabled = NO;
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
    
    if (self.type == DetailEditingTypeRepetingDateSelection) {
        UIView *footerView = [[UIView alloc] initWithFrame:(CGRect){CGPointZero, self.view.bounds.size.width, 55}];
        footerView.backgroundColor = [UIColor clearColor];
        
        NSString *buttonTitle = NSLocalizedString(@"Never Repeat", nil);
        CGSize titleSize = [buttonTitle sizeWithFont:[UIFont boldSystemFontOfSize:17]];
        CGRect buttonFrame = (CGRect){(self.view.bounds.size.width - titleSize.width - 10) / 2, 5.0, titleSize.width + 10, 45};
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [button addTarget:self action:@selector(setRepetitionToNever) forControlEvents:UIControlEventTouchUpInside];
        [button setTitle:buttonTitle forState:UIControlStateNormal];
        button.frame = buttonFrame;
        [footerView addSubview:button];
        
        self.tableView.tableFooterView = footerView;
    }
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    if (self.type == DetailEditingTypeDate) {
        if (!self.objects) self.objects = [NSDate date];
        [self.datePicker setDate:self.objects animated:YES];
        [self.tableView reloadData];
    } 
    else if (self.type == DetailEditingTypeChoice2) {
        [self.generalPicker selectRow:self.choiceIndex inComponent:0 animated:YES];
    }
    else if (self.type == DetailEditingTypeChoice) {
        [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:self.choiceIndex inSection:0] 
                              atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
    }
    else if (self.type == DetailEditingTypeRepetingDateSelection) {
        NSInteger compomentOneRow = 1;
        if (self.choiceIndex >= DaysInYear) {
            compomentOneRow = 4;
            self.choiceIndex = floor((double)(self.choiceIndex / DaysInYear));
        }
        else if (self.choiceIndex >= DaysInMonth) {
            compomentOneRow = 3;
            self.choiceIndex = floor((double)(self.choiceIndex / DaysInMonth));
        }
        else if (self.choiceIndex >= DaysInWeek) {
            compomentOneRow = 2;
            self.choiceIndex = floor((double)(self.choiceIndex / DaysInWeek));
        }
        
        [self.generalPicker selectRow:compomentOneRow - 1 inComponent:1 animated:YES];
        [self.generalPicker selectRow:self.choiceIndex - 1 inComponent:0 animated:YES];
        [self pickerView:self.generalPicker didSelectRow:compomentOneRow - 1 inComponent:1];
        [self pickerView:self.generalPicker didSelectRow:self.choiceIndex - 1 inComponent:0];
    }
    else if (self.type == DetailEditingTypeCashAmount) {
        [self.amountField becomeFirstResponder];
    }
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    if (self.type == DetailEditingTypeCashAmount) {
        if ([self.amountField isFirstResponder]) {
            [self.amountField resignFirstResponder];
        }
    }
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
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
    cell.textLabel.textAlignment = NSTextAlignmentLeft;
    
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
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
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
        
        if (self.neverRepeat) {
            cell.textLabel.text = NSLocalizedString(@"Never Repeat", nil);
        }
        else {
            cell.textLabel.text = [self pickerView:self.generalPicker titleForRow:self.choiceIndex forComponent:self.currentTimeSpanSelection];
        }
        
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
    }
    else if (self.type == DetailEditingTypeText) {
        [cell addSubview:self.textField];
        [self.textField becomeFirstResponder];
    }
    else if (self.type == DetailEditingTypeCashAmount)
    {
        if (!self.objects || [self.objects isKindOfClass:[NSString class]]) {
            NSNumber *amount = [[NSNumberFormatter decimalFormatter] numberFromString:self.objects];
            self.amountField.amount = [NSDecimalNumber decimalNumberWithString:[amount stringValue]];
        }
        
        [cell addSubview:self.amountField];
        [self.amountField becomeFirstResponder];
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
            self.textView.font = [UIFont systemFontOfSize:15];
            self.textView.backgroundColor = [UIColor clearColor];
            self.textView.spellCheckingType = UITextSpellCheckingTypeYes;
            self.textView.autocorrectionType = UITextAutocorrectionTypeYes;
            
            [cell addSubview:self.textView];
            [self.textView becomeFirstResponder];
        }
    }
    else if (self.type == DetailEditingTypeDate)
    {
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
        
        if (![self.datePicker isDescendantOfView:self.view]) {
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
    else if (self.type == DetailEditingTypeRepetingDateSelection) {
        self.neverRepeat = NO;
        [self.tableView reloadData];
        
        [UIView animateWithDuration:0.5 animations:^{
            self.generalPicker.frame = (CGRect){0.0, self.view.bounds.size.height - self.generalPicker.bounds.size.height, self.generalPicker.bounds.size};
        }];
    }
}

#pragma mark - UITextFieldDelegate

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
        if (component == 1) {
            self.currentTimeSpanSelection = row;
        }
        else {
            self.choiceIndex = row;
            days = row + 1;
        }
    }
    else {
        self.choiceIndex = row;
    }
    
    [pickerView reloadAllComponents];
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
        label.font = [UIFont boldSystemFontOfSize:17];
        label.backgroundColor = [UIColor clearColor];
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = [UIColor blackColor];
        
        if (self.type == DetailEditingTypeRepetingDateSelection) {
            if (component == 0) {
                label.text = [NSString stringWithFormat:@"%d", row + 1];
            }
            else {
                switch (row) {
                    case TimeSpanSelectionDays:
                        if (days == 1) {
                            label.text = NSLocalizedString(@"Day", nil);
                        }
                        else {
                            label.text = NSLocalizedString(@"Days", nil);
                        }
                        
                        break;
                        
                    case TimeSpanSelectionWeeks:
                        if (days == 1) {
                            label.text = NSLocalizedString(@"Week", nil);
                        }
                        else {
                            label.text = NSLocalizedString(@"Weeks", nil);
                        }
                        
                        break;
                        
                    case TimeSpanSelectionMonths:
                        if (days == 1) {
                            label.text = NSLocalizedString(@"Month", nil);
                        }
                        else {
                            label.text = NSLocalizedString(@"Months", nil);
                        }
                        
                        break;
                        
                    case TimeSpanSelectionYears:
                        if (days == 1) {
                            label.text = NSLocalizedString(@"Year", nil);
                        }
                        else {
                            label.text = NSLocalizedString(@"Years", nil);
                        }
                        
                        break;
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
        NSString *string = [NSString stringWithFormat:@"%d ", row + 1];
        
        if (days != 1) {
            if (self.currentTimeSpanSelection == TimeSpanSelectionDays) {
                string = [string stringByAppendingString:NSLocalizedString(@"Days", nil)];
            } 
            else if (self.currentTimeSpanSelection == TimeSpanSelectionWeeks) {
                string = [string stringByAppendingString:NSLocalizedString(@"Weeks", nil)];
            }
            else if (self.currentTimeSpanSelection == TimeSpanSelectionMonths) {
                string = [string stringByAppendingString:NSLocalizedString(@"Months", nil)];
            }
            else if (self.currentTimeSpanSelection == TimeSpanSelectionYears) {
                string = [string stringByAppendingString:NSLocalizedString(@"Years", nil)];
            }
        }
        else {
            if (self.currentTimeSpanSelection == TimeSpanSelectionDays) {
                string = [string stringByAppendingString:NSLocalizedString(@"Day", nil)];
            } 
            else if (self.currentTimeSpanSelection == TimeSpanSelectionWeeks) {
                string = [string stringByAppendingString:NSLocalizedString(@"Week", nil)];
            }
            else if (self.currentTimeSpanSelection == TimeSpanSelectionMonths) {
                string = [string stringByAppendingString:NSLocalizedString(@"Month", nil)];
            }
            else if (self.currentTimeSpanSelection == TimeSpanSelectionYears) {
                string = [string stringByAppendingString:NSLocalizedString(@"Year", nil)];
            }
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
    else if (self.type == DetailEditingTypeCashAmount) {
        if ([self.delegate respondsToSelector:@selector(detailEditingViewDidFinishWithReturnData:indexPath:)]) {
            [self.delegate detailEditingViewDidFinishWithReturnData:self.amountField.amount indexPath:self.indexPath];
        }
    }
    else if (self.type == DetailEditingTypeText)
    {
        [self.textField resignFirstResponder];
        
        if ([self.delegate respondsToSelector:@selector(detailEditingViewDidFinishWithReturnData:indexPath:)]) {
            [self.delegate detailEditingViewDidFinishWithReturnData:self.textField.text indexPath:self.indexPath];
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
        
        
        NSNumber *numberOfDays = [NSNumber numberWithInt:selectedDays * days];
        if (self.neverRepeat) {
            numberOfDays = [NSNumber numberWithInt:0];
        }
        
        if ([self.delegate respondsToSelector:@selector(detailEditingViewDidFinishWithReturnData:indexPath:)]) {
            [self.delegate detailEditingViewDidFinishWithReturnData:numberOfDays indexPath:self.indexPath];
        }
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)setRepetitionToNever {
    self.neverRepeat = YES;
    [self.tableView reloadData];
    
    [UIView animateWithDuration:0.5 animations:^{
        self.generalPicker.frame = (CGRect){0.0, self.view.window.bounds.size.height, self.generalPicker.bounds.size};
    }];
}

#pragma mark - GTAmountFieldDelegate

- (void)amountFieldDidPressEnterKey:(GTAmountField *)amountField
{
    [self sendDataBack];
}

#pragma mark - Setters and Getters

static CGRect const kCellFieldsFrame = (CGRect){20.0f, 0.0f, 280.0f, 50.0f};

- (GTAmountField *)amountField
{
    if (!_amountField) {
        GTAmountField *amountField = [[GTAmountField alloc] initWithFrame:kCellFieldsFrame];
        amountField.font = [UIFont boldSystemFontOfSize:24];
        amountField.minimumFontScale = 18;
        amountField.delegate = self;
        
        self.amountField = amountField;
    }
    
    return _amountField;
}

- (UITextField *)textField
{
    if (!_textField) {
        UITextField *textField = [[UITextField alloc] initWithFrame:kCellFieldsFrame];
        textField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        textField.autocorrectionType = UITextAutocorrectionTypeYes;
        textField.spellCheckingType = UITextSpellCheckingTypeYes;
        textField.clearButtonMode = UITextFieldViewModeAlways;
        textField.returnKeyType = UIReturnKeyDone;
        textField.text = self.objects;
        textField.delegate = self;
        
        self.textField = textField;
    }
    
    return _textField;
}

- (UIDatePicker *)datePicker
{
    if (!_datePicker) {
        self.datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, 200, 325, 250)];
        self.datePicker.datePickerMode = self.datePickerMode;
        self.datePicker.hidden = NO;
        self.datePicker.date = [NSDate date];
        [self.datePicker addTarget:self.tableView action:@selector(reloadData)forControlEvents:UIControlEventValueChanged];
    }
    
    return _datePicker;
}

@end
