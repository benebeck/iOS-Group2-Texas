//
//  spieleinstellungen.m
//  nopainbutshame
//
//  Created by Riza Koray Alpdogan on 16.07.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "spieleinstellungen.h"

@interface spieleinstellungen ()

@end

@implementation spieleinstellungen
@synthesize blindhohesetzen;
@synthesize blindhoheint;
@synthesize blindprorundeint;
@synthesize blindprorundesetzen;
@synthesize gegner1;
@synthesize budget;
@synthesize blindhohe;
@synthesize blindprorunden;
@synthesize MaxPlayers;
@synthesize TotalMoney;
 NSMutableArray *possiblegameStates;
- (void)viewDidLoad
{
    [super viewDidLoad];
   
	// Do any additional setup after loading the view.
}

-(IBAction)budgethohesetzen:(id)sender{
    if (budget.selectedSegmentIndex==0) {
        [self setTotalMoney:1000];
    }
    if (budget.selectedSegmentIndex==1) {
        [self setTotalMoney:2000];
    }
    if (budget.selectedSegmentIndex==2) {
        [self setTotalMoney:5000];
    }
    if (budget.selectedSegmentIndex==3) {
        [self  setTotalMoney:10000];
    }
}
-(IBAction)setzegegner1:(id)sender{
   
        [self setMaxPlayers:2];
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)viewDidUnload {
    [self setGegner1:nil];
   
    [super viewDidUnload];
}


- (IBAction)setzegegner2:(id)sender {
    [self setMaxPlayers:3];
}

- (IBAction)setzegegner3:(id)sender {
    [self setMaxPlayers:4];
}

- (IBAction)setzegegner4:(id)sender {
    [self setMaxPlayers:5];
}

- (IBAction)blindhohe:(id)sender {
    if (blindhohe.selectedSegmentIndex==0) {
        [self setBlindhoheint:10];
    }
    if (blindhohe.selectedSegmentIndex==1) {
        [self setBlindhoheint:20];
    }
    if (blindhohe.selectedSegmentIndex==2) {
        [self setBlindhoheint:50];
    }
    if (blindhohe.selectedSegmentIndex==3) {
        [self  setBlindhoheint:100];
    }

}

- (IBAction)blindprorunden:(id)sender {
    if (blindprorunden.selectedSegmentIndex==0) {
        [self setBlindprorundeint:3];
    }
    if (blindprorunden.selectedSegmentIndex==1) {
        [self setBlindprorundeint:5];
    }

}

- (IBAction)Losgehts:(id)sender {
    possiblegameStates = [NSMutableArray arrayWithObjects:@"RAISE",@"INACTIVE",@"ACTIVE",@"DEALER",@"SMALL_BLIND",@"BIG_BLIND",@"CALL",@"FOLD",@"ALL IN", nil];
    
    
    
    //start up the central game control
    GameController *gameController = [GameController sharedInstance];
    [gameController setMaxPlayers:MaxPlayers];
    [gameController setTotalMoney:TotalMoney];
    [gameController setBigBlind:blindhoheint];
    [gameController setBlindprorunde:blindprorundeint];
    [gameController setBetRoundNr:1];
    [gameController setGameStates:possiblegameStates];
    [gameController raisePlayers];
    
    [self performSegueWithIdentifier:@"losgehts" sender:nil];
    
}

@end
