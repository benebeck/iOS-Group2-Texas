//
//  ViewController.m
//  nopainbutshame
//
//  Created by Riza Koray Alpdogan on 12.05.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

UIImageView *myimageview=nil;
UIImage *myimage;
CGPoint *point;
CGPoint woist;
NSTimer *timer;
CGPoint startpoint;

-(void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch *betouched = [touches anyObject];
    startpoint = [betouched locationInView:self.view];
}

- (void)viewDidLoad
{
    
    point= (CGPoint *)malloc(sizeof(const CGPoint));
    myimage =[UIImage imageNamed:@"1_Singleplayer.png"];
    myimageview=[[UIImageView alloc] initWithImage:myimage];
    [myimageview setFrame:CGRectMake(0, 150, 55, 90)];
    [[self view]addSubview:myimageview];
    
    CGPoint mycenter = myimageview.center;
    int amount =52;
    
    [UIImageView beginAnimations:@"Bouncing" context:nil];
    [UIImageView setAnimationDelegate:self];
    [UIImageView setAnimationDuration:0.4];
    [UIImageView setAnimationCurve:UIViewAnimationCurveLinear];
    
    myimageview.frame = CGRectMake(3, 
                                   3, 
                                   myimageview.frame.size.width+amount, 
                                   myimageview.frame.size.height+amount);      
    myimageview.center= mycenter;
    [UIImageView commitAnimations];	
    
        
    /*
    
    UISwipeGestureRecognizer *recognizer;
    
    recognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeRight:)];
    [recognizer setDirection:(UISwipeGestureRecognizerDirectionRight)];
    [[self view] addGestureRecognizer:recognizer];
    
    recognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeLeft:)];
    [recognizer setDirection:(UISwipeGestureRecognizerDirectionLeft)];
    [[self view] addGestureRecognizer:recognizer];
    [super viewDidLoad];
    
    recognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeUp:)];
    [recognizer setDirection:(UISwipeGestureRecognizerDirectionUp)];
    [[self view] addGestureRecognizer:recognizer];
*/

	// Do any additional setup after loading the view, typically from a nib.
}


-(void) animate: (CGPoint) msg{
    
    
    [UIImageView beginAnimations:@"Bouncing" context:nil];
    [UIImageView setAnimationDelegate:self];
    [UIImageView setAnimationDuration:0.2];
    [UIImageView setAnimationCurve:UIViewAnimationCurveLinear];
    if (msg.x<50) {
    
    myimageview.frame = CGRectMake(0, 
                                   150, 
                                   myimageview.frame.size.width+30, 
                                   myimageview.frame.size.height);   }
        else{
            myimageview.frame = CGRectMake(0, 
                                           150, 
                                           myimageview.frame.size.width-30, 
                                           myimageview.frame.size.height);
        }
    
    [UIImageView commitAnimations];
}

static int i=1;
static int hil=1;
-(IBAction)handlePan:(UIPanGestureRecognizer *)recognizer2{
   
    
        if(i==1)
        {
            point->x=recognizer2.view.center.x;
            point->y=recognizer2.view.center.y;
            i--;
        }
    CGPoint translation = [recognizer2 translationInView:self.view];
    CGPoint velocity = [recognizer2 velocityInView:self.view];
    
    
  
    NSLog(@"recognizer.x %f,recognizer.y %f",woist.x,woist.y);
     //MAX(MIN(startpoint.y+translation.y,220),150)
    woist=CGPointMake(startpoint.x+translation.x,point->y);
     
    
   // [recognizer2 setTranslation:CGPointMake(0, 0) inView:self.view];
   
    
           //        NSLog(@"sda\n"); myimage.frame.origin.x-(int)(amount/2)
    if(hil==0){
[self animate:woist];
        hil=30;
    }else {
        hil--;
    }
      if (recognizer2.state == UIGestureRecognizerStateEnded) {
          woist=CGPointMake(point->x, point->y);
          i++;
          
     }
          /*
     CGPoint velocity = [ recognizer2 velocityInView:self.view];
     
     CGFloat magnitude= sqrtf((velocity.x * velocity.x)+(velocity.y* velocity.y));
     CGFloat slideMult= magnitude /1000;
     float slidefactor = 0.2 * slideMult;
     
     
     if ( magnitude>200 && velocity.y<0) {
     
     
     CGPoint finalpoint = CGPointMake(recognizer2.view.center.x, recognizer2.view.center.y+(velocity.y*slidefactor));
     
     [UIView animateWithDuration:slidefactor*2 delay:0 options:UIViewAnimationCurveEaseInOut animations:^{ recognizer2.view.center=finalpoint;} completion:nil];
     } else {
     recognizer2.view.center=ycenter;
     }
     
     
     }*/
}

-(void)swipeUp:(UISwipeGestureRecognizer *)recognizer{
    [self performSegueWithIdentifier:@"onetosecond" sender:nil];
}

-(void)swipeRight:(UISwipeGestureRecognizer *)recognizer{
    [self performSegueWithIdentifier:@"onetothree" sender:nil];
}
-(void)swipeLeft:(UISwipeGestureRecognizer *)recognizer{
    [self performSegueWithIdentifier:@"onetofour" sender:nil];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
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
