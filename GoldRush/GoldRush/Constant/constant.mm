#import "constant.h"


UIColor * const mainColor = [UIColor colorWithHexString:@"#d43c33"];
UIColor * const defaultBackGroundColor = [UIColor colorWithHexString:@"#eff0f2"];

//NSString * const DomainName = @"https://api.taojin.6789.net/";
//NSString * const DomainName = @"https://api-test.taojin.6789.net/";
NSString * const DomainName = @"https://api-dev.taojin.6789.net/";


NSString * const HD_ProductName = @"恒大银";
NSString * const HD_Contact = @"HGAG";

NSNotificationName const GRJJAccountIsLoginNotification = @"GRJJAccountIsLoginNotification";
NSString * const JJ_ContactXAG = @"XAG1";
NSString * const JJ_ContactCU  = @"CU";
NSString * const JJ_ContactOIL = @"OIL";
NSString * const HD_Domain = @"baibei";
NSString * const JJ_Domain = @"jlmmex";

NSArray  * const ContactS = [NSArray arrayWithObjects:HD_Contact,JJ_ContactCU,JJ_ContactOIL,JJ_ContactXAG, nil];


NSNotificationName const GRAccountIsLoginNotification = @"GRAccountIsLoginNotification";

NSNotificationName const GRPositionHoldOrStopNotification = @"GRPositionHoldOrStopNotification";

NSNotificationName const GRPositionNew_PriceSNotification = @"GRPositionNew_PriceSNotification";

NSNotificationName const GRPositionNew_DataNotification = @"GRPositionNew_DataNotification";

NSNotificationName const GRGet_TodayAndYesterdayNotification = @"GRGet_TodayAndYesterdayNotification";

