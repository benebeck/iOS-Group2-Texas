//
//  GameController.h
//  TH
//
//  Created by Benedikt Beckmann on 20.06.12.
//  Copyright (c) 2012 BB. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "GCHelper.h"
#import "Player.h"
#import "PackOfCards.h"
#import "IngameViewController.h"

@interface GameController : NSObject<PlayerDelegate, PackOfCardsDelegate>

@property (nonatomic, strong) NSMutableArray *playerList;
@property (nonatomic, strong) NSMutableArray *gameStates;
@property (nonatomic, strong) Player *activePlayer;
@property (nonatomic) int maxPlayers;
@property (nonatomic) int smallBlind;
@property (nonatomic) int bigBlind;
@property (nonatomic) int totalMoney;
@property int blindprorunde;
@property (nonatomic) int betRoundNr;
@property (nonatomic, strong) Player *player;
@property (nonatomic, weak) Player *dealer;
@property   NSMutableArray *dumm;
//sollten wir die hier nicht auch nonatomic machen?
@property             int pot;
@property             int wetthohe;
@property int spieler1geldgerade;
@property int spieler2geldgerade;
@property int spieler3geldgerade;
@property int spieler4geldgerade;
@property int spieler5geldgerade;



+(GameController *)sharedInstance;

-(void)raisePlayers;
-(void)activateNextPlayer;
-(void)endOfTurn;
-(int)getRoundNr;
-(void)setRoundNr;
-(BOOL)isShowDownTime;




@end
