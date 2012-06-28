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
@synthesize pot;
@synthesize wetthohe;

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
    [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(activateNextPlayer) userInfo:nil repeats:YES];
 
    NSMutableArray *list = [NSMutableArray arrayWithCapacity:5];
    
    //foreach-Schleife : hier müssten die mitspieler rein
    Player *player1 = [[Player alloc] init];
    player1.moneyRest=sharedInstance.totalMoney/sharedInstance.maxPlayers;
    player1.playerId = @"Player1";
    [list addObject:player1];
    Player *player2 = [[Player alloc] init];
    player2.playerId = @"Player2";
    player2.moneyRest=sharedInstance.totalMoney/sharedInstance.maxPlayers;
    [list addObject:player2];
    Player *player3 = [[Player alloc] init];
    player3.playerId = @"Player3";
    player3.moneyRest=sharedInstance.totalMoney/sharedInstance.maxPlayers;
    [list addObject:player3];
    Player *player4 = [[Player alloc] init];
    player4.playerId = @"Player4";
    player4.moneyRest=sharedInstance.totalMoney/sharedInstance.maxPlayers;
    [list addObject:player4];
    Player *player5 = [[Player alloc] init];
    player5.playerId = @"Player5";
    player5.moneyRest=sharedInstance.totalMoney/sharedInstance.maxPlayers;
    [list addObject:player5];
    
    
    self.playerList = list;
    
    for (id element in self.playerList) {
   
     player1.playerState=@"ACTIVE";
        NSLog(@"aaaaaaaaaa%@",player1.playerState);
      
       
        [self changePlayerState:@"INACTIVE" forPlayer:element];
        NSLog(@"Player: %@", [element playerId]);
    }
}


#pragma mark Game methods
    //hier muss der current player aus GC mitverwurstelt werden




    -(void)activateNextPlayer{
    
           
            Player *player;
            for (player in self.playerList)
                if (self.activePlayer == [player playerId]) {
                    
                    NSInteger index = [self.playerList indexOfObjectIdenticalTo:player];
                    if ([[self.playerList objectAtIndex:index] playerState]==@"RAISE") {
                  [sharedInstance changePlayerState:@"CALL" forPlayer:[sharedInstance.playerList objectAtIndex:index]];
                        self.wetthohe+=50;
                    }
                }

        //first player to start
        if (!self.activePlayer) {
            self.activePlayer = [[self.playerList objectAtIndex:0] playerId];
            //ACTIVATE PLAYERS !!!!!!!!!....
            if ([[self.playerList objectAtIndex:0] playerState]==@"CALL") {
                [[self.playerList objectAtIndex:0] setMoneyRest:[[self.playerList objectAtIndex:0] moneyRest]-50];
                if(self.wetthohe<=0 || self.wetthohe>100000)
                {
                    [self setPot:50];
                    [self setWetthohe:0];
                }
                else {
                    [self setPot:pot+wetthohe];
                }
                [[self.playerList objectAtIndex:0] setPlayerState:@"INACTIVE"];
                
            }   
            //jump back to first player
        }else if ([[self.playerList lastObject] playerId]  == self.activePlayer) {
            if ([[self.playerList lastObject] playerState]==@"CALL") {
        [[self.playerList lastObject] setMoneyRest:[[self.playerList lastObject] moneyRest]-50];
                if(self.pot<=0 || self.pot>100000)
                {
                    [self setPot:50];
                    [self setWetthohe:0];
                }
                else {
                    [self setPot:pot+wetthohe];
                }
                [[self.playerList lastObject] setPlayerState:@"INACTIVE"];
                NSLog(@"dfdfdf%i",_totalMoney);
                
            }
            self.activePlayer = [[self.playerList objectAtIndex:0] playerId];
            
            //next player    
        }else {
            NSLog(@"old active player: %@", self.activePlayer);
            Player *player;
            for (player in self.playerList)
                if (self.activePlayer == [player playerId]) {
                    
                    NSInteger index = [self.playerList indexOfObjectIdenticalTo:player];
                    if ([[self.playerList objectAtIndex:index] playerState]==@"CALL") {
                        [[self.playerList objectAtIndex:index] setMoneyRest:[[self.playerList objectAtIndex:index] moneyRest]-50];
                        if(self.pot<=0 || self.pot>100000)
                        {
                            [self setPot:50];
                            [self setWetthohe:0];
                        }
                        else {
                            [self setPot:pot+wetthohe];
                        }
                        [[self.playerList objectAtIndex:index] setPlayerState:@"INACTIVE"];
                        
                    }

                    index++;
                    self.activePlayer = [[self.playerList objectAtIndex:index] playerId];
                    break;
                }
        }
        NSLog(@"New Player: %@", self.activePlayer);
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

-(void)changePlayerState:(NSString *)state forPlayer:(Player *)player{
    
    player.playerState=state;
    
   
    NSLog(@"to %@", state);
    
}







@end
