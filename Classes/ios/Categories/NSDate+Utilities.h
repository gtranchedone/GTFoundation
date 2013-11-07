/*
 Erica Sadun, http://ericasadun.com
 iPhone Developer's Cookbook 3.x and beyond
 BSD License, Use at your own risk
 */

/**
 This version of the file contains additions and changes made by
 Gianluca Tranchedone ( http://sketchtocode.com ).
 The author, Erica Sadun, is not responsible for those changes.
 */

#import <Foundation/Foundation.h>
#import "TimeFormatters.h"

@interface NSDate (Utilities)

+ (BOOL)timeIs24HourFormat;

// Relative dates from the current date
+ (NSDate *)dateTomorrow;
+ (NSDate *)dateYesterday;
+ (NSDate *)dateAtBeginningOfYear;
+ (NSDate *)dateWithDaysFromNow:(NSInteger)days;
+ (NSDate *)dateWithDaysBeforeNow:(NSInteger)days;
+ (NSDate *)dateWithHoursFromNow:(NSInteger)dHours;
+ (NSDate *)dateWithHoursBeforeNow:(NSInteger)dHours;
+ (NSDate *)dateWithMinutesFromNow:(NSInteger)dMinutes;
+ (NSDate *)dateWithMinutesBeforeNow:(NSInteger)dMinutes;

// Comparing dates
- (BOOL)isEqualToDateIgnoringTime:(NSDate *)aDate;
- (BOOL)isToday;
- (BOOL)isTomorrow;
- (BOOL)isYesterday;
- (BOOL)isSameWeekAsDate:(NSDate *)aDate;
- (BOOL)isThisWeek;
- (BOOL)isNextWeek;
- (BOOL)isLastWeek;
- (BOOL)isSameMonthAsDate:(NSDate *)aDate;
- (BOOL)isSameYearAsDate:(NSDate *)aDate;
- (BOOL)isThisYear;
- (BOOL)isNextYear;
- (BOOL)isLastYear;
- (BOOL)isEarlierThanDate:(NSDate *)aDate;
- (BOOL)isLaterThanDate:(NSDate *)aDate;

// Adjusting dates
- (NSDate *)dateByAddingCalendarUnit:(NSCalendarUnit)calendarUnit; // Adds enough time to cover the time expressed by the calendar unit.
- (NSDate *)dateBySubtractingCalendarUnit:(NSCalendarUnit)calendarUnit; // Subtracts enough time to cover the time expressed by the calendar unit.
- (NSDate *)dateByAddingNumberOfCalendarUnit:(NSInteger)numberOfCalendarUnit ofKind:(NSCalendarUnit)calendarUnit;
- (NSDate *)dateBySubtractingNumberOfCalendarUnit:(NSInteger)numberOfCalendarUnit ofKind:(NSCalendarUnit)calendarUnit;

- (NSDate *)dateByAddingDays:(NSInteger)dDays;
- (NSDate *)dateBySubtractingDays:(NSInteger)dDays;
- (NSDate *)dateByAddingHours:(NSInteger)dHours;
- (NSDate *)dateBySubtractingHours:(NSInteger)dHours;
- (NSDate *)dateByAddingMinutes: (NSInteger)dMinutes;
- (NSDate *)dateBySubtractingMinutes:(NSInteger)dMinutes;
- (NSDate *)dateAtStartOfDayWithTimeZone:(NSTimeZone *)timeZone;
- (NSDate *)dateAtStartOfDay;

// Retrieving intervals
//- (NSInteger)minutesAfterDate:(NSDate *)aDate;
//- (NSInteger)minutesBeforeDate:(NSDate *)aDate;
//- (NSInteger)hoursAfterDate:(NSDate *) aDate;
//- (NSInteger)hoursBeforeDate:(NSDate *)aDate;
//- (NSInteger)daysAfterDate:(NSDate *)aDate;
//- (NSInteger)daysBeforeDate:(NSDate *)aDate;

// Decomposing dates
@property (readonly) NSInteger nearestHour;
@property (readonly) NSInteger hour;
@property (readonly) NSInteger minute;
@property (readonly) NSInteger seconds;
@property (readonly) NSInteger day;
@property (readonly) NSInteger month;
@property (readonly) NSInteger week;
@property (readonly) NSInteger weekday;
@property (readonly) NSInteger nthWeekday; // e.g. 2nd Tuesday of the month == 2
@property (readonly) NSInteger year;

@end
