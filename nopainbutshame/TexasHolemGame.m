//
//  TexasHolemGame.m
//  nopainbutshame
//
//  Created by Benedikt Beckmann on 22.05.12.
//  Copyright (c) 2012 BB. All rights reserved.
//

#import "TexasHolemGame.h"

@implementation TexasHolemGame

@synthesize players = _players;
@synthesize activePlayer = _activePlayer;
@synthesize maxPlayers = _maxPlayers;
@synthesize bigBlind = _bigBlind;
@synthesize totalMoney = _totalMoney;
@synthesize betRoundNr = _betRoundNr;


#pragma mark Initialization

/*
 *singleton TexasHoldemGame 
 */

static TexasHolemGame *sharedInstance = nil;
+(TexasHolemGame *) sharedInstance {
    if (!sharedInstance){
        sharedInstance = [[TexasHolemGame alloc] init];
    }
    return sharedInstance;
}


-(void)activateNextPlayer{
    
}

-(int)getRoundNr{
    return 0;
}

-(void)setRoundNr{
    
}

-(BOOL)isShowDownTime{
    
    return NO;
}

@end
