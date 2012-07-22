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
@synthesize dumm;
int endofturntemp=5;


#pragma mark Initialization

/*
 *singleton GameController 
 */

static GameController *sharedInstance = nil;
IngameViewController *ingame;

+(GameController *) sharedInstance {
    if (!sharedInstance){
        sharedInstance = [[GameController alloc] init];
        
   //hardcoded dummy values
   //     sharedInstance.maxPlayers = 5;
   //     sharedInstance.totalMoney = 1000;
       sharedInstance.smallBlind = 5;
       sharedInstance.bigBlind = 10;
   //     sharedInstance.betRoundNr = 1;
       // NSLog(@"GameControl is up...");
    }
    //hardcoded dummy values
    
    
   // NSLog(@"GameControl is up...");
    
    return sharedInstance;
        
    
}




//method to instantiate the players after GameControl has been started
-(void)raisePlayers{
  //  self.betRoundNr=1;
    //dummy list
 
 
    NSMutableArray *list = [NSMutableArray array];
    NSMutableArray *list2 = [NSMutableArray array];
    NSLog(@"%i",sharedInstance.maxPlayers);
    
        Player *player1 = [[Player alloc] init];
        player1.moneyRest=sharedInstance.totalMoney/sharedInstance.maxPlayers;
        player1.playerId = @"Player1";
        [list addObject:player1];
        [list2 addObject:player1];
        Player *player2 = [[Player alloc] init];
        player2.playerId = @"Player2";
        player2.moneyRest=sharedInstance.totalMoney/sharedInstance.maxPlayers;
        [list addObject:player2];
        [list2 addObject:player2];

            
    
    if (sharedInstance.maxPlayers >2) {
                Player *player3 = [[Player alloc] init];
                player3.playerId = @"Player3";
                player3.moneyRest=sharedInstance.totalMoney/sharedInstance.maxPlayers;
                [list addObject:player3];
                [list2 addObject:player3];
            }
    
    if (sharedInstance.maxPlayers >3) {
                Player *player4 = [[Player alloc] init];
                player4.playerId = @"Player4";
                player4.moneyRest=sharedInstance.totalMoney/sharedInstance.maxPlayers;
                [list addObject:player4];
                [list2 addObject:player4];
            }
    
    if (sharedInstance.maxPlayers >4) {
                Player *player5 = [[Player alloc] init];
                player5.playerId = @"Player5";
                player5.moneyRest=sharedInstance.totalMoney/sharedInstance.maxPlayers;
                [list addObject:player5];
                [list2 addObject:player5];
            }
    
    //foreach-Schleife : hier müssten die mitspieler rein
   
    
    NSLog(@"%i",[list count]);
    
    self.playerList = list;
    
    self.dumm=list2;
    
    
    //Start the game
    [self startNewRound];
    
}


#pragma mark Game methods
    //hier muss der current player aus GC mitverwurstelt werden




    -(void)activateNextPlayer{
  
      //  NSLog(@"jetzt kommt der nächste spieler%@ mit%@",[self.activePlayer playerId],[self.activePlayer playerState]);
        
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
                if([[self.playerList objectAtIndex:0] playerState]!=@"FOLD") {[[self.playerList objectAtIndex:0] setPlayerState:@"INACTIVE"];}else {
                    [dumm removeObject:[self.playerList objectAtIndex:0]];                }
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
                              
                [self endOfTurntemp];
                
            }else {
                if ([[self.playerList lastObject] playerState]!=@"RAISE") {
                    if([[self.playerList lastObject] playerState]!=@"FOLD")
                    {[[self.playerList lastObject] setPlayerState:@"INACTIVE"];
                        [self endOfTurntemp];
                    }else {
                    [dumm removeObject:[self.playerList lastObject]];   
                        NSLog(@"spieleisraus");
                        
                    }

                }else {
                    if(self.pot<=0 || self.pot>100000)
                    {
                        [self setPot:100];
                        [self setWetthohe:0];
                    }
                    else {
                        [self setPot:pot+100];
                    }
                    
                    [self endOfTurntemp];
                    
                
                }
                
            }
            self.activePlayer = [self.playerList objectAtIndex:0];
            
            //next player    
        }else {
            NSLog(@"old active player: %@", self.activePlayer.playerId);
            Player *player;
            NSInteger index=0;
            for (; index<[self.playerList count]-1; index++) {
            
            if ([self.playerList objectAtIndex:index]!=NULL ){
                player=[self.playerList objectAtIndex:index];
                if (self.activePlayer == player) {
                    
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
                        
                    }else {
                        if ([[self.playerList objectAtIndex:index] playerState]!=@"RAISE") {
                            if([[self.playerList objectAtIndex:index] playerState]!=@"FOLD")
                            {[[self.playerList objectAtIndex:index] setPlayerState:@"INACTIVE"];
                                
                            }else {
                     [dumm removeObject:[self.playerList objectAtIndex:index]];   
                                NSLog(@"spieler5israus");
                                
                               
                            }
                            
                        }else {
                            if(self.pot<=0 || self.pot>100000)
                            {
                                [self setPot:100];
                                [self setWetthohe:0];
                            }
                            else {
                                [self setPot:pot+100];
                            }
                            
                         
                            
                            
                        }

                    }

                    index++;
                    self.activePlayer = [self.playerList objectAtIndex:index];
                    break;
                }
                }
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
        
    if (sharedInstance.maxPlayers>2) {
           [self changeBetState:@"BIG_BLIND" forPlayer:[self.playerList objectAtIndex:2]];
    }
        //send SMALL_BLIND to the next
        [self changeBetState:@"SMALL_BLIND" forPlayer:[self.playerList objectAtIndex:1]];
        
        
        //send BIG_BLIND to the next
     
        
        [self endOfTurn];
    

    
}

