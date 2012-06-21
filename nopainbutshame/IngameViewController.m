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
   
    

    spielereins=[[UILabel alloc] initWithFrame:CGRectMake(33, 38, 140, 30)];
    [self.view addSubview:spielereins];
    [spielereins setBackgroundColor:[UIColor clearColor]];
    spielereins.font = [UIFont fontWithName:@"Arial" size:28];
    [spielereins setTextColor:[UIColor greenColor]];
    spielereins.text=@"Eraaaaaaay";

    spielerzwei=[[UILabel alloc] initWithFrame:CGRectMake(128, 3, 140, 30)];
    [self.view addSubview:spielerzwei];
    [spielerzwei setBackgroundColor:[UIColor clearColor]];
    spielerzwei.font = [UIFont fontWithName:@"Arial" size:28];
    [spielerzwei setTextColor:[UIColor greenColor]];
    spielerzwei.text=@"Eraaaaaaay";
    
    spielerdrei=[[UILabel alloc] initWithFrame:CGRectMake(193, 38, 140, 30)];
    [self.view addSubview:spielerdrei];
    [spielerdrei setBackgroundColor:[UIColor clearColor]];
    spielerdrei.font = [UIFont fontWithName:@"Arial" size:28];
    [spielerdrei setTextColor:[UIColor greenColor]];
    spielerdrei.text=@"Eraaaaaaay";
    
    spielervier=[[UILabel alloc] initWithFrame:CGRectMake(298, 3, 140, 30)];
    [self.view addSubview:spielervier];
    [spielervier setBackgroundColor:[UIColor clearColor]];
    spielervier.font = [UIFont fontWithName:@"Arial" size:28];
    [spielervier setTextColor:[UIColor greenColor]];
    spielervier.text=@"Eraaaaaaay";
    
    spielerfunf=[[UILabel alloc] initWithFrame:CGRectMake(348, 38, 140, 30)];
    [self.view addSubview:spielerfunf];
    [spielerfunf setBackgroundColor:[UIColor clearColor]];
    spielerfunf.font = [UIFont fontWithName:@"Arial" size:28];
    [spielerfunf setTextColor:[UIColor greenColor]];
    spielerfunf.text=@"Eraaaaaaay";
    
    
    spielereinsstat=[[UILabel alloc] initWithFrame:CGRectMake(33, 100, 140, 30)];
    [self.view addSubview:spielereinsstat];
    [spielereinsstat setBackgroundColor:[UIColor clearColor]];
    spielereinsstat.font = [UIFont fontWithName:@"Arial" size:28];
    [spielereinsstat setTextColor:[UIColor whiteColor]];
    spielereinsstat.text=[NSString stringWithFormat:@"Spieler1:%d", i];
    
    spielerzweistat=[[UILabel alloc] initWithFrame:CGRectMake(33, 140, 140, 30)];
    [self.view addSubview:spielerzweistat];
    [spielerzweistat setBackgroundColor:[UIColor clearColor]];
    spielerzweistat.font = [UIFont fontWithName:@"Arial" size:28];
    [spielerzweistat setTextColor:[UIColor whiteColor]];
    spielerzweistat.text=[NSString stringWithFormat:@"Spieler2%d", i];
    
    spielerdreistat=[[UILabel alloc] initWithFrame:CGRectMake(33, 180, 140, 30)];
    [self.view addSubview:spielerdreistat];
    [spielerdreistat setBackgroundColor:[UIColor clearColor]];
    spielerdreistat.font = [UIFont fontWithName:@"Arial" size:28];
    [spielerdreistat setTextColor:[UIColor whiteColor]];
    spielerdreistat.text=[NSString stringWithFormat:@"%d", i];
    
    spielervierstat=[[UILabel alloc] initWithFrame:CGRectMake(33, 220, 140, 30)];
    [self.view addSubview:spielervierstat];
    [spielervierstat setBackgroundColor:[UIColor clearColor]];
    spielervierstat.font = [UIFont fontWithName:@"Arial" size:28];
    [spielervierstat setTextColor:[UIColor whiteColor]];
    spielervierstat.text=[NSString stringWithFormat:@"%d", i];
    
    spielerfunfstat=[[UILabel alloc] initWithFrame:CGRectMake(33, 260, 140, 30)];
    [self.view addSubview:spielerfunfstat];
    [spielerfunfstat setBackgroundColor:[UIColor clearColor]];
    spielerfunfstat.font = [UIFont fontWithName:@"Arial" size:28];
    [spielerfunfstat setTextColor:[UIColor whiteColor]];
    spielerfunfstat.text=[NSString stringWithFormat:@"%d", i];

    
    
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
    NSLog(@"lololololo");
    i++;
    [myView setCanDraw:YES];
   
    [myView setActiveplayer:texas.activePlayer];
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
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    } else {
        return YES;
    }
}

@end
