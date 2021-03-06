//
//  PackOfCards.h
//  nopainbutshame
//
//  Created by Xiaoxi Pang on 5/22/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Player.h"

@class PackOfCards;

@protocol PackOfCardsDelegate <NSObject>

-(void)twoCardsForPlayer:(Player *) player;

@end


@interface PackOfCards : NSObject
{   int aPackOfCards[52][2]; //[[Suit_1, Value_1][Suit_1, Value_2]...[Suit_4, Value_13]] (suit: 1=spade, 2=heart, 3=diamond, 4=club)
   int recordInfoAboutPackOfCards[52][2]; //[[1/2, 1/2/3/4/5][]...[]] (1st element (if the card is opened): 1=not_opened, 2=opened; 2nd element (the card is distributed to): 1=open_card, 2=player_1, 3=player_2,...)
    
  //  NSMutableArray * recordInfoAboutPackOfCards;
//    UIImageView *showHandCardImage[2];
    
    
}

@property (nonatomic, weak) id <PackOfCardsDelegate> delegate;

+(PackOfCards *)sharedInstance;

//@property (nonatomic,strong) IBOutlet UIImageView *showHandCardImage; 
- (int) givemeinfo:(int) i;
- (int) whogotthecard:(int) i;
- (void)initializePackOfCards;
- (int)givemeinfo2:(int) i;
- (void)initializeInfoAboutPackOfCards;
- (int)distributeCard:(int) openCardOrPlayer;
- (void)changeStatusOfCard:(int) distributedCardPos forWho: (int) openCardOrPlayer;
- (void)resetStatusOfCard:(int) distributedCardPos forWho: (int) openCardOrPlayer;
- (NSArray *)erayscheck:(int[][2]) erayslist;
//- (void)showOwnTwoCardsOfHand;  
-(NSArray *)showdownComparison:(NSDictionary *) cardsOfPlayer_1 compareWith: (NSDictionary *) cardsOfPlayer_2;
-(NSDictionary *)bestFiveCardsCombination:(int[][2]) sevenCards;
@end

