#import <Cordova/CDV.h>
#import <AppLink/AppLink.h>

@interface FordAppLink : CDVPlugin

- (void) greet:(CDVInvokedUrlCommand*)command;

@end


//@interface SCTController : UIViewController <FMCProxyListener> {
    FMCSyncProxy* proxy;
    int autoIncCorrID;
    BOOL isLocked;
    BOOL isDD;
//}

//@property (retain, nonatomic) LockScreenViewController *lockScreenViewController;
//@property (retain, nonatomic) MainScreenViewController *mainScreenViewController;

//-(void) lockUserInterface;
//-(void) unlockUserInterface;

//@end