//
//  CommonFunctions.h
//  FunctionsUsedUsually
//
//  Created by HarveyHu on 2014/3/27.
//  Copyright (c) 2014年 HarveyHu. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SKPaymentTransaction;
@interface UsefulMethods : NSObject
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
//不cache memory每次都載圖
+ (UIImage *)imageNamedWithoutCache:(NSString *)imageName;
//取得App文件資料夾的路徑
+ (NSURL *)applicationDocumentsDirectory;

//NSString或NSData用MD5加密
+ (NSString*)MD5:(id)inputValue;

//立即發送本地通知
+(void) fireLocalNotificationWithMessage:(NSString *)alertBody userInfo:(NSDictionary *)userInfo;

//判斷是否有英文字
+(BOOL) isContainingEnglishCharacters:(NSString *)theString;

//取得iAP的receipt
+(NSData *) getReceiptData:(SKPaymentTransaction *)transaction;

//解決iOS 7以上版面會跑掉的問題
+(void) setViewControllerTranslucent:(UIViewController *)viewController;
@end
