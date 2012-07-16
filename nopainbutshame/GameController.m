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
@synthesize dealer = _dealer;
@synthesize pot;
@synthesize wetthohe;
int endofturntemp=5;
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
       // NSLog(@"GameControl is up...");
    }
    //hardcoded dummy values
    
    sharedInstance.maxPlayers = 5;
    sharedInstance.totalMoney = 1000;
   // NSLog(@"GameControl is up...");
    
    return sharedInstance;
        
    
}




//method to instantiate the players after GameControl has been started
-(void)raisePlayers{
    self.betRoundNr=1;
    //dummy list
 
 
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
                if (self.activePlayer == player) {
                    
                    NSInteger index = [self.playerList indexOfObjectIdenticalTo:player];
                    if ([[self.playerList objectAtIndex:index] playerState]==@"RAISE") {
                  [sharedInstance changePlayerState:@"CALL" forPlayer:[sharedInstance.playerList objectAtIndex:index]];
                        self.wetthohe+=50;
                    }
                }

        //first player to start
        if (!self.activePlayer) {
            
            self.activePlayer = [self.playerList objectAtIndex:0];
            [self startNewRound];
            //ACTIVATE PLAYERS !!!!!!!!!....
            if ([[self.playerList objectAtIndex:0] playerState]==@"CALL") {
                [[self.playerList objectAtIndex:0] setMoneyRest:[[self.playerList objectAtIndex:0] moneyRest]-50];
                if(self.wetthohe<=0 || self.wetthohe>100000)
                {
                    [self setPot:50];
                    [self setWetthohe:0];
                }
                else {
                    [self setPot:pot+50];
                }
           if([[self.playerList objectAtIndex:0] playerState]!=@"FOLD") [[self.playerList objectAtIndex:0] setPlayerState:@"INACTIVE"];
                  [self endOfTurntemp];
            }   
            //jump back to first player
        }else if ([self.playerList lastObject] == self.activePlayer) {
            if ([[self.playerList lastObject] playerState]==@"CALL") {
        [[self.playerList lastObject] setMoneyRest:[[self.playerList lastObject] moneyRest]-50];
                if(self.pot<=0 || self.pot>100000)
                {
                    [self setPot:50];
                    [self setWetthohe:0];
                }
                else {
                    [self setPot:pot+50];
                }
             if([[self.playerList lastObject] playerState]!=@"FOLD")[[self.playerList lastObject] setPlayerState:@"INACTIVE"];
                NSLog(@"dfdfdf%i",_totalMoney);
                [self endOfTurntemp];
                
            }
            self.activePlayer = [self.playerList objectAtIndex:0];
            
            //next player    
        }else {
            NSLog(@"old active player: %@", self.activePlayer.playerId);
            Player *player;
            for (player in self.playerList)
                if (self.activePlayer == player) {
                    
                    NSInteger index = [self.playerList indexOfObjectIdenticalTo:player];
                    if ([[self.playerList objectAtIndex:index] playerState]==@"CALL") {
                        [[self.playerList objectAtIndex:index] setMoneyRest:[[self.playerList objectAtIndex:index] moneyRest]-50];
                        if(self.pot<=0 || self.pot>100000)
                        {
                            [self setPot:50];
                            
                            [self setWetthohe:0];
                        }
                        else {
                            [self setPot:pot+50];
                        }
                         if([[self.playerList objectAtIndex:index] playerState]!=@"FOLD")[[self.playerList objectAtIndex:index] setPlayerState:@"INACTIVE"];
                        
                    }

                    index++;
                    self.activePlayer = [self.playerList objectAtIndex:index];
                    break;
                }
             [self endOfTurntemp];
        }
        NSLog(@"New Player: %@", self.activePlayer.playerId);
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


        //send him the DELAER status
        [self changeBetState:@"DEALER" forPlayer:[self.playerList objectAtIndex:0]]; //das ist ne ziemlich miese Lösung, einfach den ersten aus der Liste zu nehmen....
    self.activePlayer=[self.playerList objectAtIndex:0];
        
        
        //send SMALL_BLIND to the next
        [self changeBetState:@"SMALL_BLIND" forPlayer:[self.playerList objectAtIndex:1]];
        
        
        //send BIG_BLIND to the next
        [self changeBetState:@"BIG_BLIND" forPlayer:[self.playerList objectAtIndex:2]];
        
        [self endOfTurn];
    

    
}

