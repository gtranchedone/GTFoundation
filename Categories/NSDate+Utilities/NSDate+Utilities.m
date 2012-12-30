/*
 Erica Sadun, http://ericasadun.com
 iPhone Developer's Cookbook 3.x and beyond
 BSD License, Use at your own risk
 */

/*
 #import <humor.h> : Not planning to implement: dateByAskingBoyOut and dateByGettingBabysitter
 ----
 General Thanks: sstreza, Scott Lawrence, Kevin Ballard, NoOneButMe, Avi`, August Joki. Emanuele Vulcano, jcromartiej
*/

/**
 This version of the file contains additions and changes made by
 Gianluca Tranchedone ( http://sketchtocode.com ).
 The author, Erica Sadun, is not responsible for those changes.
 */

#import "NSDate+Utilities.h"

#define DATE_COMPONENTS (NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekCalendarUnit |  NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit | NSWeekdayCalendarUnit | NSWeekdayOrdinalCalendarUnit)

@implementation NSDate (Utilities)

+ (BOOL)timeIs24HourFormat 
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setLocale:[NSLocale currentLocale]];
    [formatter setDateStyle:NSDateFormatterNoStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    NSString *dateString = [formatter stringFromDate:[NSDate date]];
    NSRange amRange = [dateString rangeOfString:[formatter AMSymbol]];
    NSRange pmRange = [dateString rangeOfString:[formatter PMSymbol]];
    BOOL is24Hour = (amRange.location == NSNotFound && pmRange.location == NSNotFound);
    return is24Hour;
}

#pragma mark Relative Dates

+ (NSDate *)dateWithDaysFromNow:(NSInteger)days
{
	return [[NSDate date] dateByAddingDays:days];
}

+ (NSDate *)dateWithDaysBeforeNow:(NSInteger)days
{
	return [[NSDate date] dateBySubtractingDays:days];
}

+ (NSDate *)dateTomorrow
{
	return [NSDate dateWithDaysFromNow:1];
}

+ (NSDate *)dateYesterday
{
	return [NSDate dateWithDaysBeforeNow:1];
}

+ (NSDate *)dateAtBeginningOfYear
{
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    dateComponents.year = [[NSDate date] year];
    dateComponents.month = 1;
    dateComponents.day = 1;
    
    return [[NSCalendar currentCalendar] dateFromComponents:dateComponents];;
}

+ (NSDate *)dateWithHoursFromNow:(NSInteger)hours
{
	return [[NSDate date] dateByAddingHours:hours];
}

+ (NSDate *)dateWithHoursBeforeNow:(NSInteger)hours
{
	return [[NSDate date] dateBySubtractingHours:hours];
}

+ (NSDate *)dateWithMinutesFromNow:(NSInteger)minutes
{
	return [[NSDate date] dateByAddingMinutes:minutes];
}

+ (NSDate *)dateWithMinutesBeforeNow:(NSInteger)minutes
{
	return [[NSDate date] dateBySubtractingMinutes:minutes];
}

#pragma mark Comparing Dates

- (BOOL)isEqualToDateIgnoringTime:(NSDate *) aDate
{
	NSDateComponents *components1 = [[NSCalendar currentCalendar] components:DATE_COMPONENTS fromDate:self];
	NSDateComponents *components2 = [[NSCalendar currentCalendar] components:DATE_COMPONENTS fromDate:aDate];
	return (([components1 year] == [components2 year]) &&
			([components1 month] == [components2 month]) && 
			([components1 day] == [components2 day]));
}

- (BOOL)isToday
{
	return [self isEqualToDateIgnoringTime:[NSDate date]];
}

- (BOOL)isTomorrow
{
	return [self isEqualToDateIgnoringTime:[NSDate dateTomorrow]];
}

- (BOOL)isYesterday
{
	return [self isEqualToDateIgnoringTime:[NSDate dateYesterday]];
}

// This hard codes the assumption that a week is 7 days
- (BOOL)isSameWeekAsDate:(NSDate *)aDate
{
	NSDateComponents *components1 = [[NSCalendar currentCalendar] components:DATE_COMPONENTS fromDate:self];
	NSDateComponents *components2 = [[NSCalendar currentCalendar] components:DATE_COMPONENTS fromDate:aDate];
	
	// Must be same week. 12/31 and 1/1 will both be week "1" if they are in the same week
	if ([components1 week] != [components2 week]) return NO;
	
	// Must have a time interval under 1 week. Thanks @aclark
	return (abs([self timeIntervalSinceDate:aDate]) < (60 * 60 * 24 * 7));
}

- (BOOL)isThisWeek
{
	return [self isSameWeekAsDate:[NSDate date]];
}

