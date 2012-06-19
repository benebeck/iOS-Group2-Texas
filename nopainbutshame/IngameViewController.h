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
@interface IngameViewController : UIViewController
{
    IBOutlet UILabel *spielereins;
 
    TexasHolemGame *texas;

 IBOutlet drawCircle *myView;
  
   
  

}
-(IBAction)buttonToTriggerCircle:(id)sender;

@end
