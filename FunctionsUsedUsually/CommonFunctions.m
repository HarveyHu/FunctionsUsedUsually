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
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc]init];
    //設顯示小數點下第二位
    [formatter setMaximumFractionDigits:2];
    //設千分位的逗點
    [formatter setUsesGroupingSeparator:YES];
    [formatter setNumberStyle:NSNumberFormatterDecimalStyle];
        
    double entryFieldFloat = [number doubleValue];
    if ([number.stringValue rangeOfString:@"."].length == 1) {
        formatter.alwaysShowsDecimalSeparator = YES;
        return [formatter stringFromNumber:[NSNumber numberWithDouble:entryFieldFloat]];
    }
    
    formatter.alwaysShowsDecimalSeparator = NO;
    return [formatter stringFromNumber:[NSNumber numberWithDouble:entryFieldFloat]];
}

//把ImageView設定成正圓形
-(UIImageView *) transformToCircleShape:(UIImageView *)imageView{
    UIImageView *myImageView = [imageView copy];
    [myImageView.layer setCornerRadius:myImageView.frame.size.width / 2];
    [myImageView.layer setMasksToBounds:YES];
    return myImageView;
}

//特價
+(NSAttributedString *) onSaleString{
    NSDictionary *merchandiseInfo = @{@"price_on_sale": @20, @"price": @100};
    NSMutableAttributedString * price = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"原價 NT$ %@ 特價 NT$ %@", [merchandiseInfo objectForKey:@"price"],[merchandiseInfo objectForKey:@"price_on_sale"]]];
    NSRange specialRange = [price.string rangeOfString:@" 特價 NT$ "];
    [price addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(specialRange.location ,price.length - specialRange.location)];
    
    [price addAttribute:NSStrikethroughStyleAttributeName value:@2 range:NSMakeRange(0 ,specialRange.location)];
    return price;
}

//照片分享社群
+(void) shareToSocialNetwork:(UIViewController *)myVC withPicture:(NSArray *)images{
    //出現官方分享用的選擇按鈕( Open In ... )
    //1 張圖片會出現 Twitter, Weibo
    //2 張圖片以上，就只會有 Facebook, Flickr
    //都會出現的是 Message, Email
    UIActivityViewController *activityViewController = [[UIActivityViewController alloc] initWithActivityItems:images applicationActivities:nil];
    [myVC presentViewController:activityViewController animated:YES completion:nil];
}

//NSString to NSDate
+(NSDate *) converseToDateByString:(NSString *)dateString dateFormat:(NSString *)dateFormatString{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //[dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    [dateFormatter setDateFormat:dateFormatString];
    NSDate *date = [dateFormatter dateFromString:dateString];
    return date;
}

//製作BackItem on Navigation Bar
+(void)_makeBackItemWithImage:(UIImage *)image
                        frame:(CGRect)frame
                       target:(id)targetObj
                       action:(SEL)targetMethod
               navigationItem:(UINavigationItem *)navigationItem
{
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setFrame:frame];
    [button addTarget:targetObj action:targetMethod forControlEvents:UIControlEventTouchUpInside];
    [button setImage:image forState:UIControlStateNormal];
    //[_button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    //[_button.titleLabel setFont:[UIFont systemFontOfSize:15]];
    //[_button.titleLabel setTitle:@"Edit" forState:UIControlStateNormal];
    
    UIBarButtonItem *barItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    [navigationItem setLeftBarButtonItem:barItem animated:NO];
}

+ (NSDictionary *) parseJSonDataToDictionary:(NSData *)responseData
{
    if( !responseData )
    {
        return nil;
    }
    return (NSDictionary *)[NSJSONSerialization JSONObjectWithData:responseData
                                                           options:0
                                                             error:nil];
}

+ (UIImage *)imageNamedWithoutCache:(NSString *)imageName
{
    return [UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@/%@", [[NSBundle mainBundle] bundlePath], imageName]];
}

//取得App文件資料夾的路徑
// Returns the URL to the application's Documents directory.
+ (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}
@end
