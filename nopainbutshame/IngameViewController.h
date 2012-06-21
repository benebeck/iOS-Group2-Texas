//
//  IngameViewController.h
//  nopainbutshame
//
//  Created by Riza Koray Alpdogan on 12.05.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TexasHolemGame.h"
#import "drawCircle.h"
#import "PackOfCards.h"
#import "Player.h"
@interface IngameViewController : UIViewController
{
    IBOutlet UILabel *spielereins;
    IBOutlet UILabel *spielerzwei;
    IBOutlet UILabel *spielerdrei;
    IBOutlet UILabel *spielervier;
    IBOutlet UILabel *spielerfunf;

    IBOutlet UILabel *spielereinsstat;
    IBOutlet UILabel *spielerzweistat;
    IBOutlet UILabel *spielerdreistat;
    IBOutlet UILabel *spielervierstat;
    IBOutlet UILabel *spielerfunfstat;
   
    UIImageView *mychip50;
    UIImageView *mychip502;
    UIImageView *mychip100;
    UIImage     *chip50image;
    UIImage     *chip100image;
    
    int spielereinsgeld;
    int spielerzweigeld;
    int spielerdreigeld;
    int spielerviergeld;
    int spielerfunfgeld;
    
    TexasHolemGame *texas;
    PackOfCards     *packofcards;
    Player          *player;
    drawCircle     *myView;

    int i;
    CGPoint *point;
   
  

}
-(IBAction)handlePan:(UIPanGestureRecognizer *)recognizer;
-(void) animate:(CGPoint) msg;
-(IBAction)buttonToTriggerCircle:(id)sender;
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation;
@end
