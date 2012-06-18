//
//  InGameController.h
//  nopainbutshame
//
//  Created by Riza Koray Alpdogan on 16.06.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//
# import "TexasHolemGame.h"
#import <UIKit/UIKit.h>

@interface InGameController : UIViewController
{
    IBOutlet UILabel *einsatzSp1;
    IBOutlet UILabel *einsatzSp2;
    IBOutlet UILabel *einsatzSp3;
    TexasHolemGame *texas;
     NSArray *spieler;
}

@end
