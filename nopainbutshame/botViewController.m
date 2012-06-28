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
    if ([GameController sharedInstance].activePlayer==@"Player3") {
        [[GameController sharedInstance] changePlayerState:@"CALL" forPlayer:[[GameController sharedInstance].playerList objectAtIndex:2]];
    }
    player2stat.text=[NSString stringWithFormat:@"player3:%@",[[[GameController sharedInstance].playerList objectAtIndex:2] playerState]];
    
    
    player2stat.text=[NSString stringWithFormat:@"player3:%@",[[[GameController sharedInstance].playerList objectAtIndex:2] playerState]];
    
    totalmone.text=[NSString stringWithFormat:@"%i",hallo];
 
    if ( [GameController sharedInstance].activePlayer==@"Player1" ) {
        [self performSegueWithIdentifier:@"toplayer" sender:nil];
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
