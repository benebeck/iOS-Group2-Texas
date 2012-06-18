//
//  TexasHolemGame.h
//  nopainbutshame
//
//  Created by Benedikt Beckmann on 22.05.12.
//  Copyright (c) 2012 BB. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GCHelper.h"
#import "Player.h"
#import "PackOfCards.h"

@interface TexasHolemGame : NSObject

@property (nonatomic, strong) NSMutableArray *playerList;
@property (nonatomic) int activePlayer;
@property (nonatomic) int maxPlayers;
@property (nonatomic) int bigBlind;
@property (nonatomic) int totalMoney;
@property (nonatomic) int betRoundNr;
@property (nonatomic, strong) Player *player;


+(TexasHolemGame *)sharedInstance;

-(void)activateNextPlayer;
-(int)getRoundNr;
-(void)setRoundNr;
-(BOOL)isShowDownTime;


@end
