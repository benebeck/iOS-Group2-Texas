//
//  GameController.h
//  nopainbutshame
//
//  Created by Benedikt Beckmann on 20.06.12.
//  Copyright (c) 2012 BB. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "GCHelper.h"
#import "Player.h"
//#import "PackOfCards.h"

@interface GameController : NSObject<PlayerDelegate>

@property (nonatomic, strong) NSMutableArray *playerList;
@property (nonatomic, strong) NSMutableArray *gameStates;
@property (nonatomic, strong) NSString  *activePlayer;
@property (nonatomic) int maxPlayers;
@property (nonatomic) int bigBlind;
@property (nonatomic) int totalMoney;
@property (nonatomic) int betRoundNr;
@property (nonatomic, strong) Player *player;
@property             int pot;


+(GameController *)sharedInstance;

-(void)raisePlayers;
-(void)activateNextPlayer;
-(int)getRoundNr;
-(void)setRoundNr;
-(BOOL)isShowDownTime;




@end
