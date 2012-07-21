//
//  botViewController.m
//  nopainbutshame
//
//  Created by Riza Koray Alpdogan on 28.06.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "botViewController.h"

@interface botViewController ()

@end

@implementation botViewController
@synthesize player4stat;
@synthesize totalmone;
@synthesize player2stat;
@synthesize player3stat;
@synthesize player5stat;

int entschlossenheit;      //spielerentschlossenheit
int logikbet;             //if logikbet is over 0.7 bet
                         //if logikbet is under 0.3 fold 

int siebenkarten[7][2];
int aktiverspieler;
int karte1[1][2];
int karte2[1][2];
int karte3[1][2];
int karte4[1][2];
int karte5[1][2];
int karte6[1][2];
int karte7[1][2];
PackOfCards * tempcards;


- (void)viewDidLoad
{
    [super viewDidLoad];
    
     [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(callverdammt) userInfo:nil repeats:YES];
	// Do any additional setup after loading the view.
}

- (void)viewDidUnload
{
    [self setPlayer2stat:nil];
    [self setPlayer2stat:nil];
    [self setPlayer3stat:nil];
    [self setPlayer5stat:nil];
    
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

-(void)callverdammt{


     if ([[GameController sharedInstance].activePlayer playerId]==@"Player2") {
         if ([[GameController sharedInstance].activePlayer playerState]!=@"FOLD"){
         entschlossenheit=1.3;
         aktiverspieler=3;
         [self hartgecodedesKI];
         }else {
             [[GameController sharedInstance] activateNextPlayer];
         }
    }
    if ([[GameController sharedInstance].activePlayer playerId]==@"Player3") {
        if ([[GameController sharedInstance].activePlayer playerState]!=@"FOLD"){
            entschlossenheit=1.1;
            aktiverspieler=4;
            [self hartgecodedesKI];
        }else {
            [[GameController sharedInstance] activateNextPlayer];
        }
    }
    if ([[GameController sharedInstance].activePlayer playerId]==@"Player4") {
        if ([[GameController sharedInstance].activePlayer playerState]!=@"FOLD"){
            entschlossenheit=0.9;
            aktiverspieler=5;
            [self hartgecodedesKI];
        }else {
            [[GameController sharedInstance] activateNextPlayer];
        }
   
    }
    if ([[GameController sharedInstance].activePlayer playerId]==@"Player5") {
        if ([[GameController sharedInstance].activePlayer playerState]!=@"FOLD"){
            entschlossenheit=0.7;
            aktiverspieler=6;
            [self hartgecodedesKI];
        }else {
            [[GameController sharedInstance] activateNextPlayer];
        }
      
    }

    
  
 

       [self performSegueWithIdentifier:@"toplayer" sender:nil];
    

}

-(void)hartgecodedesKI{
   
    int temp2=0;
    bool underseven=true;
  //  NSLog(@"myfloat:%i",12/13);
    for (int temp1=0; temp1<52; temp1++) {

        if([[PackOfCards sharedInstance] whogotthecard:temp1]==aktiverspieler || [[PackOfCards sharedInstance] whogotthecard:temp1]==1){
            int temprest=1+temp1%13;
            int tempganz=1+temp1/13;
            siebenkarten[temp2][0]=tempganz;
            siebenkarten[temp2][1]=temprest;
            temp2++;
        }
            
    }
    while(underseven==true)
    {
        if (temp2>6) {
            underseven=false;
                } else {
                    int value = arc4random() % 52;
                    int temprest=1+value%13;
                    int tempganz=1+value/13;
                    siebenkarten[temp2][0]=tempganz;
                    siebenkarten[temp2][1]=temprest;
                    temp2++;
                        }
        
    }
    NSArray * compare = [NSArray arrayWithObjects: @"Royal Flush",@"Straight Flush", @"Four of a Kind", @"Boat", @"Flush", @"Straight", @"Three of a Kind", @"Two Pairs", @"Pair", @"Hight Card", nil];

     for(int lol=0; lol<40; lol++){
    NSArray *result;  
    result=[[PackOfCards sharedInstance] erayscheck:siebenkarten];

     
    if(result==[compare objectAtIndex:0]){
      [[GameController sharedInstance] changePlayerState:@"RAISE" forPlayer:[[GameController sharedInstance] activePlayer]];
        break;
    }else if (result==[compare objectAtIndex:1]) {
        [[GameController sharedInstance] changePlayerState:@"RAISE" forPlayer:[[GameController sharedInstance] activePlayer]];
        break;
    }else if (result==[compare objectAtIndex:2]) {
        [[GameController sharedInstance] changePlayerState:@"RAISE" forPlayer:[[GameController sharedInstance] activePlayer]];
    }else if (result==[compare objectAtIndex:3]) {
        [[GameController sharedInstance] changePlayerState:@"RAISE" forPlayer:[[GameController sharedInstance] activePlayer]];
        break;
    }else if (result==[compare objectAtIndex:4]) {
        [[GameController sharedInstance] changePlayerState:@"RAISE" forPlayer:[[GameController sharedInstance] activePlayer]];
        break;
    }else if (result==[compare objectAtIndex:5]) {
        [[GameController sharedInstance] changePlayerState:@"CALL" forPlayer:[[GameController sharedInstance] activePlayer]];
        break;
    }else if (result==[compare objectAtIndex:6]) {
        [[GameController sharedInstance] changePlayerState:@"CALL" forPlayer:[[GameController sharedInstance] activePlayer]];
        break;
    }else if (result==[compare objectAtIndex:7]) {
        [[GameController sharedInstance] changePlayerState:@"CALL" forPlayer:[[GameController sharedInstance] activePlayer]];
        break;
    }else if (result==[compare objectAtIndex:8]) {
        [[GameController sharedInstance] changePlayerState:@"CALL" forPlayer:[[GameController sharedInstance] activePlayer]];
    }else if (result==[compare objectAtIndex:9]) {
        [[GameController sharedInstance] changePlayerState:@"FOLD" forPlayer:[[GameController sharedInstance] activePlayer]];
        break;
    }
    }
    [[GameController sharedInstance] activateNextPlayer];
    
    // if ([result objectAtIndex:0]==compPair) {
    
  //      NSLog(@"hahahaha");

  //  }
    
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    } else {
        return YES;
    }
}

@end
