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

int entschlossenheit;       //spielerentschlossenheit
int bluff;                 //if bluff is over 0.7 raise
int logikbet;             //if logikbet is over 0.7 bet
                         //if logikbet is under 0.3 fold 
int anzahloffenekarten;
int erstekarte;
int zweitekarte;
int drittekarte;


- (void)viewDidLoad
{
    [super viewDidLoad];
    
     [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(callverdammt) userInfo:nil repeats:YES];
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
 int hallo=[[GameController sharedInstance] pot] ;

     if ([GameController sharedInstance].activePlayer==@"Player2") {
         entschlossenheit=1.3;
         [self hartgecodedesKI];
        [[GameController sharedInstance] changePlayerState:@"CALL" forPlayer:[[GameController sharedInstance].playerList objectAtIndex:1]];
    }
    if ([GameController sharedInstance].activePlayer==@"Player3") {
        entschlossenheit=1.1;
        [self hartgecodedesKI];
        [[GameController sharedInstance] changePlayerState:@"CALL" forPlayer:[[GameController sharedInstance].playerList objectAtIndex:2]];
    }
    if ([GameController sharedInstance].activePlayer==@"Player4") {
        entschlossenheit=0.9;
        [self hartgecodedesKI];
        [[GameController sharedInstance] changePlayerState:@"CALL" forPlayer:[[GameController sharedInstance].playerList objectAtIndex:3]];
    }
    if ([GameController sharedInstance].activePlayer==@"Player5") {
        entschlossenheit=0.7;
        [self hartgecodedesKI];
        [[GameController sharedInstance] changePlayerState:@"CALL" forPlayer:[[GameController sharedInstance].playerList objectAtIndex:4]];
    }
        player2stat.text=[NSString stringWithFormat:@"player2:%@",[[[GameController sharedInstance].playerList objectAtIndex:1] playerState]];
        player3stat.text=[NSString stringWithFormat:@"player3:%@",[[[GameController sharedInstance].playerList objectAtIndex:2] playerState]];
        player4stat.text=[NSString stringWithFormat:@"player4:%@",[[[GameController sharedInstance].playerList objectAtIndex:3] playerState]];
        player5stat.text=[NSString stringWithFormat:@"player5:%@",[[[GameController sharedInstance].playerList objectAtIndex:4] playerState]];
    
    totalmone.text=[NSString stringWithFormat:@"%i",hallo];
 
    if ( [GameController sharedInstance].activePlayer==@"Player1" ) {
        [self performSegueWithIdentifier:@"toplayer" sender:nil];
    }

}

-(void)hartgecodedesKI{
    for (int temp1=0; temp1<52; temp1++) {
        if([[PackOfCards sharedInstance] givemeinfo:temp1 forWho:1]==2)
            
    }
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
