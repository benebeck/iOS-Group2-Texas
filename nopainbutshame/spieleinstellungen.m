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
@synthesize blindprorundesetzen;
@synthesize budget;
@synthesize blindhohe;
@synthesize blindprorunden;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

-(IBAction)budgethohesetzen:(id)sender{
    if (budget.selectedSegmentIndex==0) {
        [[GameController sharedInstance] setTotalMoney:100];
    }
    if (budget.selectedSegmentIndex==0) {
        [[GameController sharedInstance] setTotalMoney:200];
    }
    if (budget.selectedSegmentIndex==0) {
        [[GameController sharedInstance] setTotalMoney:500];
    }
    if (budget.selectedSegmentIndex==0) {
        [[GameController sharedInstance] setTotalMoney:1000];
    }
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
