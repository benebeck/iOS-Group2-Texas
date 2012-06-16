//
//  PackOfCards.m
//  nopainbutshame
//
//  Created by Xiaoxi Pang on 5/22/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "PackOfCards.h"


@implementation PackOfCards
- (void)initializePackOfCards{
    for(int i = 1; i < 53; i++){
        for(int j = 0; j < 2; j++){
            if(i < 13){
                if(j == 0){
                    aPackOfCards[i-1][j] = 1;
                }
                if(j == 1){
                    aPackOfCards[i-1][j] = i;
                }
            }
            else {  // i > 13
                if(j == 0){
                    int suit = i/13;
                }
                if(j == 1){
                    int cardValue = i % 13;
                    if(cardValue == 0){
                        cardValue = 13;
                    }
                    aPackOfCards[i-1][j] = cardValue;
                }
            }
            
        }
    }
    
}

- (void)initializeInfoAboutPackOfCards{
    for(int i = 1; i < 53; i++){
        for(int j = 0; j < 2; j++){
            recordInfoAboutPackOfCards[i][j] = 0;       
        }
        
    }
}



- (int)getRandomNumber{
	int value = (arc4random() % 52) + 1;
    return value;
}



- (int)distributeCard:(int) openCardOrPlayer{
    int randomPos = [self getRandomNumber];
    //if the card on this position is still not opened...
    if (recordInfoAboutPackOfCards[randomPos][0] == 1){
        [self changeStatusOfCard:randomPos forWho:openCardOrPlayer];
    }
    //else run distributeCard again
    else {
        [self distributeCard:openCardOrPlayer];
    }
    return randomPos;
}

- (void)changeStatusOfCard:(int) distributedCardPos forWho:(int) openCardOrPlayer{
    recordInfoAboutPackOfCards[distributedCardPos][0] = 2;
    recordInfoAboutPackOfCards[distributedCardPos][1] = openCardOrPlayer;
}


/***
 - (void)showOwnTwoCardsOfHand:(int) playerNumber{ //playerNumber muss be (Position_of_Player_in_Array + 1) because 1 in recordInfoAboutPackOfCards is for open_card
 
 for (int m=0; m<2; m++){
 int getPosOfCard = [self distributeCard:playerNumber];
 NSString *cardImageFileName = [NSString stringWithFormat:@"%d", getPosOfCard];
 cardImageFileName = [cardImageFileName stringByAppendingFormat:@".png"];
 UIImage *cardImage = [UIImage imageNamed:cardImageFileName]; 
 showHandCardImage[m] = [[UIImageView alloc] initWithImage:cardImage];
 CGRect newFrame = showHandCardImage[m].frame;
 newFrame.origin = CGPointMake(240 + m * (120 + 20), 80);
 showHandCardImage[m].frame = newFrame;
 [self.view addSubview:showHandCardImage[m]];
 }
 
 }
 ***/

/*** Result Ranking:
 1. Royal Flush
 2. Straight Flush
 3. Four of a Kind
 4. Boat House
 5. Flush
 6. Straight
 7. Three of a Kind
 8. Two Pairs
 9. Pair
 10. High Card
 ***/

-(NSString *)getKeyFromDictionary:(NSDictionary *) dict{
    NSString * key = @"";
    NSArray * keysArray = [dict allKeys];
    if ([dict count] == 1){
        for(NSString * keys in keysArray){
            key = keys;
        }
    }
    return key;
}


-(int)compareTwoArrays: (NSArray *) a compareWith:(NSArray *) b{   
    //return value: -1 means "first array smaller than second"; 1 is "first larger than second"; 0 means "same arrays"
    int flag = 0;
    int arrayLength = [a count]; //a and b have same length
    
    for (int i =0; i < arrayLength; i++){
        NSInteger aValue = [[a objectAtIndex:i] integerValue];
        NSInteger bValue = [[b objectAtIndex:i] integerValue];
        
        if (aValue == bValue) {
            continue;
        }
        if (aValue < bValue) {
            flag = -1;
            return flag;
        }
        if (aValue > bValue) {
            flag = 1;
            return flag;
        }
        
    }
    return flag;
}

