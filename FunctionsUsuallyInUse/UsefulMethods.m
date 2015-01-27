//
//  CommonFunctions.m
//  FunctionsUsedUsually
//
//  Created by HarveyHu on 2014/3/27.
//  Copyright (c) 2014年 HarveyHu. All rights reserved.
//

#import "UsefulMethods.h"
#import <CommonCrypto/CommonDigest.h>
#import <StoreKit/SKPaymentTransaction.h>

@implementation UsefulMethods

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

//NSString或NSData用MD5加密
//要先#import <CommonCrypto/CommonDigest.h>
+ (NSString*)MD5:(id)inputValue
{
    NSMutableString *output = nil;
    if ([inputValue isKindOfClass:[NSString class]]) {
        NSString *string = inputValue;
        // Create pointer to the string as UTF8
        const char *ptr = [string UTF8String];
        
        // Create byte array of unsigned chars
        unsigned char md5Buffer[CC_MD5_DIGEST_LENGTH];
        
        // Create 16 byte MD5 hash value, store in buffer
        CC_MD5(ptr, strlen(ptr), md5Buffer);
        
        // Convert MD5 value in the buffer to NSString of hex values
        output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
        for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
            [output appendFormat:@"%02x",md5Buffer[i]];
        
    }
    else if ([inputValue isKindOfClass:[NSData class]])
    {
        NSData *data = (NSData *)inputValue;
        // Create byte array of unsigned chars
        unsigned char md5Buffer[CC_MD5_DIGEST_LENGTH];
        
        // Create 16 byte MD5 hash value, store in buffer
        CC_MD5(data.bytes, data.length, md5Buffer);
        
        // Convert unsigned char buffer to NSString of hex values
        NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
        for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
            [output appendFormat:@"%02x",md5Buffer[i]];
    }
    
    return output;
}
//立即發送本地通知
+(void) fireLocalNotificationWithMessage:(NSString *)alertBody userInfo:(NSDictionary *)userInfo
{
    UILocalNotification *localNotification = [UILocalNotification new];
    localNotification.alertBody            = alertBody;
    localNotification.userInfo             = userInfo;
    [[UIApplication sharedApplication] presentLocalNotificationNow:localNotification];
}

//判斷是否有英文字
+(BOOL) isContainingEnglishCharacters:(NSString *)theString{
    NSRegularExpression *regex = [[NSRegularExpression alloc]
                                  initWithPattern:@"[a-zA-Z]" options:0 error:NULL];
    
    // Assuming you have some NSString `myString`.
    NSUInteger matches = [regex numberOfMatchesInString:theString options:0
                                                  range:NSMakeRange(0, [theString length])];
    
    if (matches > 0) {
        // the string contains at least one English letter.
        return YES;
    }
    return NO;
}

//取得iAP的receipt
+(NSData *) getReceiptData:(SKPaymentTransaction *)transaction{
    NSData *receiptData = nil;
    if (floor(NSFoundationVersionNumber) <= NSFoundationVersionNumber_iOS_6_1) {
        receiptData = transaction.transactionReceipt;
    }
    else {
        NSURLRequest *urlRequest = [NSURLRequest requestWithURL:[[NSBundle mainBundle] appStoreReceiptURL]];
        NSError *error = nil;
        receiptData = [NSURLConnection sendSynchronousRequest:urlRequest returningResponse:nil error:&error];
    }
    return receiptData;
}

