//
//  PlayerBene.m
//  nopainbutshame
//
//  Created by Benedikt Beckmann on 19.05.12.
//  Copyright (c) 2012 BB. All rights reserved.
//

#import "PlayerBene.h"
#import "TexasHolemGame.h"

@interface PlayerBene ()
@property (nonatomic, strong) TexasHolemGame *game;
@end

@implementation PlayerBene

@synthesize playerName = _playerName;
@synthesize playerId = _playerId;
@synthesize moneyRest = _moneyRest;
//@synthesize avatar
@synthesize playerState = _playerState;
@synthesize playerRound = _playerRound;
@synthesize openCards = _openCards;
@synthesize twoCards = _twoCards;

@synthesize game = _game;


-(TexasHolemGame *) game{
    if (_game == nil) _game = [[TexasHolemGame alloc] init];
    return _game;
}


-(void)setState{

}

-(NSArray *)getStates{
    return 0;
}

-(void)removeMoney:(int)amount{
    //remove amount from personal money
    self.moneyRest = (self.moneyRest - amount);
    //amount into common pot
    self.game.totalMoney = (self.game.totalMoney + amount);
}

-(void)getMoneyFromPot:(int)amount{
    //remove money from common pot
    self.game.totalMoney = (self.game.totalMoney - amount);
    //amount into personal money
    self.moneyRest = (self.moneyRest + amount);
}






















@end