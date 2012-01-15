//
//  GTTextViewCell.m
//
//  Created by Gianluca Tranchedone on 27/05/11.
//  Copyright 2012 Sketch to Code. All rights reserved.
//

#import "GTTextViewCell.h"

@implementation GTTextViewCell

@synthesize textView = _textView;
@synthesize detailTextView = _detailTextView;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        self.textView = [[UITextView alloc] initWithFrame:CGRectZero];
        self.detailTextView = [[UITextView alloc] initWithFrame:CGRectZero];
        
        self.textView.font = [UIFont boldSystemFontOfSize:18];
        self.textView.scrollEnabled = NO;
        self.textView.editable = NO;
        self.textView.backgroundColor = [UIColor clearColor];
        
        self.detailTextView.font = [UIFont systemFontOfSize:14];
        self.detailTextView.scrollEnabled = NO;
        self.detailTextView.editable = NO;
        self.detailTextView.backgroundColor = [UIColor clearColor];

        [self addSubview:self.textView];
        [self addSubview:self.detailTextView];
        self.selectionStyle = UITableViewCellSelectionStyleGray;
    }
    return self;
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated
{
    [super setHighlighted:highlighted animated:animated];
	
	if(highlighted && self.selectionStyle != UITableViewCellSelectionStyleNone) {
        self.textView.textColor = [UIColor colorWithRed:0.000 green:0.251 blue:0.602 alpha:1.000];
        self.detailTextView.textColor = [UIColor colorWithRed:0.300 green:0.251 blue:0.000 alpha:1.000];
    } else {
        self.textView.textColor = [UIColor blackColor];
        self.detailTextView.textColor = [UIColor darkGrayColor];
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
	
    self.textView.frame = CGRectInset(self.bounds, 20, 5);
    self.detailTextView.frame = CGRectMake(self.textView.frame.origin.x, self.textView.contentSize.height, self.textView.frame.size.width, self.detailTextView.contentSize.height);
}

- (CGFloat)cellHeight:(UITableView *)tableView
{
    self.textView.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, tableView.frame.size.width-40, self.textView.contentSize.height);
    self.detailTextView.frame = CGRectMake(self.textView.frame.origin.x, self.textView.contentSize.height, self.textView.frame.size.width, self.detailTextView.contentSize.height);
    
    if (self.detailTextView.text != nil) {
        return self.textView.contentSize.height + self.detailTextView.contentSize.height + 10;
    } else {
        return self.textView.contentSize.height + 10;
    }
}

+ (CGFloat)cellHeightForText:(NSString *)text andDetailText:(NSString *)detailText forTableView:(UITableView *)tableView
{
    GTTextViewCell *textViewCell = [[GTTextViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    textViewCell.textView.text = text;
    textViewCell.detailTextView.text = detailText;
    
    textViewCell.textView.frame = CGRectMake(textViewCell.frame.origin.x, textViewCell.frame.origin.y, tableView.frame.size.width-40, textViewCell.textView.contentSize.height);
    textViewCell.detailTextView.frame = CGRectMake(textViewCell.textView.frame.origin.x, textViewCell.textView.contentSize.height, textViewCell.textView.frame.size.width, textViewCell.detailTextView.contentSize.height);
    
    if (textViewCell.detailTextView.text != nil) {
        return textViewCell.textView.contentSize.height + textViewCell.detailTextView.contentSize.height + 10;
    } else {
        return textViewCell.textView.contentSize.height + 10;
    }
}


@end
