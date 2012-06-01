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

-(IBAction)handlePan:(UIPanGestureRecognizer *)recognizer2{
    Boolean animation=false;
    CGPoint ycenter= CGPointMake(232.5, 215);
    CGPoint translation = [recognizer2 translationInView:self.view];
    
    recognizer2.view.center = CGPointMake(recognizer2.view.center.x + translation.x, MAX(MIN(recognizer2.view.center.y+translation.y,220),100));
    if (translation.y>100) {
        animation=true;
    }
   // NSLog(@"recognizer.x %f,recognizer.y %f",recognizer2.view.center.x,recognizer2.view.center.y);
    
    [recognizer2 setTranslation:CGPointMake(0, 0) inView:self.view];
    
    if (recognizer2.state == UIGestureRecognizerStateEnded) {
        
        CGPoint velocity = [ recognizer2 velocityInView:self.view];
        
        CGFloat magnitude= sqrtf((velocity.x * velocity.x)+(velocity.y* velocity.y));
        CGFloat slideMult= magnitude /1000;
        float slidefactor = 0.2 * slideMult;
      //  NSLog(@"recognizer.x %f,recognizer.y %f",velocity.y,slidefactor);

        if ( magnitude>100 && velocity.y<0) {
            
        
        CGPoint finalpoint = CGPointMake(recognizer2.view.center.x, recognizer2.view.center.y+(velocity.y*slidefactor));
        
        [UIView animateWithDuration:slidefactor*2 delay:0 options:UIViewAnimationCurveEaseInOut animations:^{ recognizer2.view.center=finalpoint;} completion:nil];
        } else {
            recognizer2.view.center=ycenter;
        }
        
        
    }
}

- (void)viewDidLoad
{
    
 

    
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


	// Do any additional setup after loading the view, typically from a nib.
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
