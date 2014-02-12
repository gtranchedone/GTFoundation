//
//  NSDate+Utilities.h
//  GTFoundation
//
//  Created by Gianluca Tranchedone on 14/08/13.
//  The MIT License (MIT)
//
//  Copyright (c) 2013 Gianluca Tranchedone
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy of
//  this software and associated documentation files (the "Software"), to deal in
//  the Software without restriction, including without limitation the rights to
//  use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
//  the Software, and to permit persons to whom the Software is furnished to do so,
//  subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
//  FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
//  COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
//  IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
//  CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
//

#import <Foundation/Foundation.h>

@interface NSDate (Utilities)

+ (BOOL)GT_timeIs24HourFormat;

///--------------------------------------------------
/// @name Relative Dates
///--------------------------------------------------

+ (NSDate *)GT_dateTomorrow;
+ (NSDate *)GT_dateYesterday;
+ (NSDate *)GT_dateAtBeginningOfYear;
+ (NSDate *)GT_dateWithDaysFromNow:(NSInteger)days;
+ (NSDate *)GT_dateWithDaysBeforeNow:(NSInteger)days;
+ (NSDate *)GT_dateWithHoursFromNow:(NSInteger)dHours;
+ (NSDate *)GT_dateWithHoursBeforeNow:(NSInteger)dHours;
+ (NSDate *)GT_dateWithMinutesFromNow:(NSInteger)dMinutes;
+ (NSDate *)GT_dateWithMinutesBeforeNow:(NSInteger)dMinutes;

///--------------------------------------------------
/// @name Comparing Dates
///--------------------------------------------------

- (BOOL)GT_isEqualToDateIgnoringTime:(NSDate *)aDate;
- (BOOL)GT_isToday;
- (BOOL)GT_isTomorrow;
- (BOOL)GT_isYesterday;
- (BOOL)GT_isSameWeekAsDate:(NSDate *)aDate;
- (BOOL)GT_isThisWeek;
- (BOOL)GT_isNextWeek;
- (BOOL)GT_isLastWeek;
- (BOOL)GT_isSameMonthAsDate:(NSDate *)aDate;
- (BOOL)GT_isSameYearAsDate:(NSDate *)aDate;
- (BOOL)GT_isThisYear;
- (BOOL)GT_isNextYear;
- (BOOL)GT_isLastYear;
- (BOOL)GT_isEarlierThanDate:(NSDate *)aDate;
- (BOOL)GT_isLaterThanDate:(NSDate *)aDate;

///--------------------------------------------------
/// @name Adjusting Dates
///--------------------------------------------------

- (NSDate *)GT_dateByAddingCalendarUnit:(NSCalendarUnit)calendarUnit; // Adds enough time to cover the time expressed by the calendar unit.
- (NSDate *)GT_dateBySubtractingCalendarUnit:(NSCalendarUnit)calendarUnit; // Subtracts enough time to cover the time expressed by the calendar unit.
- (NSDate *)GT_dateByAddingNumberOfCalendarUnit:(NSInteger)numberOfCalendarUnit ofKind:(NSCalendarUnit)calendarUnit;
- (NSDate *)GT_dateBySubtractingNumberOfCalendarUnit:(NSInteger)numberOfCalendarUnit ofKind:(NSCalendarUnit)calendarUnit;

- (NSDate *)GT_dateAtStartOfDay;
- (NSDate *)GT_dateByAddingDays:(NSInteger)days;
- (NSDate *)GT_dateBySubtractingDays:(NSInteger)days;
- (NSDate *)GT_dateByAddingHours:(NSInteger)hours;
- (NSDate *)GT_dateBySubtractingHours:(NSInteger)hours;
- (NSDate *)GT_dateByAddingMinutes: (NSInteger)minutes;
- (NSDate *)GT_dateBySubtractingMinutes:(NSInteger)minutes;
- (NSDate *)GT_dateAtStartOfDayWithTimeZone:(NSTimeZone *)timeZone;

///--------------------------------------------------
/// @name Decomposing Dates
///--------------------------------------------------

@property (readonly) NSInteger nearestHour;
@property (readonly) NSInteger hour;
@property (readonly) NSInteger minute;
@property (readonly) NSInteger seconds;
@property (readonly) NSInteger day;
@property (readonly) NSInteger month;
@property (readonly) NSInteger week;
@property (readonly) NSInteger weekday;
@property (readonly) NSInteger year;

@end
