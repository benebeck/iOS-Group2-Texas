//
//  Player.m
//  nopainbutshame
//
//  Created by Benedikt Beckmann on 22.05.12.
//  Copyright (c) 2012 BB. All rights reserved.
//

#import "Player.h"

@implementation Player

@synthesize playerName = _playerName;
@synthesize playerId = _playerId;
@synthesize moneyRest = _moneyRest;
//@synthesize avatar
@synthesize playerState = _playerState;
@synthesize betState = _betState;
@synthesize playerRound = _playerRound;
@synthesize openCards = _openCards;
@synthesize twoCards = _twoCards;

@synthesize delegate = _delegate;

-(void)setState{
    
}


-(NSArray *)getStates{
    return 0;
}

-(void)removeMoney:(int)amount{
    
}

-(void)getMoneyFromPot:(int)amount{
    
}

-(void)chooseBet:(int)amount{
    
}


@end
