//
//  ViewController.m
//  nopainbutshame
//
//  Created by Riza Koray Alpdogan on 12.05.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"
#import "GCHelper.h"

@interface ViewController ()

@end

@implementation ViewController

UIImageView *myimageview=nil;
UIImageView *myimageview2=nil;
UIImageView *myimageview3=nil;
UIImage *myimage;
CGPoint *point;
CGPoint woist;
NSTimer *timer;
CGPoint startpoint;

-(IBAction)presentGCTurnViewController:(id)sender{
    [[GCHelper sharedInstance] findMatchWithMinPlayers:2 maxPlayers:5 viewController:self];
}

-(void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch *betouched = [touches anyObject];
    startpoint = [betouched locationInView:self.view];
    [self animate:startpoint];
}

- (void)viewDidLoad
{
    
    point= (CGPoint *)malloc(sizeof(const CGPoint));
    myimage =[UIImage imageNamed:@"1_Singleplayer.png"];
    myimageview=[[UIImageView alloc] initWithImage:myimage];
    [myimageview setFrame:CGRectMake(10, 150, 55, 90)];
    [[self view]addSubview:myimageview];
    
    myimageview2=[[UIImageView alloc]initWithImage:myimage];
    [myimageview2 setFrame:CGRectMake(100, 150, 55, 90)];
    [[self view]addSubview:myimageview2];
    
    myimageview3=[[UIImageView alloc]initWithImage:myimage];
    [myimageview3 setFrame:CGRectMake(200, 150, 55, 90)];
    [[self view]addSubview:myimageview3];

    
    
    
        
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
   
    float hilf;
    float hilfcos;
    float hilfcos2;
    if(sinf(msg.x/36)>0){
        hilf=0;
    }
       else{
           hilf=sinf(msg.x/36);
       }
    if(cosf(msg.x/360)<0.94)
    {
        hilfcos=0;
    }
    else {
        hilfcos=cosf(msg.x/360);
        hilfcos=(hilfcos*100)-88;
    }
    
    if(cosf(msg.x/360)>0.83)
    {
        hilfcos2=0;
    }
    else {
        hilfcos2=cosf(msg.x/45);
       
    }
    
 
     NSLog(@"asd:%f\n",200*hilf);
    myimageview.frame = CGRectMake(10, 
                                   MAX(110,MIN(150,200-(10*hilfcos))), 
                                   //MAX(122,MIN(200,250-msg.x)),   
                                   MAX(58,MIN(140,290-msg.x)), 
                                   1.5*MAX(72,MIN(150,305-msg.x)));   
              
    myimageview2.frame = CGRectMake(100, 
                                   MAX(106,MIN(150,300+(200*hilf))), 
                                   //MAX(122,MIN(200,250-msg.x)),   
                                   MAX(58,MIN(140,-2*(200*hilf))), 
                                   1.5*MAX(72,MIN(150,305-msg.x)));  
    myimageview3.frame = CGRectMake(200, 
                                   MAX(110,MIN(150,140-(100*hilfcos2))), 
                                   //MAX(122,MIN(200,250-msg.x)),   
                                   MAX(58,MIN(140,msg.x-100)), 
                                   1.5*MAX(72,MIN(126,1.3*(msg.x-140))));   
  
}



static int i=1;

-(IBAction)handlePan:(UIPanGestureRecognizer *)recognizer2{
   
    
        if(i==1)
        {
            point->x=recognizer2.view.center.x;
            point->y=recognizer2.view.center.y;
            i--;
        }
    CGPoint translation = [recognizer2 translationInView:self.view];
   
    
    
  
   // NSLog(@"recognizer.x %f,recognizer.y %f",woist.x,woist.y);
     //MAX(MIN(startpoint.y+translation.y,220),150)
    woist=CGPointMake(startpoint.x+translation.x,point->y);
     
    
   // [recognizer2 setTranslation:CGPointMake(0, 0) inView:self.view];
   
    
           //        NSLog(@"sda\n"); myimage.frame.origin.x-(int)(amount/2)
   
[self animate:woist];
        
 
      if (recognizer2.state == UIGestureRecognizerStateEnded) {
         
          
     
     CGPoint velocity = [ recognizer2 velocityInView:self.view];
     
     CGFloat magnitude= sqrtf(1+(velocity.y* velocity.y));
     CGFloat slideMult= magnitude /1000;
     float slidefactor = 0.2 * slideMult;
     
     
     if ( magnitude>200 && woist.x<120 ) {
     
     
     CGPoint finalpoint = CGPointMake(recognizer2.view.center.x, recognizer2.view.center.y+(velocity.y*slidefactor));
     
     [UIView animateWithDuration:slidefactor*2 delay:0 options:UIViewAnimationCurveEaseInOut animations:^{ myimageview.frame=CGRectMake(myimageview.frame.origin.x, finalpoint.y, myimage.size.width, myimage.size.height);} completion:nil];
        
           [self performSegueWithIdentifier:@"onetosecond" sender:nil];
         woist=CGPointMake(point->x, point->y);
         i++;
     }else     if ( magnitude>200 && woist.x<220 && woist.x>120 ) {
         
         
         CGPoint finalpoint = CGPointMake(recognizer2.view.center.x, recognizer2.view.center.y+(velocity.y*slidefactor));
         
         [UIView animateWithDuration:slidefactor*2 delay:0 options:UIViewAnimationCurveEaseInOut animations:^{ myimageview2.frame=CGRectMake(myimageview2.frame.origin.x, finalpoint.y, myimage.size.width, myimage.size.height);} completion:nil];
         
         [self performSegueWithIdentifier:@"onetosecond" sender:nil];
         woist=CGPointMake(point->x, point->y);
         i++;
     }else     if ( magnitude>200 && woist.x>220 ) {
         
         
         CGPoint finalpoint = CGPointMake(recognizer2.view.center.x, recognizer2.view.center.y+(velocity.y*slidefactor));
         
         [UIView animateWithDuration:slidefactor*2 delay:0 options:UIViewAnimationCurveEaseInOut animations:^{ myimageview3.frame=CGRectMake(myimageview3.frame.origin.x, finalpoint.y, myimage.size.width, myimage.size.height);} completion:nil];
         
         [self performSegueWithIdentifier:@"onetosecond" sender:nil];
         woist=CGPointMake(point->x, point->y);
         i++;
     }
     
     
     }
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
