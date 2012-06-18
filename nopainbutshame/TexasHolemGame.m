//
//  TexasHolemGame.m
//  nopainbutshame
//
//  Created by Benedikt Beckmann on 22.05.12.
//  Copyright (c) 2012 BB. All rights reserved.
//

#import "TexasHolemGame.h"


@interface TexasHolemGame ()
-(void)singletonSetup;
-(void)initPlayers;

@end

@implementation TexasHolemGame

@synthesize playerList = _playerList;
@synthesize activePlayer = _activePlayer;
@synthesize maxPlayers = _maxPlayers;
@synthesize bigBlind = _bigBlind;
@synthesize totalMoney = _totalMoney;
@synthesize betRoundNr = _betRoundNr;
@synthesize player = _player;


#pragma mark Initialization

/*
 *singleton TexasHoldemGame 
 */

static TexasHolemGame *sharedInstance = nil;
+(TexasHolemGame *) sharedInstance {
    if (!sharedInstance){
        sharedInstance = [[TexasHolemGame alloc] init];
        //setup sharedInstance
        [sharedInstance singletonSetup];
        //init Player
        [sharedInstance initPlayers];

    }
    return sharedInstance;
}

//Setup sharedInstance when game starts. Dummy setup method
-(void) singletonSetup{
    //# of players, replace with player
    NSMutableArray *players = [NSMutableArray arrayWithCapacity:10]; 
                               
    [players addObject:[NSNumber numberWithInt:5]];
    self.playerList = players;
    self.maxPlayers = 5;
    self.bigBlind = 5;
    self.totalMoney = 1000;
}


//init Players
-(void)initPlayers{
    for(NSNumber *myStr in self.playerList) {
        NSLog(myStr);
    }
}
     

#pragma mark Game methods

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
