//
//  GCHelper.m
//  nopainbutshame
//
//  Created by Benedikt Beckmann on 16.06.12.
//  Copyright (c) 2012 BB. All rights reserved.
//

#import "GCHelper.h"

@implementation GCHelper

@synthesize delegate = _delegate;

/*
 * The complete GameCenter part is from Ray Wenderlichs tutorial. Thanks!
 */

@synthesize gameCenterAvailable = _gameCenterAvailable;
@synthesize currentMatch = _currentMatch;


#pragma mark Initialization

/*
 *singleton GCHelper 
 */

static GCHelper *sharedHelper = nil;
+(GCHelper *) sharedInstance {
    if (!sharedHelper){
        sharedHelper = [[GCHelper alloc] init];
    }
    return sharedHelper;
}

- (BOOL)isGameCenterAvailable
{
    // check for presence of GKLocalPlayer API
    Class gcClass = (NSClassFromString(@"GKLocalPlayer"));
    
    // check if the device is running iOS 4.1 or later
    NSString *reqSysVer = @"4.1";
    NSString *currSysVer = [[UIDevice currentDevice] systemVersion];
    BOOL osVersionSupported = ([currSysVer compare:reqSysVer options:NSNumericSearch] != NSOrderedAscending);
    return (gcClass && osVersionSupported);
}

- (id)init
{
    if ((self = [super init])) {
        gameCenterAvailable = [self isGameCenterAvailable];
        if (gameCenterAvailable) {
            NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
            [nc addObserver:self 
                   selector:@selector(authenticationChanged) 
                       name:GKPlayerAuthenticationDidChangeNotificationName 
                     object:nil];
        }
    }
    return self;
}


- (void)authenticationChanged
{    
    if ([GKLocalPlayer localPlayer].isAuthenticated && !userAuthenticated) {
        NSLog(@"Authentication changed: player authenticated.");
        userAuthenticated = TRUE;           
    } else if (![GKLocalPlayer localPlayer].isAuthenticated && userAuthenticated) {
        NSLog(@"Authentication changed: player not authenticated");
        userAuthenticated = FALSE;
    }
    
}


#pragma mark User functions

- (void)authenticationChanged
{    
    if ([GKLocalPlayer localPlayer].isAuthenticated && !userAuthenticated) {
        NSLog(@"Authentication changed: player authenticated.");
        userAuthenticated = TRUE;           
    } else if (![GKLocalPlayer localPlayer].isAuthenticated && userAuthenticated) {
        NSLog(@"Authentication changed: player not authenticated");
        userAuthenticated = FALSE;
    }
    
}


- (void)authenticateLocalUser
{ 
    if (!gameCenterAvailable) return;
    
    void (^setGKEventHandlerDelegate)(NSError *) = ^ (NSError *error)
    {
        GKTurnBasedEventHandler *ev = [GKTurnBasedEventHandler sharedTurnBasedEventHandler];
        ev.delegate = (id)self;
    };
    
    NSLog(@"Authenticating local user...");
    if ([GKLocalPlayer localPlayer].authenticated == NO) {     
        [[GKLocalPlayer localPlayer] authenticateWithCompletionHandler: setGKEventHandlerDelegate];        
    } else {
        NSLog(@"Already authenticated!");
        setGKEventHandlerDelegate(nil);
    }
}




@end






