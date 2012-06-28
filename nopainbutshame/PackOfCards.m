//
//  PackOfCards.m
//  nopainbutshame
//
//  Created by Xiaoxi Pang on 5/22/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "PackOfCards.h"

//for private functions
@interface PackOfCards ()
//init of cardDeck should be possible during init of sharedInstance only
-(void)initializePackOfCards;
@end


@implementation PackOfCards

static PackOfCards *sharedInstance = nil;
    +(PackOfCards *) sharedInstance {
        if (!sharedInstance){
            sharedInstance = [[PackOfCards alloc] init];
            [sharedInstance initializePackOfCards];
            NSLog(@"Card deck is up...");
        }

        
        return sharedInstance;
}

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

- (int)givemeinfo:(int) i forWho:(int) j{
    recordInfoAboutPackOfCards[i][j];
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


-(NSArray *) convertIntArrayToNSArray: (int [][2]) intArray{ //convert array int[][] to NSArray with Object NSNumber
    NSArray *arr = [NSArray array];
    
    int sizeArray = 7;
    for (int i = 0; i<7; i++){
        NSArray *subarr = [NSArray array];;
        for (int j = 0; j<2; j++){
            //subarr = [subarr arrayByAddingObject:[[NSString alloc] initWithFormat:@"%i", intArray[i][j]]];
            
            subarr = [subarr arrayByAddingObject:[NSNumber numberWithInt:intArray[i][j]]];
        }
        arr = [arr arrayByAddingObject:subarr];
    }
    return arr;
    
}



-(NSArray *)sortIntArray:(int [][2]) cardsArray{ // for every player at the showdown time seven cards will be stored
                                           // in cardsArray with their values and farbes
    int sizeArray = 7;                     // then we sort them according to their value
    
    int hold[2];
    for (int pass=1;pass<=sizeArray-1;pass++) { 
        for (int i=0;i<=sizeArray-(pass+1);i++) { 
            if (cardsArray[i][1] < cardsArray[i+1][1]) { //compare the values of cards: larger value comes forword
                for (int j=0; j<2; j++){
                    hold[j]=cardsArray[i][j];
                    cardsArray[i][j]=cardsArray[i+1][j];
                    cardsArray[i+1][j]=hold[j];
                }
            }
        }
    }
    
    //    return sizeArray;
    NSArray * cardsNSArray= [self convertIntArrayToNSArray:cardsArray];
    return cardsNSArray;
}


 
-(NSDictionary *)hasRoyalFlush: (int[][2]) sevenSortedCards{
    NSArray * sevenCards= [self sortIntArray:sevenSortedCards];
    
    NSDictionary *res = [NSDictionary alloc];
    NSArray * array_13 = [NSArray array];
    
    NSArray * array_12 = [NSArray array];

    NSArray * array_11 = [NSArray array];

    NSArray * array_10 = [NSArray array];

    NSArray * array_1 = [NSArray array];
    
    NSMutableDictionary *record = [NSMutableDictionary dictionaryWithCapacity:5];
    
    NSNumber * suit;
    for (int i = 0; i<7; i++) {
        int value = [[sevenCards objectAtIndex:i] objectAtIndex:0];
        switch (value) {
            case 13:
                [record setObject:[array_13 arrayByAddingObject:[NSNumber numberWithInt:i]] forKey:@"13"]; //array_13 record the position(s) of cards with value 13, because cards with value 13 may occurs more than one time with different suits 
                break;
            case 12:
                [record setObject:[array_12 arrayByAddingObject:[NSNumber numberWithInt:i]] forKey:@"12"];
                break;
            case 11:
                [record setObject:[array_11 arrayByAddingObject:[NSNumber numberWithInt:i]] forKey:@"11"];
                break;
            case 10:
                [record setObject:[array_10 arrayByAddingObject:[NSNumber numberWithInt:i]] forKey:@"10"];
                break;
            case 1:
                [record setObject:[array_1 arrayByAddingObject:[NSNumber numberWithInt:i]] forKey:@"1"];
                break;
                
            default:
                break;
        }
    }
    if ([record count]==5) { // there are A, K ,Q, J, 10 in seven cards, then we check their suits
        for (NSString * cardValueKey in record) {
            NSArray * posArray= [record objectForKey:cardValueKey];
            if ([posArray count]==1) { 
                suit = [[sevenCards objectAtIndex:[posArray objectAtIndex:0]] objectAtIndex:0]; //for one card an array with length 2 will be used, first element is suit, second is value
                break;
            }
        }

        for  (NSString * cardValueKey in record) {
            int flag = 0; //note if card(s) has only different suit (that will be not royal flush)

            NSArray * posArray= [record objectForKey:cardValueKey];
            for (int m = 0; m<[posArray count]; m++) {
                if ([[sevenCards objectAtIndex:[posArray objectAtIndex:m]] objectAtIndex:0]== suit) {
                    flag = 1;
                    break;
                }
            }
            if (flag == 0) {
                res = [res initWithObjectsAndKeys:[NSNumber numberWithInt: 0], @"False", nil];
                return res;
            }
            
        }
        NSArray * cardsRoyalFlush = [NSArray arrayWithObjects:[NSNumber numberWithInt:13],[NSNumber numberWithInt:12],[NSNumber numberWithInt:11],[NSNumber numberWithInt:10],[NSNumber numberWithInt:1], nil];
        res = [res initWithObjectsAndKeys:cardsRoyalFlush,@"Royal Flush", nil];
        return res;
    }
    else { // in these seven cards it lacks card(s) to form A, K ,Q, J, 10
        res = [res initWithObjectsAndKeys:[NSNumber numberWithInt: 0], @"False", nil];
        return res;
    }
    
}

-(NSDictionary *)hasStraightFlushOrStraight: (int[][2]) sevenSortedCards{
    NSArray * sevenCards= [self sortIntArray:sevenSortedCards];
    NSDictionary *res = [NSDictionary alloc];
    NSArray * cardsStraightFlush = [NSArray array];
    NSArray * cardsStraight = [NSArray array];
    
    for (int i = 0; i < 7; i++) {
    //<#statements#>
    }
}

-(NSDictionary *)hatFourOfAKind: (int[][2]) sevenSortedCards{
    NSArray * sevenCards= [self sortIntArray:sevenSortedCards];
    NSDictionary *res = [NSDictionary alloc];
    NSArray * cardsFourOfAKind = [NSArray array];
    for (int i = 0; i < 4; i++) {
        if (([[sevenCards objectAtIndex:i] objectAtIndex:1]==[[sevenCards objectAtIndex:(i+1)] objectAtIndex:1]) &&  ([[sevenCards objectAtIndex:i] objectAtIndex:1]==[[sevenCards objectAtIndex:(i+2)] objectAtIndex:1]) && ([[sevenCards objectAtIndex:i] objectAtIndex:1]==[[sevenCards objectAtIndex:(i+3)] objectAtIndex:1])){
            if (i!=0) {
                NSArray * cardsFourOfAKind = [NSArray arrayWithObjects:[[sevenCards objectAtIndex:i] objectAtIndex:1],[[sevenCards objectAtIndex:i] objectAtIndex:1],[[sevenCards objectAtIndex:i] objectAtIndex:1],[[sevenCards objectAtIndex:i] objectAtIndex:1], [[sevenCards objectAtIndex:0] objectAtIndex:1],nil];
            }
            else {
                NSArray * cardsFourOfAKind = [NSArray arrayWithObjects:[[sevenCards objectAtIndex:i] objectAtIndex:1],[[sevenCards objectAtIndex:i] objectAtIndex:1],[[sevenCards objectAtIndex:i] objectAtIndex:1],[[sevenCards objectAtIndex:i] objectAtIndex:1], [[sevenCards objectAtIndex:(i+4)] objectAtIndex:1],nil];
            }
            
            res = [res initWithObjectsAndKeys: cardsFourOfAKind, @"Four of a Kind", nil];
            return res;
        }
    }
    res = [res initWithObjectsAndKeys:[NSNumber numberWithInt: 0], @"False", nil];
    return res;

}

-(NSDictionary *)hatBoatOrThreeOfAKind: (int[][2]) sevenSortedCards{
    NSArray * sevenCards= [self sortIntArray:sevenSortedCards];
    NSDictionary *res = [NSDictionary alloc];
    NSArray * cardsBoat = [NSArray array];
    NSArray * cardsThreeOfAKind = [NSArray array];
    for (int i = 0; i < 5; i++) {
        if (([[sevenCards objectAtIndex:i] objectAtIndex:1]==[[sevenCards objectAtIndex:(i+1)] objectAtIndex:1]) &&  ([[sevenCards objectAtIndex:i] objectAtIndex:1]==[[sevenCards objectAtIndex:(i+2)] objectAtIndex:1])){
            
            if (i > 1) {
                for (int j = 0; j < (i - 1); j++) {
                    if ([[sevenCards objectAtIndex:j] objectAtIndex:1]==[[sevenCards objectAtIndex:(j+1)] objectAtIndex:1]){
                        NSArray * cardsBoat = [NSArray arrayWithObjects:[[sevenCards objectAtIndex:i] objectAtIndex:1],[[sevenCards objectAtIndex:i] objectAtIndex:1],[[sevenCards objectAtIndex:i] objectAtIndex:1],[[sevenCards objectAtIndex:j] objectAtIndex:1], [[sevenCards objectAtIndex:(j+1)] objectAtIndex:1],nil];
                        res = [res initWithObjectsAndKeys: cardsBoat, @"Boat", nil];
                        return res;
                    }
                }
                
            }
            else {
                for (int j = (i+3); j < 7; j++) {
                    if ([[sevenCards objectAtIndex:j] objectAtIndex:1]==[[sevenCards objectAtIndex:(j+1)] objectAtIndex:1]){
                        NSArray * cardsBoat = [NSArray arrayWithObjects:[[sevenCards objectAtIndex:i] objectAtIndex:1],[[sevenCards objectAtIndex:i] objectAtIndex:1],[[sevenCards objectAtIndex:i] objectAtIndex:1],[[sevenCards objectAtIndex:j] objectAtIndex:1], [[sevenCards objectAtIndex:(j+1)] objectAtIndex:1],nil];
                        res = [res initWithObjectsAndKeys: cardsBoat, @"Boat", nil];
                        return res;

                    }
                }
            }
            if (i == 0) { // without a pair it must be three of a kind, find here two cards with largest values except three same value cards
                NSArray * cardsThreeOfAKind = [NSArray arrayWithObjects:[[sevenCards objectAtIndex:i] objectAtIndex:1],[[sevenCards objectAtIndex:i] objectAtIndex:1],[[sevenCards objectAtIndex:i] objectAtIndex:1],[[sevenCards objectAtIndex:(i+3)] objectAtIndex:1], [[sevenCards objectAtIndex:(i+4)] objectAtIndex:1],nil];
                res = [res initWithObjectsAndKeys: cardsThreeOfAKind, @"Three of a Kind", nil];
                return res;
            }
            else if (i == 1) {
                NSArray * cardsThreeOfAKind = [NSArray arrayWithObjects:[[sevenCards objectAtIndex:i] objectAtIndex:1],[[sevenCards objectAtIndex:i] objectAtIndex:1],[[sevenCards objectAtIndex:i] objectAtIndex:1],[[sevenCards objectAtIndex:0] objectAtIndex:1], [[sevenCards objectAtIndex:4] objectAtIndex:1],nil];
                res = [res initWithObjectsAndKeys: cardsThreeOfAKind, @"Three of a Kind", nil];
                return res;
            }
            else {
                NSArray * cardsThreeOfAKind = [NSArray arrayWithObjects:[[sevenCards objectAtIndex:i] objectAtIndex:1],[[sevenCards objectAtIndex:i] objectAtIndex:1],[[sevenCards objectAtIndex:i] objectAtIndex:1],[[sevenCards objectAtIndex:0] objectAtIndex:1], [[sevenCards objectAtIndex:1] objectAtIndex:1],nil];
                res = [res initWithObjectsAndKeys: cardsThreeOfAKind, @"Three of a Kind", nil];
                return res;
            }
        }
    }
    res = [res initWithObjectsAndKeys:[NSNumber numberWithInt: 0], @"False", nil];
    return res;
}

-(NSDictionary *)hatFlush: (int[][2]) sevenSortedCards{
    
}

-(NSDictionary *)hatStraight: (int[][2]) sevenSortedCards{
    
}


-(NSDictionary *)hatTwoPairs: (int[][2]) sevenSortedCards{
    
}

-(NSDictionary *)hatPair: (int[][2]) sevenSortedCards{
    
}

//-(NSDictionary *)hatHightCards: (int[][2]) sevenSortedCards{
    
//}



 /*** 
 -(NSDictionary *)bestFiveCardsCombination:(){
 
 
 }
 ***/



-(NSArray *)showdownComparison:(NSDictionary *) cardsOfPlayer_1 compareWith: (NSDictionary *) cardsOfPlayer_2{
    // dictionary cardsOfPlayer_1 indicate the best five final cards of the player_1 at the showdown time, e.g. {"Boat House": [3,3,3,7,5]}
    NSArray * winners = [NSArray array];
    NSArray * ranking = [NSArray arrayWithObjects: @"Royal Flush",@"Straight Flush", @"Four of a Kind", @"Boat", @"Flush", @"Straight", @"Three of a Kind", @"Two Pairs", @"Pair", @"Hight Card", nil];
    
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