- (BOOL)isNextWeek
{
	NSDate *newDate = [[NSDate date] dateByAddingCalendarUnit:NSWeekCalendarUnit];
	return [self isSameYearAsDate:newDate];
}

- (BOOL)isLastWeek
{
	NSDate *newDate = [[NSDate date] dateBySubtractingCalendarUnit:NSWeekCalendarUnit];
	return [self isSameYearAsDate:newDate];
}

- (BOOL)isSameMonthAsDate:(NSDate *)aDate
{
    NSDateComponents *components1 = [[NSCalendar currentCalendar] components:NSYearCalendarUnit fromDate:self];
	NSDateComponents *components2 = [[NSCalendar currentCalendar] components:NSYearCalendarUnit fromDate:aDate];
	return ([components1 month] == [components2 month]);
}

- (BOOL)isSameYearAsDate:(NSDate *)aDate
{
	NSDateComponents *components1 = [[NSCalendar currentCalendar] components:NSYearCalendarUnit fromDate:self];
	NSDateComponents *components2 = [[NSCalendar currentCalendar] components:NSYearCalendarUnit fromDate:aDate];
	return ([components1 year] == [components2 year]);
}

- (BOOL)isThisYear
{
	return [self isSameYearAsDate:[NSDate date]];
}

- (BOOL)isNextYear
{
	NSDateComponents *components1 = [[NSCalendar currentCalendar] components:NSYearCalendarUnit fromDate:self];
	NSDateComponents *components2 = [[NSCalendar currentCalendar] components:NSYearCalendarUnit fromDate:[NSDate date]];
	
	return ([components1 year] == ([components2 year] + 1));
}

- (BOOL)isLastYear
{
	NSDateComponents *components1 = [[NSCalendar currentCalendar] components:NSYearCalendarUnit fromDate:self];
	NSDateComponents *components2 = [[NSCalendar currentCalendar] components:NSYearCalendarUnit fromDate:[NSDate date]];
	
	return ([components1 year] == ([components2 year] - 1));
}

- (BOOL)isEarlierThanDate: (NSDate *) aDate
{
	return ([self earlierDate:aDate] == self);
}

- (BOOL)isLaterThanDate: (NSDate *) aDate
{
	return ([self laterDate:aDate] == self);
}


#pragma mark Adjusting Dates

- (NSDate *)dateByAddingCalendarUnit:(NSCalendarUnit)calendarUnit
{
    return [self dateByAddingNumberOfCalendarUnit:1 ofKind:calendarUnit];
}

- (NSDate *)dateBySubtractingCalendarUnit:(NSCalendarUnit)calendarUnit
{
    return [self dateBySubtractingNumberOfCalendarUnit:1 ofKind:calendarUnit];
}

- (NSDate *)dateByAddingNumberOfCalendarUnit:(NSInteger)numberOfCalendarUnit ofKind:(NSCalendarUnit)calendarUnit
{
    NSDateComponents *components = [[NSDateComponents alloc] init];
    
    switch (calendarUnit) {
        case NSSecondCalendarUnit:
            [components setSecond:numberOfCalendarUnit];
            break;
            
        case NSMinuteCalendarUnit:
            [components setMinute:numberOfCalendarUnit];
            break;
            
        case NSHourCalendarUnit:
            [components setHour:numberOfCalendarUnit];
            break;
            
        case NSDayCalendarUnit:
            [components setDay:numberOfCalendarUnit];
            break;
            
        case NSWeekCalendarUnit:
            [components setWeekOfYear:numberOfCalendarUnit];
            break;
            
        case NSMonthCalendarUnit:
            [components setMonth:numberOfCalendarUnit];
            break;
            
        case NSYearCalendarUnit:
            [components setYear:numberOfCalendarUnit];
            break;
            
        default:
            NSLog(@"Calendar Unit Not Supported Yet.");
            break;
    }
    
    return [[NSCalendar currentCalendar] dateByAddingComponents:components toDate:self options:0];
}

- (NSDate *)dateBySubtractingNumberOfCalendarUnit:(NSInteger)numberOfCalendarUnit ofKind:(NSCalendarUnit)calendarUnit
{
    return [self dateByAddingNumberOfCalendarUnit:(numberOfCalendarUnit * -1) ofKind:calendarUnit];
}

- (NSDate *)dateByAddingDays:(NSInteger)days
{
	return [self dateByAddingNumberOfCalendarUnit:days ofKind:NSDayCalendarUnit];
}

- (NSDate *)dateBySubtractingDays:(NSInteger)days
{
	return [self dateByAddingDays:(days * -1)];
}

- (NSDate *)dateByAddingHours:(NSInteger)hours
{
	return [self dateByAddingNumberOfCalendarUnit:hours ofKind:NSHourCalendarUnit];
}