-(void) endOfTurntemp{
    

    if (endofturntemp==0) {
        endofturntemp=5;
        NSLog(@"%i",endofturntemp);
        NSLog(@"%i",self.betRoundNr);
        
        if (self.betRoundNr == 2){
           
            [[PackOfCards sharedInstance] distributeCard:1];
            [[PackOfCards sharedInstance] distributeCard:1];
            [[PackOfCards sharedInstance] distributeCard:1];
              
        }if (self.betRoundNr == 3){
          
            [[PackOfCards sharedInstance] distributeCard:1];
        }if (self.betRoundNr == 4){
        
            [[PackOfCards sharedInstance] distributeCard:1];
        }
        if (self.betRoundNr == 5){
 

            
            
            int spieler1karten[7][2];
            int spieler2karten[7][2];
            int spieler3karten[7][2];
            int spieler4karten[7][2];
            int spieler5karten[7][2];
            

            
            
            int temp11=0;
            int temp12=0;
            int temp13=0;
            int temp14=0;
            int temp15=0;
            
            for (int temp1=0; temp1<52; temp1++) {
                
                if([[PackOfCards sharedInstance] whogotthecard:temp1]==2 || [[PackOfCards sharedInstance] whogotthecard:temp1]==1){
                    int temprest=1+temp1%13;
                    int tempganz=1+temp1/13;
                    spieler1karten[temp11][0]=tempganz;
                    spieler1karten[temp11][1]=temprest;
                    temp11++;
                }
                
                if([[PackOfCards sharedInstance] whogotthecard:temp1]==3 || [[PackOfCards sharedInstance] whogotthecard:temp1]==1){
                    int temprest=1+temp1%13;
                    int tempganz=1+temp1/13;
                    spieler2karten[temp12][0]=tempganz;
                    spieler2karten[temp12][1]=temprest;
                    temp12++;
                }
                
                if([[PackOfCards sharedInstance] whogotthecard:temp1]==4 || [[PackOfCards sharedInstance] whogotthecard:temp1]==1){
                    int temprest=1+temp1%13;
                    int tempganz=1+temp1/13;
                    spieler3karten[temp13][0]=tempganz;
                    spieler3karten[temp13][1]=temprest;
                    temp13++;
                }
                
                if([[PackOfCards sharedInstance] whogotthecard:temp1]==5 || [[PackOfCards sharedInstance] whogotthecard:temp1]==1){
                    int temprest=1+temp1%13;
                    int tempganz=1+temp1/13;
                    spieler4karten[temp14][0]=tempganz;
                    spieler4karten[temp14][1]=temprest;
                    temp14++;
                }
                
                if([[PackOfCards sharedInstance] whogotthecard:temp1]==6 || [[PackOfCards sharedInstance] whogotthecard:temp1]==1){
                    int temprest=1+temp1%13;
                    int tempganz=1+temp1/13;
                    spieler5karten[temp15][0]=tempganz;
                    spieler5karten[temp15][1]=temprest;
                    temp15++;
                }
                
            }
            
            if([[self. playerList objectAtIndex:0] playerState]==@"Fold")
            {
                for (int j=0; j<7; j++) {
                    spieler1karten[j][0]=1;
                    spieler1karten[j][1]=(j+1)*2;
                }
            }
            
            if([[self. playerList objectAtIndex:1] playerState]==@"Fold")
            {
                for (int j=0; j<7; j++) {
                    spieler1karten[j][0]=1;
                    spieler1karten[j][1]=((j+1)*2)+1;
                }
            }
            
            if([[self. playerList objectAtIndex:2] playerState]==@"Fold")
            {
                for (int j=0; j<7; j++) {
                    spieler1karten[j][0]=1;
                    spieler1karten[j][1]=(j+9)*2;
                }
            }
            
            if([[self. playerList objectAtIndex:3] playerState]==@"Fold")
            {
                for (int j=0; j<7; j++) {
                    spieler1karten[j][0]=1;
                    spieler1karten[j][1]=((j+9)*2)+1;
                }
            }
            
            if([[self. playerList objectAtIndex:4] playerState]==@"Fold")
            {
                for (int j=0; j<7; j++) {
                    spieler1karten[j][0]=1;
                    spieler1karten[j][1]=(j+17)*2;
                }
            }
            
            
            
            
            NSMutableArray *comparelist = [NSMutableArray arrayWithCapacity:5];
            
            NSDictionary *spieler1=[[PackOfCards sharedInstance] bestFiveCardsCombination:spieler1karten];
            [comparelist addObject:spieler1];
            NSDictionary *spieler2=[[PackOfCards sharedInstance] bestFiveCardsCombination:spieler2karten];
            [comparelist addObject:spieler2];
            NSDictionary *spieler3=[[PackOfCards sharedInstance] bestFiveCardsCombination:spieler3karten];
            [comparelist addObject:spieler3];
            NSDictionary *spieler4=[[PackOfCards sharedInstance] bestFiveCardsCombination:spieler4karten];
            [comparelist addObject:spieler4];
            NSDictionary *spieler5=[[PackOfCards sharedInstance] bestFiveCardsCombination:spieler5karten];
            [comparelist addObject:spieler5];
            
            for (id key in [comparelist objectAtIndex:0]) {
                NSLog(@"key: %@, value: %@", key, [[comparelist objectAtIndex:0] objectForKey:key]);
            }

            
            for (id key in [comparelist objectAtIndex:1]) {
                NSLog(@"key: %@, value: %@", key, [[comparelist objectAtIndex:1] objectForKey:key]);
            }

            
            for (id key in [comparelist objectAtIndex:2]) {
                NSLog(@"key: %@, value: %@", key, [[comparelist objectAtIndex:2] objectForKey:key]);
            }

            
            for (id key in [comparelist objectAtIndex:3]) {
                NSLog(@"key: %@, value: %@", key, [[comparelist objectAtIndex:3] objectForKey:key]);
            }

            
            for (id key in [comparelist objectAtIndex:4]) {
                NSLog(@"key: %@, value: %@", key, [[comparelist objectAtIndex:4] objectForKey:key]);
            }

            

            NSArray *vergleich2;
            for (int i=0; i<4; i++) {
               vergleich2=[[PackOfCards sharedInstance] showdownComparison:[comparelist objectAtIndex:i] compareWith:[comparelist objectAtIndex:i+1]];
                        
                int a = [[vergleich2 objectAtIndex:0] intValue]; 
               
                NSLog(@"asdsdsa%i",a);
                if (a==1) {
                   
                    [comparelist replaceObjectAtIndex:i+1 withObject:[comparelist objectAtIndex:i]];
                }
               
                
            }
             
           
            for (id key in [comparelist objectAtIndex:4]) {
                NSLog(@"key: %@, value: %@", key, [[comparelist objectAtIndex:4] objectForKey:key]);
            }
        }
        self.betRoundNr++;
    }else {
        endofturntemp--;
    }
}

