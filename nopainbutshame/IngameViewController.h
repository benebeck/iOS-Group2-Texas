//
//  IngameViewController.h
//  nopainbutshame
//
//  Created by Riza Koray Alpdogan on 12.05.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GameController.h"
#import <QuartzCore/QuartzCore.h>
#import "PackOfCards.h"
#import "Player.h"
@interface IngameViewController : UIViewController
{
    IBOutlet UILabel *spielereins;
    IBOutlet UILabel *spielerzwei;
    IBOutlet UILabel *spielerdrei;
    IBOutlet UILabel *spielervier;
    IBOutlet UILabel *spielerfunf;

    IBOutlet UILabel *Pot;
    IBOutlet UILabel *spielereinsstat;
    IBOutlet UILabel *spielerzweistat;
    IBOutlet UILabel *spielerdreistat;
    IBOutlet UILabel *spielervierstat;
    IBOutlet UILabel *spielerfunfstat;
   
    UIImageView *mychip50;
    UIImageView *mychip502;
    UIImageView *mychip100;
    UIImageView *backofcardsleft;
    UIImageView *backofcardsright;
    UIImageView *slidetofold;
    UIImageView *opencard1imageview;
    UIImageView *opencard2imageview;
    UIImageView *opencard3imageview;
    UIImageView *opencard4imageview;
    UIImageView *opencard5imageview;
    
    UIView      *player1status;
    UIView      *player2status;
    UIView      *player3status;
    UIView      *player4status;
    UIView      *player5status;
    
    UIImage     *tempimage;
    UIImage     *chip50image;
    UIImage     *chip100image;
    UIImage     *backofcardsleft1;
    UIImage     *backofcardsleft2;
    UIImage     *backofcardsleft3;
    UIImage     *backofcardsright1;
    UIImage     *backofcardsright2;
    UIImage     *backofcardsright3;
    UIImage     *opencard1image;
    UIImage     *opencard2image;
    UIImage     *opencard3image;
    UIImage     *opencard4image;
    UIImage     *opencard5image;
    
    NSArray     *opencard;
    NSString    *opencard1;
    NSString    *opencard2;
    
    int spielereinsgeld;
    int spielerzweigeld;
    int spielerdreigeld;
    int spielerviergeld;
    int spielerfunfgeld;
    

    PackOfCards     *packofcards;
  
  

    int i;
    CGPoint *point;
   
  

}
-(IBAction)handlePan:(UIPanGestureRecognizer *)recognizer;
-(void) animate:(CGPoint) msg;
-(IBAction)buttonToTriggerCircle:(id)sender;
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation;
@end
