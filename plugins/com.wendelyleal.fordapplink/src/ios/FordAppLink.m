#import "FordAppLink.h"

// These should be replaced with a vaild AppName and AppID
#define PLACEHOLDER_APPNAME @"CarCast"
#define PLACEHOLDER_APPID @"1034050817"

// IDs used in the settings bundle
#define PREFS_FIRST_RUN @"firstRun"
// #define PREFS_PROTOCOL @"iap"
#define PREFS_PROTOCOL @"tcps"
#define PREFS_IPADDRESS @"127.0.0.1"
#define PREFS_PORT @"12345"

@implementation FordAppLink

- (void)greet:(CDVInvokedUrlCommand*)command
{
    
    NSString* callbackId = [command callbackId];
    NSString* name = [[command arguments] objectAtIndex:0];
    NSString* msg = [NSString stringWithFormat: @"FordAppLink, %@", name];
    
    CDVPluginResult* result = [CDVPluginResult
                               resultWithStatus:CDVCommandStatus_OK
                               messageAsString:msg];
    
    [self success:result callbackId:callbackId];
}



#pragma mark Settings Bundle Defaults

-(void) savePreferences {
    
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    
    //Set to match settings.bundle defaults
    // if (![[prefs objectForKey:PREFS_FIRST_RUN] isEqualToString:@"False"]) {
    [prefs setObject:@"False" forKey:PREFS_FIRST_RUN];
    [prefs setObject:@"tcps" forK
                  ey:PREFS_PROTOCOL];
//    [prefs setObject:@"iap" forKey:PREFS_PROTOCOL];
    [prefs setObject:@"127.0.0.1" forKey:PREFS_IPADDRESS];
    [prefs setObject:@"12345" forKey:PREFS_PORT];
    // }
    [prefs synchronize];
}

#pragma mark AppLink Proxy

-(void) setupProxy:(CDVInvokedUrlCommand*)command {
    [FMCDebugTool logInfo:@"setupProxy"];
    
    [self savePreferences];
    
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    if ([[prefs objectForKey:PREFS_PROTOCOL] isEqualToString:@"tcpl"]) {
        [FMCDebugTool logInfo:@"setupProxy: tcpl"];
        proxy = [[FMCSyncProxyFactory buildSyncProxyWithListener: self
                                                    tcpIPAddress: nil
                                                         tcpPort: [prefs objectForKey:PREFS_PORT]] retain];
    } else if ([[prefs objectForKey:PREFS_PROTOCOL] isEqualToString:@"tcps"]) {
        [FMCDebugTool logInfo:@"setupProxy: tcps, ip:"];
        [FMCDebugTool logInfo:[prefs objectForKey:PREFS_IPADDRESS]];
        proxy = [[FMCSyncProxyFactory buildSyncProxyWithListener: self
                                                    tcpIPAddress: [prefs objectForKey:PREFS_IPADDRESS]
                                                         tcpPort: [prefs objectForKey:PREFS_PORT]] retain];
    } else {
        [FMCDebugTool logInfo:@"setupProxy: else"];
        
        proxy = [[FMCSyncProxyFactory buildSyncProxyWithListener: self] retain];
    }
    
    autoIncCorrID = 101;
}

-(void) teardownProxy {
    [FMCDebugTool logInfo:@"teardownProxy"];
    [proxy dispose];
    [proxy release];
    proxy = nil;
}


#pragma mark AppLink Callbacks

-(void) onProxyOpened {
    [FMCDebugTool logInfo:@"onProxyOpened"];
    FMCRegisterAppInterface* raiRequest = [FMCRPCRequestFactory buildRegisterAppInterfaceWithAppName:PLACEHOLDER_APPNAME languageDesired:[FMCLanguage EN_US] appID:PLACEHOLDER_APPID];
    raiRequest.isMediaApplication = [NSNumber numberWithBool:YES];
    raiRequest.ngnMediaScreenAppName = nil;
    raiRequest.vrSynonyms = nil;
    
    //Build ttsName Array
    NSMutableArray *ttsName = [NSMutableArray arrayWithObject:[FMCTTSChunkFactory buildTTSChunkForString:@"HelloAppLink" type:FMCSpeechCapabilities.TEXT]];
    raiRequest.ttsName = ttsName;
    
    [proxy sendRPCRequest:raiRequest];
}

