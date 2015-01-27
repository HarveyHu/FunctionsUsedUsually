//
//  NSData+Format.m
//  FunctionsUsedUsually
//
//  Created by HarveyHu on 2014/4/8.
//  Copyright (c) 2014年 HarveyHu. All rights reserved.
//

#import "NSDate+Format.h"

@implementation NSDate (Format)

- (NSString *)yyyy_MM_dd__HH_mm_apm
{
    NSMutableString *dateString = [NSMutableString new];
    NSDateFormatter *formatter  = [NSDateFormatter new];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    [dateString setString:[formatter stringFromDate:self]];
    
    unsigned unitFlags = NSHourCalendarUnit | NSMinuteCalendarUnit;
    NSDateComponents *comps = [[NSCalendar currentCalendar] components:unitFlags fromDate:self];
    NSInteger hour = [comps hour];
    NSInteger min = [comps minute];
    [dateString appendFormat:@" %02d:%02d%@", hour > 12 ? hour -12 : hour, min, hour < 12 ? @"am" : @"pm"];
    return dateString;
}

- (NSString *)yyyy_MM_dd__HH_mm
{
    NSDateFormatter* formatter = [NSDateFormatter new];
    formatter.dateFormat = @"yyyy-MM-dd HH:mm";
    return [formatter stringFromDate:self];
}

@end
