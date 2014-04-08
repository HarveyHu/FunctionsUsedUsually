//
//  NSData+Format.h
//  FunctionsUsedUsually
//
//  Created by HarveyHu on 2014/4/8.
//  Copyright (c) 2014年 HarveyHu. All rights reserved.
//

#import <Foundation/Foundation.h>

/*
 *  @import 之後，可以在NSDate直接取用這個方法
 */
@interface NSDate (Format)

- (NSString *)yyyy_MM_dd__HH_mm_apm;
- (NSString *)yyyy_MM_dd__HH_mm;

@end