//解決iOS 7以上版面會跑掉的問題
+(void) setViewControllerTranslucent:(UIViewController *)viewController{
    
    if( [[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0f )
    {
        viewController.edgesForExtendedLayout = UIRectEdgeNone;
        if (viewController.navigationController) {
            viewController.navigationController.navigationBar.translucent = NO;
        }
        if (viewController.tabBarController) {
            viewController.tabBarController.tabBar.translucent = NO;
        }
    }
}

//取得指定文件資料夾的圖片
+(UIImage *) getImageInDocumentFolderWithName:(NSString *)imageName{
    
    NSString *documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    UIImage *image = [UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@/%@", documentPath, imageName]];
    return image;
}

//將圖片存入指定文件資料夾
+(void) saveImageToDocumentFolder:(UIImage *)image imageName:(NSString *)imageName{
    
    NSString *documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    [UIImagePNGRepresentation(image) writeToFile:[documentPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@", imageName]] options:NSAtomicWrite error:nil];
}

//得到按字母排列的CountryNameArray
+(NSArray *) getCountryNameArray {
    
    NSArray *countryNameArray;
    NSArray *countryCodes = [NSLocale ISOCountryCodes];
    NSMutableArray *countryStringArray = [NSMutableArray arrayWithCapacity:[countryCodes count]];
    
    for (NSString *countryCode in countryCodes)
    {
        NSString *identifier = [NSLocale localeIdentifierFromComponents: [NSDictionary dictionaryWithObject: countryCode forKey: NSLocaleCountryCode]];
        NSString *countryName = [[NSLocale currentLocale] displayNameForKey: NSLocaleIdentifier value: identifier];
        [countryStringArray addObject:countryName];
    }
    countryNameArray = [countryStringArray sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
    
    return countryNameArray;
}

//把十六進制的字串轉為NSNumber
+(NSNumber *) unitDigitFromHexString:(NSString *)unitDigit{
    int number = 0;
    if ([unitDigit isEqualToString:@"a"] || [unitDigit isEqualToString:@"A"]) {
        number = 10;
    }
    else if ([unitDigit isEqualToString:@"b"] || [unitDigit isEqualToString:@"B"]) {
        number = 11;
    }
    else if ([unitDigit isEqualToString:@"c"] || [unitDigit isEqualToString:@"C"]) {
        number = 12;
    }
    else if ([unitDigit isEqualToString:@"d"] || [unitDigit isEqualToString:@"D"]) {
        number = 13;
    }
    else if ([unitDigit isEqualToString:@"e"] || [unitDigit isEqualToString:@"E"]) {
        number = 14;
    }
    else if ([unitDigit isEqualToString:@"f"] || [unitDigit isEqualToString:@"F"]) {
        number = 15;
    }
    else if (0 <= [unitDigit intValue] < 10)
    {
        NSNumber *result = [NSNumber numberWithInt:[unitDigit intValue]];
        return result;
    }
    else
    {
        return nil;
    }
    
    NSNumber *result = [NSNumber numberWithInt:number];
    return result;
}

//把十六進位字串逐字轉成NSData
+(NSData *) getDataFromHexadecimalString:(NSString*)hexString{
    NSUInteger len = hexString.length;
    NSString* dataString = [[NSString alloc]initWithString:hexString];
    
    NSMutableData* data = [[NSMutableData alloc]init];
    if (dataString.length % 2 != 0) {
        dataString = [NSString stringWithFormat:@"0%@",dataString];
    }
    //逐字轉成Bytes
    for (int i = 0; i < len; i = i + 2)
    {
        NSRange range = NSMakeRange(i, 1);
        NSString *firstString = [dataString substringWithRange:range];
        range = NSMakeRange(i + 1, 1);
        NSString *secondString = [dataString substringWithRange:range];
        NSNumber* firstDigit = [NSNumber numberWithInt:[[UsefulMethods unitDigitFromHexString:firstString] intValue] * 16];
        NSNumber* secondDigit = [UsefulMethods unitDigitFromHexString:secondString];
        NSNumber* number = [NSNumber numberWithInt:[firstDigit intValue] + [secondDigit intValue]];
        
        unsigned char charNumber = [number charValue];
        [data appendBytes:&charNumber length:1];
        
    }
    return data;
}


//把NSData以byte分割，再以十六進制字串表示
+(NSString *) getHexadecimalStringFromData:(NSData *)data{
    if (data.length == 0) {
        return nil;
    }
    
    NSArray* dataSplitIntoByte = [UsefulMethods splitDataIntoChunks:data bytesPerChunk:1];
    
    NSMutableString* dataString = [[NSMutableString alloc]init];
    for (NSData *piece in dataSplitIntoByte) {
        NSNumber *number = [NSNumber numberWithUnsignedShort:(unsigned char)[piece bytes]];
        //一個byte轉換為二個16進制數字
        NSNumber *digitInTens = @([number integerValue] / 16);
        NSNumber *digitInOnes = @([number integerValue] % 16);
        NSString *pieceString = [NSString stringWithFormat:@"%@%@", [UsefulMethods unitDigitStringFromHex:digitInTens], [UsefulMethods unitDigitStringFromHex:digitInOnes]];
        [dataString appendString:pieceString];
    }
    
    return dataString;
}

//把NSNumber轉為十六進制的字串
+(NSString *) unitDigitStringFromHex:(NSNumber *)HexNumber{
    NSInteger number = [HexNumber integerValue];
    switch (number) {
        case 0:
        case 1:
        case 2:
        case 3:
        case 4:
        case 5:
        case 6:
        case 7:
        case 8:
        case 9:
            return [HexNumber stringValue];
            break;
        case 10:
            return @"A";
            break;
        case 11:
            return @"B";
            break;
        case 12:
            return @"C";
            break;
        case 13:
            return @"D";
            break;
        case 14:
            return @"E";
            break;
        case 15:
            return @"F";
            break;
            
        default:
            return nil;
            break;
    }
}

//把data切成等長度的小data，放到Array中
+ (NSArray*)splitDataIntoChunks:(NSData*)data bytesPerChunk:(NSUInteger)bytesPerChunk{
    
    if(!data) return nil;
    
    NSMutableArray* array = [[NSMutableArray alloc]init];
    NSUInteger dataLength = [data length];
    NSUInteger chunkCount = 0;
    while (chunkCount < dataLength)
    {
        NSRange range = NSMakeRange(chunkCount, bytesPerChunk);
        NSData* chunk = [data subdataWithRange:range];
        [array addObject:chunk];
        chunkCount += 2;
    }
    
    return array;
}

//取得文件資料夾的路徑(另一種寫法)
+(NSString *) documentDirectoryPath{
    NSString * docDirectoryPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    
    return docDirectoryPath;
}

//縮放圖片到指定大小
+(UIImage *)scaleToSize:(UIImage *)image size:(CGSize)size
{
    UIGraphicsBeginImageContext(size);
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return scaledImage;
}

//NSString to NSNumber
+(NSNumber *) stringToNumber:(NSString *)string
{
    //新增一個numberFormatter
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    //將style設定為NSNumberFormatterDecimalStyle
    numberFormatter.numberStyle = NSNumberFormatterDecimalStyle;
    //NSString轉成NSNumber
    NSNumber *number = [numberFormatter numberFromString:string];
    return number;
}
@end
