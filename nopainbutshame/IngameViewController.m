//
//  IngameViewController.m
//  nopainbutshame
//
//  Created by Riza Koray Alpdogan on 12.05.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "IngameViewController.h"

@interface IngameViewController ()

@end

@implementation IngameViewController

- (void)viewDidLoad
{
  


    texas =[[TexasHolemGame alloc]init];    
   CGRect frame;
    frame.origin.x = 50;
    frame.origin.y = 50;
    frame.size.width = 50;
    frame.size.height = 50;
    spielereins=[[UILabel alloc] initWithFrame:frame];
    [self.view addSubview:spielereins];
    [spielereins setBackgroundColor:[UIColor clearColor]];
    spielereins.font = [UIFont fontWithName:@"Arial" size:50];

    [spielereins setTextColor:[UIColor greenColor]];
    spielereins.text=@"pups";

    
    
    NSArray *Spieler;
    Spieler= [texas players];
    UISwipeGestureRecognizer *recognizer;
    
    recognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeRight:)];
    [recognizer setDirection:(UISwipeGestureRecognizerDirectionRight)];
    [[self view] addGestureRecognizer:recognizer];
    
    recognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeLeft:)];
    [recognizer setDirection:(UISwipeGestureRecognizerDirectionLeft)];
    [[self view] addGestureRecognizer:recognizer];
    [super viewDidLoad];
    
    
	// Do any additional setup after loading the view, typically from a nib.
}



-(IBAction)buttonToTriggerCircle:(id)sender{
    
    [myView setCanDraw:YES];
    [myView setNeedsDisplay];
}

-(void)swipeRight:(UISwipeGestureRecognizer *)recognizer{
     
}

-(void)swipeLeft:(UISwipeGestureRecognizer *)recognizer{
    [self performSegueWithIdentifier:@"backtostart" sender:nil];
}


- (void)viewDidUnload
{
 
 
    [super viewDidUnload];
    [myView setCanDraw:NO];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