-(void) onProxyClosed {
    [FMCDebugTool logInfo:@"onProxyClosed"];
    [self unlockUserInterface];
    [self teardownProxy];
    [self setupProxy];
}

-(void) onOnHMIStatus:(FMCOnHMIStatus*) notification {
    if (notification.hmiLevel == FMCHMILevel.HMI_NONE ) {
        
        [FMCDebugTool logInfo:@"HMI_NONE"];
        [self unlockUserInterface];
        
    } else if (notification.hmiLevel == FMCHMILevel.HMI_FULL ) {
        
        [FMCDebugTool logInfo:@"HMI_FULL"];
        [self lockUserInterface];
        
        FMCShow* showRequest = [FMCRPCRequestFactory buildShowWithMainField1:@"Let's listen to" mainField2:@"something cool!" alignment:[FMCTextAlignment CENTERED] correlationID:[NSNumber numberWithInt:autoIncCorrID++]];
        [proxy sendRPCRequest:showRequest];
        
    } else if (notification.hmiLevel == FMCHMILevel.HMI_BACKGROUND ) {
        
        [FMCDebugTool logInfo:@"HMI_BACKGROUND"];
        
    } else if (notification.hmiLevel == FMCHMILevel.HMI_LIMITED ) {
        
        [FMCDebugTool logInfo:@"HMI_LIMTED"];
    }
}

-(void) onOnDriverDistraction:(FMCOnDriverDistraction*)notification {
    if (notification.state == FMCDriverDistractionState.DD_OFF ) {
        
        [FMCDebugTool logInfo:@"DD Off"];
        isDD = NO;
        [self unlockUserInterface];
        
    } else if (notification.state == FMCDriverDistractionState.DD_ON ) {
        
        [FMCDebugTool logInfo:@"DD On"];
        isDD = YES;
        [self lockUserInterface];
    }
}


#pragma mark Lock Screen Methods

-(void) lockUserInterface {
    [FMCDebugTool logInfo:@"lockUserInterface"];
    //    if (!isLocked) {
    //        [UIView beginAnimations:@"View Flip" context:nil];
    //        [UIView setAnimationDuration:1.25];
    //        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    //
    //        if (self.lockScreenViewController == nil)
    //        {
    //            LockScreenViewController *lockScreenController = [[LockScreenViewController alloc] initWithNibName:@"LockScreenViewController" bundle:nil];
    //            self.lockScreenViewController = lockScreenController;
    //            [lockScreenController release];
    //        }
    //        [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:self.view cache:YES];
    //
    //        [mainScreenViewController viewWillAppear:YES];
    //        [lockScreenViewController viewWillDisappear:YES];
    //
    //        [mainScreenViewController.view removeFromSuperview];
    //        [self.view insertSubview:lockScreenViewController.view atIndex:0];
    //
    //        [lockScreenViewController viewDidDisappear:YES];
    //        [mainScreenViewController viewDidAppear:YES];
    //        [UIView commitAnimations];
    //    }
    isLocked = YES;
}

-(void) unlockUserInterface {
    [FMCDebugTool logInfo:@"unlockUserInterface"];
    //    if (isLocked) {
    //        [UIView beginAnimations:@"View Flip" context:nil];
    //        [UIView setAnimationDuration:1.25];
    //        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    //
    //        if (self.mainScreenViewController == nil)
    //        {
    //            MainScreenViewController *mainScreenController = [[MainScreenViewController alloc] initWithNibName:@"MainScreenViewController" bundle:nil];
    //            self.mainScreenViewController = mainScreenController;
    //            [mainScreenController release];
    //        }
    //
    //        [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:self.view cache:YES];
    //
    //        [lockScreenViewController viewWillAppear:YES];
    //        [mainScreenViewController viewWillDisappear:YES];
    //
    //        [lockScreenViewController.view removeFromSuperview];
    //        [self.view insertSubview:mainScreenViewController.view atIndex:0];
    //
    //        [mainScreenViewController viewDidDisappear:YES];
    //        [lockScreenViewController viewDidAppear:YES];
    //        [UIView commitAnimations];
    //    }
    isLocked = NO;
}

@end