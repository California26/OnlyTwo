#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


#define WS(weakSelf) __weak typeof(self) weakSelf = self;

extern UIColor * const mainColor;
extern UIColor * const defaultBackGroundColor;


extern NSString * const DomainName;

extern NSString * const HD_ProductName;

UIKIT_EXTERN NSNotificationName const GRJJAccountIsLoginNotification;

extern NSString * const HD_Domain;
extern NSString * const JJ_Domain;

extern NSString * const HD_Contact;

extern NSString * const JJ_ContactXAG;
extern NSString * const JJ_ContactCU;
extern NSString * const JJ_ContactOIL;

extern NSArray  * const ContactS;


UIKIT_EXTERN NSNotificationName const GRAccountIsLoginNotification;

UIKIT_EXTERN NSNotificationName const GRPositionHoldOrStopNotification;

UIKIT_EXTERN NSNotificationName const GRPositionNew_PriceSNotification;

UIKIT_EXTERN NSNotificationName const GRPositionNew_DataNotification;
UIKIT_EXTERN NSNotificationName const GRGet_TodayAndYesterdayNotification;

