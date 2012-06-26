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

NSString *playerid;
CGPoint startpoint;


- (void)viewDidLoad
{
    
    opencard=[[NSArray alloc] initWithArray:player.twoCards];     
    //opencard1=[[NSString alloc]initWithFormat:@"%i",[opencard objectAtIndex:0]];
    //opencard2=[[NSString alloc]initWithFormat:@"%i",[opencard objectAtIndex:1]];
opencard1 = @"1";
    opencard2 = @"3";
    CGRect newFrame = CGRectMake(0, 0, 320, 480); // Frame of the view to be animated
    UIView * viewToBeAnimated = [[UIView alloc] initWithFrame:newFrame];
    viewToBeAnimated.backgroundColor = [UIColor clearColor];
    
    // Gesture recognizer for single finger pan (drag) of this view
    UIPanGestureRecognizer *singleFingerPanGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
    singleFingerPanGestureRecognizer.maximumNumberOfTouches = 1;
    [viewToBeAnimated addGestureRecognizer: singleFingerPanGestureRecognizer];
    
    [self.view addSubview:viewToBeAnimated]; 
   
    point= (CGPoint *)malloc(sizeof(const CGPoint));
    player=[[Player alloc] init];
    myView=[[drawCircle alloc] init];
    playerid=[player playerId];
    
    
    chip50image =[UIImage imageNamed:@"pokerchip50.png"];
    mychip50=[[UIImageView alloc] initWithImage:chip50image];
    [mychip50 setFrame:CGRectMake(0, 90, 110, 110)];
    [[self view]addSubview:mychip50];
    
    chip100image =[UIImage imageNamed:@"pokerchip100.png"];
    mychip100=[[UIImageView alloc] initWithImage:chip100image];
    [mychip100 setFrame:CGRectMake(70, 190, 110, 110)];
    [[self view]addSubview:mychip100];
    
    
    
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
    spielereinsstat.text=[NSString stringWithFormat:@"Totalmoney:%i", texas.totalMoney];
    

    backofcardsleft1 =[UIImage imageNamed:@"backofcards.png"];
    backofcardsleft=[[UIImageView alloc] initWithImage:backofcardsleft1];
    [backofcardsleft setFrame:CGRectMake(210, 170, 120, 176)];
    [[self view]addSubview:backofcardsleft];

    backofcardsright1 =[UIImage imageNamed:@"backofcards.png"];
    backofcardsright=[[UIImageView alloc] initWithImage:backofcardsright1];
    [backofcardsright setFrame:CGRectMake(340, 170, 120, 176)];
    [[self view]addSubview:backofcardsright];
    
    [super viewDidLoad];
    
    
	// Do any additional setup after loading the view, typically from a nib.
}


-(void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch *betouched = [touches anyObject];
    startpoint = [betouched locationInView:self.view];
    NSLog(@"ichbinimstart");
 //   [myView setCanDraw:YES];
 //   [myView setActiveplayer:i];
 //   [myView setNeedsDisplay];
    if (startpoint.x<170) {
        if (startpoint.y>60 && startpoint.y<160 && startpoint.x<110) {
            i=1;
        } else {
            if (startpoint.y>189 && startpoint.y<320 && startpoint.x>69) i=2;
            else {
                i=0;
            }
        }
    } 
}




int iba=1;
int flipcardleft=1;
int flipcardback=0;
int canwin=0;

