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
@end