-(void) endOfTurntemp{
    if ([self.dumm count]==1) {
        [self addToPlayerAccount:pot forPlayer:[sharedInstance.playerList lastObject]];
        sharedInstance.betRoundNr=1;
        [self.playerList removeAllObjects];
        [self.dumm removeAllObjects];
        [ingame endiwinnaiz:@"Spieler1"];
        [sharedInstance setPot:0];
        for (int h=0; h<51; h++) {
            [[PackOfCards sharedInstance] resetStatusOfCard:h forWho:0];
        }
        [self raisePlayers];
        [self startNewRound];

        [sharedInstance setPot:0];
        for (int h=0; h<51; h++) {
            [[PackOfCards sharedInstance] resetStatusOfCard:h forWho:0];
        }
        [self raisePlayers];
        [self startNewRound];

    }

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
            
            
            
            
            
            
            
            NSArray *vergleich2;

            NSMutableArray *apple=[NSMutableArray array];
            for (int x=0;x<[self.dumm count];x++) {
             
                for (int y=0;y<[self.playerList count]; y++) {
                if ([dumm objectAtIndex:x]==[self.playerList objectAtIndex:y] ) {
                    [apple addObject:[self.playerList objectAtIndex:y]];
                }
                }
            }

            
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
            
            
            for (int j=0; j<2; j++) {
                
            for (int temp1=0; temp1<52; temp1++) {
                
                
                
                if((([[PackOfCards sharedInstance] whogotthecard:temp1]==2 || [[PackOfCards sharedInstance] whogotthecard:temp1]==1))&&j==0){
                    
                    int temprest=1+temp1%13;
                    
                    int tempganz=1+temp1/13;
                    
                    spieler1karten[temp11][0]=tempganz;
                    
                    spieler1karten[temp11][1]=temprest;
                    
                    temp11++;
                    
                }
                
                
                
                if(([[PackOfCards sharedInstance] whogotthecard:temp1]==3 || [[PackOfCards sharedInstance] whogotthecard:temp1]==1)&&j==0){
                    
                    int temprest=1+temp1%13;
                    
                    int tempganz=1+temp1/13;
                    
                    spieler2karten[temp12][0]=tempganz;
                    
                    spieler2karten[temp12][1]=temprest;
                    
                    temp12++;
                    
                }
                
                
                
                if(([[PackOfCards sharedInstance] whogotthecard:temp1]==4 || [[PackOfCards sharedInstance] whogotthecard:temp1]==1)&&j==0){
                    
                    int temprest=1+temp1%13;
                    
                    int tempganz=1+temp1/13;
                    
                    spieler3karten[temp13][0]=tempganz;
                    
                    spieler3karten[temp13][1]=temprest;
                    
                    temp13++;
                    
                }
                
                
                
                if(([[PackOfCards sharedInstance] whogotthecard:temp1]==5 || [[PackOfCards sharedInstance] whogotthecard:temp1]==1)&&j==0){
                    
                    int temprest=1+temp1%13;
                    
                    int tempganz=1+temp1/13;
                    
                    spieler4karten[temp14][0]=tempganz;
                    
                    spieler4karten[temp14][1]=temprest;
                    
                    temp14++;
                    
                }
                
                
                
                if(([[PackOfCards sharedInstance] whogotthecard:temp1]==6 || [[PackOfCards sharedInstance] whogotthecard:temp1]==1)&&j==0){
                    
                    int temprest=1+temp1%13;
                    
                    int tempganz=1+temp1/13;
                    
                    spieler5karten[temp15][0]=tempganz;
                    
                    spieler5karten[temp15][1]=temprest;
                    
                    temp15++;
                    
                }
                
                
                
            }
                
                if(j>0&&temp11<6)
                    
                {
                    
                    for (int j=0; j<7; j++) {
                        
                        spieler1karten[j][0]=1;
                        
                        spieler1karten[j][1]=((j*2)%13)+1;
                        
                    }
                    
                }
                
                
                
                if(j>0&&temp12<6)
                    
                {
                    
                    for (int j=0; j<7; j++) {
                        
                        spieler1karten[j][0]=1;
                        
                        spieler1karten[j][1]=((j*2)%13)+1;
                        
                    }
                    
                }
                
                
                
                if(j>0&&temp13<6)
                    
                {
                    
                    for (int j=0; j<7; j++) {
                        
                        spieler1karten[j][0]=1;
                        
                        spieler1karten[j][1]=((j*2)%13)+1;
                        
                    }
                    
                }
                
                
                
                if(j>0&&temp14<6)
                    
                {
                    
                    for (int j=0; j<7; j++) {
                        
                        spieler1karten[j][0]=1;
                        
                        spieler1karten[j][1]=((j*2)%13)+1;
                        
                    }
                    
                }
                
                
                
                if(j>0&&temp15<6)
                    
                {
                    
                    for (int j=0; j<7; j++) {
                        
                        spieler1karten[j][0]=1;
                        
                        spieler1karten[j][1]=((j*2)%13)+1;
                        
                    }
                    
                }
            
        }
          
            
            
            
            
 

              for (int m=0; m<[apple count]-1; m++) {
                  
                  int temp111=0;
                  NSMutableArray *comparelist = [NSMutableArray arrayWithCapacity:2];  
            
            NSDictionary *spieler1=[[PackOfCards sharedInstance] bestFiveCardsCombination:spieler1karten];
                  if([[apple objectAtIndex:m+temp111] playerId]==@"Player1"){
            [comparelist addObject:spieler1];
                      temp111++;
                  }
            
            NSDictionary *spieler2=[[PackOfCards sharedInstance] bestFiveCardsCombination:spieler2karten];
                  if([[apple objectAtIndex:m+temp111] playerId]==@"Player2"){
            [comparelist addObject:spieler2];
                      temp111++;   
                  }
            
            NSDictionary *spieler3=[[PackOfCards sharedInstance] bestFiveCardsCombination:spieler3karten];
                  if (temp111<2) {
               
                  if([[apple objectAtIndex:m+temp111] playerId]==@"Player3"){
            [comparelist addObject:spieler3];
                      temp111++;   
                  }
                  }
            
            NSDictionary *spieler4=[[PackOfCards sharedInstance] bestFiveCardsCombination:spieler4karten];
                         if (temp111<2) {
                  if([[apple objectAtIndex:m+temp111] playerId]==@"Player4"){
            [comparelist addObject:spieler4];
                      temp111++;   
                  }
                         }
                  
            NSDictionary *spieler5=[[PackOfCards sharedInstance] bestFiveCardsCombination:spieler5karten];
                         if (temp111<2) {
             if([[apple objectAtIndex:m+temp111] playerId]==@"Player5"&&temp111==1)
            [comparelist addObject:spieler5];
                         }
            
            
            

               vergleich2=[[PackOfCards sharedInstance] showdownComparison:[comparelist objectAtIndex:0] compareWith:[comparelist objectAtIndex:1]];
                        
               int a = [[vergleich2 objectAtIndex:0] intValue]; 
              
                if (a==1) {
                   
                    [apple replaceObjectAtIndex:m+1 withObject:[apple objectAtIndex:m]];
                }
               
                
            }
            
       
            [ingame endiwinnaiz:[[apple lastObject] playerId]]; 
            
            [self addToPlayerAccount:pot forPlayer:[apple lastObject]];
            sharedInstance.betRoundNr=0;
            endofturntemp=5;
            [self.playerList removeAllObjects];
            [self.dumm removeAllObjects];
          
            [sharedInstance setPot:0];
            for (int h=0; h<51; h++) {
                [[PackOfCards sharedInstance] resetStatusOfCard:h forWho:0];
            }
            
  //          [ingame endiwinnaiz:testi];
        }
        self.betRoundNr++;
        [self raisePlayers];
        [self startNewRound];
    }else {
        endofturntemp--;
    }
}

//Diese Methode wird immer ausgeführt, wenn ein Spieler mit seinem Zug fertig ist. Hier muss ziemlich viel Entscheidung rein!!!
-(void)endOfTurn{
    ingame=[[IngameViewController alloc]init];

    Player *oldPlayer = self.activePlayer;
    //first round
    if (self.betRoundNr == 1) {
              self.betRoundNr++;
        NSLog(@"We are in round %d", self.betRoundNr);
        //Wir sind in der ersten Wettrunde
        if (oldPlayer.betState == @"DEALER") {
            
            for (int k=0; k<2; k++) {
                for (int m=2; m<sharedInstance.maxPlayers+2; m++) {
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