//Diese Methode wird immer ausgeführt, wenn ein Spieler mit seinem Zug fertig ist. Hier muss ziemlich viel Entscheidung rein!!!
-(void)endOfTurn{
    Player *oldPlayer = self.activePlayer;
    //first round
    if (self.betRoundNr == 1) {
              self.betRoundNr++;
        NSLog(@"We are in round %d", self.betRoundNr);
        //Wir sind in der ersten Wettrunde
        if (oldPlayer.betState == @"DEALER") {
            
            for (int k=0; k<2; k++) {
                for (int m=2; m<7; m++) {
                    [[PackOfCards sharedInstance] distributeCard:m];
                }
            }
            
  
             

            NSLog(@"This was the DEALER'S turn");
        }else if (oldPlayer.betState == @"SMALL_BLIND") {
            //get money (SMALL_BLIND)
            [self substractFromPlayerAccount:self.smallBlind forPlayer:oldPlayer];
            [self setPot:self.smallBlind];
            NSLog(@"Player paid %d", self.smallBlind);
            NSLog(@"and has left %d", oldPlayer.moneyRest);
            
            //get cards
            //[self twoCardsForPlayer:oldPlayer]; //CRASH in PackOfCards!!!
            
            
            
            [self changeBetState:@"INACTIVE" forPlayer:oldPlayer];
            NSLog(@"This was the SMALL_BLIND'S turn");
            
        }else if (oldPlayer.betState == @"BIG_BLIND") {
            //get money (BIG_BLIND)
            [self substractFromPlayerAccount:self.bigBlind forPlayer:oldPlayer];
            [self setPot:self.bigBlind];
            NSLog(@"Player paid %d", self.bigBlind);
            NSLog(@"and has left %d", oldPlayer.moneyRest);
      
            NSLog(@"This was the BIG_BLIND'S turn");
        }
        
    }
 
    if (self.betRoundNr == 42){  //after showdown!!!
        [self activateNextPlayer];
        self.dealer = self.activePlayer;
        
    }
    
    
    
    
}




#pragma mark PlayerDelegate protocol implementation

-(void)changePlayerState:(NSString *)state forPlayer:(Player *)player{
    
    //set all players INACTIVE again
       
    player.playerState=state;
    
   
    NSLog(@"to %@", state);
    
    /*  @Xi, sollten wier hier nicht den Player einsetzen anstelle des int?
     
     Also so: 
     
     PackOfCards.h
     
     -(void)distributeCard:(Player *) player
     
     
     
     
     */
    
}

-(void)changeBetState:(NSString *)state forPlayer:(Player *)player{
    Player *pl = player;
    pl.betState = state;
    NSLog(@"Changed state of player %@", pl.playerId);
    NSLog(@"to %@", pl.betState);
}

-(void)substractFromPlayerAccount:(int)money forPlayer:(Player *)player{
    Player *pl = player;
    pl.moneyRest = pl.moneyRest - money;
}

-(void)addToPlayerAccount:(int)money forPlayer:(Player *)player{
    Player *pl = player;
    pl.moneyRest = pl.moneyRest + money;
}


#pragma mark PackOfCardDelegate protocol implementation

-(void)twoCardsForPlayer:(Player *) player{
    
}


@end








