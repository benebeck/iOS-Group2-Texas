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

@synthesize delegate = _delegate;

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
    int suit;
    int cardValue;
    for(int i = 1; i < 53; i++){
        for(int j = 0; j < 2; j++){
            if(i % 13 == 0){
                suit = i/13;
                cardValue = 13;
            }
            else {  // i != 13/26/39/52
                suit = i/13 + 1;
                cardValue = i%13;
            }    
            if(j == 0){
                aPackOfCards[i-1][j] = suit;
            }
            if(j == 1){
                aPackOfCards[i-1][j] = cardValue;
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
    return recordInfoAboutPackOfCards[i][j];
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
    for (int i = 0; i<sizeArray; i++){
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


 
-(BOOL)hasAceInArray:(NSArray *)sevenSortedCards{
    if ([[[sevenSortedCards objectAtIndex:6] objectAtIndex:1] isEqualToNumber:[NSNumber numberWithInt:1]]) {
        return TRUE;
    }
    else {
        return FALSE;
    }
}

-(NSArray *)convertAceTo14inSevenSortedArray: (int[][2]) sevenCards{
    for (int i=0; i<7; i++) {
        if (sevenCards[i][1]==1) {
            sevenCards[i][1]=14;
        }
    }
    
    NSArray * aceTo14SortedArray = [self sortIntArray:sevenCards];
    
    return aceTo14SortedArray;
}


-(NSDictionary *)hasRoyalFlush:(NSArray *) sevenSortedCards{   //return Royal Flush or Straight A, K, Q, J, 10 with different suit or nothing if there isn't such cases.
    NSDictionary *res = [NSDictionary alloc];
    
    NSMutableArray * array_14 = [NSMutableArray array];
    
    NSMutableArray * array_13 = [NSMutableArray array];
    
    NSMutableArray * array_12 = [NSMutableArray array];
    
    NSMutableArray * array_11 = [NSMutableArray array];
    
    NSMutableArray * array_10 = [NSMutableArray array];
    
    NSMutableDictionary *record = [NSMutableDictionary dictionaryWithCapacity:5];
    
    NSNumber * suit;
    for (int i = 0; i<7; i++) {
        int value = [[[sevenSortedCards objectAtIndex:i] objectAtIndex:1] intValue];
        switch (value) {
            case 14:
                [array_14 addObject:[NSNumber numberWithInt:i]];
                [record setObject:array_14 forKey:@"14"];
                break;   
                
            case 13:
                [array_13 addObject:[NSNumber numberWithInt:i]];
                [record setObject:array_13 forKey:@"13"]; //array_13 record the position(s) of cards with value 13, because cards with value 13 may occurs more than one time with different suits 
                break;
                
            case 12:
                [array_12 addObject:[NSNumber numberWithInt:i]];
                [record setObject:array_12 forKey:@"12"];
                break;
            case 11:
                [array_11 addObject:[NSNumber numberWithInt:i]];
                [record setObject:array_11 forKey:@"11"];
                break;
            case 10:
                [array_10 addObject:[NSNumber numberWithInt:i]];
                [record setObject:array_10 forKey:@"10"];
                break;
                
                
            default:
                break;
        }
    }
    if ([record count]==5) { // there are A, K ,Q, J, 10 in seven cards, then we check their suits
        for (NSString * cardValueKey in record) {
            NSArray * posArray= [record objectForKey:cardValueKey];
            if ([posArray count]==1) { 
                suit = [[sevenSortedCards objectAtIndex:[[posArray objectAtIndex:0] intValue]] objectAtIndex:0]; //for one card an array with length 2 will be used, first element is suit, second is value
                break;
            }
        }
        int recordSuit = 0;
        for  (NSString * cardValueKey in record) {
            int flag = 0; //note if card(s) has only different suit (that will be not royal flush)
            
            NSArray * posArray= [record objectForKey:cardValueKey];
            for (int m = 0; m<[posArray count]; m++) {
                if ([[sevenSortedCards objectAtIndex:[[posArray objectAtIndex:m] intValue]] objectAtIndex:0]== suit) {
                    flag = 1;
                    break;
                }
            }
            if (flag == 1) {  
                recordSuit = 1;
            }
            else {  //Flush has different suit
                recordSuit = 0;
                break;
            }
            
        }
        if (recordSuit==1) {
            NSArray * cardsRoyalFlush = [NSArray arrayWithObjects:[NSNumber numberWithInt:14],[NSNumber numberWithInt:13],[NSNumber numberWithInt:12],[NSNumber numberWithInt:11],[NSNumber numberWithInt:10], nil];
            res = [res initWithObjectsAndKeys:cardsRoyalFlush,@"Royal Flush", nil];
            return res;
        }
        else {
            NSArray * cardsRoyalFlush = [NSArray arrayWithObjects:[NSNumber numberWithInt:14],[NSNumber numberWithInt:13],[NSNumber numberWithInt:12],[NSNumber numberWithInt:11],[NSNumber numberWithInt:10], nil];
            res = [res initWithObjectsAndKeys:cardsRoyalFlush, @"Straight", nil];
            return res;
        }
        
    }
    else { // in these seven cards it lacks card(s) to form A, K ,Q, J, 10
        res = [res initWithObjectsAndKeys:[NSNumber numberWithInt: 0], @"False", nil];
        return res;
    }
    
}


-(NSDictionary *)hasStraightFlushOrStraight:(NSArray *) sevenSortedCards{
    NSDictionary *res = [NSDictionary alloc];
    NSArray * cardsStraightFlush = [NSArray array];
    NSArray * cardsStraight = [NSArray array];
    NSMutableArray * allStraights = [NSMutableArray array];
    
    
    
    NSMutableDictionary *record = [NSMutableDictionary dictionaryWithCapacity:7]; //dictionary records the position of card for each value, maximal seven different values
    
    NSMutableArray * pos;// = [NSMutableArray arrayWithCapacity:4]; // for one value it can appear maximal 4 times
    int last = 0;
    for (int i = 0; i < 7; i++) {
        if ([[[sevenSortedCards objectAtIndex:i] objectAtIndex:1] isEqualToNumber:[NSNumber numberWithInt:last]]){
            [pos addObject:[NSNumber numberWithInt:i]];
        }
        else { //[[sevenSortedCards objectAtIndex:i] objectAtIndex:1] != [NSNumber numberWithInt:last]
            if (i!=0) { // not for first element
                //      NSLog(@"%i",[[pos objectAtIndex:0] integerValue]);
                [record setObject:pos forKey:[[[sevenSortedCards objectAtIndex:i-1] objectAtIndex:1] stringValue]];
                pos = [NSMutableArray array];
                [pos addObject:[NSNumber numberWithInt:i]];
                last = [[[sevenSortedCards objectAtIndex:i] objectAtIndex:1] intValue];
            }
            else {
                pos = [NSMutableArray array];
                [pos addObject:[NSNumber numberWithInt:i]];
                last = [[[sevenSortedCards objectAtIndex:i] objectAtIndex:1] intValue];
            }
            
        }
    }
    [record setObject:pos forKey:[[[sevenSortedCards objectAtIndex:6] objectAtIndex:1] stringValue]];    
    
    
    for (int i = 0; i < 3; i++) { //the first card of a smallest (or last) five cards straight cannot appear after the position with index 2 in an array (i<3)
        
        if (i == 0) {
            NSNumber * lastValue = [[sevenSortedCards objectAtIndex:i] objectAtIndex:1];
            
            int nextValueCard = 2; // record the largest index of the card with next value which can not be exceeded
            
            NSMutableArray * straightValues = [NSMutableArray arrayWithCapacity:5]; //records 5 cards straight
            [straightValues addObject:lastValue];
            
            
            for (int j = (i+1); j < (nextValueCard+2); j++){                
                if ([[[sevenSortedCards objectAtIndex:j] objectAtIndex:1] isEqualToNumber: [NSNumber numberWithInt:([lastValue integerValue]-1)]]){
                    [straightValues addObject:[[sevenSortedCards objectAtIndex:j] objectAtIndex:1]];
                    lastValue = [[sevenSortedCards objectAtIndex:j] objectAtIndex:1]; // update last value
                    nextValueCard = nextValueCard + 1; // next card
                    
                }
                if (nextValueCard > 5) {// it means that five cards straight has been found
                    [allStraights addObject:straightValues];
                    break;
                }
            }
            //
            
            
        }
        else { // i!=0, compare the value of this card and the last card, if both are with same value, we can spring to next card 
            if (![[[sevenSortedCards objectAtIndex:i] objectAtIndex:1] isEqualToNumber: [[sevenSortedCards objectAtIndex:(i-1)] objectAtIndex:1]]) {
                NSNumber * lastValue = [[sevenSortedCards objectAtIndex:i] objectAtIndex:1];
                
                int nextValueCard = 2; // record the largest index of the card with next value which can not be exceeded
                
                NSMutableArray * straightValues = [NSMutableArray arrayWithCapacity:5]; //records 5 cards straight
                [straightValues addObject:lastValue];
                
                for (int j = (i+1); j < (nextValueCard+2); j++){
                    
                    if ([[[sevenSortedCards objectAtIndex:j] objectAtIndex:1] isEqualToNumber:[NSNumber numberWithInt:([lastValue integerValue]-1)]]){
                        [straightValues addObject:[[sevenSortedCards objectAtIndex:j] objectAtIndex:1]];
                        lastValue = [[sevenSortedCards objectAtIndex:j] objectAtIndex:1]; // update last value
                        nextValueCard = nextValueCard + 1; // next card
                        
                    }
                    if (nextValueCard > 5) { //it means that five cards straight has been found
                        [allStraights addObject:straightValues];
                        break;
                    }
                }
                
            }
            
        }
        
        
        
    }
    
    if ([allStraights count]!= 0) {// if allStraights is not empty
        int hasStraightFlush = 0;
        for (id straight in allStraights) {
            
            int hasSameSuit = 1;
            
            for (id position in [record objectForKey:[[straight objectAtIndex:0] stringValue]]) {
                
                for(int i = 1; i<[straight count]; i++){
                    int flag = 0;
                    for (id p in [record objectForKey:[[straight objectAtIndex:i] stringValue]]) {
                        if ([[[sevenSortedCards objectAtIndex:[p intValue]] objectAtIndex:0] isEqualToNumber:[[sevenSortedCards objectAtIndex:[position intValue]] objectAtIndex:0]]) {
                            flag = 1;
                            break;
                        }
                    }
                    if (flag != 1) {
                        hasSameSuit = 0;
                        break;
                    }
                }
            }
            if (hasSameSuit == 1) {
                hasStraightFlush = 1;
                cardsStraightFlush = straight;
                res = [res initWithObjectsAndKeys:cardsStraightFlush, @"Straight Flush", nil];
                return res;
            }
            
        }
        if (hasStraightFlush == 0) {
            cardsStraight = [allStraights objectAtIndex:0];
            res = [res initWithObjectsAndKeys:cardsStraight, @"Straight", nil];
            return res;
        }
        
    }
    else {
        res = [res initWithObjectsAndKeys:[NSNumber numberWithInt:0], @"False", nil];
        return res;
    }
}


-(NSDictionary *)hasFourOfAKind:(NSArray *) sevenSortedCards{
    NSDictionary *res = [NSDictionary alloc];
    NSArray * cardsFourOfAKind = [NSArray array];
    for (int i = 0; i < 4; i++) {
        if (([[[sevenSortedCards objectAtIndex:i] objectAtIndex:1] isEqualToNumber:[[sevenSortedCards objectAtIndex:(i+1)] objectAtIndex:1]]) &&  ([[[sevenSortedCards objectAtIndex:i] objectAtIndex:1] isEqualToNumber:[[sevenSortedCards objectAtIndex:(i+2)] objectAtIndex:1]]) && ([[[sevenSortedCards objectAtIndex:i] objectAtIndex:1] isEqualToNumber:[[sevenSortedCards objectAtIndex:(i+3)] objectAtIndex:1]])){
            if (i!=0) {
                cardsFourOfAKind = [NSArray arrayWithObjects:[[sevenSortedCards objectAtIndex:i] objectAtIndex:1],[[sevenSortedCards objectAtIndex:i] objectAtIndex:1],[[sevenSortedCards objectAtIndex:i] objectAtIndex:1],[[sevenSortedCards objectAtIndex:i] objectAtIndex:1], [[sevenSortedCards objectAtIndex:0] objectAtIndex:1],nil];
            }
            else {
                cardsFourOfAKind = [NSArray arrayWithObjects:[[sevenSortedCards objectAtIndex:i] objectAtIndex:1],[[sevenSortedCards objectAtIndex:i] objectAtIndex:1],[[sevenSortedCards objectAtIndex:i] objectAtIndex:1],[[sevenSortedCards objectAtIndex:i] objectAtIndex:1], [[sevenSortedCards objectAtIndex:(i+4)] objectAtIndex:1],nil];
            }
            
            res = [res initWithObjectsAndKeys: cardsFourOfAKind, @"Four of a Kind", nil];
            return res;
        }
    }
    res = [res initWithObjectsAndKeys:[NSNumber numberWithInt: 0], @"False", nil];
    return res;
    
}


-(NSDictionary *)hasBoatOrThreeOfAKind: (NSArray *) sevenSortedCards{
    NSDictionary *res = [NSDictionary alloc];
    NSArray * cardsBoat = [NSArray array];
    NSArray * cardsThreeOfAKind = [NSArray array];
    for (int i = 0; i < 5; i++) {
        if (([[[sevenSortedCards objectAtIndex:i] objectAtIndex:1] isEqualToNumber:[[sevenSortedCards objectAtIndex:(i+1)] objectAtIndex:1]]) &&  ([[[sevenSortedCards objectAtIndex:i] objectAtIndex:1] isEqualToNumber:[[sevenSortedCards objectAtIndex:(i+2)] objectAtIndex:1]])){
            
            if (i > 1) {
                for (int j = 0; j < (i - 1); j++) { //search pair before three same value cards
                    if ([[[sevenSortedCards objectAtIndex:j] objectAtIndex:1] isEqualToNumber:[[sevenSortedCards objectAtIndex:(j+1)] objectAtIndex:1]]){
                        cardsBoat = [NSArray arrayWithObjects:[[sevenSortedCards objectAtIndex:i] objectAtIndex:1],[[sevenSortedCards objectAtIndex:i] objectAtIndex:1],[[sevenSortedCards objectAtIndex:i] objectAtIndex:1],[[sevenSortedCards objectAtIndex:j] objectAtIndex:1], [[sevenSortedCards objectAtIndex:(j+1)] objectAtIndex:1],nil];
                        res = [res initWithObjectsAndKeys: cardsBoat, @"Boat", nil];
                        return res;
                    }
                }
            }
            if (i<3) {
                for (int j = (i+3); j < 6; j++) { //search pair after three same value cards
                    if ([[[sevenSortedCards objectAtIndex:j] objectAtIndex:1] isEqualToNumber:[[sevenSortedCards objectAtIndex:(j+1)] objectAtIndex:1]]){
                        cardsBoat = [NSArray arrayWithObjects:[[sevenSortedCards objectAtIndex:i] objectAtIndex:1],[[sevenSortedCards objectAtIndex:i] objectAtIndex:1],[[sevenSortedCards objectAtIndex:i] objectAtIndex:1],[[sevenSortedCards objectAtIndex:j] objectAtIndex:1], [[sevenSortedCards objectAtIndex:(j+1)] objectAtIndex:1],nil];
                        res = [res initWithObjectsAndKeys: cardsBoat, @"Boat", nil];
                        return res;
                        
                    }
                }
            }
            
            
            if (i == 0) { // without a pair it must be three of a kind, find here two cards with largest values except three same value cards
                cardsThreeOfAKind = [NSArray arrayWithObjects:[[sevenSortedCards objectAtIndex:i] objectAtIndex:1],[[sevenSortedCards objectAtIndex:i] objectAtIndex:1],[[sevenSortedCards objectAtIndex:i] objectAtIndex:1],[[sevenSortedCards objectAtIndex:(i+3)] objectAtIndex:1], [[sevenSortedCards objectAtIndex:(i+4)] objectAtIndex:1],nil];
                res = [res initWithObjectsAndKeys: cardsThreeOfAKind, @"Three of a Kind", nil];
                return res;
            }
            else if (i == 1) {
                cardsThreeOfAKind = [NSArray arrayWithObjects:[[sevenSortedCards objectAtIndex:i] objectAtIndex:1],[[sevenSortedCards objectAtIndex:i] objectAtIndex:1],[[sevenSortedCards objectAtIndex:i] objectAtIndex:1],[[sevenSortedCards objectAtIndex:0] objectAtIndex:1], [[sevenSortedCards objectAtIndex:4] objectAtIndex:1],nil];
                res = [res initWithObjectsAndKeys: cardsThreeOfAKind, @"Three of a Kind", nil];
                return res;
            }
            else {
                NSArray * cardsThreeOfAKind = [NSArray arrayWithObjects:[[sevenSortedCards objectAtIndex:i] objectAtIndex:1],[[sevenSortedCards objectAtIndex:i] objectAtIndex:1],[[sevenSortedCards objectAtIndex:i] objectAtIndex:1],[[sevenSortedCards objectAtIndex:0] objectAtIndex:1], [[sevenSortedCards objectAtIndex:1] objectAtIndex:1],nil];
                res = [res initWithObjectsAndKeys: cardsThreeOfAKind, @"Three of a Kind", nil];
                return res;
            }
        }
    }
    res = [res initWithObjectsAndKeys:[NSNumber numberWithInt: 0], @"False", nil];
    return res;
}

-(NSDictionary *)hasFlush: (NSArray *) sevenSortedCards{
    NSDictionary *res = [NSDictionary alloc];
    NSMutableArray * cardsFlush = [NSMutableArray array];
    
    
    for (int i = 0; i < 3; i++) {
        int count = 1;
        [cardsFlush addObject:[[sevenSortedCards objectAtIndex:i] objectAtIndex:1]];
        int suit = [[[sevenSortedCards objectAtIndex:i] objectAtIndex:0] intValue]; // actual suit 
        
        for (int j = (i+1); j < 7; j++){
            if ([[[sevenSortedCards objectAtIndex:j] objectAtIndex:0] intValue] == suit) {
                [cardsFlush addObject:[[sevenSortedCards objectAtIndex:j] objectAtIndex:1]];
                count = count + 1; 
            }
            if (count == 5) {
                res = [res initWithObjectsAndKeys:cardsFlush, @"Flush", nil];
                return res;
            }
        }
        
        cardsFlush = [NSMutableArray array];
        
    }
    res = [res initWithObjectsAndKeys:[NSNumber numberWithInt:0], @"False", nil];
    return res;
}


-(NSDictionary *)hasTwoPairsOrPair: (NSArray *) sevenSortedCards{
    NSDictionary *res = [NSDictionary alloc];
    NSMutableArray * cardsTwoPairs = [NSMutableArray array];
    
    NSNumber * lastValue = [[sevenSortedCards objectAtIndex:0] objectAtIndex:1]; //value of first card
    NSMutableArray * recordPairCardsIndex = [NSMutableArray array];
    int count = 0;
    for (int i =1; i<6; i++) {
        if ([lastValue isEqualToNumber:[[sevenSortedCards objectAtIndex:i] objectAtIndex:1]]) {
            [cardsTwoPairs addObject:lastValue];
            [cardsTwoPairs addObject:lastValue];
            [recordPairCardsIndex addObject:[NSNumber numberWithInt:(i-1)]];
            [recordPairCardsIndex addObject:[NSNumber numberWithInt:i]];
            count = count + 1;
        }
        else {
            lastValue = [[sevenSortedCards objectAtIndex:i] objectAtIndex:1];
        }
        if (count == 2) {
            for (int j = 0; j<7; j++) {
                if (![recordPairCardsIndex containsObject:[NSNumber numberWithInt:j]]) {
                    [cardsTwoPairs addObject:[[sevenSortedCards objectAtIndex:j] objectAtIndex:1]];
                    res = [res initWithObjectsAndKeys:cardsTwoPairs, @"Two Pairs", nil];
                    return res;
                }
            }
        }
        
    }
    if (count == 1) {
        int threeOtherCards = 0;
        for (int j = 0; j<7; j++) {
            if (![recordPairCardsIndex containsObject:[NSNumber numberWithInt:j]]) {
                [cardsTwoPairs addObject:[[sevenSortedCards objectAtIndex:j] objectAtIndex:1]];
                threeOtherCards = threeOtherCards + 1;
                if (threeOtherCards == 3) {
                    res = [res initWithObjectsAndKeys:cardsTwoPairs, @"Pair", nil];
                    return res;
                }
                
            }
        }
    }
    else { // there is no pair in seven cards
        res = [res initWithObjectsAndKeys:[NSNumber numberWithInt:0], @"False", nil];
        return res;
    }
    
}




-(NSDictionary *)hasHighCard: (NSArray *) sevenSortedCards{
    NSDictionary *res = [NSDictionary alloc];
    NSMutableArray * cardsHighCard = [NSMutableArray array];
    
    for (int i=0; i<5; i++) {
        [cardsHighCard addObject:[[sevenSortedCards objectAtIndex:i] objectAtIndex:1]];
    }
    res = [res initWithObjectsAndKeys:cardsHighCard, @"Hight Card", nil];
    return res;
    
}




-(NSDictionary *)bestFiveCardsCombination:(int[][2]) sevenCards{
    NSArray * sevenSortedCards = [self sortIntArray:sevenCards];
    
    NSArray * aceTo14SevenSortedArray = [NSArray array];  //convert ace value in Array to 14
    if ([self hasAceInArray:sevenSortedCards]) {
        aceTo14SevenSortedArray = [self convertAceTo14inSevenSortedArray:sevenCards];
    }
    else {
        aceTo14SevenSortedArray = sevenSortedCards;
    }
    
    NSDictionary * res = [self hasRoyalFlush:aceTo14SevenSortedArray];
    
    
    if ([[[res allKeys] objectAtIndex:0] isEqualToString:@"Royal Flush"]) {
        return res;
    }
    else { //Straight with AKQJ10 or False
        NSDictionary * priorRes = [self hasStraightFlushOrStraight:sevenSortedCards]; // we only need Ace with Value 1
        if ([[[priorRes allKeys] objectAtIndex:0] isEqualToString:@"Straight Flush"]) {
            return priorRes;
        }
        else { // with key "Straight" or "False" 
            NSDictionary * priorResSecond = [self hasFourOfAKind:aceTo14SevenSortedArray];
            if ([[[priorResSecond allKeys] objectAtIndex:0] isEqualToString:@"Four of a Kind"]) {
                return priorResSecond;
            }
            else {
                priorResSecond = [self hasBoatOrThreeOfAKind:aceTo14SevenSortedArray];
                if ([[[priorResSecond allKeys] objectAtIndex:0] isEqualToString:@"Boat"]) {
                    return priorResSecond;
                }
                else { //priorResSecond has key "Three of a Kind" or False
                    NSDictionary * priorResThird = [self hasFlush:aceTo14SevenSortedArray];
                    if ([[[priorResThird allKeys] objectAtIndex:0] isEqualToString:@"Flush"]) {
                        return priorResThird;
                    }
                    else {
                        if ([[[res allKeys] objectAtIndex:0] isEqualToString:@"Straight"]) { //straight A,K,Q,J,10 hat priority to other straights
                            return res;
                        }
                        else { //hasRoyalFlush returns a dictionary with key "False"
                            if ([[[priorRes allKeys] objectAtIndex:0] isEqualToString:@"Straight"]) {
                                return priorRes;
                            }
                            else {
                                if ([[[priorResSecond allKeys] objectAtIndex:0] isEqualToString:@"Three of a Kind"]){
                                    return priorResSecond;
                                }
                                else {
                                    res = [self hasTwoPairsOrPair:aceTo14SevenSortedArray];
                                    if ([[[res allKeys] objectAtIndex:0] isEqualToString:@"Two Pairs"]) {
                                        return res;
                                    }
                                    else if ([[[res allKeys] objectAtIndex:0] isEqualToString:@"Pair"]) {
                                        return res;
                                    }
                                    else {
                                        res = [self hasHighCard:aceTo14SevenSortedArray];
                                        return res;
                                    }
                                }
                            }
                            
                        }
                        
                    }
                    
                }
                
            }
        }
        
    }
    
    
}




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
