//
//  GCHelper.h
//  nopainbutshame
//
//  Created by Benedikt Beckmann on 16.06.12.
//  Copyright (c) 2012 BB. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <GameKit/GameKit.h>
#import "TexasHolemGame.h"


/*
 *delegate protocol to manage communication between GCHelper and the TexasHoldemGame class
 */

@protocol GCHelperDelegate
- (void)enterNewGame:(GKTurnBasedMatch *)match;
- (void)layoutMatch:(GKTurnBasedMatch *)match;
- (void)takeTurn:(GKTurnBasedMatch *)match;
- (void)recieveEndGame:(GKTurnBasedMatch *)match;
- (void)sendNotice:(NSString *)notice forMatch:(GKTurnBasedMatch *)match;

@end

/*
 * GcHelper is a Singleton and distinguishes between 
 * a new and existing match, etc. Then passes the match 
 * to TexasHoldemGame class to handle the game logic.
 */
@interface GCHelper : NSObject<GKTurnBasedMatchmakerViewControllerDelegate, GKTurnBasedEventHandlerDelegate>
{
    BOOL gameCenterAvailable;
    BOOL userAuthenticated;
    
    UIViewController *presentingViewController;
    GKTurnBasedMatch *currentMatch;
    
    id <GCHelperDelegate> delegate;
}


@property (nonatomic, retain) id <GCHelperDelegate> delegate;

@property (assign, readonly) BOOL gameCenterAvailable;
@property UIViewController *presentingViewController; 
@property (retain) GKTurnBasedMatch *currentMatch;

+ (GCHelper *)sharedInstance; //class method, das hier macht es zum singleton
- (void)authenticateLocalUser;
- (void)findMatchWithMinPlayers:(int)minPlayers maxPlayers:(int)maxPlayers viewController:(UIViewController *)viewController;


@end
