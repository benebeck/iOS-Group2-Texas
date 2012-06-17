//
//  TexasHolemGame.h
//  nopainbutshame
//
//  Created by Benedikt Beckmann on 22.05.12.
//  Copyright (c) 2012 BB. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GCHelper.h"

@interface TexasHolemGame : NSObject<GCHelperDelegate>

@property (nonatomic, weak) NSArray *players;
@property (nonatomic) int activePlayer;
@property (nonatomic) int maxPlayers;
@property (nonatomic) int bigBlind;
@property (nonatomic) int totalMoney;
@property (nonatomic) int betRoundNr;

-(void)activateNextPlayer;
-(int)getRoundNr;
-(void)setRoundNr;
-(BOOL)isShowDownTime;

@end
