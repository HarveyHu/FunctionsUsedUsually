//
//  CommonFunctions.m
//  FunctionsUsedUsually
//
//  Created by HarveyHu on 2014/3/27.
//  Copyright (c) 2014年 HarveyHu. All rights reserved.
//

#import "CommonFunctions.h"

@implementation CommonFunctions

//四捨五入
+ (NSNumber *)round_off:(NSNumber *)number
{
    int intNumber = round([number doubleValue]);
    NSNumber * result = [[NSNumber alloc] initWithInt:intNumber];
    return result;
}
//無條件進位
+ (NSNumber *)takeCeiling:(NSNumber *)number
{
    int intNumber = floor([number doubleValue]);
    NSNumber * result = [[NSNumber alloc] initWithInt:intNumber];
    return result;
}
//無條件捨去
+ (NSNumber *)chop_off:(NSNumber *)number
{
    int intNumber = ceil([number doubleValue]);
    NSNumber * result = [[NSNumber alloc] initWithInt:intNumber];
    return result;
}

//滿千加逗號
+ (NSString *)formatNumberWithComma:(NSNumber *)number
{
    NSNumberFormatter *numberFormat = [[NSNumberFormatter alloc] init];
    numberFormat.usesGroupingSeparator = YES;
    numberFormat.groupingSeparator  = @",";
    numberFormat.groupingSize = 3;
    return [numberFormat stringFromNumber:[NSNumber numberWithInteger:[number integerValue]]];
}

@end
