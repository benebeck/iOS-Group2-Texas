//
//  PlayerBene.h
//  nopainbutshame
//
//  Created by Benedikt Beckmann on 19.05.12.
//  Copyright (c) 2012 BB. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PlayerBene : NSObject

@property (weak, nonatomic) NSString *playerName;
@property (nonatomic) int playerId;
@property (nonatomic) int moneyRest; 
//@property () avatar
@property (weak, nonatomic) NSArray *playerState; 
@property (nonatomic) int playerRound;
@property (weak, nonatomic) NSArray *openCards;
@property (weak, nonatomic) NSArray *twoCards;


-(void)setState;

-(void)removeMoney;

@end