-(IBAction)handlePan:(UIPanGestureRecognizer *)recognizer{
    
    
   
    CGPoint locationInView = [recognizer locationInView:self.view];
    NSLog(@"lol:,%i",locationInView.x);
    
    if(i==1)mychip50.center = locationInView;
    if(i==2)mychip100.center = locationInView;
    
    if (startpoint.x>380&&locationInView.x>380) {
        backofcardsleft.image=[UIImage imageNamed:@"backofcards"];
        backofcardsright.image=[UIImage imageNamed:@"backofcards"];
        NSLog(@"zweig1,%i",flipcardleft);
        flipcardleft=1;
    }
    
    if (locationInView.x<381 && locationInView.x>280 && flipcardleft==1) {
        backofcardsleft.image=[UIImage imageNamed:@"backofcardslinks"];
        backofcardsright.image=[UIImage imageNamed:@"backofcardsrechts"];
        flipcardleft=2;
        NSLog(@"zweig2,%i",flipcardleft);
    }
                    
    if (locationInView.x>260 && locationInView.x<281 && (flipcardleft==2||flipcardback==1) ) {
                        backofcardsleft.image=[UIImage imageNamed:@"backofcardslinks2"];
                        backofcardsright.image=[UIImage imageNamed:@"backofcards2"];
                        flipcardleft=3;
      
        
        NSLog(@"zweig3,%i",flipcardleft);
        flipcardback=0;
                            }
    
    if ( locationInView.x<261 && flipcardleft==3 ) {
       
        
        flipcardleft=1;
        flipcardback=1;
        NSLog(@"zweig4,%i",flipcardleft);
        int playerIDint=[playerid intValue];
        int opencardindex=0;
        for (int anfang=0; anfang<52; anfang++) {
               if([packofcards givemeinfo:anfang forWho:1]==playerIDint)
               {
                   if(opencardindex==0){
                       backofcardsright.image=[UIImage imageNamed:[NSString stringWithFormat:@"%i",anfang]];
                       opencardindex++;
                                        }
                    if(opencardindex==1){
                        backofcardsleft.image=[UIImage imageNamed:[NSString stringWithFormat:@"%i",anfang]];
                                        }

               }
                
        }
        
        backofcardsleft.image=[UIImage imageNamed:opencard1];
        backofcardsright.image=[UIImage imageNamed:opencard2];
    }
  
    
    if (recognizer.state == UIGestureRecognizerStateEnded) {
         backofcardsleft.image=[UIImage imageNamed:@"backofcards"];
         backofcardsright.image=[UIImage imageNamed:@"backofcards"];
        flipcardleft=1;
        CGPoint velocity = [ recognizer velocityInView:self.view];
        CGFloat magnitude= sqrtf(1+(velocity.y* velocity.y));
        CGFloat slideMult= magnitude /1000;
        float slidefactor = 0.2 * slideMult;
        
        
        if ( magnitude>1000 ) {
            CGPoint finalpoint = CGPointMake(recognizer.view.center.x, recognizer.view.center.y+(velocity.y*slidefactor));
            if(i==1){
            [UIView animateWithDuration:slidefactor*2 delay:0 options:UIViewAnimationCurveEaseInOut animations:^{ mychip50.frame=CGRectMake(mychip50.frame.origin.x, finalpoint.y, mychip50.frame.size.width, mychip50.frame.size.height);} completion:nil];
                [player chooseBet:50];
                canwin+=50;
                Pot.text=[NSString stringWithFormat:@"Pot:%i",canwin];
            }
            if(i==2){
                [UIView animateWithDuration:slidefactor*2 delay:0 options:UIViewAnimationCurveEaseInOut animations:^{ mychip100.frame=CGRectMake(mychip100.frame.origin.x, finalpoint.y, mychip100.frame.size.width, mychip100.frame.size.height);} completion:nil];
                [player chooseBet:100];
                canwin+=100;
                Pot.text=[NSString stringWithFormat:@"Pot:%i",canwin];
            }
          //  [self performSegueWithIdentifier:@"onetosecond" sender:nil];
            iba++;
        }   
            else {
            if(i==1)mychip50.center=CGPointMake(55, 145);
            if(i==2)mychip100.center=CGPointMake(125, 245);
                
            }
    }
}






- (void)viewDidUnload
{
 

//    Pot = nil;
    [super viewDidUnload];
  //  [myView setCanDraw:NO];

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
