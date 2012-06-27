//
//  Player.h
//  TH
//
//  Created by Benedikt Beckmann on 20.06.12.
//  Copyright (c) 2012 BB. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Player;

@protocol PlayerDelegate <NSObject>

-(void)changePlayerState:(NSString *)state forPlayer:(Player *)player;
-(void)changeBetState:(NSString *)state forPlayer:(Player *) player;
-(void)substractFromPlayerAccount:(int)money forPlayer: (Player *)player;
-(void)addToPlayerAccount:(int)money forPlayer: (Player *)player;


@end


@interface Player : NSObject

@property (nonatomic, weak) id <PlayerDelegate> delegate;

@property (weak, nonatomic) NSString *playerName;
@property (nonatomic, strong) NSString *playerId;
@property (nonatomic) int moneyRest; 
//@property () avatar
@property (weak, nonatomic) NSString *playerState;
@property (nonatomic, weak) NSString *betState;
@property (nonatomic) int playerRound;
//@property (weak, nonatomic) NSArray *openCards;
//@property (weak, nonatomic) NSArray *twoCards;




@end
