//
//  spieleinstellungen.h
//  nopainbutshame
//
//  Created by Riza Koray Alpdogan on 16.07.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GameController.h"

@interface spieleinstellungen : UIViewController
@property (strong, nonatomic) IBOutlet UISegmentedControl *budget;
@property (strong, nonatomic) IBOutlet UISegmentedControl *blindhohe;
@property (strong, nonatomic) IBOutlet UISegmentedControl *blindprorunden;
- (IBAction)budgethohesetzen:(id)sender;
@property (strong, nonatomic) IBOutlet UISegmentedControl *blindhohesetzen;
@property (strong, nonatomic) IBOutlet UISegmentedControl *blindprorundesetzen;
@property (strong, nonatomic) IBOutlet UIImageView *gegner1;
- (IBAction)setzegegner1:(id)sender;
@property int MaxPlayers;
@property int blindprorundeint;
@property int blindhoheint;
- (IBAction)Losgehts:(id)sender;
@property int TotalMoney;
- (IBAction)setzegegner2:(id)sender;
- (IBAction)setzegegner3:(id)sender;
- (IBAction)setzegegner4:(id)sender;
- (IBAction)blindhohe:(id)sender;
- (IBAction)blindprorunden:(id)sender;


@end