//for the function showdownComparison we need still a function "bestFiveCardsCombination" which for each player creates the best five cards combination from seven cards (two cards in hand and five open cards), and sort five cards in an array according to each type of combination
/***
 -(int)sortIntArray:(int[]) cardsArray{
 int sizeArray = sizeof(cardsArray)/sizeof(*cardsArray);
 int hold[2];
 for (int pass=1;pass<=sizeArray-1;pass++){ 
 for (int i=0;i<=sizeArray-(pass+1);i++) { 
 if (cardsArray[i][0] < cardsArray[i+1][0]) {
 for (int j=0; j<2; j++){
 hold[j]=cardsArray[i][j];
 cardsArray[i][j]=cardsArray[i+1][j];
 cardsArray[i+1][j]=hold[j];
 }
 
 
 
 }
 }
 }
 
 
 }
 
 -(NSDictionary *)hatRoyalFlush: (int[]) sevenCards{
 
 }
 
 -(NSDictionary *)bestFiveCardsCombination:(){
 
 
 }
 ***/



-(NSArray *)showdownComparison:(NSDictionary *) cardsOfPlayer_1 compareWith: (NSDictionary *) cardsOfPlayer_2{
    // dictionary cardsOfPlayer_1 indicate the best five final cards of the player_1 at the showdown time, e.g. {"Boat House": [3,3,3,7,5]}
    NSArray * winners = [NSArray array];
    NSArray * ranking = [NSArray arrayWithObjects: @"Royal Flush",@"Straight Flush", @"Four of a Kind", @"Boat House", @"Flush", @"Straight", @"Three of a Kind", @"Two Pairs", @"Pair", @"Hight Card", nil];
    
    NSString * resultPlayer_1 = [self getKeyFromDictionary:cardsOfPlayer_1];
    NSString * resultPlayer_2 = [self getKeyFromDictionary:cardsOfPlayer_2];
    
    if (resultPlayer_1 == resultPlayer_2){ //player_1 and player_2 have the same type of the combination of five cards
        if(resultPlayer_1 == @"Royal Flush"){
            winners = [winners arrayByAddingObject:@"1"];
            winners = [winners arrayByAddingObject:@"2"];
            return winners;
        }
        else {  
            //player_1 and player_2 have the same type of the combination of five cards but not "Royal Flush", we should compare the values of five cards
            NSArray * fiveCardsPlayer_1 = [cardsOfPlayer_1 objectForKey:resultPlayer_1]; // five cards of player 1
            NSArray * fiveCardsPlayer_2 = [cardsOfPlayer_2 objectForKey:resultPlayer_2]; // five cards of player 2
            
            if ([self compareTwoArrays: fiveCardsPlayer_1 compareWith:fiveCardsPlayer_2] == 1){
                winners = [winners arrayByAddingObject:@"1"];
            }
            else if ([self compareTwoArrays: fiveCardsPlayer_1 compareWith:fiveCardsPlayer_2] == -1) {
                winners = [winners arrayByAddingObject:@"2"];
            }
            
            else {
                winners = [winners arrayByAddingObject:@"1"];
                winners = [winners arrayByAddingObject:@"2"]; 
            }
            
            
            return winners;
        }
    }
    
    
    else { 
        //easier situation: two players have different type of the combination cards, we just need to compare their results in ranking
        if ([ranking indexOfObject:resultPlayer_1]<[ranking indexOfObject:resultPlayer_2]){
            winners = [winners arrayByAddingObject:@"1"];
            return winners;
        }
        else {
            winners = [winners arrayByAddingObject:@"2"];
            return winners;
        }
        
    }
    
    
}

@end