- (NSDate *)dateBySubtractingHours:(NSInteger)hours
{
	return [self dateByAddingHours:(hours * -1)];
}

- (NSDate *)dateByAddingMinutes:(NSInteger)minutes
{
	return [self dateByAddingNumberOfCalendarUnit:minutes ofKind:NSMinuteCalendarUnit];
}

- (NSDate *)dateBySubtractingMinutes:(NSInteger)minutes
{
	return [self dateByAddingMinutes:(minutes * -1)];
}

- (NSDate *)dateAtStartOfDayWithTimeZone:(NSTimeZone *)timeZone
{
    NSDateComponents *components = [[NSCalendar currentCalendar] components:DATE_COMPONENTS fromDate:self];
	[components setHour:0];
	[components setMinute:0];
	[components setSecond:0];
    [components setTimeZone:timeZone];
	return [[NSCalendar currentCalendar] dateFromComponents:components];
}

- (NSDate *)dateAtStartOfDay
{
	return [self dateAtStartOfDayWithTimeZone:[NSTimeZone defaultTimeZone]];
}

- (NSDateComponents *)componentsWithOffsetFromDate: (NSDate *) aDate
{
	NSDateComponents *dTime = [[NSCalendar currentCalendar] components:DATE_COMPONENTS fromDate:aDate toDate:self options:0];
	return dTime;
}

#pragma mark Retrieving Intervals

//- (NSInteger)minutesAfterDate: (NSDate *) aDate
//{
//	NSTimeInterval ti = [self timeIntervalSinceDate:aDate];
//	return (NSInteger) (ti / D_MINUTE);
//}
//
//- (NSInteger)minutesBeforeDate: (NSDate *) aDate
//{
//	NSTimeInterval ti = [aDate timeIntervalSinceDate:self];
//	return (NSInteger) (ti / D_MINUTE);
//}
//
//- (NSInteger)hoursAfterDate: (NSDate *) aDate
//{
//	NSTimeInterval ti = [self timeIntervalSinceDate:aDate];
//	return (NSInteger) (ti / D_HOUR);
//}
//
//- (NSInteger)hoursBeforeDate: (NSDate *) aDate
//{
//	NSTimeInterval ti = [aDate timeIntervalSinceDate:self];
//	return (NSInteger) (ti / D_HOUR);
//}
//
//- (NSInteger)daysAfterDate: (NSDate *) aDate
//{
//	NSTimeInterval ti = [self timeIntervalSinceDate:aDate];
//	return (NSInteger) (ti / D_DAY);
//}
//
//- (NSInteger)daysBeforeDate: (NSDate *) aDate
//{
//	NSTimeInterval ti = [aDate timeIntervalSinceDate:self];
//	return (NSInteger) (ti / D_DAY);
//}

#pragma mark Decomposing Dates

- (NSInteger)nearestHour
{
	NSDateComponents *components = [[NSCalendar currentCalendar] components:NSHourCalendarUnit fromDate:self];
    NSInteger minute = [components minute];
    NSInteger hour = [components hour];
    
    if (minute >= 30) {
        hour++;
    }
    
	return hour;
}

- (NSInteger)hour
{
	NSDateComponents *components = [[NSCalendar currentCalendar] components:DATE_COMPONENTS fromDate:self];
	return [components hour];
}

- (NSInteger)minute
{
	NSDateComponents *components = [[NSCalendar currentCalendar] components:DATE_COMPONENTS fromDate:self];
	return [components minute];
}

- (NSInteger)seconds
{
	NSDateComponents *components = [[NSCalendar currentCalendar] components:DATE_COMPONENTS fromDate:self];
	return [components second];
}

- (NSInteger)day
{
	NSDateComponents *components = [[NSCalendar currentCalendar] components:DATE_COMPONENTS fromDate:self];
	return [components day];
}

- (NSInteger)month
{
	NSDateComponents *components = [[NSCalendar currentCalendar] components:DATE_COMPONENTS fromDate:self];
	return [components month];
}

- (NSInteger)week
{
	NSDateComponents *components = [[NSCalendar currentCalendar] components:DATE_COMPONENTS fromDate:self];
	return [components week];
}

- (NSInteger)weekday
{
	NSDateComponents *components = [[NSCalendar currentCalendar] components:DATE_COMPONENTS fromDate:self];
	return [components weekday];
}

- (NSInteger)nthWeekday // e.g. 2nd Tuesday of the month is 2
{
	NSDateComponents *components = [[NSCalendar currentCalendar] components:DATE_COMPONENTS fromDate:self];
	return [components weekdayOrdinal];
}

- (NSInteger)year
{
	NSDateComponents *components = [[NSCalendar currentCalendar] components:DATE_COMPONENTS fromDate:self];
	return [components year];
}

@end
