//
//  Player.h
//  nopainbutshame
//
//  Created by Benedikt Beckmann on 22.05.12.
//  Copyright (c) 2012 BB. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Player;

@protocol PlayerDelegate <NSObject>

-(void)changePlayerState:(NSString *)state forPlayer:(NSObject *)player;

@end


@interface Player : NSObject

@property (nonatomic, weak) id <PlayerDelegate> delegate;

@property (weak, nonatomic) NSString *playerName;
@property (nonatomic, strong) NSString *playerId;
@property (nonatomic) int moneyRest; 
//@property () avatar
@property (weak, nonatomic) NSString *playerState; 
@property (nonatomic) int playerRound;
@property (weak, nonatomic) NSArray *openCards;
@property (weak, nonatomic) NSArray *twoCards;


-(void)setState;
-(NSArray *)getStates;
-(void)removeMoney:(int)amount;
-(void)getMoneyFromPot:(int)amount;
-(void)chooseBet:(int)amount;


@end
