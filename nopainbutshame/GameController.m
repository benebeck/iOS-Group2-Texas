//
//  GameController.m
//  TH
//
//  Created by Benedikt Beckmann on 20.06.12.
//  Copyright (c) 2012 BB. All rights reserved.
//

#import "GameController.h"

@interface GameController ()
-(void)startNewRound;


@end

@implementation GameController

@synthesize playerList = _playerList;
@synthesize gameStates = _gameStates;
@synthesize activePlayer = _activePlayer;
@synthesize maxPlayers = _maxPlayers;
@synthesize smallBlind = _smallBlind;
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
        
        //hardcoded dummy values
        sharedInstance.maxPlayers = 5;
        sharedInstance.totalMoney = 1000;
        sharedInstance.smallBlind = 5;
        sharedInstance.bigBlind = 10;
        sharedInstance.betRoundNr = 1;
        NSLog(@"GameControl is up...");
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
    //Start the game
    [self startNewRound];
    
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





#pragma mark Game Logic

-(void)startNewRound{
    if (self.betRoundNr == 1) {
        //activate first player
        [self activateNextPlayer];
        //send him the DELAER status
        [self changeBetState:@"DEALER" forPlayer:[self.playerList objectAtIndex:0]]; //das ist ne ziemlich miese Lösung, einfach den ersten aus der Liste zu nehmen....
        
        
        //send SMALL_BLIND to the next
        [self changeBetState:@"SMALL_BLIND" forPlayer:[self.playerList objectAtIndex:1]];
        
        
        //send BIG_BLIND to the next
        [self changeBetState:@"BIG_BLIND" forPlayer:[self.playerList objectAtIndex:2]];
        
        [self endOfTurn];
        
    }else {
        NSLog(@"Could not start new round with the first player!");
    }
    
    
    
}

//Diese Methode wird immer ausgeführt, wenn ein Spieler mit seinem Zug fertig ist. Hier muss ziemlich viel Entscheidung rein!!!
-(void)endOfTurn{
    Player *oldPlayer = self.activePlayer;
    //first round
    if (self.betRoundNr == 1) {
        NSLog(@"We are in round %d", self.betRoundNr);
        //Wir sind in der ersten Wettrunde
        if (oldPlayer.betState == @"DEALER") {
            //Macht der Dealer eigentlich irgendwas???
            
            NSLog(@"This was the DEALER'S turn");
        }else if (oldPlayer.betState == @"SMALL_BLIND") {
            //get money (SMALL_BLIND)
            [self substractFromPlayerAccount:self.smallBlind forPlayer:oldPlayer];
            NSLog(@"Player paid %d", self.smallBlind);
            NSLog(@"and has left %d", oldPlayer.moneyRest);
            
            //get cards
            //[self twoCardsForPlayer:oldPlayer]; //CRASH in PackOfCards!!!
            
            
            
            [self changeBetState:nil forPlayer:oldPlayer];
            NSLog(@"This was the SMALL_BLIND'S turn");
            
        }else if (oldPlayer.betState == @"BIG_BLIND") {
            //get money (BIG_BLIND)
            [self substractFromPlayerAccount:self.bigBlind forPlayer:oldPlayer];
            NSLog(@"Player paid %d", self.bigBlind);
            NSLog(@"and has left %d", oldPlayer.moneyRest);
            
            NSLog(@"This was the BIG_BLIND'S turn");
        }
        
    }if (self.betRoundNr == 2){
        //bäm
    }if (self.betRoundNr == 3){
        //bäm
    }
    
    [self activateNextPlayer];
    
    
}




#pragma mark PlayerDelegate

-(void)changePlayerState:(NSString *)state forPlayer:(Player *)player{
    Player *pl;
    //set all players INACTIVE again
    for (id element in self.playerList) {
        pl = element;
        pl.playerState = @"INACTIVE";
    }
    
    player.playerState=state;
    
   
    NSLog(@"to %@", state);
    
    /*  @Xi, sollten wier hier nicht den Player einsetzen anstelle des int?
     
     Also so: 
     
     PackOfCards.h
     
     -(void)distributeCard:(Player *) player
     
     
     
     
     */
    
}



@end








