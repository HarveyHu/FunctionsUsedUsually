//
//  CommonFunctions.h
//  FunctionsUsedUsually
//
//  Created by HarveyHu on 2014/3/27.
//  Copyright (c) 2014年 HarveyHu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CommonFunctions : NSObject
//四捨五入
+ (NSNumber *)round_off:(NSNumber *)number;
//無條件進位
+ (NSNumber *)takeCeiling:(NSNumber *)number;
//無條件捨去
+ (NSNumber *)chop_off:(NSNumber *)number;
//滿千加逗號
+ (NSString *)formatNumberWithComma:(NSNumber *)number;
//把ImageView設定成正圓形
-(UIImageView *) transformToCircleShape:(UIImageView *)imageView;

//特價
+(NSAttributedString *)onSaleString;
//照片分享社群
+(void) shareToSocialNetwork:(UIViewController *)myVC withPicture:(NSArray *)images;
//拆Json data
+ (NSDictionary *)parseJSonDataToDictionary:(NSData *)responseData;
@end
