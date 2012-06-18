//
//  Player.h
//  nopainbutshame
//
//  Created by Benedikt Beckmann on 22.05.12.
//  Copyright (c) 2012 BB. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Player : NSObject


@property (weak, nonatomic) NSString *playerName;
@property (nonatomic) int playerId;
@property (nonatomic) int moneyRest; 
//@property () avatar
@property (weak, nonatomic) NSArray *playerState; 
@property (nonatomic) int playerRound;
@property (weak, nonatomic) NSArray *openCards;
@property (weak, nonatomic) NSArray *twoCards;


-(void)setState;
-(NSArray *)getStates;
-(void)removeMoney:(int)amount;
-(void)getMoneyFromPot:(int)amount;


@end
