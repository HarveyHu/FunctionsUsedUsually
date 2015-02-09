FunctionsUsedUsually
====================

This project provides functions(as following) usually in use.
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

//取得指定文件資料夾的圖片
+(UIImage *) getImageInDocumentFolderWithName:(NSString *)imageName;

//將圖片存入指定文件資料夾
+(void) saveImageToDocumentFolder:(UIImage *)image imageName:(NSString *)imageName;

//得到按字母排列的CountryNameArray
+(NSArray *) getCountryNameArray;

//把十六進制的字串轉為NSNumber
+(NSNumber *) unitDigitFromHexString:(NSString *)unitDigit;

//把十六進位字串逐字轉成NSData
+(NSData *) getDataFromHexadecimalString:(NSString*)hexString;

//把NSData以byte分割，再以十六進制字串表示
+(NSString *) getHexadecimalStringFromData:(NSData *)data;

//把NSNumber轉為十六進制的字串
+(NSString *) unitDigitStringFromHex:(NSNumber *)HexNumber;

//把data切成等長度的小data，放到Array中
+(NSArray *) splitDataIntoChunks:(NSData*)data bytesPerChunk:(NSUInteger)bytesPerChunk;

//取得文件資料夾的路徑(另一種寫法)
+(NSString *) documentDirectoryPath;

//縮放圖片到指定大小
+(UIImage *) scaleToSize:(UIImage *)image size:(CGSize)size;

//NSString to NSNumber
+(NSNumber *) stringToNumber:(NSString *)string;

//格式化時間轉文字
+(NSString *) formatedDate:(NSDate *)date dateFormat:(NSString *)dateFormat;