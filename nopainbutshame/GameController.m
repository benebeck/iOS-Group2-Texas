//
//  GameController.m
//  nopainbutshame
//
//  Created by Benedikt Beckmann on 20.06.12.
//  Copyright (c) 2012 BB. All rights reserved.
//

#import "GameController.h"

@interface GameController ()



@end

@implementation GameController

@synthesize playerList = _playerList;
@synthesize gameStates = _gameStates;
@synthesize activePlayer = _activePlayer;
@synthesize maxPlayers = _maxPlayers;
@synthesize bigBlind = _bigBlind;
@synthesize totalMoney = _totalMoney;
@synthesize betRoundNr = _betRoundNr;
@synthesize player = _player;


#pragma mark Initialization

/*
 *singleton GameController 
 */

static GameController *sharedInstance = nil;
+(GameController *) sharedInstance {
    if (!sharedInstance){
        sharedInstance = [[GameController alloc] init];
    }
    //hardcoded dummy values
    sharedInstance.maxPlayers = 5;
    sharedInstance.totalMoney = 1000;
    NSLog(@"GameControl is up...");
    return sharedInstance;
}




//method to instantiate the players after GameControl has been started
-(void)raisePlayers{
    
    //dummy list
    NSMutableArray *list = [NSMutableArray arrayWithCapacity:5];
    
    //foreach-Schleife : hier müssten die mitspieler rein
    Player *player1 = [[Player alloc] init];
    player1.playerId = @"Player1";
    [list addObject:player1];
    Player *player2 = [[Player alloc] init];
    player2.playerId = @"Player2";
    [list addObject:player2];
    Player *player3 = [[Player alloc] init];
    player3.playerId = @"Player3";
    [list addObject:player3];
    Player *player4 = [[Player alloc] init];
    player4.playerId = @"Player4";
    [list addObject:player4];
    Player *player5 = [[Player alloc] init];
    player5.playerId = @"Player5";
    [list addObject:player5];
    
    
    self.playerList = list;
    
    for (id element in self.playerList) {
        [self changePlayerState:@"INACTIVE" forPlayer:element];
        //NSLog(@"Player: %@", [element playerId]);
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





#pragma mark PlayerDelegate

-(void)changePlayerState:(NSString *)state forPlayer:(NSObject *)player{
    Player *pl = player;
    NSLog(@"Changed State of %@", [pl playerId]);
    NSLog(@"to %@", state);
    
}







@end
